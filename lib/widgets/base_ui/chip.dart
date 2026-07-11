import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';

/// Chip color style
enum ChipStyleType { full, soft, outline }

///  Chip Shape TYpe
enum ChipShapeType { rectangular, rounded }

/// Chip Size
enum ChipSize { small, medium, large }

/// Mapping extension for size
extension ChipSizeData on ChipSize {
  double get height {
    switch (this) {
      case ChipSize.small:
        return smallHeight;
      case ChipSize.medium:
        return mediumHeight;
      case ChipSize.large:
        return largeHeight;
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case ChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 0, vertical: 0);
      case ChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 0, vertical: 0);
      case ChipSize.large:
        return const EdgeInsets.symmetric(horizontal: 0, vertical: 0);
    }
  }

  TextStyle get labelStyle {
    switch (this) {
      case ChipSize.small:
        return const TextStyle(fontSize: kBodySmall);
      case ChipSize.medium:
        return const TextStyle(fontSize: kBodyMedium);
      case ChipSize.large:
        return const TextStyle(
          fontSize: kBodyLarge,
          fontWeight: FontWeight.w600,
        );
    }
  }
}

class CustomChip extends StatelessWidget {
  final Widget label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final Color? color;
  final Color? labelColor;
  final Color? borderColor;
  final Color? deleteIconColor;
  final VoidCallback? onDeleted;
  final TextStyle? labelStyle;
  final double? elevation;
  final ChipStyleType type;
  final ChipShapeType shapeType;
  final ChipSize size;
  final EdgeInsets? padding;

  const CustomChip({
    super.key,
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.color,
    this.labelColor,
    this.borderColor,
    this.deleteIconColor,
    this.onDeleted,
    this.labelStyle,
    this.elevation,
    this.type = ChipStyleType.full,
    this.shapeType = ChipShapeType.rectangular,
    this.size = ChipSize.medium,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color effectiveColor = color ?? theme.colorScheme.primary;
    final Color effectiveLabelColor =
        labelColor ??
        ((type == ChipStyleType.outline || type == ChipStyleType.soft)
            ? effectiveColor
            : theme.colorScheme.onPrimary);
    final Color effectiveDeleteIconColor =
        deleteIconColor ??
        (type == ChipStyleType.soft
            ? effectiveLabelColor.withValues(alpha: 0.5)
            : effectiveLabelColor);
    final Color effectiveBorderColor =
        borderColor ??
        (type == ChipStyleType.outline ? effectiveColor : Colors.transparent);

    //  background color based on chip type
    Color background;
    switch (type) {
      case ChipStyleType.full:
        background = effectiveColor;
        break;
      case ChipStyleType.soft:
        background = effectiveColor.withValues(alpha: 0.15);
        break;
      case ChipStyleType.outline:
        background = Colors.transparent;
        break;
    }

    //  chip shape type
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        shapeType == ChipShapeType.rounded ? size.height / 2 : 4,
      ),
      side: BorderSide(color: effectiveBorderColor, width: 1),
    );

    return Chip(
      label: DefaultTextStyle.merge(
        style: (labelStyle ?? size.labelStyle).copyWith(
          color: effectiveLabelColor,
        ),
        child: label,
      ),
      avatar: avatar,
      deleteIcon: deleteIcon,
      deleteIconColor: deleteIconColor ?? effectiveDeleteIconColor,
      onDeleted: onDeleted,
      padding: padding,
      backgroundColor: background,
      elevation: elevation ?? 0,
      shape: shape,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}

// Tag Input Field

class ChipInputField extends StatefulWidget {
  final List<String> initialTags;
  final List<String> suggestions;
  final String? hintText;
  final Color? color;
  final ValueChanged<List<String>>? onChanged;

  const ChipInputField({
    super.key,
    this.initialTags = const [],
    this.suggestions = const [],
    this.hintText,
    this.color,
    this.onChanged,
  });

  @override
  State<ChipInputField> createState() => _ChipInputFieldState();
}

class _ChipInputFieldState extends State<ChipInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // When focused, we just need to "trigger" the controller
        // to restart the optionsBuilder with the existing (empty) text.
        // This will automatically display all suggestions.
        _controller.value = _controller.value.copyWith();
      }
    });
  }

  void _addTag(String text) {
    final tag = text.trim();

    if (tag.isEmpty || _tags.contains(tag)) {
      _controller.clear();
      _focusNode.requestFocus();
      return;
    }

    setState(() {
      _tags.add(tag);
      _controller.clear();
    });
    widget.onChanged?.call(_tags);

    _focusNode.requestFocus();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);

      _controller.value = _controller.value.copyWith();
    });

    widget.onChanged?.call(_tags);

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Wrap(
      spacing: kDefaultPadding / 2,
      runSpacing: kDefaultPadding / 2,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ..._tags.map(
          (tag) => CustomChip(
            label: Text(tag),
            onDeleted: () => _removeTag(tag),
            color: widget.color ?? themeData.colorScheme.primary,
            type: ChipStyleType.soft,
            shapeType: ChipShapeType.rounded,
          ),
        ),

        RawAutocomplete<String>(
          textEditingController: _controller,
          focusNode: _focusNode,

          // optionsBuilder sekarang menjadi pusat logika
          optionsBuilder: (TextEditingValue textEditingValue) {
            final String input = textEditingValue.text.trim();

            // 1. If the input is empty (including when it is just clicked/focused)
            if (input.isEmpty) {
              // Display all suggestions that are NOT in _tags
              return widget.suggestions
                  .where((s) => !_tags.contains(s))
                  .toList();
            }

            // 2. If there is input, filter based on the input
            return widget.suggestions
                .where(
                  (s) =>
                      s.toLowerCase().contains(input.toLowerCase()) &&
                      !_tags.contains(s),
                )
                .toList();
          },
          displayStringForOption: (option) => option,
          onSelected: _addTag,

          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            final themeData = Theme.of(context);
            return Container(
              width: 240,
              height: mediumHeight,
              decoration: BoxDecoration(
                border: BorderDirectional(
                  start: BorderSide(color: kTextColor, width: 1),
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Type something...',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: (mediumHeight - 11) / 2,
                  ),
                  hoverColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  filled: true,
                ),
                onSubmitted: _addTag,
              ),
            );
          },

          // ... optionsViewBuilder ...
          optionsViewBuilder: (context, onSelected, options) => Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      onTap: () => onSelected(option),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

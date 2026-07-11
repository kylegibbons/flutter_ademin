import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final bool enableSearch;
  final ValueChanged<T?>? onChanged;
  final double menuMaxHeight;
  final double? width;

  const SearchableDropdown({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.enableSearch = true,
    this.onChanged,
    this.menuMaxHeight = 300,
    this.width,
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  String _selectedLabel() {
    try {
      final item = widget.items.firstWhere((it) => it.value == widget.value);
      final child = item.child;
      if (child is Text) return child.data ?? '';
      return child.toString();
    } catch (e) {
      return widget.hintText ?? '';
    }
  }

  Future<void> _openDropdown(BuildContext context) async {
    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        // Local state inside the bottom sheet so filtering updates UI immediately
        return StatefulBuilder(
          builder: (context, setModalState) {
            final TextEditingController searchController =
                TextEditingController();
            List<DropdownMenuItem<T>> filtered = List.from(widget.items);

            // We'll keep a small helper to build the content and update filtered
            void applyFilter(String q) {
              final qLower = q.toLowerCase();
              if (qLower.isEmpty) {
                filtered = List.from(widget.items);
              } else {
                filtered = widget.items.where((item) {
                  final child = item.child;
                  if (child is Text) {
                    return (child.data ?? '').toLowerCase().contains(qLower);
                  } else {
                    // Fallback: check toString
                    return child.toString().toLowerCase().contains(qLower);
                  }
                }).toList();
              }
              setModalState(() {}); // rebuild bottom sheet
            }

            // init: keep reference to controller and listen (we attach listener after build)
            // But since controller is recreated each builder call, we'll instead wire up via onChanged in TextField.
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: widget.menuMaxHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.enableSearch)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (v) => applyFilter(v),
                        ),
                      ),
                    Flexible(
                      child: filtered.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No items'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: filtered.length,
                              separatorBuilder: (_, _) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final item = filtered[index];
                                return ListTile(
                                  title: item.child,
                                  onTap: () {
                                    Navigator.of(context).pop(item.value);
                                  },
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null && widget.onChanged != null) {
      widget.onChanged!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final display = _selectedLabel();
    return InkWell(
      onTap: () => _openDropdown(context),
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(display),
      ),
    );
  }
}

/// Reusable Dropdown wrapper with custom error handling
class CustomDropdownFormField<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final FormFieldSetter<T>? onSaved;
  final InputDecoration? decoration;
  final AutovalidateMode? autovalidateMode;
  final bool isExpanded;
  final String? hint;
  final String? disabledHint;
  final IconData? icon;
  final double? iconSize;
  final Color? dropdownColor;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final FormSize size;
  final double radius;
  final IconData? prefixIcon; // Added for prefix icon
  final double? prefixIconSize;
  final String? successMessage;

  /// Custom error builder: you can limit height, style, etc.
  final Widget Function(String errorText)? customErrorBuilder;

  const CustomDropdownFormField({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.decoration,
    this.autovalidateMode,
    this.isExpanded = true,
    this.hint,
    this.disabledHint,
    this.icon,
    this.iconSize,
    this.dropdownColor,
    this.padding,
    this.enabled = true,
    this.customErrorBuilder,
    this.prefixIcon,
    this.size = FormSize.medium,
    this.radius = defaultRadius,
    this.prefixIconSize,
    this.successMessage,
  });

  @override
  State<CustomDropdownFormField<T>> createState() =>
      _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T>
    extends State<CustomDropdownFormField<T>> {
  late T? _baselineValue;

  @override
  void initState() {
    super.initState();
    _baselineValue = widget.initialValue;
  }

  // show success message condition

  bool _shouldShowSuccess(FormFieldState<T> field) {
    if (widget.successMessage == null) return false;
    if (!field.isValid) return false;
    if (field.value == null) return false;

    // EDIT MODE → only show if changed
    if (_baselineValue != null) {
      return field.value != _baselineValue;
    }

    // ADD MODE → show when valid
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final FormConfig config = getFormConfig(widget.size);

    return FormField<T>(
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.initialValue,
      builder: (field) {
        final showSuccess = _shouldShowSuccess(field);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: config.formHeight,
              child: DropdownButtonFormField<T>(
                items: widget.items,
                initialValue: field.value,
                onChanged: widget.enabled
                    ? (val) {
                        field.didChange(val);
                        if (widget.onChanged != null) widget.onChanged!(val);
                      }
                    : null,
                isDense: true,
                decoration: InputDecoration(
                  errorText: null,
                  contentPadding: config.padding,
                  labelStyle: TextStyle(fontSize: config.fontSize),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: field.hasError
                          ? kErrorColor
                          : showSuccess
                          ? kSuccessColor
                          : themeData.colorScheme.outline,
                      width: outlineWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: field.hasError
                          ? kErrorColor
                          : field.isValid &&
                                field.value != null &&
                                field.value.toString().isNotEmpty &&
                                widget.successMessage != null
                          ? kSuccessColor
                          : themeData.colorScheme.outline,
                      width: outlineWidth,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.withValues(alpha: 0.3),
                      width: outlineWidth,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    gapPadding: 0,
                    borderSide: BorderSide(width: outlineWidth),
                  ),
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon, size: config.iconSize)
                      : null, // Add prefix icon
                  prefixIconConstraints: BoxConstraints.tightFor(
                    width: config.formHeight,
                    height: config.iconSize,
                  ),
                  suffixIconConstraints: BoxConstraints.tightFor(
                    width: config.formHeight,
                    height: config.iconSize,
                  ),
                  fillColor: widget.enabled
                      ? themeData.colorScheme.surfaceContainerHighest
                      : Colors.blueGrey.withValues(alpha: 0.1),
                ),
                isExpanded: widget.isExpanded,
                hint: Text(
                  widget.hint ?? 'Please select...',
                  style: TextStyle(
                    fontSize: config.fontSize,
                    color: kTextColor,
                  ),
                ),
                disabledHint: Text(
                  widget.disabledHint ?? 'Disabled',
                  style: TextStyle(
                    fontSize: config.fontSize,
                    color: kTextColor,
                  ),
                ),
                icon: Icon(
                  widget.icon ??
                      Icons
                          .keyboard_arrow_down, // Default icon if customIcon is null
                  color: field.hasError
                      ? kErrorColor
                      : showSuccess
                      ? kSuccessColor
                      : themeData.colorScheme.onSurface,
                  size: config.iconSize,
                ),
                iconSize: widget.iconSize ?? config.iconSize,
                dropdownColor: widget.dropdownColor,
              ),
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: config.horizontalPadding,
                  top: config.verticalPadding / 2,
                ),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: kErrorColor,
                    fontSize: config.assitiveFontSize,
                  ),
                ),
              )
            else if (showSuccess)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: config.horizontalPadding,
                  top: config.verticalPadding / 2,
                ),
                child: Text(
                  widget.successMessage!,
                  style: TextStyle(
                    color: kSuccessColor,
                    fontSize: config.assitiveFontSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

//multiple selection
class MultipleDropdown extends StatefulWidget {
  final List<String> allChoices;
  final List<String> selectedChoices;
  final Function(List<String>) onSelectionChanged;
  final Color? chipColor;
  final FormSize size;
  final String? hint;
  final double? radius;
  final bool enabled; // Tambahkan argumen ini

  const MultipleDropdown({
    super.key,
    required this.allChoices,
    this.selectedChoices = const [],
    required this.onSelectionChanged,
    this.chipColor,
    this.size = FormSize.medium,
    this.hint,
    this.radius = defaultRadius,
    this.enabled = true, // Default: enabled
  });

  @override
  State<MultipleDropdown> createState() => _MultipleDropdownState();
}

class _MultipleDropdownState extends State<MultipleDropdown> {
  List<String> selectedChoices = [];

  @override
  void initState() {
    super.initState();
    selectedChoices = List<String>.from(widget.selectedChoices);
  }

  void _showCustomMenu(BuildContext context, double parentWidth) async {
    if (!widget.enabled) return; // Tidak bisa dibuka jika disabled
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);

    final String? result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + button.size.height,
        offset.dx + parentWidth,
        offset.dy,
      ),
      items: widget.allChoices
          .where((choice) => !selectedChoices.contains(choice))
          .map((choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: SizedBox(
                width: parentWidth - kDefaultPadding,
                child: Text(
                  choice,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            );
          })
          .toList(),
      constraints: BoxConstraints(maxWidth: parentWidth),
    );

    if (result != null) {
      setState(() {
        selectedChoices.add(result);
        widget.onSelectionChanged(selectedChoices);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final FormConfig config = getFormConfig(widget.size);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double parentWidth = constraints.maxWidth;

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: config.formHeight,
            maxWidth: parentWidth,
          ),
          child: GestureDetector(
            onTap: widget.enabled
                ? () => _showCustomMenu(context, parentWidth)
                : null,
            child: Container(
              width: parentWidth,
              decoration: BoxDecoration(
                color: widget.enabled
                    ? themeData.colorScheme.surfaceContainerHighest
                    : Colors.blueGrey.withValues(alpha: 0.08),
                border: Border.all(
                  color: themeData.colorScheme.outline,
                  width: outlineWidth,
                ),
                borderRadius: BorderRadius.circular(widget.radius!),
              ),
              child: selectedChoices.isEmpty && widget.hint != null
                  ? Container(
                      height: config.formHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.hint!,
                          style: TextStyle(
                            color: widget.enabled
                                ? themeData.hintColor
                                : themeData.disabledColor,
                            fontSize: config.fontSize,
                          ),
                        ),
                      ),
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(minHeight: config.formHeight),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: (config.formHeight - 24) / 2,
                        ),
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          spacing: kDefaultPadding / 2,
                          runSpacing: kDefaultPadding / 2,
                          children: selectedChoices.map((choice) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: widget.enabled
                                    ? (widget.chipColor ?? kPrimaryColor)
                                    : (widget.chipColor?.withValues(
                                            alpha: 0.5,
                                          ) ??
                                          kPrimaryColor.withValues(alpha: 0.3)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    choice,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: kLabelMedium,
                                    ),
                                  ),
                                  if (widget.enabled)
                                    const SizedBox(width: kDefaultPadding / 2),
                                  if (widget.enabled)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedChoices.remove(choice);
                                          widget.onSelectionChanged(
                                            selectedChoices,
                                          );
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

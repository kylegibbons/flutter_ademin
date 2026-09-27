import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

// multiple checkbox

class MultiCheckboxWidget extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>>? onChanged;

  // CustomCheckbox customization
  final Color? activeColor;
  final bool isOutlined;
  final bool isLabelOnRight;
  final IconData? icon;
  final double boxWidth;

  const MultiCheckboxWidget({
    super.key,
    required this.options,
    this.selectedOptions = const [],
    this.onChanged,
    this.activeColor,
    this.isOutlined = false,
    this.isLabelOnRight = true,
    this.icon,
    this.boxWidth = 18,
  });

  @override
  State<MultiCheckboxWidget> createState() => _MultiCheckboxWidgetState();
}

class _MultiCheckboxWidgetState extends State<MultiCheckboxWidget> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.selectedOptions);
  }

  void _onOptionChanged(String option, bool checked) {
    setState(() {
      if (checked) {
        _selected.add(option);
      } else {
        _selected.remove(option);
      }
      widget.onChanged?.call(_selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isLabelOnRight
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: List.generate(widget.options.length, (index) {
        final option = widget.options[index];
        final isLast = index == widget.options.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : kDefaultPadding),
          child: CustomCheckbox(
            label: option,
            value: _selected.contains(option),
            onChanged: (checked) => _onOptionChanged(option, checked ?? false),
            activeColor: widget.activeColor ?? kPrimaryColor,
            isOutlined: widget.isOutlined,
            isLabelOnRight: widget.isLabelOnRight,
            kIcon: widget.icon ?? Icons.check,
            boxWidth: widget.boxWidth,
          ),
        );
      }),
    );
  }
}
//Custom Checkbox

class CustomCheckbox extends FormField<bool> {
  CustomCheckbox({
    super.key,
    String? label,
    required bool value,
    ValueChanged<bool?>? onChanged,
    bool isLabelOnRight = true,
    bool isDisabled = false,
    bool isOutlined = false,
    Color? activeColor,
    double boxWidth = 18,
    IconData kIcon = Icons.check,
    super.validator, // Tambahkan validator
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled,
  }) : super(
         initialValue: value,
         builder: (FormFieldState<bool> state) {
           final themeData = Theme.of(state.context);
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Semantics(
                 label: label,
                 checked: state.value ?? false,
                 child: InkWell(
                   onTap: isDisabled
                       ? null
                       : () {
                           final newValue = !(state.value ?? false);
                           state.didChange(newValue);
                           onChanged?.call(newValue);
                         },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.max,
                     children: [
                       if (!isLabelOnRight && (label?.isNotEmpty ?? false))
                         Flexible(
                           child: Padding(
                             padding: EdgeInsetsDirectional.only(
                               end: 0.5 * kDefaultPadding,
                             ),
                             child: _buildLabel(
                               state.context,
                               label!,
                               isDisabled,
                             ),
                           ),
                         ),
                       Stack(
                         children: [
                           Container(
                             width: boxWidth,
                             height: boxWidth,
                             decoration: BoxDecoration(
                               color: isOutlined
                                   ? themeData
                                         .colorScheme
                                         .surfaceContainerHighest
                                   : (state.value ?? false)
                                   ? (activeColor ?? kPrimaryColor)
                                   : themeData
                                         .colorScheme
                                         .surfaceContainerHighest,
                               borderRadius: BorderRadius.circular(4),
                               border: Border.all(
                                 color: (state.value ?? false)
                                     ? (activeColor ?? kPrimaryColor)
                                     : themeData.colorScheme.outline,
                                 width: outlineWidth,
                               ),
                             ),
                             child: (state.value ?? false)
                                 ? Icon(
                                     kIcon,
                                     color: isOutlined
                                         ? activeColor
                                         : Colors.white,
                                     size: boxWidth * 0.7,
                                   )
                                 : null,
                           ),
                           if (isDisabled)
                             Container(
                               width: boxWidth,
                               height: boxWidth,
                               decoration: BoxDecoration(
                                 color: Colors.white.withValues(alpha: 0.2),
                                 borderRadius: BorderRadius.circular(4),
                               ),
                             ),
                         ],
                       ),
                       if (isLabelOnRight && (label?.isNotEmpty ?? false))
                         Flexible(
                           child: Padding(
                             padding: EdgeInsetsDirectional.only(
                               start: 0.5 * kDefaultPadding,
                             ),
                             child: _buildLabel(
                               state.context,
                               label!,
                               isDisabled,
                             ),
                           ),
                         ),
                     ],
                   ),
                 ),
               ),
               if (state.hasError)
                 Padding(
                   padding: EdgeInsetsDirectional.only(
                     start: boxWidth + kDefaultPadding / 2,
                     top: kDefaultPadding / 2,
                   ),
                   child: Text(
                     state.errorText!,
                     style: TextStyle(color: kErrorColor, fontSize: kBodySmall),
                   ),
                 ),
             ],
           );
         },
       );

  static Widget _buildLabel(
    BuildContext context,
    String label,
    bool isDisabled,
  ) {
    final themeData = Theme.of(context);
    return Text(
      label,
      style: TextStyle(
        color: isDisabled
            ? themeData.disabledColor
            : themeData.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
//Custom Radio Button

class CustomRadioButton extends StatelessWidget {
  final String? label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isLabelOnRight;
  final bool isDisabled;
  final bool isOutlined;
  final Color? activeColor;
  final Color inactiveColor;
  final double radioSize;
  final TextStyle? labelStyle;

  const CustomRadioButton({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.isLabelOnRight = true,
    this.isDisabled = false,
    this.isOutlined = false,
    this.activeColor,
    this.inactiveColor = Colors.transparent,
    this.radioSize = 18.0,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context); // Get the current theme

    return InkWell(
      onTap: isDisabled ? null : () => onChanged(!value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!isLabelOnRight && (label?.isNotEmpty ?? false))
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 0.5 * kDefaultPadding),
                child: _buildLabel(context, label!, labelStyle),
              ),
            ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: radioSize,
                height: radioSize,
                decoration: BoxDecoration(
                  color: isOutlined
                      ? themeData.colorScheme.surfaceContainerHighest
                      : value
                      ? (activeColor ??
                            kPrimaryColor) // Active color when selected
                      : inactiveColor, // Default color when unselected
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: value
                        ? (activeColor ?? kPrimaryColor)
                        : themeData.colorScheme.outline,
                    width: 1.0,
                  ),
                ),
                child: value
                    ? Center(
                        child: Container(
                          width: radioSize * 0.4, // Inner circle size
                          height: radioSize * 0.4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isOutlined
                                ? (activeColor ?? kPrimaryColor)
                                : Colors.white, // Inner circle color
                          ),
                        ),
                      )
                    : null,
              ),
              // Masking Layer for Disabled State
              if (isDisabled)
                Container(
                  width: radioSize,
                  height: radioSize,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2), // Mask color
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          if (isLabelOnRight && (label?.isNotEmpty ?? false))
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 0.5 * kDefaultPadding,
                ),
                child: _buildLabel(context, label!, labelStyle),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLabel(
    BuildContext context,
    String label,
    TextStyle? labelStyle,
  ) {
    final ThemeData themeData = Theme.of(context);
    // Combines the base style with the custom style so that attributes
    // like fontWeight are maintained even when labelStyle is sent
    final TextStyle defaultStyle = TextStyle(
      color: isDisabled
          ? themeData.disabledColor
          : themeData.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );

    return Text(label, style: defaultStyle.merge(labelStyle));
  }
}

//Custom Switch

class CustomSwitch extends StatelessWidget {
  final String? label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLabelOnRight;
  final bool isDisabled;
  final bool isOutlined;
  final Color? activeColor;
  final Color inactiveColor;
  final double switchWidth;
  final double switchHeight;
  final Duration? animationDuration;

  const CustomSwitch({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.isLabelOnRight = true,
    this.isDisabled = false,
    this.activeColor,
    this.inactiveColor = Colors.grey,
    this.isOutlined = false,
    this.switchWidth = 32.0,
    this.switchHeight = 16.0,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: isDisabled ? null : () => onChanged(!value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!isLabelOnRight && (label?.isNotEmpty ?? false))
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: 0.5 * kDefaultPadding),
                child: _buildLabel(context, label!),
              ),
            ),
          Stack(
            alignment: Alignment.center,
            children: [
              // Animated background color and size for the switch
              AnimatedContainer(
                duration: animationDuration ?? Duration(milliseconds: 300),
                width: switchWidth,
                height: switchHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(switchHeight / 2),
                  border: Border.all(
                    color: value
                        ? (activeColor ?? kPrimaryColor)
                        : themeData.colorScheme.outline,
                    width: outlineWidth,
                  ),
                  color: isOutlined
                      ? themeData.colorScheme.surfaceContainerHighest
                      : value
                      ? (activeColor ?? kPrimaryColor)
                      : themeData.colorScheme.surfaceContainerHighest,
                ),
                child: AnimatedAlign(
                  duration: animationDuration ?? Duration(milliseconds: 300),
                  alignment: value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 0.7 * switchHeight,
                    height: 0.7 * switchHeight,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isOutlined
                          ? value
                                ? (activeColor ?? kPrimaryColor)
                                : inactiveColor
                          : value
                          ? Colors.white
                          : inactiveColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              // Masking overlay when the switch is disabled
              if (isDisabled)
                Container(
                  width: switchWidth,
                  height: switchHeight,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(switchHeight / 2),
                  ),
                ),
            ],
          ),
          if (isLabelOnRight && (label?.isNotEmpty ?? false))
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 0.5 * kDefaultPadding,
                ),
                child: _buildLabel(context, label!),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label) {
    final themeData = Theme.of(context);
    return Text(
      label,
      style: TextStyle(
        color: isDisabled
            ? themeData.disabledColor
            : themeData.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

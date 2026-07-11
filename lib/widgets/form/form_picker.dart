import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as flutter_picker;
import 'package:flex_color_picker/flex_color_picker.dart' as flex_picker;

//Color picker

enum ColorPickerType { flutter, flex }

enum ColorPickerDisplay { textField, container }

class ColorPickerField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final Color? initialColor;
  final Function(String)? onColorSelected;
  final String? Function(String?)? validator;
  final FormSize size;
  final double radius;
  final ColorPickerType pickerType;

  const ColorPickerField({
    super.key,
    this.controller,
    required this.labelText,
    this.initialColor,
    this.onColorSelected,
    this.validator,
    this.size = FormSize.medium,
    this.radius = 4,
    this.pickerType = ColorPickerType.flutter,
    ColorPickerDisplay displayAs = ColorPickerDisplay.textField,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late TextEditingController _controller;
  Color _selectedColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _selectedColor = widget.initialColor ?? kPrimaryColor;
    if (_selectedColor != Colors.transparent) {
      _controller.text = _colorToHex(_selectedColor);
    }
  }

  // Convert color to hex string
  String _colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  // Brightness check
  bool _isColorDark(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  }

  Future<void> _selectColor(BuildContext context) async {
    Color pickedColor = _selectedColor;

    if (widget.pickerType == ColorPickerType.flutter) {
      // Default: flutter_colorpicker

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          final themeData = Theme.of(context);
          return AlertDialog(
            contentPadding: EdgeInsets.all(kDefaultPadding),
            actionsPadding: EdgeInsets.all(kDefaultPadding),
            titlePadding: EdgeInsets.all(kDefaultPadding),
            buttonPadding: EdgeInsets.all(kDefaultPadding),
            title: Text(
              'Select Color',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: kBodyLarge,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            content: SingleChildScrollView(
              child: flutter_picker.ColorPicker(
                pickerColor: _selectedColor,
                onColorChanged: (Color color) {
                  pickedColor = color;
                },
                pickerAreaHeightPercent: 0.8,
                // ignore: deprecated_member_use
                labelTextStyle: TextStyle(
                  color: themeData.colorScheme.onSurface,
                ),
                displayThumbColor: true,
              ),
            ),
            actions: <Widget>[
              SoftButton(
                kText: 'Cancel',
                bgColor: themeData.colorScheme.onSurface,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                kText: 'Select',
                bgColor: kSuccessColor,
                kTextColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _selectedColor = pickedColor;
                    _controller.text = _colorToHex(_selectedColor);
                  });
                  if (widget.onColorSelected != null) {
                    widget.onColorSelected!(_colorToHex(_selectedColor));
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Flex Color Picker with custom AlertDialog
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          final themeData = Theme.of(context);
          return AlertDialog(
            contentPadding: EdgeInsets.all(kDefaultPadding),
            actionsPadding: EdgeInsets.all(kDefaultPadding),
            titlePadding: EdgeInsets.all(kDefaultPadding),
            buttonPadding: EdgeInsets.all(kDefaultPadding),
            title: Text(
              'Select Color',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
                fontSize: kBodyLarge,
              ),
            ),
            content: SingleChildScrollView(
              child: flex_picker.ColorPicker(
                color: _selectedColor,
                onColorChanged: (Color color) {
                  pickedColor = color;
                },
                pickersEnabled: const <flex_picker.ColorPickerType, bool>{
                  flex_picker.ColorPickerType.both: false,
                  flex_picker.ColorPickerType.primary: true,
                  flex_picker.ColorPickerType.accent: true,
                  flex_picker.ColorPickerType.bw: true,
                  flex_picker.ColorPickerType.custom: true,
                  flex_picker.ColorPickerType.wheel: true,
                },
                pickerTypeTextStyle: TextStyle(
                  color: themeData.colorScheme.onSurface,
                ),
                enableOpacity: true,
                enableShadesSelection: true,
                showColorCode: true,
                colorCodeHasColor: true,
                padding: const EdgeInsets.all(kDefaultPadding),
                selectedPickerTypeColor: kPrimaryColor,
                borderRadius: 4,
              ),
            ),
            actions: <Widget>[
              SoftButton(
                kText: 'Cancel',
                bgColor: themeData.colorScheme.onSurface,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                kText: 'Select',
                bgColor: kSuccessColor,
                kTextColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _selectedColor = pickedColor;
                    _controller.text = _colorToHex(_selectedColor);
                  });
                  widget.onColorSelected?.call(_colorToHex(_selectedColor));
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _isColorDark(_selectedColor)
        ? Colors.white
        : kOnSurfaceLight;
    final FormConfig config = getFormConfig(widget.size);

    return FormField<String>(
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: config.formHeight,
              child: TextField(
                controller: _controller,
                readOnly: true,
                mouseCursor: SystemMouseCursors.click,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  hintText: 'Pick a color',
                  errorText: null,
                  isDense: false,
                  contentPadding: config.padding,
                  suffixIcon: Icon(
                    Icons.color_lens_outlined,
                    size: config.iconSize,
                    color: textColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    gapPadding: 0,
                    borderSide: BorderSide(
                      width: outlineWidth,
                      color: _selectedColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: _selectedColor,
                      width: outlineWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: BorderSide(
                      color: _selectedColor,
                      width: outlineWidth,
                    ),
                  ),
                  filled: true,
                  fillColor: _selectedColor,
                  suffixIconConstraints: BoxConstraints.tightFor(
                    width: config.formHeight,
                    height: config.iconSize,
                  ),
                ),
                style: TextStyle(color: textColor, fontSize: config.fontSize),
                onTap: () => _selectColor(context),
                onChanged: (value) => field.didChange(value),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  top: kDefaultPadding / 2,
                ),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: kErrorColor,
                    fontSize: config.assitiveFontSize,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

// Enum for button size
enum FormSize { small, medium, large }

// enum for form type

enum FormType { text, date, time }

class FormConfig {
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconSize;
  final double formHeight;
  final double assitiveFontSize;

  FormConfig({
    required this.fontSize,
    required this.fontWeight,
    required this.padding,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.iconSize,
    required this.formHeight,
    required this.assitiveFontSize,
  });
}

FormConfig getFormConfig(FormSize size) {
  switch (size) {
    case FormSize.small:
      return FormConfig(
        fontSize: kBodySmall,
        fontWeight: FontWeight.w500,
        padding: EdgeInsets.symmetric(
          horizontal: 0.6 * kDefaultPadding,
          vertical: 0.8 * kVerticalPadding,
        ),
        horizontalPadding: 0.6 * kDefaultPadding,
        verticalPadding: 0.8 * kVerticalPadding,
        iconSize: 13,
        formHeight: smallHeight,
        assitiveFontSize: kBodySmall,
      );
    case FormSize.medium:
      return FormConfig(
        fontSize: kBodyMedium,
        fontWeight: FontWeight.w500,
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kVerticalPadding,
        ),
        horizontalPadding: kDefaultPadding,
        verticalPadding: kVerticalPadding,
        iconSize: 16,
        formHeight: mediumHeight,
        assitiveFontSize: kBodySmall,
      );
    case FormSize.large:
      return FormConfig(
        fontSize: kBodyLarge,
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(
          horizontal: 1.2 * kDefaultPadding,
          vertical: 1.2 * kVerticalPadding,
        ),
        horizontalPadding: 1.2 * kDefaultPadding,
        verticalPadding: 1.2 * kVerticalPadding,
        iconSize: 18,
        formHeight: largeHeight,
        assitiveFontSize: kBodyMedium,
      );
  }
}

// ===============================
// CUSTOM TEXT FORM FIELD
// ===============================

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  // decoration-ish
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final TextStyle? floatingLabelStyle;
  final MouseCursor? mouseCursor;
  final TextAlign? textAlign;

  // behavior
  final bool enabled;
  final bool readOnly;
  final bool isPassword;
  final String? originalValue; // for dirty check
  final String? successMessage;

  final double? radius;
  final FormSize size;

  // Forward all additional TextFormField arguments
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool? obscureText; // Manual override

  const CustomTextFormField({
    super.key,
    this.controller,
    this.autovalidateMode,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onTap,

    // decoration
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.floatingLabelAlignment = FloatingLabelAlignment.start,
    this.floatingLabelStyle,
    this.mouseCursor,
    this.textAlign,

    // behavior
    this.enabled = true,
    this.readOnly = false,
    this.isPassword = false,
    this.originalValue,
    this.successMessage,

    // style
    this.radius,
    this.size = FormSize.medium,

    // forward
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.obscureText,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

// ==========================================================
// STATE
// ==========================================================

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscure = true;
  late GlobalKey<FormFieldState<String>> _formFieldKey;

  @override
  void initState() {
    super.initState();
    _formFieldKey = GlobalKey<FormFieldState<String>>();
    if (widget.obscureText != null) {
      _obscure = widget.obscureText!;
    }

    // Listen to controller changes dan sync FormField state
    widget.controller?.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    // Keep FormField value in sync with the external controller.
    _formFieldKey.currentState?.didChange(widget.controller?.text);

    // Only trigger validation when autovalidate is enabled.
    if (widget.autovalidateMode != null &&
        widget.autovalidateMode != AutovalidateMode.disabled) {
      _formFieldKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  bool _shouldShowSuccess(FormFieldState<String> state) {
    if (widget.successMessage == null) return false;
    if (!state.isValid) return false;
    if (state.value == null || state.value!.isEmpty) return false;

    // EDIT MODE → only show if changed
    if (widget.originalValue != null) {
      return state.value != widget.originalValue;
    }

    // ADD MODE → normal behavior
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final config = getFormConfig(widget.size);

    return FormField<String>(
      key: _formFieldKey,
      validator: widget.validator,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.controller?.text ?? '',
      builder: (state) {
        // Determine suffix icon
        Widget? suffix;
        if (widget.isPassword) {
          suffix = InkWell(
            child: Icon(
              _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: state.hasError ? kErrorColor : kTextColor,
              size: config.iconSize,
            ),
            onTap: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          );
        } else if (state.hasError) {
          suffix = Icon(
            Icons.error_outline,
            color: kErrorColor,
            size: config.iconSize,
          );
        } else if (_shouldShowSuccess(state)) {
          suffix = Icon(
            Icons.check,
            size: config.iconSize,
            color: kSuccessColor,
          );
        } else if (widget.suffixIcon != null) {
          suffix = Icon(widget.suffixIcon, size: config.iconSize);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: config.formHeight),
              child: TextField(
                controller: widget.controller,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                mouseCursor: widget.mouseCursor,
                obscureText: widget.isPassword
                    ? _obscure
                    : (widget.obscureText ?? false),
                onTap: widget.onTap,
                onChanged: (value) {
                  state.didChange(value);
                  widget.onChanged?.call(value);
                },
                style: TextStyle(
                  fontSize: config.fontSize,
                  color: themeData.colorScheme.onSurface,
                ),
                strutStyle: StrutStyle(
                  fontSize: config.fontSize,
                  height: 1.5,
                  forceStrutHeight: true,
                ),
                maxLines: widget.maxLines,
                minLines: widget.maxLines,
                textAlign: widget.textAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  alignLabelWithHint: true,

                  hintText: widget.hintText,
                  contentPadding: config.padding,
                  floatingLabelBehavior: widget.floatingLabelBehavior,
                  floatingLabelStyle: widget.floatingLabelStyle,
                  floatingLabelAlignment: widget.floatingLabelAlignment,
                  isDense: true,
                  filled: true,
                  fillColor: widget.enabled
                      ? themeData.colorScheme.surfaceContainerHighest
                      : Colors.blueGrey.withValues(alpha: 0.1),

                  // border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.radius ?? defaultRadius,
                    ),
                    borderSide: BorderSide(width: outlineWidth),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.radius ?? defaultRadius,
                    ),
                    borderSide: BorderSide(
                      width: outlineWidth,
                      color: state.hasError
                          ? kErrorColor
                          : _shouldShowSuccess(state)
                          ? kSuccessColor
                          : themeData.colorScheme.outline,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.radius ?? defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: Colors.blueGrey.withValues(alpha: 0.3),
                      width: outlineWidth,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.radius ?? defaultRadius,
                    ),
                    borderSide: BorderSide(
                      width: outlineWidth,
                      color: state.hasError
                          ? kErrorColor
                          : _shouldShowSuccess(state)
                          ? kSuccessColor
                          : kPrimaryColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.radius ?? defaultRadius,
                    ),
                    borderSide: BorderSide(
                      color: kErrorColor,
                      width: outlineWidth,
                    ),
                  ),

                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon, size: config.iconSize)
                      : null,
                  suffixIcon: suffix,
                  prefixIconConstraints: BoxConstraints.tightFor(
                    width: config.formHeight,
                  ),
                  suffixIconConstraints: BoxConstraints.tightFor(
                    width: config.formHeight,
                  ),
                ),
              ),
            ),

            // ========= ERROR MESSAGE =========
            if (state.hasError)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: config.horizontalPadding,
                  top: config.verticalPadding / 2,
                ),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: kErrorColor,
                    fontSize: config.assitiveFontSize,
                  ),
                ),
              ),

            // ========= SUCCESS MESSAGE =========
            if (_shouldShowSuccess(state))
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

//outline search bar

class OutlineSearchBar extends StatelessWidget {
  const OutlineSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.autofocus = false,
    this.radius = defaultRadius,
    this.size = FormSize.medium,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted; // Added for submission
  final VoidCallback? onEditingComplete; // Added for editing complete
  final VoidCallback? onTap; // Added for tap action
  final FormFieldSetter? onSaved; // Added for saving
  final FormFieldValidator<String>? validator; //added for validation
  final List<TextInputFormatter>? inputFormatters; // Added for input formater
  final TextInputType? keyboardType;
  final bool? autofocus;
  final double radius;
  final FormSize size;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final config = getFormConfig(size);
    return TextFormField(
      onChanged: onChanged,
      autofocus: autofocus!,
      cursorColor: themeData.colorScheme.onSurface,
      style: TextStyle(
        fontSize: config.fontSize,
        color: themeData.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
          gapPadding: 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
          gapPadding: 0,
        ),
        fillColor: themeData.colorScheme.surface,
        hintStyle: TextStyle(color: kTextColor, fontSize: kBodyMedium),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.search, color: kTextColor, size: 18),
        contentPadding: config.padding,
      ),
    );
  }
}

//Soft search bar

class SoftSearchBar extends StatelessWidget {
  const SoftSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.radius = defaultRadius,
    this.size = FormSize.medium,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted; // Added for submission
  final VoidCallback? onEditingComplete; // Added for editing complete
  final VoidCallback? onTap; // Added for tap action
  final FormFieldSetter? onSaved; // Added for saving
  final FormFieldValidator<String>? validator; //added for validation
  final List<TextInputFormatter>? inputFormatters; // Added for input formater
  final TextInputType? keyboardType;
  final double radius;
  final FormSize size;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final config = getFormConfig(size);
    return TextFormField(
      onChanged: onChanged,
      cursorColor: themeData.colorScheme.onSurface,
      style: TextStyle(
        fontSize: config.fontSize,
        color: themeData.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: themeData.scaffoldBackgroundColor,
        hintStyle: TextStyle(color: kTextColor, fontSize: kBodyMedium),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.search, color: kTextColor, size: 18),
        contentPadding: config.padding,
      ),
    );
  }
}

// modern search bar

class SearchBarWithActions extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onMicTap;
  final VoidCallback? onVisionTap;
  final FormSize size;
  final String? hintText;

  const SearchBarWithActions({
    super.key,
    this.controller,
    this.onMicTap,
    this.onVisionTap,
    this.size = FormSize.medium,
    this.hintText = 'Search',
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final config = getFormConfig(size);
    return Container(
      height: config.formHeight,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: themeData.colorScheme.primary),
          // SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hoverColor: Colors.transparent,
                contentPadding: config.padding,
              ),
              style: TextStyle(
                fontSize: config.fontSize,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
          InkWell(
            onTap: onMicTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Icon(Icons.mic_outlined, color: kSuccessColor),
            ),
          ),
          InkWell(
            onTap: onMicTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Icon(Icons.camera_alt_outlined, color: kErrorColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom search bar

class OversizeSearchBar extends StatelessWidget {
  final String? hintText;
  const OversizeSearchBar({super.key, this.hintText = 'Search'});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: kDefaultPadding,
          horizontal: kDefaultPadding,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kTableHeaderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
      ),
      style: TextStyle(
        fontSize: kBodyLarge,
        color: themeData.colorScheme.onSurface,
      ),
    );
  }
}

// compact horizontal email form

class CompactHorizontalEmailForm extends StatelessWidget {
  const CompactHorizontalEmailForm({
    super.key,
    this.controller,
    required this.onPressed,
    this.hintText,
    this.buttonColor,
    this.validator,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final VoidCallback onPressed;
  final String? hintText;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: hintText ?? 'Enter your email address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                gapPadding: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                borderSide: BorderSide(
                  width: outlineWidth,
                  color: themeData.colorScheme.outline,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                borderSide: BorderSide(color: kErrorColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                  width: outlineWidth,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                borderSide: BorderSide(color: kErrorColor),
              ),
              errorStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: mediumHeight,
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: buttonColor ?? kPrimaryColor,
              iconColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(4),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            ),
            onPressed: onPressed,
            icon: Icon(Icons.send, size: 18),
            label: Text('Send', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

//Custom TextField

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText; // Added for label
  final IconData? prefixIcon; // Added for prefix icon
  final IconData? suffixIcon; // Added for suffix icon
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted; // Added for submission
  final VoidCallback? onEditingComplete; // Added for editing complete
  final VoidCallback? onTap; // Added for tap action
  final bool? readOnly; // Added for read-only state
  final bool? enabled; // Added for enabling/disabling the field

  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final List<TextInputFormatter>? inputFormatters;

  final int? minLines;
  final int? maxLines;
  final bool obscureText;
  final FormSize size;

  final bool isPassword;
  final double radius;

  const CustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.minLines,
    this.maxLines = 1,
    this.obscureText = false,
    this.size = FormSize.medium,
    this.isPassword = false,
    this.radius = 4,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isDisabled = !(widget.enabled ?? true) || (widget.readOnly ?? false);
    final FormConfig config = getFormConfig(widget.size);

    return (widget.minLines != null && widget.minLines! > 1)
        ? buildTextField(isDisabled, config, themeData)
        : SizedBox(
            height: config.formHeight,
            child: buildTextField(isDisabled, config, themeData),
          );
  }

  TextField buildTextField(
    bool isDisabled,
    FormConfig config,
    ThemeData themeData,
  ) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted, // Handle input submission
      onEditingComplete: widget.onEditingComplete, // Handle editing complete
      onTap: widget.onTap, // Handle tap action
      readOnly: widget.readOnly ?? false, // Handle read-only state
      enabled: widget.enabled ?? true, // Handle enabled/disabled state
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      obscureText: _obscure,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: null, //  custom error handling
        counterText: "", // not showing maxLength in default counter
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          gapPadding: 0,
          borderSide: BorderSide(width: outlineWidth),
        ),
        isDense: true,
        contentPadding: (widget.minLines != null && widget.minLines! > 1)
            ? EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              )
            : config.padding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: kPrimaryColor, width: outlineWidth),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, size: config.iconSize)
            : null, // Add prefix icon
        suffixIcon: widget.isPassword
            ? InkWell(
                child: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: config.iconSize,
                ),
                onTap: () {
                  setState(() {
                    _obscure = !_obscure; // Toggle password visibility
                  });
                },
              )
            : widget.suffixIcon != null
            ? Icon(widget.suffixIcon, size: config.iconSize)
            : null, // Add suffix icon

        prefixIconConstraints: BoxConstraints.tightFor(
          width: config.formHeight,
          height: config.iconSize,
        ),
        suffixIconConstraints: BoxConstraints.tightFor(
          width: config.formHeight,
          height: config.iconSize,
        ),

        fillColor: isDisabled
            ? kTableHeaderColor
            : themeData
                  .colorScheme
                  .surfaceContainerHighest, // Change background color
      ),
      style: TextStyle(
        color: themeData.colorScheme.onSurface,
        fontSize: config.fontSize,
      ),
    );
  }
}

//Input Group
enum TextFieldPosition { left, right, center, both }

class InputGroup extends StatelessWidget {
  final TextFieldPosition position;
  final String? hintTextLeft;
  final String? hintTextRight;
  final String? hintText;
  final Widget? buttonChildRight;
  final Widget? buttonChildLeft;
  final Widget? buttonChild; // For single button in both case

  const InputGroup({
    super.key,
    required this.position,
    this.hintTextLeft,
    this.hintTextRight,
    this.hintText,
    this.buttonChildRight,
    this.buttonChildLeft,
    this.buttonChild,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: mediumHeight,
      decoration: BoxDecoration(
        border: Border.all(
          width: outlineWidth,
          color: themeData.colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildInputGroup(context),
      ),
    );
  }

  List<Widget> _buildInputGroup(BuildContext context) {
    List<Widget> widgets = [];

    switch (position) {
      case TextFieldPosition.left:
        widgets.add(
          _buildTextField(hintTextLeft ?? 'Enter text here', context),
        );
        widgets.add(
          _buildButton(
            buttonChildRight ?? Text('Button'),
            context,
            false,
            true,
          ),
        );
        break;
      case TextFieldPosition.right:
        widgets.add(
          _buildButton(buttonChildLeft ?? Text('Button'), context, true, false),
        );
        widgets.add(
          _buildTextField(hintTextRight ?? 'Enter text here', context),
        );
        break;
      case TextFieldPosition.center:
        widgets.add(
          _buildButton(
            buttonChildLeft ?? Text('Button 1'),
            context,
            true,
            false,
          ),
        ); // First button
        widgets.add(
          _buildTextField(hintText ?? 'Enter text here', context),
        ); // Center text field
        widgets.add(
          _buildButton(
            buttonChildRight ?? Text('Button 2'),
            context,
            false,
            true,
          ),
        ); // Second button
        break;
      case TextFieldPosition.both:
        widgets.add(
          _buildTextField(hintTextLeft ?? 'Hint 1', context),
        ); // First text field
        widgets.add(
          _buildButton(buttonChild ?? Text('Button'), context, true, true),
        ); // Button in between
        widgets.add(
          _buildTextField(hintTextRight ?? 'Hint 2', context),
        ); // Second text field
        break;
    }

    return widgets;
  }

  Widget _buildTextField(String hint, BuildContext context) {
    final themeData = Theme.of(context);
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // This line removes the border
            enabledBorder: InputBorder.none, // Remove border when enabled
            focusedBorder: InputBorder.none, // Remove border when focused
            hintText: hint,
          ),
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontSize: kBodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    Widget child,
    BuildContext context,
    bool isLeftEdge,
    bool isRightEdge,
  ) {
    final themeData = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.1),
        border: Border(
          left: isRightEdge
              ? BorderSide(
                  width: outlineWidth,
                  color: themeData.colorScheme.outline,
                )
              : BorderSide.none,
          right: isLeftEdge
              ? BorderSide(
                  width: outlineWidth,
                  color: themeData.colorScheme.outline,
                )
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}

// input with button

class ActionInputField extends StatefulWidget {
  final String hintText;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final void Function(String value)? onSubmit;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool clearOnSubmit;
  final FormSize size;
  final String? successMessage;
  final double radius;

  const ActionInputField({
    super.key,
    required this.hintText,
    required this.buttonText,
    this.textColor = Colors.white,
    required this.buttonColor,
    this.onSubmit,
    this.controller,
    this.validator,
    this.clearOnSubmit = true,
    this.size = FormSize.medium,
    this.successMessage,
    this.radius = defaultRadius,
  });

  @override
  State<ActionInputField> createState() => _ActionInputFieldState();
}

class _ActionInputFieldState extends State<ActionInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit(FormFieldState<String> field) {
    // Jalankan validasi internal jika ada
    final isValid = field.validate();
    if (isValid && widget.onSubmit != null) {
      widget.onSubmit!(_controller.text.trim());
      if (widget.clearOnSubmit) _controller.clear();
      field.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final FormConfig config = getFormConfig(widget.size);

    return FormField<String>(
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // field
                Expanded(
                  child: SizedBox(
                    height: config.formHeight,
                    child: TextFormField(
                      controller: _controller,
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontSize: config.fontSize,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        errorText: null,
                        counterText: "",
                        isDense: false,
                        contentPadding: config.padding,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          gapPadding: 0,
                          borderSide: BorderSide(width: outlineWidth),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          borderSide: BorderSide(
                            width: outlineWidth,
                            color: themeData.colorScheme.outline,
                          ),
                          gapPadding: 0,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          borderSide: BorderSide(
                            color: kErrorColor,
                            width: outlineWidth,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: outlineWidth,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(widget.radius),
                            bottomStart: Radius.circular(widget.radius),
                          ).resolve(Directionality.of(context)),
                          borderSide: BorderSide(
                            color: kErrorColor,
                            width: outlineWidth,
                          ),
                        ),
                      ),
                      onChanged: field.didChange,
                      onFieldSubmitted: (_) => _handleSubmit(field),
                    ),
                  ),
                ),

                // button
                SizedBox(
                  height: config.formHeight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: widget.buttonColor,
                      foregroundColor: widget.textColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(widget.radius),
                          bottomEnd: Radius.circular(widget.radius),
                        ),
                      ),
                    ),
                    onPressed: () => _handleSubmit(field),
                    child: Text(
                      widget.buttonText,
                      style: TextStyle(fontSize: config.fontSize),
                    ),
                  ),
                ),
              ],
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
            else if (field.isValid &&
                field.value != null &&
                field.value!.isNotEmpty &&
                widget.successMessage != null)
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

class FormLabel extends StatelessWidget {
  const FormLabel({
    super.key,
    required this.text,
    this.showRequired = true,
    this.fontWeight = FontWeight.w600,
    this.fontColor,
  });

  final String text;
  final bool? showRequired;
  final FontWeight fontWeight;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return showRequired == false
        ? labelText(themeData)
        : Row(
            children: [
              labelText(themeData),
              Text(
                ' *',
                style: TextStyle(color: kErrorColor, fontWeight: fontWeight),
              ),
            ],
          );
  }

  Text labelText(ThemeData themeData) {
    return Text(
      text,
      style: TextStyle(
        color: fontColor ?? themeData.colorScheme.onSurface,
        fontWeight: fontWeight,
      ),
    );
  }
}

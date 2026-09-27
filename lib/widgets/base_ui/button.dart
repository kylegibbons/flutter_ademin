import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Enum for button size
enum ButtonSize { small, medium, large }

class ButtonConfig {
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry textPadding;
  final double iconSize;
  final double buttonHeight;
  final double horizontalPadding;

  ButtonConfig({
    required this.fontSize,
    required this.padding,
    required this.textPadding,
    required this.iconSize,
    required this.buttonHeight,
    required this.horizontalPadding,
  });
}

ButtonConfig getButtonConfig(ButtonSize size) {
  switch (size) {
    case ButtonSize.small:
      return ButtonConfig(
        fontSize: kBodySmall,
        padding: const EdgeInsets.symmetric(
          horizontal: 0.4 * kDefaultPadding,
          vertical: 0,
        ),
        textPadding: const EdgeInsets.symmetric(
          horizontal: 0.2 * kDefaultPadding,
        ),
        horizontalPadding: 0.4 * kDefaultPadding,
        iconSize: 12,
        buttonHeight: smallHeight,
      );
    case ButtonSize.medium:
      return ButtonConfig(
        fontSize: kBodyMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 0,
        ),
        textPadding: const EdgeInsets.symmetric(
          horizontal: 0.5 * kDefaultPadding,
        ),
        horizontalPadding: 0.5 * kDefaultPadding,
        iconSize: 16,
        buttonHeight: mediumHeight,
      );
    case ButtonSize.large:
      return ButtonConfig(
        fontSize: kBodyLarge,
        padding: const EdgeInsets.symmetric(
          horizontal: 1.2 * kDefaultPadding,
          vertical: 0,
        ),
        textPadding: const EdgeInsets.symmetric(
          horizontal: 0.8 * kDefaultPadding,
        ),
        horizontalPadding: 1.2 * kDefaultPadding,
        iconSize: 20,
        buttonHeight: largeHeight,
      );
  }
}

// animated button function

class AnimatedContent extends StatefulWidget {
  final bool isAnimated;
  final Widget child;
  final Duration duration;

  const AnimatedContent({
    super.key,
    required this.isAnimated,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<AnimatedContent> createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<AnimatedContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, -0.2), // naik
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -0.2),
          end: const Offset(0, 0.2), // turun
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero, // kembali
        ),
        weight: 1.0,
      ),
    ]).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    if (widget.isAnimated) {
      _controller.forward(from: 0);
    }
  }

  void _onExit(PointerEvent details) {
    if (widget.isAnimated) {}
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnimated) return widget.child;

    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: SlideTransition(position: _animation, child: widget.child),
    );
  }
}

// split button

class SplitButton extends StatelessWidget {
  final VoidCallback onPrimaryPressed;
  final List<PopupMenuEntry<String>> menuItems;
  final void Function(String)? onMenuItemSelected;
  final String label;
  final Color? backgroundColor;
  final Color foregroundColor;
  final double borderRadius;

  const SplitButton({
    super.key,
    required this.onPrimaryPressed,
    required this.menuItems,
    this.onMenuItemSelected,
    this.label = 'Action',
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediumHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onPrimaryPressed,
            style: TextButton.styleFrom(
              foregroundColor: foregroundColor,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
            ),
            child: Text(label),
          ),
          Container(
            width: 1,
            height: mediumHeight,
            color: foregroundColor.withValues(alpha: 0.3),
          ),
          PopupMenuButton<String>(
            onSelected: onMenuItemSelected,
            itemBuilder: (context) => menuItems,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: Icon(Icons.arrow_drop_down, color: foregroundColor),
            ),
          ),
        ],
      ),
    );
  }
}

// custom icon button

enum ButtonShape { circle, square }

class CustomIconButton extends StatelessWidget {
  final Object icon;
  final ButtonShape shape;
  final Color? buttonColor;
  final Color? hoverColor;
  final Color? iconColor;
  final String? tooltipMessage;
  final VoidCallback? onTap;
  final bool isOutlined;
  final Color? outlineColor;
  final bool useFontAwesome;
  final ButtonSize size;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.shape = ButtonShape.square,
    this.buttonColor,
    this.hoverColor,
    this.iconColor,
    this.tooltipMessage,
    this.onTap,
    this.isOutlined = false,
    this.outlineColor,
    this.useFontAwesome = false,
    this.size = ButtonSize.medium, // Default value
  });

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final borderRadius = shape == ButtonShape.circle
        ? BorderRadius.circular(config.buttonHeight / 2)
        : BorderRadius.circular(defaultRadius);
    final themeData = Theme.of(context);

    Widget iconWidget;

    if (useFontAwesome && icon is FaIconData) {
      iconWidget = FaIcon(
        icon as FaIconData,
        size: config.iconSize,
        color: iconColor ?? kTextColor,
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        size: config.iconSize,
        color: iconColor ?? kTextColor,
      );
    } else {
      throw ArgumentError('icon must be IconData or FaIconData');
    }

    if (shape == ButtonShape.square) {
      return Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        borderRadius: borderRadius,
        child: Tooltip(
          message: tooltipMessage ?? '',
          child: InkWell(
            onTap: onTap,
            hoverColor: hoverColor ?? Colors.blueGrey.withValues(alpha: 0.1),
            customBorder: RoundedRectangleBorder(borderRadius: borderRadius),
            child: Container(
              height: config.buttonHeight,
              width: config.buttonHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: buttonColor ?? Colors.transparent,
                borderRadius: borderRadius,
                border: isOutlined
                    ? Border.all(
                        color: outlineColor ?? themeData.colorScheme.outline,
                        width: outlineWidth,
                      )
                    : null,
              ),
              child: iconWidget,
            ),
          ),
        ),
      );
    } else {
      return Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        borderRadius: borderRadius,
        child: Tooltip(
          message: tooltipMessage ?? '',
          child: InkWell(
            onTap: onTap,
            hoverColor: hoverColor ?? Colors.blueGrey.withValues(alpha: 0.1),
            customBorder: RoundedRectangleBorder(borderRadius: borderRadius),
            child: CircleAvatar(
              backgroundColor: buttonColor ?? Colors.transparent,
              radius: config.buttonHeight / 2,
              child: iconWidget,
            ),
          ),
        ),
      );
    }
  }
}

//Fancy Icon Button widget

class FancyIconButton extends StatelessWidget {
  const FancyIconButton({
    super.key,
    required this.kText,
    required this.kTextColor,
    required this.bgColor,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.isFullWidth = false,
  });

  final String kText;
  final Color kTextColor, bgColor;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final bool isDisabled = onPressed == null;
    const double disabledOpacity = 0.4;
    const double textDisabledOpacity = 0.8;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (isDisabled) {
            return bgColor.withValues(alpha: disabledOpacity);
          }
          return bgColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (isDisabled) {
            return kTextColor.withValues(alpha: textDisabledOpacity);
          }
          return kTextColor;
        }),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? 50 : defaultRadius),
          ),
        ),
      ),
      child: AnimatedContent(
        isAnimated: isAnimated,
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: config.buttonHeight,
                    width: config.buttonHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        isRounded ? 50 : defaultRadius,
                      ),
                    ),
                    child: SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? kTextColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  if (isFullWidth) Spacer(),
                  Padding(
                    padding: config.textPadding,
                    child: Text(
                      loadingText,
                      style: TextStyle(
                        fontSize: config.fontSize,
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                  ),
                  if (isFullWidth) Spacer(),
                  if (isFullWidth)
                    SizedBox(
                      width: config.buttonHeight - config.horizontalPadding,
                    ),
                  SizedBox(width: config.horizontalPadding),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  kLeadingIcon != null
                      ? Container(
                          height: config.buttonHeight,
                          width: config.buttonHeight,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kTextColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              isRounded ? 50 : defaultRadius,
                            ),
                          ),
                          child: Icon(
                            kLeadingIcon,
                            color: kTextColor,
                            size: config.iconSize,
                          ),
                        )
                      : SizedBox(width: config.horizontalPadding),
                  if (isFullWidth) Spacer(),
                  if (isFullWidth && kLeadingIcon == null)
                    SizedBox(
                      width: config.buttonHeight - config.horizontalPadding,
                    ),
                  Padding(
                    padding: config.textPadding,
                    child: Text(
                      kText,
                      style: TextStyle(fontSize: config.fontSize),
                    ),
                  ),
                  if (isFullWidth) Spacer(),
                  if (isFullWidth && kTrailingIcon == null)
                    SizedBox(
                      width: config.buttonHeight - config.horizontalPadding,
                    ),
                  kTrailingIcon != null
                      ? Container(
                          height: config.buttonHeight,
                          width: config.buttonHeight,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              isRounded ? 50 : defaultRadius,
                            ),
                          ),
                          child: Icon(
                            kTrailingIcon,
                            color: kTextColor,
                            size: config.iconSize,
                          ),
                        )
                      : SizedBox(width: config.horizontalPadding),
                ],
              ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.kText,
    required this.bgColor,
    required this.kTextColor,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.isFullWidth = false,
  });

  final String kText;
  final List<Color> bgColor;
  final Color kTextColor;
  final VoidCallback onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: bgColor, // Define your gradient colors here
        ),
        borderRadius: BorderRadius.circular(isRounded ? 50 : defaultRadius),
      ),
      height: config.buttonHeight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: config.padding,
          foregroundColor: kTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isRounded ? 50 : defaultRadius),
          ),
        ),
        child: AnimatedContent(
          isAnimated: isAnimated,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? kTextColor,
                        strokeWidth: 2,
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth) SizedBox(width: config.iconSize),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kLeadingIcon != null)
                      Icon(kLeadingIcon, size: config.iconSize),
                    if (isFullWidth && kLeadingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        kText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth && kTrailingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (kTrailingIcon != null)
                      Icon(kTrailingIcon, size: config.iconSize),
                  ],
                ),
        ),
      ),
    );
  }
}

//soft button widget

class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.kText,
    required this.bgColor,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.isFullWidth = false,
  });

  final String kText;
  final Color bgColor;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final bool isDisabled = onPressed == null;
    const double disabledOpacity = 0.05;
    const double textDisabledOpacity = 0.4;
    return SizedBox(
      height: config.buttonHeight,
      child: TextButton(
        onPressed: onPressed,
        // style: TextButton.styleFrom(
        //   backgroundColor: bgColor.withValues(alpha: 0.1),
        //   foregroundColor: bgColor,
        //   padding: config.padding,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(
        //       isRounded ? 50 : defaultRadius,
        //     ),
        //   ),
        // ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return bgColor.withValues(alpha: disabledOpacity);
            }
            return bgColor.withValues(alpha: 0.1);
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return bgColor.withValues(alpha: textDisabledOpacity);
            }
            return bgColor;
          }),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(config.padding),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                isRounded ? 50 : defaultRadius,
              ),
            ),
          ),
        ),
        child: AnimatedContent(
          isAnimated: isAnimated,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? bgColor,
                        strokeWidth: 2,
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: bgColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth) SizedBox(width: config.iconSize),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kLeadingIcon != null)
                      Icon(kLeadingIcon, size: config.iconSize),
                    if (isFullWidth && kLeadingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        kText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth && kTrailingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (kTrailingIcon != null)
                      Icon(kTrailingIcon, size: config.iconSize),
                  ],
                ),
        ),
      ),
    );
  }
}

//Custom outlined button

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.kText,
    required this.outlineColor,
    this.textColor,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.isFullWidth = false,
  });

  final String kText;
  final Color outlineColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final bool isDisabled = onPressed == null;
    const double disabledOpacity = 0.4;
    const double textDisabledOpacity = 0.4;
    return SizedBox(
      height: config.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,

        style: ButtonStyle(
          side: WidgetStateProperty.resolveWith<BorderSide?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return BorderSide(
                color: outlineColor.withValues(alpha: disabledOpacity),
                width: 1.0,
              );
            }
            return BorderSide(color: outlineColor);
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return outlineColor.withValues(alpha: textDisabledOpacity);
            }
            return outlineColor;
          }),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(config.padding),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                isRounded ? 50 : defaultRadius,
              ),
            ),
          ),
        ),
        child: AnimatedContent(
          isAnimated: isAnimated,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? outlineColor,
                        strokeWidth: 2,
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: textColor ?? outlineColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth) SizedBox(width: config.iconSize),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kLeadingIcon != null)
                      Icon(
                        kLeadingIcon,
                        size: config.iconSize,
                        color: textColor,
                      ),
                    if (isFullWidth && kLeadingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        kText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: textColor ?? outlineColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth && kTrailingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (kTrailingIcon != null)
                      Icon(
                        kTrailingIcon,
                        size: config.iconSize,
                        color: textColor,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

//flat button widget

class FlatButton extends StatelessWidget {
  const FlatButton({
    super.key,
    required this.kText,
    required this.bgColor,
    required this.kTextColor,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.enabled = true,
    this.tooltip,
    this.focusNode,
    this.autofocus = false,
    this.onLongPress,
    this.isFullWidth = false,
  });

  final String kText;
  final Color bgColor, kTextColor;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool enabled;
  final String? tooltip;
  final FocusNode? focusNode;
  final bool autofocus;
  final VoidCallback? onLongPress;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final bool isDisabled = onPressed == null;
    const double disabledOpacity = 0.4;
    const double textDisabledOpacity = 0.8;
    return SizedBox(
      height: config.buttonHeight,
      child: TextButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        onLongPress: enabled && !isLoading ? onLongPress : null,
        focusNode: focusNode,
        autofocus: autofocus,

        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return bgColor.withValues(alpha: disabledOpacity);
            }
            return bgColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return kTextColor.withValues(alpha: textDisabledOpacity);
            }
            return kTextColor;
          }),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(config.padding),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                isRounded ? 50 : defaultRadius,
              ),
            ),
          ),
        ),
        child: AnimatedContent(
          isAnimated: isAnimated,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? kTextColor,
                        strokeWidth: 2,
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth) SizedBox(width: config.iconSize),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kLeadingIcon != null)
                      Icon(kLeadingIcon, size: config.iconSize),
                    if (isFullWidth && kLeadingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        kText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth && kTrailingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (kTrailingIcon != null)
                      Icon(kTrailingIcon, size: config.iconSize),
                  ],
                ),
        ),
      ),
    );
  }
}

//custom elevated button

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.kText,
    required this.bgColor,
    required this.kTextColor,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isRounded = false,
    this.kLeadingIcon,
    this.kTrailingIcon,
    this.isAnimated = false,
    this.isLoading = false,
    this.loaderColor,
    this.loadingText = 'Loading...',
    this.isFullWidth = false,
  });

  final String kText;
  final Color bgColor, kTextColor;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isRounded;
  final IconData? kLeadingIcon;
  final IconData? kTrailingIcon;
  final bool isAnimated;
  final bool isLoading;
  final Color? loaderColor;
  final String loadingText;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final ButtonConfig config = getButtonConfig(size);
    final bool isDisabled = onPressed == null;
    const double disabledOpacity = 0.4;
    const double textDisabledOpacity = 0.8;
    return SizedBox(
      height: config.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return bgColor.withValues(alpha: disabledOpacity);
            }
            return bgColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (isDisabled) {
              return kTextColor.withValues(alpha: textDisabledOpacity);
            }
            return kTextColor;
          }),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(config.padding),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                isRounded ? 50 : defaultRadius,
              ),
            ),
          ),
        ),
        child: AnimatedContent(
          isAnimated: isAnimated,
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: config.iconSize,
                      width: config.iconSize,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? kTextColor,
                        strokeWidth: 2,
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        loadingText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth) SizedBox(width: config.iconSize),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (kLeadingIcon != null)
                      Icon(kLeadingIcon, size: config.iconSize),
                    if (isFullWidth && kLeadingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (isFullWidth) Spacer(),
                    Padding(
                      padding: config.textPadding,
                      child: Text(
                        kText,
                        style: TextStyle(
                          fontSize: config.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isFullWidth) Spacer(),
                    if (isFullWidth && kTrailingIcon == null)
                      SizedBox(width: config.iconSize),
                    if (kTrailingIcon != null)
                      Icon(kTrailingIcon, size: config.iconSize),
                  ],
                ),
        ),
      ),
    );
  }
}

// custom choice chip button

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onSelected(!selected),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: selected
                ? themeData.colorScheme.primary
                : themeData.colorScheme.surface,
            border: Border.all(
              color: selected
                  ? themeData.colorScheme.primary
                  : themeData.dividerColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? themeData.colorScheme.surface
                  : themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

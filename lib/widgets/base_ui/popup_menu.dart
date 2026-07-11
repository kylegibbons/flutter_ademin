import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

/// Data model untuk custom item popup menu
class PopupMenuItemData<T> {
  final T value;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final bool iconEnd;
  final bool enabled;
  final bool showDividerAfter;
  final TextStyle? textStyle;

  final Widget? child;

  PopupMenuItemData({
    required this.value,
    this.child,
    this.text,
    this.icon,
    this.iconColor,
    this.iconSize = 16,
    this.iconEnd = false,
    this.enabled = true,
    this.showDividerAfter = false,
    this.textStyle,
  });
}

/// Reusable & powerful popup menu widget
class CustomPopupMenu<T> extends StatelessWidget {
  final List<PopupMenuItemData<T>> items;
  final Widget? child;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final void Function(T value)? onSelected;
  final PopupMenuPosition position;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final double elevation;
  final EdgeInsets itemPadding;
  final bool enableFeedback;
  final Offset offset;
  final Color? hoverColor;
  final Color? disabledColor;
  final BorderRadius borderRadius;
  final double dividerThickness;
  final Color? dividerColor;
  final double splashRadius;

  const CustomPopupMenu({
    super.key,
    required this.items,
    this.child,
    this.icon,
    this.iconSize = 16,
    this.iconColor,
    this.onSelected,
    this.position = PopupMenuPosition.under,
    this.shape,
    this.backgroundColor,
    this.elevation = 8,
    this.itemPadding = const EdgeInsets.symmetric(
      horizontal: kDefaultPadding,
      vertical: 0,
    ),
    this.enableFeedback = true,
    this.offset = Offset.zero,
    this.hoverColor,
    this.disabledColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(defaultRadius)),
    this.dividerThickness = outlineWidth,
    this.dividerColor,
    this.splashRadius = mediumHeight / 2,
  }) : assert(
         child != null || icon != null,
         'Either child or icon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return PopupMenuButton<T>(
      itemBuilder: (context) {
        final List<PopupMenuEntry<T>> menuEntries = [];

        for (int i = 0; i < items.length; i++) {
          final item = items[i];
          menuEntries.add(_buildMenuItem(context, item, themeData));

          // Tambahkan divider jika showDividerAfter = true
          if (item.showDividerAfter && i < items.length - 1) {
            menuEntries.add(PopupMenuDivider(height: 0));
          }
        }

        return menuEntries;
      },
      onSelected: onSelected,
      position: position,
      shape: shape ?? RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColor ?? themeData.colorScheme.surface,
      elevation: elevation,
      enableFeedback: enableFeedback,
      popUpAnimationStyle: AnimationStyle.noAnimation,
      offset: offset,
      splashRadius: splashRadius,
      icon: child == null
          ? Icon(
              icon,
              size: iconSize,
              color: iconColor ?? themeData.colorScheme.onSurface,
            )
          : null,
      child: child,
    );
  }

  PopupMenuItem<T> _buildMenuItem(
    BuildContext context,
    PopupMenuItemData<T> item,
    ThemeData themeData,
  ) {
    final isDisabled = !item.enabled;

    // Jika child kustom diberikan, gunakan langsung tanpa layout default
    if (item.child != null) {
      return PopupMenuItem<T>(
        value: item.value,
        enabled: item.enabled,
        padding: itemPadding,
        child: item.child!,
      );
    }
    final textColor = isDisabled
        ? (disabledColor ?? themeData.disabledColor)
        : (item.textStyle?.color ?? themeData.colorScheme.onSurface);

    // ✅ Warna icon prioritas: item.iconColor → disabledColor → default
    final iconColor = isDisabled
        ? (disabledColor ?? themeData.disabledColor)
        : (item.iconColor ?? themeData.iconTheme.color);

    final textWidget = item.text != null
        ? Text(
            item.text!,
            style:
                item.textStyle?.copyWith(color: textColor) ??
                TextStyle(
                  color: isDisabled
                      ? (disabledColor ?? themeData.disabledColor)
                      : themeData.colorScheme.onSurface,
                ),
          )
        : const SizedBox();

    final iconWidget = item.icon != null
        ? Icon(item.icon, size: item.iconSize, color: iconColor)
        : const SizedBox();

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!item.iconEnd) iconWidget,
        if (item.icon != null && item.text != null)
          const SizedBox(width: kDefaultPadding / 2),
        textWidget,
        if (item.iconEnd) ...[
          if (item.text != null && item.icon != null)
            const SizedBox(width: kDefaultPadding / 2),
          iconWidget,
        ],
      ],
    );

    return PopupMenuItem<T>(
      value: item.value,
      enabled: item.enabled,
      padding: itemPadding,
      child: content,
    );
  }
}

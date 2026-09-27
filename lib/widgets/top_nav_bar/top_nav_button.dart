// Top Navigation Icon Button
// use as default icon button in top navigation bar

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class TopNavButton extends StatelessWidget {
  const TopNavButton({
    super.key,
    this.onTap,
    required this.icon,
    this.bgColor,
    this.tooltipMessage,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final Color? bgColor;
  final String? tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Tooltip(
        message: tooltipMessage,
        child: InkWell(
          onTap: onTap,
          hoverColor: kSecondaryColor.withValues(alpha: 0.1),
          splashColor: kSecondaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(50),
          child: CircleAvatar(
            radius: mediumHeight / 2,
            backgroundColor: bgColor ?? Colors.transparent,
            child: Icon(icon, color: kTextColor),
          ),
        ),
      ),
    );
  }
}

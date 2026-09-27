import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

/// Filter Tab

class FilterTab extends StatelessWidget {
  final String label;
  final int? badge;
  final bool isSelected;
  final VoidCallback onTap;
  final ThemeData themeData;
  final Color? color;

  const FilterTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.themeData,
    this.badge,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(
          color: isSelected ? kSecondaryColor : themeData.colorScheme.outline,
          width: 0.6,
        ),
      ),

      showCheckmark: false,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: kBodyMedium,
              color: isSelected ? kSecondaryColor : kTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (badge != null && badge! > 0) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color ?? kErrorColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$badge',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.transparent,
      selectedColor: kSecondaryColor.withValues(alpha: 0.1),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class PricingTabSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const PricingTabSelector({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isMonthly = selectedIndex == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOption(
          context: context,
          label: "Monthly",
          selected: isMonthly,
          onTap: () => onTabChanged(0),
          showArrow: isMonthly,
        ),
        _buildOption(
          context: context,
          label: "Annually",
          selected: !isMonthly,
          onTap: () => onTabChanged(1),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: kSuccessColor,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Text(
              "25% Off",
              style: TextStyle(color: Colors.white, fontSize: kBodySmall),
            ),
          ),
          showArrow: !isMonthly, // Show arrow only when selected
        ),
      ],
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Widget? trailing,
    bool showArrow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: selected ? kPrimaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: kDefaultPadding / 3),
                  trailing,
                ],
              ],
            ),
          ),
          // FaIcon(
          //   FontAwesomeIcons.caretDown,
          //   size: 16,
          //   color: selected && showArrow ? kPrimaryColor : Colors.transparent,
          // ),
          Transform.translate(
            offset: Offset(0, -8),
            child: Icon(
              Icons.arrow_drop_down,
              size: 32,
              color: selected && showArrow ? kPrimaryColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

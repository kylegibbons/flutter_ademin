import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class PortfolioMetricCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double mainAmount;
  final double subAmount;
  final double percentageChange;
  final Color iconColor;
  final Color? bgColor;

  PortfolioMetricCard({
    super.key,
    required this.title,
    required this.icon,
    required this.mainAmount,
    required this.subAmount,
    required this.percentageChange,
    Color? iconColor,
    this.bgColor,
  }) : iconColor = iconColor ?? kPrimaryColor;

  String formatNumber(double value) {
    return value
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = percentageChange >= 0;
    final themeData = Theme.of(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(color: bgColor ?? Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: kBodyMedium,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  Text(
                    '\$${formatNumber(mainAmount)}',
                    style: TextStyle(
                      fontSize: kHeadlineSmall,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: [
                      Text(
                        '\$${formatNumber(subAmount)}',
                        style: TextStyle(
                          fontSize: kBodyMedium + 1,
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),
                      Container(
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.surface,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isPositive
                                ? kSuccessColor.withValues(alpha: 0.2)
                                : kErrorColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isPositive
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: isPositive ? kSuccessColor : kErrorColor,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${percentageChange.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color: isPositive
                                      ? kSuccessColor
                                      : kErrorColor,
                                  fontSize: kBodySmall,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(icon, size: 36, color: iconColor),
          ],
        ),
      ),
    );
  }
}

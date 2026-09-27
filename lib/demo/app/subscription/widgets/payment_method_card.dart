import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/subscription/dialogs/update_payment.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_data.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:flutkit_ademin/widgets/base_ui/progress.dart';

class PaymentMethodCard extends StatelessWidget {
  final String cardBrand;
  final String last4Digits;
  final String expiry;

  const PaymentMethodCard({
    super.key,
    required this.cardBrand,
    required this.last4Digits,
    required this.expiry,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kScreenWidthXl;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title section
            Text(
              "Payment Method",
              style: TextStyle(
                fontSize: kBodyLarge,
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: kDefaultPadding / 4),

            /// Subtitle
            Text("Manage your payment details"),

            const SizedBox(height: kDefaultPadding),

            /// Card info container
            Container(
              padding: const EdgeInsets.all(kDefaultPadding),

              /// Inner card style (slightly elevated look)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                border: Border.all(
                  color: themeData.colorScheme.outline,
                  width: outlineWidth,
                ),
              ),

              child: Row(
                children: [
                  /// Card icon container
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    child: Icon(
                      Icons.credit_card,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(width: kDefaultPadding),

                  /// Card details (brand + last digits + expiry)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${cardBrand.toUpperCase()} **** **** **** $last4Digits",
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 4),
                        Text("Expires $expiry"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Update button (full width)
            CustomOutlinedButton(
              kText: "Update Payment Method",
              outlineColor: themeData.colorScheme.primary,
              isFullWidth: true,
              onPressed: () {
                // update payment method dialog

                showCustomDialog(
                  context: context,
                  title: "Update Payment Method",
                  showCloseButton: true,
                  width: 720,
                  content: UpdatePaymentDialog(parentContext: context),
                );
              },
            ),

            const SizedBox(height: 1.2 * kDefaultPadding),
            if (!isMobile) const Spacer(),
            // usage
            UsageSection(),
          ],
        ),
      ),
    );
  }
}

// usage progress bar

class UsageProgressItem extends StatelessWidget {
  final String title;
  final double value;
  final double max;
  final String unit; // e.g. "GB", "calls", "seats"

  const UsageProgressItem({
    super.key,
    required this.title,
    required this.value,
    required this.max,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    /// Ensure progress stays between 0 and 1
    final progress = (value / max).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top row: label + usage text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
            Text(
              "${value.toStringAsFixed(0)} / ${max.toStringAsFixed(0)} $unit",
            ),
          ],
        ),

        const SizedBox(height: kDefaultPadding / 2),

        /// Progress bar container
        LinearProgress(
          value: progress,
          color: themeData.colorScheme.onSurface,
          isAnimated: true,
        ),
      ],
    );
  }
}

class UsageSection extends StatelessWidget {
  const UsageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section title
        Text(
          "Usage",
          style: TextStyle(
            color: themeData.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: kDefaultPadding),

        /// usage list
        Column(
          children: [
            for (int i = 0; i < usageItems.length; i++) ...[
              UsageProgressItem(
                title: usageItems[i].title,
                value: usageItems[i].value,
                max: usageItems[i].max,
                unit: usageItems[i].unit,
              ),
              if (i != usageItems.length - 1)
                const SizedBox(height: kDefaultPadding),
            ],
          ],
        ),
      ],
    );
  }
}

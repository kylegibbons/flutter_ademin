import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/subscription/dialogs/cancel_subscription.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_data.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:go_router/go_router.dart';

class CurrentPlanCard extends StatelessWidget {
  const CurrentPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final currentPlan = getCurrentPlan();
    final activeFeatures = List<String>.from(
      currentPlan['activeFeatures'] as List<dynamic>? ?? const [],
    );
    final inactiveFeatures = List<String>.from(
      currentPlan['inactiveFeatures'] as List<dynamic>? ?? const [],
    );
    final title = currentPlan['title'] as String? ?? 'Unknown';
    final price = currentPlan['price'] as num? ?? 0;

    final List<FeatureItemModel> features = [
      ...activeFeatures.map((e) => FeatureItemModel(text: e, isActive: true)),
      ...inactiveFeatures.map(
        (e) => FeatureItemModel(text: e, isActive: false),
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < kScreenWidthXl;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top section: Title + Plan badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Left: Title and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Plan",
                      style: TextStyle(
                        fontSize: kBodyLarge,
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding / 4),
                    Text("You are on the $title Plan"),
                  ],
                ),

                CustomBadge(
                  kText: '$title Plan',
                  kFontSize: kBodyMedium,
                  kColor: kSuccessColor,
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            /// Price section
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: kHeadlineMedium,
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Text(
                  "/month",
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            /// Feature list
            Column(
              children: features.map((item) {
                return _FeatureItem(text: item.text, isActive: item.isActive);
              }).toList(),
            ),

            if (!isMobile) const Spacer(),
            const SizedBox(height: 1.2 * kDefaultPadding),

            /// Action buttons
            Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding / 2,
              children: [
                /// Primary action
                FlatButton(
                  kText: "Upgrade Plan",
                  bgColor: kSecondaryColor,
                  kTextColor: Colors.white,
                  isFullWidth: isMobile ? true : false,
                  onPressed: () {
                    // updrade plan logic
                    GoRouter.of(context).go(RouteUri.pricing);
                  },
                ),

                /// Secondary action
                CustomOutlinedButton(
                  kText: "Cancel Subscription",
                  outlineColor: themeData.colorScheme.primary,
                  isFullWidth: isMobile ? true : false,
                  onPressed: () {
                    // cancel plan dialog

                    showCustomDialog(
                      context: context,
                      title: "Cancel Subscription?",
                      showCloseButton: true,
                      width: 640,
                      content: CancelSubscriptionDialog(
                        expiryDate: DateTime(2026, 8, 12),
                        onCancelConfirmed: () {
                          // call API cancel subscription
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  final bool isActive;

  const _FeatureItem({required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Row(
        children: [
          /// Icon changes based on active state
          Icon(
            isActive ? Icons.check : Icons.close,
            color: isActive ? kSuccessColor : kErrorColor,
            size: 18,
          ),
          const SizedBox(width: kDefaultPadding),

          /// Text style also reflects state
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

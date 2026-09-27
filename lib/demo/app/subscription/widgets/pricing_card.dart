import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class PricingCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final bool isMonthly;
  const PricingCard({super.key, required this.plan, this.isMonthly = true});

  @override
  Widget build(BuildContext context) {
    final isPopular = plan['isPopular'] ?? false;
    final isCurrent = plan['isCurrent'] ?? false;
    final themeData = Theme.of(context);
    final annualPrice = plan['price'] * 12;
    final discountedAnualPrice = annualPrice * 0.75; // 25% off

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: kTableHeaderColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // plan title
                  Row(
                    children: [
                      Text(
                        plan['title'],
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          fontWeight: FontWeight.w800,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      Spacer(),

                      //plan price
                      isMonthly
                          ? Text(
                              "\$${plan['price']}",
                              style: TextStyle(
                                fontSize: kHeadlineSmall,
                                fontWeight: FontWeight.w800,
                                color: themeData.colorScheme.onSurface,
                              ),
                            )
                          : Row(
                              children: [
                                Text(
                                  "\$$annualPrice",
                                  style: TextStyle(
                                    fontSize: kBodySmall,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 4),
                                Text(
                                  "\$$discountedAnualPrice",
                                  style: TextStyle(
                                    fontSize: kHeadlineSmall,
                                    fontWeight: FontWeight.w800,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                      isMonthly
                          ? Text(
                              ' /Month',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          : Text(
                              ' /Year',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                    ],
                  ),

                  SizedBox(height: kDefaultPadding),

                  // Generate active features
                  ...List.generate(
                    plan['activeFeatures'].length,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: kSuccessColor,
                            size: 16,
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Flexible(
                            child: Text(
                              plan['activeFeatures'][i],
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Generate inactive features
                  ...List.generate(
                    plan['inactiveFeatures'].length,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPadding),
                      child: Row(
                        children: [
                          Icon(Icons.cancel, color: kErrorColor, size: 16),
                          SizedBox(width: kDefaultPadding / 2),
                          Flexible(
                            child: Text(
                              plan['inactiveFeatures'][i],
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Spacer(),

                  // action button
                  FlatButton(
                    kText: isCurrent ? 'Your Current Plan' : 'Change Plan',
                    kTextColor: Colors.white,
                    bgColor: isCurrent
                        ? kErrorColor.withValues(alpha: 0.8)
                        : kInfoColor,
                    isFullWidth: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isPopular)
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
                vertical: kDefaultPadding / 4,
              ),
              decoration: BoxDecoration(
                color: kErrorColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(width: kDefaultPadding / 3),
                  Text(
                    'Popular',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

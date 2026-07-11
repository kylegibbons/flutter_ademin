import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/dashboard_analytics_data.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TopReferralWidget extends StatelessWidget {
  const TopReferralWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final totalReferrals = 825700;
    final growthPercentage = 17.42;
    final numberFormat = NumberFormat.decimalPattern();
    final themeData = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 438,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: title & export
            CardHeader(
              kText: 'Top Referrals Pages',
              kWidget: Padding(
                padding: EdgeInsetsDirectional.only(end: kDefaultPadding),
                child: SoftButton(
                  kText: 'Export Data',
                  bgColor: themeData.colorScheme.primary,
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
              ),
            ),

            SizedBox(height: kDefaultPadding),

            // Total + Growth + Image
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL REFERRALS PAGE',
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            fontWeight: FontWeight.w600,
                            color: kTextColor,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        Text(
                          numberFormat.format(totalReferrals),
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        Row(
                          children: [
                            CustomBadge(
                              kColor: kSuccessColor,
                              kText: '${growthPercentage.toStringAsFixed(2)}%',
                              isSoft: true,
                            ),
                            SizedBox(width: kDefaultPadding / 2),
                            Text(
                              'vs. prev month',
                              style: TextStyle(color: kTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: DotLottieLoader.fromAsset(
                        "assets/animations/rocketresearch.lottie",
                        frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                          if (dotlottie != null) {
                            return Lottie.memory(
                              dotlottie.animations.values.single,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Horizontal Bar Indicator
            Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: topReferrals
                    .map(
                      (e) => Expanded(
                        flex: (e.percentage * 100).toInt(),
                        child: Container(height: 8, color: e.color()),
                      ),
                    )
                    .toList(),
              ),
            ),

            Spacer(),

            // Referral List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: topReferrals.map((ref) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 3,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(right: kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ref.color(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ref.name,
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: kTextColor,
                            ),
                          ),
                        ),
                        Text(
                          '${ref.percentage.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kBodyMedium,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: kDefaultPadding),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Show All',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

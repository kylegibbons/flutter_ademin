import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class AltcoinSeasonIndex extends StatelessWidget {
  final double indexValue; // Range 0 - 100

  const AltcoinSeasonIndex({super.key, required this.indexValue});

  String getSeasonLabel(double value) {
    if (value <= 30) return 'Bitcoin Season';
    if (value <= 50) return 'Mostly Bitcoin';
    if (value <= 70) return 'Mostly Altcoin';
    return 'Altcoin Season';
  }

  String getMeaning(double value) {
    if (value <= 30) {
      return 'Bitcoin is strongly outperforming altcoins.';
    } else if (value <= 50) {
      return 'Bitcoin is outperforming, but altcoins are gaining momentum.';
    } else if (value <= 70) {
      return 'Altcoins are starting to outperform Bitcoin.';
    } else {
      return 'Altcoins are significantly outperforming Bitcoin.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final clampedValue = indexValue.clamp(0, 100);
    final themeData = Theme.of(context);

    final label = getSeasonLabel(clampedValue.toDouble());
    final meaning = getMeaning(clampedValue.toDouble());
    return Card(
      child: SizedBox(
        height: (583 - (2 * kDefaultPadding)) / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            CardHeader(
              kText: 'Altcoin Season Index',
              kWidget: CustomIconButton(
                icon: Icons.info_outline,
                onTap: () {},
                iconColor: themeData.colorScheme.onSurface,
                shape: ButtonShape.circle,
                tooltipMessage:
                    'Indicates Altcoin Season (high score) or Bitcoin Season (low \nscore). Use this to determine if the market trend currently \nfavors alternative cryptocurrencies for investment.',
              ),
            ),

            Spacer(),

            // Value row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Text(
                    clampedValue.toInt().toString(),
                    style: TextStyle(
                      fontSize: kHeadlineSmall,
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    ' / 100',
                    style: TextStyle(
                      fontSize: kBodyLarge,
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Label
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  Text(
                    'Bitcoin Season',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    'Altcoin Season',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // Bar and Indicator
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double indicatorPos =
                      (clampedValue / 100) * constraints.maxWidth;

                  return SizedBox(
                    height: 24,
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            children: [
                              // 0 - 30 Bitcoin (orange)
                              Expanded(
                                flex: 30,
                                child: Container(
                                  height: 12,
                                  color: kWarningColor,
                                ),
                              ),

                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: 12,
                                  color: kWarningColor.withValues(alpha: 0.3),
                                ),
                              ),

                              Expanded(
                                flex: 20,
                                child: Container(
                                  height: 12,
                                  color: kInfoColor.withValues(alpha: 0.3),
                                ),
                              ),

                              // 70 - 100 Altcoin (blue)
                              Expanded(
                                flex: 30,
                                child: Container(height: 12, color: kInfoColor),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: indicatorPos - 8, // center the circle
                          child: Tooltip(
                            richMessage: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Index: ${clampedValue.toInt()}\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        themeData.colorScheme.onInverseSurface,
                                  ),
                                ),
                                TextSpan(
                                  text: '$label\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        themeData.colorScheme.onInverseSurface,
                                  ),
                                ),
                                TextSpan(
                                  text: meaning,
                                  style: TextStyle(color: kTextColor),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(kDefaultPadding),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.inverseSurface,
                              borderRadius: BorderRadius.circular(
                                defaultRadius,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: themeData.colorScheme.onSurface,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: themeData.colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/animation/animated_icon.dart';
import 'package:flutkit_ademin/widgets/animation/animation.dart';

class CryptoBuySellMetrics extends StatelessWidget {
  const CryptoBuySellMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2, kScreenWidthLg: 4},
      runSpacing: kDefaultPadding,
      spacing: kDefaultPadding,
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
      children: mockBuySellMetricData
          .map((card) => CryptoBuySellMetricCard(card: card))
          .toList(),
    );
  }
}

// 3. Card Widget
class CryptoBuySellMetricCard extends StatelessWidget {
  final CryptoBuySellMetric card;

  const CryptoBuySellMetricCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.title,
                    style: TextStyle(
                      fontSize: kBodyMedium,
                      color: kTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '\$${card.value.toStringAsFixed(0)}', // Format value to remove decimal if .00
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text:
                              '.${card.value.toStringAsFixed(2).split('.').last}', // Get the decimal part
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            color: kTextColor,
                          ),
                        ),
                        TextSpan(
                          text: card.unit,
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            color: kTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: card.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: CustomAnimatedIcon(
                  icon: card.icon,
                  color: card.iconColor,
                  size: 28,
                  duration: const Duration(seconds: 2),
                  animationType: LoopingAnimationType.bounce,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

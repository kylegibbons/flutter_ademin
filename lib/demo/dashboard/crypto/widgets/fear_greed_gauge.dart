import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class FearGreedGauge extends StatelessWidget {
  final double value; // e.g. 63

  const FearGreedGauge({super.key, required this.value});

  String getLabel(double value) {
    if (value < 25) return 'Extreme Fear';
    if (value < 50) return 'Fear';
    if (value < 75) return 'Greed';
    return 'Extreme Greed';
  }

  Color getColor(double value) {
    if (value < 25) return kErrorColor;
    if (value < 50) return kWarningColor;
    if (value < 75) return kSuccessColor;
    return kInfoColor;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: SizedBox(
        height: (583 - (2 * kDefaultPadding)) / 3,
        child: Column(
          children: [
            CardHeader(
              kText: 'Fear and Greed Index',
              kWidget: CustomIconButton(
                icon: Icons.info_outline,
                onTap: () {},
                iconColor: themeData.colorScheme.onSurface,
                shape: ButtonShape.circle,
                tooltipMessage:
                    'Measures overall market sentiment. A score near 0 (Extreme \nFear) suggests overselling and potential buying \nopportunities. A score near 100 (Extreme Greed) suggests \novervaluation and potential correction.',
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: AnimatedRadialGauge(
                  duration: Duration(milliseconds: 800),
                  radius: 120,
                  value: value,
                  curve: Curves.easeInOut,
                  axis: GaugeAxis(
                    min: 0,
                    max: 100,
                    sweepDegrees: 180,
                    style: GaugeAxisStyle(
                      thickness: 15,
                      background: themeData.colorScheme.surface,
                      zoneSpacing: 4,
                    ),
                    progressBar: GaugeProgressBar.rounded(
                      color: Colors.transparent,
                    ),
                    zones: [
                      GaugeZone(
                        from: 0,
                        to: 25,
                        color: kErrorColor,
                        cornerRadius: Radius.circular(4),
                      ),
                      GaugeZone(
                        from: 25,
                        to: 50,
                        color: kWarningColor,
                        cornerRadius: Radius.circular(4),
                      ),
                      GaugeZone(
                        from: 50,
                        to: 75,
                        color: kSuccessColor,
                        cornerRadius: Radius.circular(4),
                      ),
                      GaugeZone(
                        from: 75,
                        to: 100,
                        color: kInfoColor,
                        cornerRadius: Radius.circular(4),
                      ),
                    ],
                  ),
                  builder: (context, child, value) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          getLabel(value),
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

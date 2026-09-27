import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/dashboard_crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinMarketCapIndex extends StatelessWidget {
  final double currentValue;
  final double percentChange;
  final List<MarketChartData> data;

  const CoinMarketCapIndex({
    super.key,
    required this.currentValue,
    required this.percentChange,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = percentChange < 0;
    final color = isNegative ? kErrorColor : kSuccessColor;
    final icon = isNegative ? Icons.arrow_downward : Icons.arrow_upward;
    final themeData = Theme.of(context);

    return Card(
      child: SizedBox(
        height: (583 - (2 * kDefaultPadding)) / 3,
        child: Column(
          children: [
            CardHeader(
              kText: 'CoinMarketCap 100 Index',
              kWidget: CustomIconButton(
                icon: Icons.info_outline,
                onTap: () {},
                iconColor: themeData.colorScheme.onSurface,
                shape: ButtonShape.circle,
                tooltipMessage:
                    'The benchmark index for the broader crypto market. It tracks \nthe performance of the top 100 cryptocurrencies by market \ncap (excluding stablecoins and wrapped tokens).',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: Info
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${currentValue.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: kHeadlineMedium,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 4),
                        Container(
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          padding: EdgeInsets.only(
                            left: 4,
                            right: 8,
                            top: 4,
                            bottom: 4,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(icon, color: color, size: 14),
                              SizedBox(width: 0),
                              Text(
                                '${percentChange.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: kBodyMedium,
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right: Chart
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 110,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(isVisible: false),
                        primaryYAxis: NumericAxis(isVisible: false),
                        margin: EdgeInsets.zero,
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <CartesianSeries>[
                          LineSeries<MarketChartData, double>(
                            dataSource: data,
                            xValueMapper: (datum, _) => datum.x,
                            yValueMapper: (datum, _) => datum.y,
                            color: color,
                            width: 2,
                            markerSettings: MarkerSettings(isVisible: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

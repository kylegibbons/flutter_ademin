import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WonLostDealsChart extends StatelessWidget {
  const WonLostDealsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Deals Amount Won vs Lost - Monthly Trend',
              kWidget: Padding(
                padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
                child: SoftButton(
                  kText: 'View Report',
                  bgColor: kSecondaryColor,
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0.7),
                    // labelRotation: -45,
                  ),
                  primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
                    title: AxisTitle(
                      text: 'Amount',
                      textStyle: chartAxisLabelStyle,
                    ),
                    majorGridLines: MajorGridLines(width: 0.7),
                  ),
                  series: <CartesianSeries>[
                    // 🟢 Actual Won (Jan–Jul)
                    StackedColumnSeries<DealTrend, String>(
                      dataSource: data2025,
                      xValueMapper: (d, i) => d.month,
                      yValueMapper: (d, i) =>
                          i < forecastStartIndex ? d.wonAmount : null,
                      name: 'Won Amount',
                      color: kSuccessColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      borderRadius: chartTopRadius,
                    ),

                    // 🔴 Actual Lost (Jan–Jul)
                    StackedColumnSeries<DealTrend, String>(
                      dataSource: data2025,
                      xValueMapper: (d, i) => d.month,
                      yValueMapper: (d, i) =>
                          i < forecastStartIndex ? d.lostAmount : null,
                      name: 'Lost Amount',
                      color: kErrorColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      borderRadius: chartBottomRadius,
                    ),

                    // 🟢 Forecast Won (Aug–Des)
                    StackedColumnSeries<DealTrend, String>(
                      dataSource: data2025,
                      xValueMapper: (d, i) => d.month,
                      yValueMapper: (d, i) =>
                          i >= forecastStartIndex ? d.forecastWon : null,
                      name: 'Won Forecast',
                      color: kSuccessColor,
                      opacity: 0.6,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      borderRadius: chartTopRadius,
                    ),

                    // 🔴 Forecast Lost (Aug–Des)
                    StackedColumnSeries<DealTrend, String>(
                      dataSource: data2025,
                      xValueMapper: (d, i) => d.month,
                      yValueMapper: (d, i) =>
                          i >= forecastStartIndex ? d.forecastLost : null,
                      name: 'Lost Forecast',
                      color: kErrorColor,
                      opacity: 0.6,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      borderRadius: chartBottomRadius,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

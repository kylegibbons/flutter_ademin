import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_data.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RevenueChart extends StatelessWidget {
  final List<RevenueChartData> data;

  const RevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 560,
        child: Column(
          children: [
            CardHeader(
              kText: 'Monthly Revenue vs Conversion Rate',
              kWidget: PeriodPopUpMenu(),
            ),

            // Revenue metrics summary
            Container(
              decoration: BoxDecoration(
                color: kTableHeaderColor,
                border: Border(
                  bottom: BorderSide(
                    color: kTextColor.withValues(alpha: 0.2),
                    width: 0.6,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1.5 * kDefaultPadding,
              ),
              child: RevenueSummaryRow(summaries: revenueSummaries),
            ),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  margin: EdgeInsets.all(0),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    name: 'Revenue',
                    numberFormat: NumberFormat.compactSimpleCurrency(),
                    title: AxisTitle(
                      text: 'Revenue',
                      textStyle: chartAxisLabelStyle,
                    ),
                  ),
                  axes: <ChartAxis>[
                    NumericAxis(
                      name: 'ConversionRate',
                      opposedPosition: true,
                      interval: 0.5,
                      minimum: 0,
                      title: AxisTitle(
                        text: 'Conversion Rate (%)',
                        textStyle: chartAxisLabelStyle,
                      ),
                    ),
                  ],
                  series: <CartesianSeries>[
                    // Column chart for Revenue
                    ColumnSeries<RevenueChartData, String>(
                      name: 'Revenue',
                      dataSource: data,
                      xValueMapper: (RevenueChartData d, _) => d.month,
                      yValueMapper: (RevenueChartData d, _) => d.revenue,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: kSuccessColor,
                      borderRadius: chartTopRadius,
                    ),

                    // Line chart for Conversion Rate
                    LineSeries<RevenueChartData, String>(
                      name: 'Conversion Rate',
                      dataSource: data,
                      xValueMapper: (RevenueChartData d, _) => d.month,
                      yValueMapper: (RevenueChartData d, _) => d.conversionRate,
                      yAxisName: 'ConversionRate',
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        color: kErrorColor,
                      ),
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      color: kErrorColor,
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

// revenue metrics summary card

class RevenueSummaryRow extends StatelessWidget {
  final List<RevenueSummary> summaries;

  const RevenueSummaryRow({super.key, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      breakpoints: {
        kScreenWidthSm - 1: 2, // set breakpoint for 1 column layout,
        kScreenWidthSm: 4, // set breakpoint for 2 column layout
      },
      columnRatios: const [
        0.25, // set column A as 25% width
        0.25, // set column B as 25% width
        0.25, // set column C as 25% width
        0.25, // set column D as 25% width
      ],
      spacing: kDefaultPadding, // spacing
      runSpacing: 2 * kDefaultPadding, // run spacing
      crossAlignment: WrapCrossAlignment.start,
      children: summaries.map((summary) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              summary.value,
              style: TextStyle(
                fontSize: kBodyMedium + 1,
                fontWeight: FontWeight.w600,
                color:
                    summary.valueColor ??
                    Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: kDefaultPadding / 4),
            Text(
              summary.label,
              style: TextStyle(fontSize: kBodyMedium, color: kTextColor),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}

// Audience Metrics
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/data/dashboard_analytics_data.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/dashboard_analytics_models.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/popup_menu_button.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AudienceMetricsChart extends StatelessWidget {
  const AudienceMetricsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final tooltipBehavior = TooltipBehavior(enable: true);

    return Card(
      child: SizedBox(
        height: 479,
        child: Column(
          children: [
            CardHeader(kText: 'Audience Metrics', kWidget: PeriodPopUpMenu()),

            // audience metrics summary
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
              child: AudienceSummaryRow(summaries: audienceSummaries),
            ),
            SizedBox(height: kDefaultPadding),

            // audience metrics chart
            Expanded(
              child: SfCartesianChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                ),
                tooltipBehavior: tooltipBehavior,
                margin: EdgeInsets.only(
                  top: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.MMMd(),
                  intervalType: DateTimeIntervalType.days,
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Users / Sessions',
                    textStyle: chartAxisLabelStyle,
                  ),
                  opposedPosition: false,
                  minimum: 0,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  majorGridLines: MajorGridLines(dashArray: [5, 5]),
                ),
                axes: <ChartAxis>[
                  NumericAxis(
                    name: 'pageviewAxis',
                    title: AxisTitle(
                      text: 'Page Views',
                      textStyle: chartAxisLabelStyle,
                    ),
                    opposedPosition: true,
                    minimum: 0,
                  ),
                ],
                series: <CartesianSeries>[
                  // Users Bar
                  ColumnSeries<AudienceData, DateTime>(
                    name: 'User',
                    dataSource: audienceMetrics,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.users,
                    color: kInfoColor,
                    borderRadius: chartTopRadius,
                    enableTooltip: true,
                  ),

                  // Pageviews Line
                  SplineSeries<AudienceData, DateTime>(
                    name: 'Pageviews',
                    dataSource: audienceMetrics,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.pageviews,
                    yAxisName: 'pageviewAxis',
                    color: kSuccessColor,
                    width: 1.8,
                    // markerSettings: MarkerSettings(isVisible: true),
                    enableTooltip: true,
                  ),

                  // Sessions Line (dotted)
                  SplineSeries<AudienceData, DateTime>(
                    name: 'Sessions',
                    dataSource: audienceMetrics,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.sessions,
                    color: kErrorColor,
                    width: 1.8,
                    // dashArray: <double>[6, 3],
                    // markerSettings: MarkerSettings(isVisible: true),
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// audience metrics summary card

class AudienceSummaryRow extends StatelessWidget {
  final List<AudienceSummary> summaries;

  const AudienceSummaryRow({super.key, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm / 2: 2, kScreenWidthSm: 4},
      columnRatios: const [
        0.25, // set column A as 25% width
        0.25, // set column B as 25% width
        0.25, // set column C as 25% width
        0.25, // set column D as 25% width
      ],
      spacing: kDefaultPadding, // spacing
      runSpacing: kDefaultPadding, // run spacing
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
                    summary.valueColor?.call() ??
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

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/project/data/dashboard_project_data.dart';
import 'package:flutkit_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

class AvgResolutionResponseChart extends StatelessWidget {
  const AvgResolutionResponseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 520,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Avg. Resolution and Response Times',
              kWidget: MorePopUpMenu(),
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
                  margin: EdgeInsets.zero,
                  primaryXAxis: CategoryAxis(labelRotation: -35),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Resolution Time',
                      textStyle: chartAxisLabelStyle,
                    ),
                    minimum: 0,
                    maximum: 120,
                    interval: 20,
                  ),
                  axes: <ChartAxis>[
                    NumericAxis(
                      name: 'responseAxis',
                      opposedPosition: true,
                      minimum: 4.1,
                      maximum: 4.9,
                      interval: 0.1,
                      title: AxisTitle(
                        text: 'Response Time',
                        textStyle: chartAxisLabelStyle,
                      ),
                    ),
                  ],
                  series: <CartesianSeries>[
                    ColumnSeries<SupportTimeData, String>(
                      dataSource: supportTimeData,
                      xValueMapper: (d, _) => d.month,
                      yValueMapper: (d, _) => d.resolutionTime,
                      name: 'Avg. Resolution Time',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                      ),
                      color: kSuccessColor,
                      borderRadius: chartTopRadius,
                    ),
                    SplineSeries<SupportTimeData, String>(
                      dataSource: supportTimeData,
                      xValueMapper: (d, _) => d.month,
                      yValueMapper: (d, _) => d.responseTime,
                      yAxisName: 'responseAxis',
                      name: 'Avg. Response Time',
                      markerSettings: MarkerSettings(isVisible: true),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.outer,
                        builder: (data, _, _, _, _) {
                          final value = (data as SupportTimeData).responseTime
                              .toStringAsFixed(2);
                          return Text(
                            '$value hrs',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                            ),
                          );
                        },
                      ),
                      color: kErrorColor,
                      width: 3,
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

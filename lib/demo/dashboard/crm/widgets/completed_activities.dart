import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/crm/dashboard_crm_data.dart';
import 'package:flutter_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompletedActivities extends StatelessWidget {
  const CompletedActivities({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Forecast of Activities Completed - Monthly Trends',
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
                    overflowMode: LegendItemOverflowMode.wrap,
                    legendItemBuilder:
                        (
                          String name,
                          dynamic series,
                          dynamic point,
                          int index,
                        ) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                color: legendColors[name] ?? Colors.grey,
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: kBodySmall,
                                  color: themeData.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          );
                        },
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  margin: EdgeInsets.all(0),
                  series: <CartesianSeries<ActivityData, String>>[
                    // 📞 Actuals
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Call',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) =>
                          index < forecastStartIndex ? data.call : null,
                      color: kPrimaryColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Email',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) =>
                          index < forecastStartIndex ? data.email : null,
                      color: kInfoColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Event',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) =>
                          index < forecastStartIndex ? data.event : null,
                      color: kSuccessColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Meeting',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) =>
                          index < forecastStartIndex ? data.meeting : null,
                      color: kWarningColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'To-do',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) =>
                          index < forecastStartIndex ? data.todo : null,
                      color: kErrorColor,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                      borderRadius: chartTopRadius,
                    ),

                    // 🔮 Forecasts
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Call Forecast',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) => index >= forecastStartIndex
                          ? data.callForecast
                          : null,
                      color: kPrimaryColor.withValues(alpha: 0.4),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Email Forecast',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) => index >= forecastStartIndex
                          ? data.emailForecast
                          : null,
                      color: kInfoColor.withValues(alpha: 0.4),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Event Forecast',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) => index >= forecastStartIndex
                          ? data.eventForecast
                          : null,
                      color: kSuccessColor.withValues(alpha: 0.4),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'Meeting Forecast',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) => index >= forecastStartIndex
                          ? data.meetingForecast
                          : null,
                      color: kWarningColor.withValues(alpha: 0.4),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                    ),
                    StackedColumnSeries<ActivityData, String>(
                      name: 'To-do Forecast',
                      dataSource: activityData2025,
                      xValueMapper: (data, index) => data.month,
                      yValueMapper: (data, index) => index >= forecastStartIndex
                          ? data.todoForecast
                          : null,
                      color: kErrorColor.withValues(alpha: 0.4),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 10),
                      ),
                      borderRadius: chartTopRadius,
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

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_data.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

class EstimatedVsActualChart extends StatefulWidget {
  const EstimatedVsActualChart({super.key});

  @override
  State<EstimatedVsActualChart> createState() => _EstimatedVsActualChartState();
}

class _EstimatedVsActualChartState extends State<EstimatedVsActualChart> {
  String? selectedValue = 'all_time';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 560,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Estimated vs. Actual Hours by Project',
              kWidget: TimeFilterDropdown(),
            ),
            SizedBox(height: kDefaultPadding),

            Expanded(
              child: SfCartesianChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(
                  labelRotation: -40,
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: 'Hours',
                    textStyle: chartAxisLabelStyle,
                  ),
                  minimum: 0,
                  interval: 10000,
                  numberFormat: NumberFormat.compact(),
                ),
                margin: EdgeInsets.all(kDefaultPadding),
                series: <CartesianSeries>[
                  ColumnSeries<ProjectHours, String>(
                    dataSource: projectHoursData,
                    xValueMapper: (ProjectHours project, _) => project.name,
                    yValueMapper: (ProjectHours project, _) =>
                        project.estimated,
                    name: 'Estimated Hours',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    color: kErrorColor,
                    borderRadius: chartTopRadius,
                    width: 0.6,
                    spacing: 0.1,
                  ),
                  ColumnSeries<ProjectHours, String>(
                    dataSource: projectHoursData,
                    xValueMapper: (ProjectHours project, _) => project.name,
                    yValueMapper: (ProjectHours project, _) => project.actual,
                    name: 'Actual Hours',
                    color: kSuccessColor,
                    borderRadius: chartTopRadius,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    width: 0.6,
                    spacing: 0.1,
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

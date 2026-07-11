import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_data.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

class TicketStatusChart extends StatelessWidget {
  const TicketStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Card(
      child: SizedBox(
        height: 388,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Tickets by Issue Type and Status',
              kWidget: MorePopUpMenu(),
            ),

            SizedBox(height: kDefaultPadding),

            // chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: mediaQueryData.size.width < kScreenWidthMd
                        ? LegendPosition.bottom
                        : LegendPosition.right,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Tickets',
                      textStyle: chartAxisLabelStyle,
                    ),
                    minimum: 0,
                    maximum: 100,
                    interval: 20,
                  ),
                  margin: EdgeInsets.zero,
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Issue Type',
                      textStyle: chartAxisLabelStyle,
                    ),
                    labelPlacement: LabelPlacement.betweenTicks,
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  series: <CartesianSeries>[
                    StackedBarSeries<TicketStatusData, String>(
                      dataSource: ticketStatusData,
                      xValueMapper: (d, _) => d.issueType,
                      yValueMapper: (d, _) => d.resolved,
                      name: 'Resolved Tickets',
                      color: kSuccessColor,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    StackedBarSeries<TicketStatusData, String>(
                      dataSource: ticketStatusData,
                      xValueMapper: (d, _) => d.issueType,
                      yValueMapper: (d, _) => d.open,
                      name: 'Open Tickets',
                      color: kWarningColor,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                    StackedBarSeries<TicketStatusData, String>(
                      dataSource: ticketStatusData,
                      xValueMapper: (d, _) => d.issueType,
                      yValueMapper: (d, _) => d.unresolved,
                      name: 'Unresolved Tickets',
                      color: kErrorColor,
                      borderRadius: chartBarRadius,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
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

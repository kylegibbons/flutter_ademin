import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_data.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

class TicketBySourceDonutChart extends StatelessWidget {
  const TicketBySourceDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 520,
        child: Column(
          children: [
            // header
            CardHeader(kText: 'Tickets by Source', kWidget: MorePopUpMenu()),

            Expanded(
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                ),
                margin: EdgeInsets.all(kDefaultPadding),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <DoughnutSeries<TicketSourceData, String>>[
                  DoughnutSeries<TicketSourceData, String>(
                    dataSource: ticketSourceData,
                    xValueMapper: (d, _) => d.source,
                    yValueMapper: (d, _) => d.count,
                    pointColorMapper: (d, _) => d.color,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      connectorLineSettings: ConnectorLineSettings(
                        type: ConnectorType.curve,
                      ),
                    ),
                    explode: true,
                    explodeIndex: 0,
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

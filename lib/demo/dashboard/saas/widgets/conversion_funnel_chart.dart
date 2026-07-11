import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ConversionFunnelGroupedChart extends StatelessWidget {
  final List<FunnelData> data;

  const ConversionFunnelGroupedChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Conversion Funnel',
            kWidget: CustomPopupMenu<String>(
              onSelected: (value) => debugPrint('Selected: $value'),

              items: [
                // details menu
                PopupMenuItemData(
                  value: 'details',
                  text: 'Details',
                  icon: Icons.list_alt_outlined,
                ),

                // refresh menu
                PopupMenuItemData(
                  value: 'refresh',
                  text: 'Refresh',
                  icon: Icons.refresh,
                ),
              ],
              // icon button
              icon: Icons.more_vert,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: SfCartesianChart(
              legend: Legend(isVisible: true, position: LegendPosition.top),
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Colors.grey.withValues(alpha: .2),
                ),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                ColumnSeries<FunnelData, String>(
                  name: 'Ad Impression',
                  dataSource: data,
                  xValueMapper: (d, _) => d.month,
                  yValueMapper: (d, _) => d.impressions,
                  borderRadius: chartTopRadius,
                  color: kPrimaryColor,
                ),
                ColumnSeries<FunnelData, String>(
                  name: 'Website Session',
                  dataSource: data,
                  xValueMapper: (d, _) => d.month,
                  yValueMapper: (d, _) => d.sessions,
                  borderRadius: chartTopRadius,
                  color: kSuccessColor,
                ),
                ColumnSeries<FunnelData, String>(
                  name: 'App Download',
                  dataSource: data,
                  xValueMapper: (d, _) => d.month,
                  yValueMapper: (d, _) => d.downloads,
                  borderRadius: chartTopRadius,
                  color: kInfoColor,
                ),
                ColumnSeries<FunnelData, String>(
                  name: 'New Users',
                  dataSource: data,
                  xValueMapper: (d, _) => d.month,
                  yValueMapper: (d, _) => d.newUsers,
                  borderRadius: chartTopRadius,
                  color: kErrorColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

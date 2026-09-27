import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FunnelChart extends StatelessWidget {
  const FunnelChart({super.key});

  @override
  Widget build(BuildContext context) {
    String formatDollarMillion(double value) {
      double million = value / 1000000;
      return '\$${million.toStringAsFixed(1)}M';
    }

    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Potential Sales by Stages',
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
                child: SfFunnelChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  legend: Legend(isVisible: true),
                  onDataLabelRender: (DataLabelRenderArgs args) {
                    final rawValue = salesStageData[args.pointIndex].amount;
                    args.text = formatDollarMillion(rawValue);
                  },
                  onTooltipRender: (TooltipArgs args) {
                    final rawValue =
                        salesStageData[args.pointIndex! as int].amount;
                    args.text =
                        '${args.text!.split(':').first}: ${formatDollarMillion(rawValue)}';
                  },
                  margin: EdgeInsets.all(0),
                  series: FunnelSeries<SalesStageData, String>(
                    dataSource: salesStageData,
                    xValueMapper: (SalesStageData d, _) => d.stage,
                    yValueMapper: (SalesStageData d, _) => d.amount,
                    pointColorMapper: (SalesStageData d, _) => d.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

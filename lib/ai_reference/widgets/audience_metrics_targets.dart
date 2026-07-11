import 'package:flutter/material.dart';
import 'package:flutter_ademin/ai_reference/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/ai_reference/ai_reference_data.dart';
import 'package:flutter_ademin/ai_reference/ai_reference_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AudienceMetricsTargets extends StatelessWidget {
  const AudienceMetricsTargets({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Audience Metrics vs Targets',
            kWidget: PeriodPopUpMenu(),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: metrics.map((m) => MiniMetricCard(data: m)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniMetricCard extends StatelessWidget {
  final MiniMetricData data;

  const MiniMetricCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isPositive = data.change >= 0;
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 86,
              child: SfCartesianChart(
                margin: EdgeInsets.zero,
                plotAreaBorderWidth: 0,
                primaryXAxis: const NumericAxis(isVisible: false),
                primaryYAxis: const NumericAxis(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: false),
                title: ChartTitle(
                  text: data.title,
                  alignment: ChartAlignment.near,
                  textStyle: const TextStyle(fontSize: kBodySmall),
                ),
                series: <CartesianSeries>[
                  SplineAreaSeries<GoldChartData, int>(
                    dataSource: data.trend,
                    xValueMapper: (GoldChartData d, _) => d.x,
                    yValueMapper: (GoldChartData d, _) => d.y,
                    color: data.color().withValues(alpha: 0.3),
                    borderColor: data.color(),
                    borderWidth: 1.5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data.value,
                  style: TextStyle(
                    fontSize: kBodyLarge,
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? kSuccessColor : kErrorColor,
                      size: 14,
                    ),
                    Text(
                      '${data.change.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w600,
                        color: isPositive ? kSuccessColor : kErrorColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  data.prevLabel,
                  style: TextStyle(fontSize: kBodySmall, color: kTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

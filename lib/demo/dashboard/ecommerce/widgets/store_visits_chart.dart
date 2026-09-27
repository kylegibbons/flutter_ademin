import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/data/dashboard_ecommerce_data.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StoreVisitsDonutChart extends StatelessWidget {
  const StoreVisitsDonutChart({super.key});

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
              kText: 'Store Visits by Source',
              kWidget: Padding(
                padding: EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
                child: CustomIconButton(
                  icon: Icons.info_outline,
                  onTap: () {},
                  iconColor: themeData.colorScheme.onSurface,
                  shape: ButtonShape.circle,
                  tooltipMessage:
                      'Shows the marketing channels that drove traffic to your\nlocation. Use this data to measure the effectiveness \nof your online campaigns on offline results.',
                ),
              ),
            ),

            // Donut Chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCircularChart(
                  margin: EdgeInsets.zero,
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    DoughnutSeries<VisitSourceData, String>(
                      dataSource: visitData,
                      xValueMapper: (VisitSourceData data, _) => data.source,
                      yValueMapper: (VisitSourceData data, _) =>
                          data.percentage,
                      pointColorMapper: (VisitSourceData data, _) => data.color,
                      radius: '90%',
                      innerRadius: '65%',
                      dataLabelMapper: (VisitSourceData data, _) =>
                          '${data.percentage.toStringAsFixed(1)}%',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        textStyle: TextStyle(
                          fontSize: kBodySmall,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Quarterly Sales

class QuartelySalesChart extends StatelessWidget {
  const QuartelySalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Quartely Sales',
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
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0.7),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Sales',
                      textStyle: chartAxisLabelStyle,
                    ),
                    majorGridLines: MajorGridLines(width: 0.7),
                    numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  margin: EdgeInsets.all(0),
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  series: <CartesianSeries>[
                    // Bar chart for actual sales
                    BarSeries<QuarterlySales, String>(
                      name: 'Sales',
                      dataSource: quarterlySales,
                      xValueMapper: (QuarterlySales data, _) => data.quarter,
                      yValueMapper: (QuarterlySales data, _) => data.sales,
                      pointColorMapper: (QuarterlySales q, _) => q.color,
                      borderRadius: chartBarRadius,
                    ),
                    // Marker for target sales
                    ScatterSeries<QuarterlySales, String>(
                      name: 'Target',
                      dataSource: quarterlySales,
                      color: kErrorColor,
                      borderColor: Colors.white,
                      borderWidth: 0.8,
                      xValueMapper: (QuarterlySales data, _) => data.quarter,
                      yValueMapper: (QuarterlySales data, _) => data.target,
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        width: 12, // Marker size
                        height: 12,
                        shape: DataMarkerType.diamond,
                        borderColor: Colors.white,
                        borderWidth: 0.8,
                        color: kErrorColor, // Fill color for the marker
                      ),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
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

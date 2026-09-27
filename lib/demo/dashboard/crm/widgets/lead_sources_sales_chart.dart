import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/widgets/format_currency.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LeadSourcesSalesChart extends StatelessWidget {
  const LeadSourcesSalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Sales by Lead Source',
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
                    labelRotation: -45,
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: MajorGridLines(width: 0.7),
                    title: AxisTitle(
                      text: 'Sales in USD',
                      textStyle: chartAxisLabelStyle,
                    ),
                    numberFormat: NumberFormat.compactCurrency(symbol: '\$'),
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    ColumnSeries<LeadSourceSales, String>(
                      name: 'Sales',
                      dataSource: leadSourceSalesData,
                      xValueMapper: (LeadSourceSales d, _) => d.source,
                      yValueMapper: (LeadSourceSales d, _) => d.amount,
                      pointColorMapper: (LeadSourceSales d, _) => d.color,
                      borderRadius: chartTopRadius,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.outer,
                        builder:
                            (data, point, series, pointIndex, seriesIndex) {
                              final value = (data as LeadSourceSales).amount;
                              return Text(
                                formatCurrency(value),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: kBodySmall,
                                ),
                              );
                            },
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

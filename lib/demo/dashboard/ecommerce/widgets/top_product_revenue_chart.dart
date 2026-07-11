import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopProductRevenueChart extends StatelessWidget {
  final List<ProductData> data;

  const TopProductRevenueChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 560,
        child: Column(
          children: [
            CardHeader(
              kText: 'Top Products Revenue and Conversion Rate',
              kWidget: PeriodPopUpMenu(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  margin: EdgeInsets.only(right: kDefaultPadding),
                  primaryYAxis: NumericAxis(
                    name: 'Revenue',
                    title: AxisTitle(
                      text: 'Revenue (\$)',
                      textStyle: chartAxisLabelStyle,
                    ),
                    numberFormat: NumberFormat.compactSimpleCurrency(),
                    maximum: 114000,
                  ),
                  axes: <ChartAxis>[
                    NumericAxis(
                      name: 'ConversionRate',
                      opposedPosition: true,
                      minimum: 0,
                      maximum: 2,
                      interval: 0.5,
                      title: AxisTitle(
                        text: 'Conversion Rate (%)',
                        textStyle: chartAxisLabelStyle,
                      ),
                      numberFormat: NumberFormat("0.00'%'"),
                    ),
                  ],
                  primaryXAxis: CategoryAxis(maximumLabelWidth: 80),
                  series: <CartesianSeries>[
                    // Revenue Bar
                    BarSeries<ProductData, String>(
                      name: 'Revenue',
                      dataSource: data,
                      xValueMapper: (ProductData d, _) => d.name,
                      yValueMapper: (ProductData d, _) => d.revenue,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: kPrimaryColor,
                      borderRadius: chartBarRadius,
                    ),

                    // Conversion Rate Bar
                    BarSeries<ProductData, String>(
                      name: 'Conversion Rate',
                      dataSource: data,
                      xValueMapper: (ProductData d, _) => d.name,
                      yValueMapper: (ProductData d, _) => d.conversionRate,
                      yAxisName: 'ConversionRate',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      color: kInfoColor,
                      borderRadius: chartBarRadius,
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

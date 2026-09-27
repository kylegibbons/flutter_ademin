import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/widgets/format_currency.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesbyRegion extends StatelessWidget {
  const SalesbyRegion({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Sales by Region',
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
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Text(
                      formatCurrency(
                        regionSales.fold(
                          0,
                          (sum, item) => (sum + item.amount).toInt(),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: kHeadlineSmall,
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
                series: <DoughnutSeries<RegionSales, String>>[
                  DoughnutSeries<RegionSales, String>(
                    dataSource: regionSales,
                    xValueMapper: (RegionSales data, _) => data.region,
                    yValueMapper: (RegionSales data, _) => data.amount,
                    pointColorMapper: (RegionSales data, _) => data.color,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                      useSeriesColor: true,
                      builder: (data, point, series, pointIndex, seriesIndex) {
                        final value = (data as RegionSales).amount;
                        return Text(
                          formatCurrency(value.toInt()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: kBodySmall,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    radius: '90%',
                    innerRadius: '60%',
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

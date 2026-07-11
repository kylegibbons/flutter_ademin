import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductPerformanceCard extends StatelessWidget {
  final String title;
  final String amountText; // e.g. "$2,950"
  final double percentChange; // e.g. 0.52
  final TrendType trend;
  final List<SalesData> data;

  const ProductPerformanceCard({
    super.key,
    required this.title,
    required this.amountText,
    required this.percentChange,
    required this.trend,
    required this.data,
  });

  bool get isIncrease => trend == TrendType.increase;

  @override
  Widget build(BuildContext context) {
    final trendColor = isIncrease ? kSuccessColor : kErrorColor;
    final trendBg = trendColor.withValues(alpha: 0.1);
    final trendIcon = isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
    final themeData = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 567,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              kText: 'Product Performance',
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
            //  metrics summary
            Container(
              decoration: BoxDecoration(
                color: kTableHeaderColor,
                border: Border(
                  bottom: BorderSide(
                    color: kTextColor.withValues(alpha: 0.2),
                    width: 0.6,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1.5 * kDefaultPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TrendStat(
                      title: 'Digital Product',
                      value: 790,
                      trend: TrendType.increase,
                    ),
                  ),

                  Expanded(
                    child: TrendStat(
                      title: 'Physical Product',
                      value: 572,
                      trend: TrendType.decrease,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: trendBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(trendIcon, size: 14, color: trendColor),
                        const SizedBox(width: 4),
                        Text(
                          "${percentChange.toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: trendColor,
                            fontWeight: FontWeight.w600,
                            fontSize: kBodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: kDefaultPadding / 2),

            /// AMOUNT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                amountText,
                style: TextStyle(
                  fontSize: kHeadlineSmall,
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: kDefaultPadding),

            /// CHART
            Expanded(
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                margin: EdgeInsets.all(kDefaultPadding),
                primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  majorGridLines: MajorGridLines(
                    width: 1,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),

                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  ColumnSeries<SalesData, String>(
                    name: 'Daily Sales',
                    dataSource: data,
                    xValueMapper: (SalesData d, _) => d.day,
                    yValueMapper: (SalesData d, _) => d.value,
                    width: 0.5,
                    borderRadius: chartTopRadius,
                    color: kSecondaryColor,
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

class TrendStat extends StatelessWidget {
  final String title;
  final int value;
  final TrendType trend;

  const TrendStat({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
  });

  bool get isIncrease => trend == TrendType.increase;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isIncrease
        ? kSuccessColor.withValues(alpha: 0.1)
        : kErrorColor.withValues(alpha: 0.1);

    final Color iconColor = isIncrease ? kSuccessColor : kErrorColor;

    final IconData icon = isIncrease
        ? Icons.arrow_upward
        : Icons.arrow_downward;
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: themeData.colorScheme.onSurface)),
        const SizedBox(height: kDefaultPadding / 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 10,
                color: iconColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              value.toString(),
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: kBodyLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

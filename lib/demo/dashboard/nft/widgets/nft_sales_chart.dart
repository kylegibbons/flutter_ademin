import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_data.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// nft total sales chart

class NftSalesChart extends StatelessWidget {
  const NftSalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Total NFT Sales Over Time',
              kWidget: TimeFilterDropdown(),
            ),

            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                margin: EdgeInsets.all(kDefaultPadding),
                primaryXAxis: DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  dateFormat: DateFormat.MMMd(),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value} ETH',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                ),
                series: <CartesianSeries<NftSalesData, DateTime>>[
                  SplineAreaSeries<NftSalesData, DateTime>(
                    dataSource: nftSales,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.salesEth,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: kInfoColor,
                    name: 'Sales',
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

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/data/dashboard_nft_data.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/popup_menu_button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Top NFT Collections by Sales Volume pie chart

class TopSalesPieChart extends StatelessWidget {
  const TopSalesPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Top NFT by Sales Volume',
              kWidget: TimeFilterDropdown(),
            ),

            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: SfCircularChart(
                margin: EdgeInsets.all(kDefaultPadding),
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  format: 'point.x: point.y ETH',
                ),
                series: <PieSeries<CollectionSales, String>>[
                  PieSeries<CollectionSales, String>(
                    dataSource: topCollections,
                    xValueMapper: (CollectionSales data, _) => data.name,
                    yValueMapper: (CollectionSales data, _) => data.volumeEth,
                    pointColorMapper: (CollectionSales data, _) => data.color,
                    dataLabelMapper: (CollectionSales data, _) =>
                        '${data.name}\n${data.volumeEth.toStringAsFixed(1)} ETH',
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    radius: '80%',
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

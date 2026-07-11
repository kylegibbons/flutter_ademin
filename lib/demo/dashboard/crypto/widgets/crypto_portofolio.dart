import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/dashboard_crypto_data.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/dashboard_crypto_models.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoPortfolioWidget extends StatefulWidget {
  const CryptoPortfolioWidget({super.key});

  @override
  State<CryptoPortfolioWidget> createState() => _CryptoPortfolioWidgetState();
}

class _CryptoPortfolioWidgetState extends State<CryptoPortfolioWidget> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final total = cryptoList.fold<double>(0, (sum, e) => sum + e.value);
    final themeData = Theme.of(context);

    final currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
    );

    return Card(
      child: SizedBox(
        height: 584,
        child: Column(
          children: [
            // header
            CardHeader(kText: 'My Portfolio', kWidget: PeriodPopUpMenu()),

            // circular chart
            Expanded(
              child: SfCircularChart(
                margin: EdgeInsets.zero,
                tooltipBehavior: _tooltipBehavior,
                onTooltipRender: (TooltipArgs args) {
                  final index = args.pointIndex!;
                  final data = cryptoList[index.toInt()];
                  final percent = (data.value / total) * 100;

                  args.text =
                      '${data.symbol}: ${currencyFormatter.format(data.value)} (${percent.toStringAsFixed(1)}%)';
                },
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total value',
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          currencyFormatter.format(total),
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                series: <CircularSeries>[
                  DoughnutSeries<CryptoData, String>(
                    dataSource: cryptoList,
                    xValueMapper: (CryptoData data, _) => data.symbol,
                    yValueMapper: (CryptoData data, _) => data.value,
                    pointColorMapper: (CryptoData data, _) => data.color,
                    innerRadius: '75%',
                    radius: '90%',
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),

            // crypto list
            ...cryptoList.map((data) => CryptoTile(data: data)),
            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}

// crypto tile

class CryptoTile extends StatelessWidget {
  final CryptoData data;

  const CryptoTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: kDefaultPadding,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blueGrey.shade50,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: data.color,
              child: FaIcon(data.icon, color: Colors.white, size: 16),
            ),
          ),
          SizedBox(width: kDefaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Text(data.symbol),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${data.symbol} ${data.amount.toStringAsFixed(8)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              Text(
                currencyFormatter.format(data.value),
                style: TextStyle(
                  color: data.isProfit == false ? kErrorColor : kSuccessColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/data/dashboard_crypto_data.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';

// Investment metrics card

class InvestmentMetrics extends StatelessWidget {
  const InvestmentMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
      columnRatios: [1 / 3, 1 / 3, 1 / 3],
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      children: cryptoMetrics.map((data) {
        return IconicMetricCard(data: data);
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/data/dashboard_analytics_data.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';

// Dashboard Metrics

class DashboardMetrics extends StatelessWidget {
  const DashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Column count
    int crossAxisCount;
    if (screenWidth > kScreenWidthSm) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        mainAxisExtent: 128,
      ),
      itemBuilder: (context, index) {
        return StandardMetricCard(data: metrics[index]);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';

class DashboardMetrics extends StatelessWidget {
  const DashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > kScreenWidthSm ? 2 : 1;

    final metrics = [
      StandardMetricCardData(
        title: 'Users',
        value: '56.05k',
        icon: Icons.person_outline,
        change: '+34.21%',
        isPositive: true,
        subtitle: 'vs. prev month',
      ),
      StandardMetricCardData(
        title: 'Sessions',
        value: '127.66k',
        icon: Icons.monitor_heart_outlined,
        change: '-7.76%',
        isPositive: false,
        subtitle: 'vs. prev month',
      ),
      StandardMetricCardData(
        title: 'Avg. Visit Duration',
        value: '8m 42sec',
        icon: Icons.access_time,
        change: '-0.28%',
        isPositive: false,
        subtitle: 'vs. prev month',
      ),
      StandardMetricCardData(
        title: 'Bounce Rate',
        value: '37.48%',
        icon: Icons.open_in_new,
        change: '+9.05%',
        isPositive: true,
        subtitle: 'vs. prev month',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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

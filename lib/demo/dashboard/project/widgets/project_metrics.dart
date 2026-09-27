import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';

class ProjectMetricCard extends StatelessWidget {
  const ProjectMetricCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 3},
      columnRatios: const [1 / 3, 1 / 3, 1 / 3],
      spacing: kDefaultPadding, // spacing
      runSpacing: kDefaultPadding, // run spacing
      children: [
        SquareIconicMetricCard(
          icon: Icons.work_outline,
          title: 'ACTIVE PROJECTS',
          value: '1,125',
          subtitle: 'Projects this month',
          percentage: -3.12,
          color: kSuccessColor,
        ),
        SquareIconicMetricCard(
          icon: Icons.stars_outlined,
          title: 'NEW LEADS',
          value: '4,572',
          subtitle: 'Leads this month',
          percentage: 6.58,
          color: kInfoColor,
        ),
        SquareIconicMetricCard(
          icon: Icons.access_time_outlined,
          title: 'TOTAL TASKS',
          value: '128h 15m',
          subtitle: 'Work this month',
          percentage: -20.15,
          color: kErrorColor,
        ),
      ],
    );
  }
}

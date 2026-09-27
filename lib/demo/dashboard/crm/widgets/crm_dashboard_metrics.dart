import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';

// CRM Dashboard Metrics

class CRMDashboardMetrics extends StatelessWidget {
  const CRMDashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {
        kScreenWidthSm: 1,
        kScreenWidthLg: 2,
        kScreenWidthXl: 4,
      },
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4, ],
      children: metricsStatsData
          .map((e) => CompactMetricCard(data: e))
          .toList(),
    );
  }
}

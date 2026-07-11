import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/crm/dashboard_crm_data.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/metric_card.dart';

// CRM Dashboard Metrics

class CRMDashboardMetrics extends StatelessWidget {
  const CRMDashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      breakpoints: {
        kScreenWidthSm: 1,
        kScreenWidthMd: 2,
        kScreenWidthLg: 3,
        kScreenWidthXl: 4,
        kScreenWidthXxl: 5,
      },
      columnRatios: [1 / 5, 1 / 5, 1 / 5, 1 / 5, 1 / 5],
      children: metricsStatsData
          .map((e) => CompactMetricCard(data: e))
          .toList(),
    );
  }
}

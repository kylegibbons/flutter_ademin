import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';

import 'widgets/audience_metrics_chart.dart';
import 'widgets/audience_metrics_targets.dart';
import 'widgets/dashboard_metrics_section.dart';
import 'widgets/live_users_heat_map.dart';
import 'widgets/upgrade_banner.dart';
import 'widgets/user_management_table.dart';

class AiReferenceScreen extends StatefulWidget {
  const AiReferenceScreen({super.key});

  @override
  State<AiReferenceScreen> createState() => _AiReferenceScreenState();
}

class _AiReferenceScreenState extends State<AiReferenceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pageTitle = Lang.of(context).aiReference;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // page header
          PageHeader(
            title: lang.aiReference.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(
                label: lang.aiReference,
                uri: RouteUri.aiReference,
              ),
            ],
          ),

          // content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: const [0.6, 0.4],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: const [LiveUsersHeatMap(), _BannerMetricColumn()],
                ),
                const SizedBox(height: kDefaultPadding),
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: const [0.6, 0.4],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: const [
                    AudienceMetricsChart(),
                    AudienceMetricsTargets(),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                const UserManagementTable(),
              ],
            ),
          ),

          // footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

class _BannerMetricColumn extends StatelessWidget {
  const _BannerMetricColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UpgradeBanner(),
        SizedBox(height: kDefaultPadding),
        DashboardMetrics(),
      ],
    );
  }
}

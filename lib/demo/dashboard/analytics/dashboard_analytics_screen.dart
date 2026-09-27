import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/data/dashboard_analytics_ai_operator_data.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/data/dashboard_analytics_data.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/audience_metric_target.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/audience_metrics.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/dashboard_metrics.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/live_users_heat_map.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/top_pages_table.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/top_referal_page.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/upgrade_banner.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/user_device_chart.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_insight_card.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class DashboardAnalyticsScreen extends StatefulWidget {
  const DashboardAnalyticsScreen({super.key});

  @override
  State<DashboardAnalyticsScreen> createState() =>
      _DashboardAnalyticsScreenState();
}

class _DashboardAnalyticsScreenState extends State<DashboardAnalyticsScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pageTitle = Lang.of(
        context,
      ).analytics; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final mockData = getAnalyticsAIOperatorData();

    return PortalMasterLayout(
      aiFlyout: AIFlyoutConfig(
        enabled: true,
        dataSource: StaticDataSource(mockData),
        drawerWidth: 640,
        badgeCount: mockData.conversations.fold<int>(
          0,
          (sum, conversation) => sum + conversation.unreadCount,
        ),
      ),
      body: ListView(
        children: [
          // page header
          PageHeader(
            title: lang.analytics.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.analytics, uri: ''),
            ],
          ),
          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.6, 0.4],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // live user heat map
                    LiveUsersHeatMap(),

                    Column(
                      children: [
                        // upgrade banner card
                        UpgradeBanner(),
                        SizedBox(height: kDefaultPadding),

                        // metrics
                        DashboardMetrics(),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
                  columnRatios: [2 / 3, 1 / 3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  useScreenWidth: true,
                  children: [
                    ResponsiveWrap(
                      breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2},
                      columnRatios: [1 / 2, 1 / 2],
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      useScreenWidth: true,
                      children: [
                        // top referall widget
                        TopReferralWidget(),

                        // user by devices
                        UsersByDeviceChart(),
                      ],
                    ),

                    // top pages
                    TopPagesTable(),
                  ],
                ),
                SizedBox(height: kDefaultPadding),
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.6, 0.4],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // AI Insight
                    AiInsightCard(
                      insight: DummyAiInsights.getTrafficDropInsight(),
                    ),

                    // AI Action
                    SizedBox(
                      height: 285,
                      child: AIActionsCard(
                        onViewAll: () {
                          debugPrint('Navigate to View All');
                        },
                        actions: DummyAIActionData.aiActions,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.6, 0.4],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // audience metrics chart
                    AudienceMetricsChart(),

                    // audience metrics target chart
                    AudienceMetricsTargets(),
                  ],
                ),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

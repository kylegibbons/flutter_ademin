import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/project/data/dashboard_project_data.dart';
import 'package:flutkit_ademin/demo/dashboard/project/data/dashboard_projects_ai_operator_data.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/customer_satisfaction_gauge.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/project_hours_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/project_metrics.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/project_overview.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/project_status_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/schedule_calendar.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/ticket_response_time_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/ticket_source_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/ticket_status_chart.dart';
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

class DashboardProjectScreen extends StatefulWidget {
  const DashboardProjectScreen({super.key});

  @override
  State<DashboardProjectScreen> createState() => _DashboardProjectScreenState();
}

class _DashboardProjectScreenState extends State<DashboardProjectScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).project(2); //update your page tittle here
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
    final mockData = getProjectsAIOperatorData();

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
            title: lang.project(2).toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.project(2), uri: ''),
            ],
          ),
          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    Column(
                      children: [
                        // project metrics card
                        ProjectMetricCard(),

                        SizedBox(height: kDefaultPadding),

                        //chart
                        ProjectOverviewChart(),
                      ],
                    ),

                    // Calendar widget
                    ScheduleCalendar(),
                  ],
                ),
                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.3, 0.7],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Project Status Overview
                    ProjectStatusOverview(),

                    // Estimated Vs Actual Chart widget
                    EstimatedVsActualChart(),
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
                      insight: DummyAiInsights.getProjectDelayInsight(),
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
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Ticket By Issue Chart
                    TicketStatusChart(),

                    // Customer Satisfaction Gauge widget
                    CustomerSatisfactionGauge(value: 74.33),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.3, 0.7],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Ticket By Source Donut Chart
                    TicketBySourceDonutChart(),

                    // Avg Resolution Response Chart
                    AvgResolutionResponseChart(),
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

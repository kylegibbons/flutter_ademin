import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/data/dashboard_saas_ai_operator_data.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/data/dashboard_saas_data.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/widgets/conversion_funnel_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/widgets/product_performance_card.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/widgets/recent_activities.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/widgets/recent_invoices_table.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_insight_card.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardSaasScreen extends StatefulWidget {
  const DashboardSaasScreen({super.key});

  @override
  State<DashboardSaasScreen> createState() => _DashboardSaasScreenState();
}

class _DashboardSaasScreenState extends State<DashboardSaasScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).saas;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final mockData = getSaaSAIOperatorData();

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
            title: lang.saas.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.saas, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // Overview Metrics
                ResponsiveWrap(
                  breakpoints: {
                    kScreenWidthMd: 1,
                    kScreenWidthLg: 2,
                    kScreenWidthXl: 4,
                  },
                  columnRatios: const [0.25, 0.25, 0.25, 0.25],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Total Revenue
                    LinkMetricCard(
                      title: 'Total Revenue',
                      value: '\$759.15k',
                      changePercent: 3.5,
                      actionText: 'Net revenue',
                      icon: FontAwesomeIcons.dollarSign,
                      iconBgColor: kInfoColor,
                    ),

                    // Active Users
                    LinkMetricCard(
                      title: 'Active Users',
                      value: '9,528',
                      changePercent: 9.5,
                      actionText: 'All users',
                      icon: FontAwesomeIcons.user,
                      iconBgColor: kSuccessColor,
                    ),

                    // Customer Lifetime Value
                    LinkMetricCard(
                      title: 'Lifetime Value',
                      value: '\$879.18k',
                      changePercent: -1.6,
                      actionText: 'Total value',
                      icon: FontAwesomeIcons.tags,
                      iconBgColor: kWarningColor,
                    ),

                    // Customer Acquisition Cost
                    LinkMetricCard(
                      title: 'Cost Per Acquisition',
                      value: '\$629.75k',
                      changePercent: 3.5,
                      actionText: 'Total cost',
                      icon: FontAwesomeIcons.moneyBill,
                      iconBgColor: kErrorColor,
                    ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
                  columnRatios: const [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  useScreenWidth: true,
                  children: [
                    Column(
                      children: [
                        ResponsiveWrap(
                          breakpoints: {kScreenWidthMd: 1, kScreenWidthXxl: 2},
                          columnRatios: const [0.5, 0.5],
                          spacing: kDefaultPadding,
                          runSpacing: kDefaultPadding,
                          useScreenWidth: true,
                          children: [
                            // churn rate
                            ChartMetricCard(
                              title: 'Churn Rate',
                              subtitle: 'Downgrade to Free plan',
                              value: '4.26%',
                              delta: -0.31,
                              deltaText: 'than last Week',
                              chartData: [
                                56,
                                90,
                                123,
                                109,
                                70,
                                125,
                                50,
                                65,
                                58,
                                45,
                                18,
                                25,
                                12,
                                15,
                                10,
                              ],
                            ),

                            // user growth
                            ChartMetricCard(
                              title: 'User Growth',
                              subtitle: 'New signups',
                              value: '\$3,768',
                              delta: 3.85,
                              deltaText: 'than last Week',
                              chartData: [
                                185,
                                90,
                                200,
                                131,
                                70,
                                125,
                                50,
                                160,
                                185,
                                210,
                                205,
                                240,
                                275,
                                265,
                                310,
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: kDefaultPadding),
                        // coversion funnel
                        ConversionFunnelGroupedChart(data: funnelData),
                      ],
                    ),

                    // product performance
                    ProductPerformanceCard(
                      title: "Average Daily Sales",
                      amountText: "\$2,950",
                      percentChange: 0.52,
                      trend: TrendType.decrease,
                      data: salesData,
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
                    // AI Insight
                    AiInsightCard(
                      insight: DummyAiInsights.getSaaSChurnInsight(),
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
                  breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
                  columnRatios: const [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  useScreenWidth: true,
                  children: [
                    // recent inovoices
                    RecentInvoicesTable(),

                    // activities
                    ActivitiesWidget(activities: activities),
                  ],
                ),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

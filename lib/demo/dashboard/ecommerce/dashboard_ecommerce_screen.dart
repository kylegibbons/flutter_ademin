import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/data/dashboard_ecommerce_ai_operator_data.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/data/dashboard_ecommerce_data.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/dashboard_metrics.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/fulfillment_card.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/recent_orders_table.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/revenue_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/state_revenue_map.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/store_visits_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/widgets/top_product_revenue_chart.dart';
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

class DashboardEcommerceScreen extends StatefulWidget {
  const DashboardEcommerceScreen({super.key});

  @override
  State<DashboardEcommerceScreen> createState() =>
      _DashboardEcommerceScreenState();
}

class _DashboardEcommerceScreenState extends State<DashboardEcommerceScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).ecommerce; //update your page tittle here
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
    final mockData = getEcommerceAIOperatorData();

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
            title: lang.ecommerce.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.ecommerce, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // dashboard metrics
                EcommerceDashboardMetrics(),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Revenue Chart
                    RevenueChart(data: monthlyData),

                    // top product revenue
                    TopProductRevenueChart(data: topProductData),
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
                      insight: DummyAiInsights.getCartAbandonmentInsight(),
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
                    // Orders Table Page
                    RecentOrdersTable(),

                    // Fulfillment Card
                    FulfillmentCard(),
                  ],
                ),
                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Revenue By State Map
                    RevenueByStateMap(),

                    // Store Visits Donut Chart
                    StoreVisitsDonutChart(),
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

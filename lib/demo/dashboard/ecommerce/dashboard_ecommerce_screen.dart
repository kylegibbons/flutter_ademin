import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_data.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/dashboard_metrics.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/fulfillment_card.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/recent_orders_table.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/revenue_chart.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/state_revenue_map.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/store_visits_chart.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/widgets/top_product_revenue_chart.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

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
    MediaQuery.of(context);

    return PortalMasterLayout(
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

                AdaptiveWrap(
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

                AdaptiveWrap(
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

                AdaptiveWrap(
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

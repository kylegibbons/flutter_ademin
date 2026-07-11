import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/completed_activities.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/contact_map.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/crm_dashboard_metrics.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/funnel_chart.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/lead_sources_sales_chart.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/open_pipe.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/quartely_sales_chart.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/sales_region.dart';
import 'package:flutter_ademin/demo/dashboard/crm/widgets/won_lost_deals_chart.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class DashboardCrmScreen extends StatefulWidget {
  const DashboardCrmScreen({super.key});

  @override
  State<DashboardCrmScreen> createState() => _DashboardCrmScreenState();
}

class _DashboardCrmScreenState extends State<DashboardCrmScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).crm; //update your page tittle here
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
            title: lang.crm.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.crm, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // crm dashboard metrics
                CRMDashboardMetrics(),

                SizedBox(height: kDefaultPadding),

                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // contact map
                    ContactMap(),

                    // sales by region
                    SalesbyRegion(),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // lead source sales
                    LeadSourcesSalesChart(),

                    // quartely sales
                    QuartelySalesChart(),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // won v lost deal
                    WonLostDealsChart(),

                    // open pipe
                    OpenPipeNextMonthChart(),
                  ],
                ),
                SizedBox(height: kDefaultPadding),

                // funnel chart + completed activities
                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // funnel chart
                    FunnelChart(),

                    // completed activities
                    CompletedActivities(),
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

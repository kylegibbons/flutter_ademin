import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/data/dashboard_nft_ai_operator_data.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/data/dashboard_nft_data.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/hero_slider.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/nft_cta.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/nft_sales_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/top_bidders_table.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/top_nft_sales_pie_chart.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/top_selling_artists_table.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/widgets/trending_nft_slider.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_insight_card.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';

class DashboardNftScreen extends StatefulWidget {
  const DashboardNftScreen({super.key});

  @override
  State<DashboardNftScreen> createState() => _DashboardNftScreenState();
}

class _DashboardNftScreenState extends State<DashboardNftScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).nft; //update your page tittle here
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
    final mockData = getNFTsAIOperatorData();

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
            title: lang.nft.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.nft, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // hero slider
                HeroSlider(),

                SizedBox(height: kDefaultPadding),

                // nft call to action
                NftCTA(),

                SizedBox(height: kDefaultPadding),

                // trending NFT
                TrendingNFTSlider(),

                SizedBox(height: kDefaultPadding),

                // NFT Sales
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // total sales
                    NftSalesChart(),

                    // top collections
                    TopSalesPieChart(),
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
                      insight: DummyAiInsights.getNFTFloorPriceInsight(),
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

                // Top Bidders
                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // total bidder
                    TopBiddersTable(),

                    // top selling artist
                    TopSellingArtistsTable(),
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

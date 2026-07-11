import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/hero_slider.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/nft_cta.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/nft_sales_chart.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/top_bidders_table.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/top_nft_sales_pie_chart.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/top_selling_artists_table.dart';
import 'package:flutter_ademin/demo/dashboard/nft/widgets/trending_nft_slider.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';

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

    return PortalMasterLayout(
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
                AdaptiveWrap(
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

                // Top Bidders
                AdaptiveWrap(
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

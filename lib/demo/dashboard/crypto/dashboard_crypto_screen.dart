import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/dashboard_crypto_data.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/alt_season_index.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/coin_carousel.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/coin_market_cap.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/crypto_portofolio.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/fear_greed_gauge.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/investment_metrics.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/market_graph.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/widgets/portofolio_table.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/carousel.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';

class DashboardCryptoScreen extends StatefulWidget {
  const DashboardCryptoScreen({super.key});

  @override
  State<DashboardCryptoScreen> createState() => _DashboardCryptoScreenState();
}

class _DashboardCryptoScreenState extends State<DashboardCryptoScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle =
          Lang.of(context).crypto +
          Lang.of(context).dashboard; //update your page tittle here
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
            title: lang.crypto.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.crypto, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.3, 0.7],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,

                  children: [
                    // crypto portofolio
                    CryptoPortfolioWidget(),

                    Column(
                      children: [
                        // metrics card
                        InvestmentMetrics(),

                        SizedBox(height: kDefaultPadding),

                        // market graph
                        MarketGraphWidget(),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                // coin carousel
                CustomCarousel(
                  pages: buildCoinCarousel(coins, context),
                  showControls: false,
                  showIndicator: false,
                  autoSlideInterval: Duration(seconds: 6),
                  height: 146,
                ),

                SizedBox(height: kDefaultPadding),

                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,

                  children: [
                    // crypto portofolio table
                    CryptoPortfolioTable(),

                    Column(
                      children: [
                        // fear greed index
                        FearGreedGauge(value: 67),

                        SizedBox(height: kDefaultPadding),

                        // alt coint season index
                        AltcoinSeasonIndex(indexValue: 34),

                        SizedBox(height: kDefaultPadding),

                        // coin marketplace
                        CoinMarketCapIndex(
                          currentValue: 238.73,
                          percentChange: -0.95,
                          data: mockCoinMarketCapData,
                        ),
                      ],
                    ),
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

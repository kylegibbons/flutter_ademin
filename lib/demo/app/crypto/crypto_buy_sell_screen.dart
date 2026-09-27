import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/widgets/crypto_buy_sell_market_graph.dart';
import 'package:flutkit_ademin/demo/app/crypto/widgets/crypto_buy_sell_market_table.dart';
import 'package:flutkit_ademin/demo/app/crypto/widgets/crypto_buy_sell_metric.dart';
import 'package:flutkit_ademin/demo/app/crypto/widgets/crypto_buy_sell_trade.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class CryptoBuySellScreen extends StatefulWidget {
  const CryptoBuySellScreen({super.key});

  @override
  State<CryptoBuySellScreen> createState() => _CryptoBuySellScreenState();
}

class _CryptoBuySellScreenState extends State<CryptoBuySellScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).buySell; //update your page tittle here
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
          // header
          PageHeader(
            title: lang.transactions.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.crypto, uri: ''),
              BreadcrumbItem(label: lang.buySell, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // metris
                CryptoBuySellMetrics(),

                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: [0.7, 0.3],
                  children: [
                    // candle chart
                    MarketGraph(),

                    // trade widget
                    TradeWidget(),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                // market table
                MarketTable(),
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

import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/widgets/crypto_wallet_coin_watchlist.dart';
import 'package:flutter_ademin/demo/app/crypto/widgets/crypto_wallet_my_portfolio_stats.dart';
import 'package:flutter_ademin/demo/app/crypto/widgets/crypto_wallet_portfolio_metric_card.dart';
import 'package:flutter_ademin/demo/app/crypto/widgets/crypto_wallet_portfolio_tabled.dart';
import 'package:flutter_ademin/demo/app/crypto/widgets/crypto_wallet_recent_transaction.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class CryptoMyWalletScreen extends StatefulWidget {
  const CryptoMyWalletScreen({super.key});

  @override
  State<CryptoMyWalletScreen> createState() => _CryptoMyWalletScreenState();
}

class _CryptoMyWalletScreenState extends State<CryptoMyWalletScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).myWallet; //update your page tittle here
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
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // header
          PageHeader(
            title: lang.myWallet.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.crypto, uri: ''),
              BreadcrumbItem(label: lang.myWallet, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                AdaptiveWrap(
                  runSpacing: kDefaultPadding,
                  spacing: kDefaultPadding,
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXxl: 2},
                  columnRatios: [0.75, 0.25],
                  children: [
                    Column(
                      children: [
                        //My Portfolio Statistics
                        MyPortfolioStats(),
                        SizedBox(height: kDefaultPadding),

                        // Coin watchlist
                        CoinWatchlist(),

                        SizedBox(height: kDefaultPadding),

                        // portfolio table
                        PortfolioTable(),
                      ],
                    ),

                    Column(
                      children: [
                        AdaptiveWrap(
                          spacing: kDefaultPadding,
                          runSpacing: kDefaultPadding,
                          breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 3},
                          columnRatios: [1 / 3, 1 / 3, 1 / 3],
                          children: [
                            PortfolioMetricCard(
                              title: 'My Portfolio',
                              icon: Icons.account_balance_wallet_outlined,
                              mainAmount: 6191967.29,
                              subAmount: 2510974,
                              percentageChange: 4.37,
                              iconColor: themeData.colorScheme.primary,
                              bgColor: kWarningColor.withValues(alpha: 0.2),
                            ),
                            PortfolioMetricCard(
                              title: 'Today’s Profit',
                              icon: Icons.savings_outlined,
                              mainAmount: 274365.84,
                              subAmount: 910564,
                              percentageChange: 1.25,
                              iconColor: themeData.colorScheme.primary,
                            ),
                            PortfolioMetricCard(
                              title: 'Overall Profit',
                              icon: Icons.trending_up_outlined,
                              mainAmount: 3267120.42,
                              subAmount: 1822730,
                              percentageChange: 8.34,
                              iconColor: themeData.colorScheme.primary,
                            ),
                          ],
                        ),

                        SizedBox(height: kDefaultPadding),

                        // recent transaction
                        RecentTransactionList(),
                      ],
                    ),
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

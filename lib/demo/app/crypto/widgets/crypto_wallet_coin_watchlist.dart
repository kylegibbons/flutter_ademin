import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinWatchlist extends StatelessWidget {
  const CoinWatchlist({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Watchlist'.toUpperCase(),
              style: TextStyle(
                fontSize: kBodyMedium,
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            Spacer(),

            // add watchlist button
            isMobile
                ? CustomIconButton(
                    icon: Icons.star_outline,
                    iconColor: Colors.white,
                    buttonColor: kSuccessColor,
                    onTap: () {},
                  )
                : FlatButton(
                    kText: 'Add watchlist',
                    bgColor: kSuccessColor,
                    kTextColor: Colors.white,
                    onPressed: () {},
                    kLeadingIcon: Icons.star_outline,
                  ),
          ],
        ),

        SizedBox(height: kDefaultPadding),

        // slider
        CustomCarousel(
          pages: buildCarouselPages(coins, context),
          showControls: false,
          showIndicator: false,
          autoSlideInterval: const Duration(seconds: 6),
          height: 146,
        ),
      ],
    );
  }
}

List<Widget> buildCarouselPages(List<CoinData> allCoins, BuildContext context) {
  // coinsPerPage
  int calculateCoinPerPage(double width) {
    if (width >= kScreenWidthMd) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  // Calculate padding multiplier based on screen width
  int calculatePaddingMultiplier(double width) {
    if (width >= kScreenWidthMd) return 2; // More padding for larger screens
    if (width >= kScreenWidthSm) return 1; // Medium padding for medium screens
    return 0; // Less padding for small screens
  }

  final screenWidth = MediaQuery.of(context).size.width;

  final coinsPerPage = calculateCoinPerPage(screenWidth);
  final paddingMultiplier = calculatePaddingMultiplier(
    screenWidth,
  ); // Get the padding multiplier

  final pageCount = (allCoins.length / coinsPerPage).ceil();

  return List.generate(pageCount, (pageIndex) {
    final start = pageIndex * coinsPerPage;
    final end = (start + coinsPerPage).clamp(0, allCoins.length);
    final coinsOnPage = allCoins.sublist(start, end);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the calculated paddingMultiplier here
        final availableWidth =
            constraints.maxWidth - (paddingMultiplier * kDefaultPadding);

        final cardWidth = availableWidth / coinsPerPage;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: coinsOnPage
              .map(
                (coin) => SizedBox(
                  width: cardWidth,
                  child: CoinCard(coin: coin),
                ),
              )
              .toList(),
        );
      },
    );
  });
}

class CoinCard extends StatelessWidget {
  final CoinData coin;
  const CoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final isNegative = coin.changePercent < 0;
    final changeColor = isNegative ? kErrorColor : kSuccessColor;
    final themeData = Theme.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: 2),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.withValues(alpha: 0.2),
                  radius: 16,
                  child: CircleAvatar(
                    backgroundColor: coin.color,
                    radius: 14,
                    child: FaIcon(coin.icon, color: Colors.white, size: 14),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Text(
                  coin.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth = constraints.maxWidth * 0.6;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // price and delta
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${coin.price}',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.bold,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding / 4),
                        Row(
                          children: [
                            Text(
                              '${isNegative ? '' : '+'}${coin.changePercent}%',
                              style: TextStyle(
                                color: changeColor,
                                fontSize: kBodySmall,
                              ),
                            ),
                            Text(
                              ' (${coin.symbol})',
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // chart with 50% width
                    SizedBox(
                      height: 64,
                      width: chartWidth,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        margin: EdgeInsets.zero,
                        primaryXAxis: NumericAxis(isVisible: false),
                        primaryYAxis: NumericAxis(isVisible: false),
                        series: <CartesianSeries>[
                          SplineAreaSeries<double, int>(
                            dataSource: coin.chartData,
                            xValueMapper: (_, i) => i,
                            yValueMapper: (value, _) => value,
                            gradient: LinearGradient(
                              colors: [
                                coin.color.withValues(alpha: 0.4),
                                coin.color.withValues(alpha: 0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderColor: coin.color,
                            borderWidth: 2,
                          ),
                        ],
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                          tooltipAlignment: ChartAlignment.near,
                          tooltipDisplayMode:
                              TrackballDisplayMode.floatAllPoints,
                          lineDashArray: [4, 4],
                          lineWidth: 0.6,
                          lineColor: kTextColor,
                          tooltipSettings: InteractiveTooltip(
                            enable: true,
                            format: 'point.x : \$point.y',
                            color: themeData.colorScheme.surface,
                            textStyle: TextStyle(
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

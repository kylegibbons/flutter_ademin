import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/widgets/popup_menu_button.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/data/dashboard_crypto_data.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/dashboard_crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Market Graph Widget

class MarketGraphWidget extends StatefulWidget {
  const MarketGraphWidget({super.key});

  @override
  State<MarketGraphWidget> createState() => _MarketGraphWidgetState();
}

class _MarketGraphWidgetState extends State<MarketGraphWidget> {
  String selectedTimeRange = '1H'; // Default selected time range

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return Card(
      child: SizedBox(
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Market Graph, Time Range Buttons
            CardHeader(
              kText: 'Market Graph',
              kWidget: mediaQueryData.size.width < kScreenWidthSm
                  ? PeriodPopUpMenu()
                  : Padding(
                      padding: EdgeInsetsDirectional.only(end: kDefaultPadding),
                      child: _buildTimeRangeSelector(),
                    ),
            ),

            Container(
              decoration: BoxDecoration(color: kTableHeaderColor),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1.5 * kDefaultPadding,
              ),
              child: ResponsiveWrap(
                breakpoints: {
                  kScreenWidthSm / 2: 1, // set breakpoint for 1 column layout,
                  kScreenWidthSm: 2, // set breakpoint for 2 column layout
                  kScreenWidthMd: 4, // set breakpoint for 4 column layout
                },
                columnRatios: const [
                  0.25, // set column A as 25% width
                  0.25, // set column B as 25% width
                  0.25, // set column C as 25% width
                  0.25, // set column D as 25% width
                ],
                spacing: kDefaultPadding, // spacing
                runSpacing: 2 * kDefaultPadding, // run spacing
                children: [
                  // Current Price and Bitcoin Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$43,659.13',
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BITCOIN (BTC)',
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: kSuccessColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_outward,
                                  color: kSuccessColor,
                                  size: 10,
                                ),
                                Text(
                                  '2.15%',
                                  style: TextStyle(
                                    color: kSuccessColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: kBodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // High, Low, Market Volume
                  _buildInfoColumn('High', '\$18,732.77', kSuccessColor),
                  _buildInfoColumn('Low', '\$69,386.73', kErrorColor),
                  _buildInfoColumn(
                    'Market Volume',
                    '\$987,423,960',
                    kPrimaryColor,
                  ),
                ],
              ),
            ),

            // Candle Chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0, // Remove chart border
                  margin: EdgeInsets.zero,
                  primaryXAxis: DateTimeAxis(
                    majorGridLines: MajorGridLines(
                      width: 0,
                    ), // Hide vertical grid lines
                    dateFormat:
                        DateFormat.jm(), // Format for time (e.g., 01:00 AM)
                    intervalType: DateTimeIntervalType.hours,
                    axisLine: AxisLine(width: 0), // Hide X-axis line
                    majorTickLines: MajorTickLines(
                      size: 0,
                    ), // Hide X-axis tick lines
                    labelStyle: TextStyle(color: kTextColor),
                  ),
                  primaryYAxis: NumericAxis(
                    // minimum: 6560, // Set the minimum value for the Y-axis
                    // maximum: 6850, // Set the maximum value for the Y-axis
                    interval:
                        16, // Set the interval between major grid lines/labels
                    majorGridLines: MajorGridLines(
                      width: 0.6,
                      color: kTextColor.withValues(
                        alpha: 0.2,
                      ), // Light grey horizontal grid lines
                    ),
                    axisLine: AxisLine(width: 0), // Hide Y-axis line
                    majorTickLines: MajorTickLines(
                      size: 0,
                    ), // Hide Y-axis tick lines
                    labelStyle: TextStyle(color: kTextColor),
                    numberFormat: NumberFormat.compactSimpleCurrency(
                      locale: 'en_US',
                      name: '\$',
                    ), // Display as compact currency, no dollar sign for the axis labels
                  ),
                  series: <CandleSeries>[
                    CandleSeries<CandleData, DateTime>(
                      dataSource: mockCandleData,
                      name: 'Bitcoin (BTC)',
                      xValueMapper: (CandleData sales, _) => sales.time,
                      lowValueMapper: (CandleData sales, _) => sales.low,
                      highValueMapper: (CandleData sales, _) => sales.high,
                      openValueMapper: (CandleData sales, _) => sales.open,
                      closeValueMapper: (CandleData sales, _) => sales.close,
                      enableSolidCandles: true, // Solid candles
                      bearColor: kErrorColor, // Bearish candle color (red)
                      bullColor: kSuccessColor, // Bullish candle color (green)
                      borderWidth: 1, // Add a border to the candles
                    ),
                  ],
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                    lineDashArray: [4, 4],
                    lineWidth: 0.6,
                    lineColor: kTextColor,
                    tooltipSettings: InteractiveTooltip(
                      enable: true,
                      color: themeData.colorScheme.surface,
                      textStyle: TextStyle(
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    enableSelectionZooming: true,
                    enablePanning: true,
                    zoomMode: ZoomMode.x, // Allow zooming only on X-axis (time)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the time range selector buttons
  Widget _buildTimeRangeSelector() {
    List<String> timeRanges = ['1H', '7D', '1M', '1Y', 'ALL'];
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        children: timeRanges.map((range) {
          bool isSelected = selectedTimeRange == range;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeRange = range;
                // In a real app, this would trigger data fetching for the selected range
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? themeData.colorScheme.surface
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(defaultRadius),
                // border:
                //     isSelected ? Border.all(color: Colors.grey.shade200) : null,
              ),
              child: Text(
                range,
                style: TextStyle(
                  fontSize: kBodySmall,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? kSecondaryColor
                      : themeData.colorScheme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper to build the info columns (High, Low, Market Volume)
  Widget _buildInfoColumn(String title, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: kBodyMedium, color: kTextColor),
        ),
        SizedBox(height: kDefaultPadding / 2),
        Text(
          value,
          style: TextStyle(
            fontSize: kBodyLarge,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

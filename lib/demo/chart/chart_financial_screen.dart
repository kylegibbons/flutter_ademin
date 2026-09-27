import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartFinancialScreen extends StatefulWidget {
  const ChartFinancialScreen({super.key});

  @override
  State<ChartFinancialScreen> createState() => _ChartFinancialScreenState();
}

class _ChartFinancialScreenState extends State<ChartFinancialScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).stepLineChart; //update your page tittle here
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
          //page title and breadcrumb
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.financialChart.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.chart, uri: ''),
                        BreadcrumbItem(
                          label: lang.financialChart,
                          uri: RouteUri.chartBubble,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // High Low Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'High Low Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: HighLowStockChart(),
                            ),
                            codeView:
                                '''HighLowStockChart() source code can be found in the lib/demo/chart/chart_financial_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Open-High-Low-Close (OHLC) Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Open High Low Close (OHLC) Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: StockOHLCChart(),
                            ),
                            codeView:
                                '''HighLowStockChart() source code can be found in the lib/demo/chart/chart_financial_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Candle Stick Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Candle Stick Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: StockCandleChart(),
                            ),
                            codeView:
                                '''HighLowStockChart() source code can be found in the lib/demo/chart/chart_financial_screen.dart file.''',
                            height: 440,
                          ),
                        ),
                      ],
                    );
                  },
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

// FINANCIAL CHART //

class HighLowStockChart extends StatefulWidget {
  const HighLowStockChart({super.key});

  @override
  State<HighLowStockChart> createState() => _HighLowStockChartState();
}

class _HighLowStockChartState extends State<HighLowStockChart> {
  late List<StockPriceData> _stockData;

  @override
  void initState() {
    super.initState();
    _stockData = _getStockData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Stock Price High-Low (Last 7 Days)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(text: 'Date', textStyle: chartAxisLabelStyle),
        dateFormat: DateFormat.MMMd(),
        minimum: DateTime(2025, 01, 10),
        maximum: DateTime(2025, 01, 18),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Stock Price (USD)',
          textStyle: chartAxisLabelStyle,
        ),
        numberFormat: NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 0,
        ),
        minimum: 120,
        maximum: 220,
        interval: 20,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <HiloSeries>[
        HiloSeries<StockPriceData, DateTime>(
          name: 'Stock Price',
          dataSource: _stockData,
          xValueMapper: (StockPriceData data, _) => data.date,
          highValueMapper: (StockPriceData data, _) => data.high,
          lowValueMapper: (StockPriceData data, _) => data.low,
          color: kSecondaryColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          borderWidth: 3.0,
        ),
      ],
    );
  }

  /// Sample Stock Data
  List<StockPriceData> _getStockData() {
    return [
      StockPriceData(DateTime(2025, 01, 11), 180, 150),
      StockPriceData(DateTime(2025, 01, 12), 175, 140),
      StockPriceData(DateTime(2025, 01, 13), 190, 160),
      StockPriceData(DateTime(2025, 01, 14), 185, 155),
      StockPriceData(DateTime(2025, 01, 15), 170, 145),
      StockPriceData(DateTime(2025, 01, 16), 195, 170),
      StockPriceData(DateTime(2025, 01, 17), 200, 180),
    ];
  }

  @override
  void dispose() {
    _stockData.clear();
    super.dispose();
  }
}

/// Data Model
class StockPriceData {
  final DateTime date;
  final double high;
  final double low;

  StockPriceData(this.date, this.high, this.low);
}

// OHLC chart

class StockOHLCChart extends StatefulWidget {
  const StockOHLCChart({super.key});

  @override
  State<StockOHLCChart> createState() => _StockOHLCChartState();
}

class _StockOHLCChartState extends State<StockOHLCChart> {
  late List<StockDataOHLC> _stockDataOHLC;

  @override
  void initState() {
    super.initState();
    _stockDataOHLC = _getStockDataOHLC();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Apple Inc. (AAPL) - OHLC Prices',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(text: 'Date', textStyle: chartAxisLabelStyle),
        dateFormat: DateFormat('MMM dd'),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Stock Price (USD)',
          textStyle: chartAxisLabelStyle,
        ),
        numberFormat: NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 0,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <HiloOpenCloseSeries>[
        HiloOpenCloseSeries<StockDataOHLC, DateTime>(
          name: 'AAPL',
          dataSource: _stockDataOHLC,
          xValueMapper: (StockDataOHLC data, _) => data.date,
          lowValueMapper: (StockDataOHLC data, _) => data.low,
          highValueMapper: (StockDataOHLC data, _) => data.high,
          openValueMapper: (StockDataOHLC data, _) => data.open,
          closeValueMapper: (StockDataOHLC data, _) => data.close,
          bearColor: kErrorColor,
          bullColor: kSuccessColor,
          borderWidth: 3.0,
        ),
      ],
    );
  }

  /// Generates sample stock price data for a week.
  List<StockDataOHLC> _getStockDataOHLC() {
    final DateTime today = DateTime.now();
    return List.generate(7, (index) {
      double open = 145 + (index * 1.5);
      double close = open + (index % 2 == 0 ? 2.0 : -1.0);
      return StockDataOHLC(
        today.subtract(Duration(days: index)),
        open,
        open + 3.0, // High
        open - 2.0, // Low
        close,
      );
    }).reversed.toList(); // Reverse for chronological order
  }

  @override
  void dispose() {
    _stockDataOHLC.clear();
    super.dispose();
  }
}

/// Stock Data Model
class StockDataOHLC {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  StockDataOHLC(this.date, this.open, this.high, this.low, this.close);
}

// candle stick chart

class StockCandleChart extends StatefulWidget {
  const StockCandleChart({super.key});

  @override
  State<StockCandleChart> createState() => _StockCandleChartState();
}

class _StockCandleChartState extends State<StockCandleChart> {
  late List<StockDataCandle> _stockDataCandle;

  @override
  void initState() {
    super.initState();
    _stockDataCandle = _getStockDataCandle();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Apple Inc. (AAPL) - Candlestick Prices',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: DateTimeAxis(
        title: AxisTitle(text: 'Date', textStyle: chartAxisLabelStyle),
        dateFormat: DateFormat('MMM dd'),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Stock Price (USD)',
          textStyle: chartAxisLabelStyle,
        ),
        numberFormat: NumberFormat.currency(locale: 'en_US', symbol: '\$'),
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <CandleSeries>[
        CandleSeries<StockDataCandle, DateTime>(
          name: 'AAPL',
          dataSource: _stockDataCandle,
          xValueMapper: (StockDataCandle data, _) => data.date,
          lowValueMapper: (StockDataCandle data, _) => data.low,
          highValueMapper: (StockDataCandle data, _) => data.high,
          openValueMapper: (StockDataCandle data, _) => data.open,
          closeValueMapper: (StockDataCandle data, _) => data.close,
          bullColor: kSuccessColor, // Green for increasing price
          bearColor: kErrorColor, // Red for decreasing price
          borderWidth: 3.0,
        ),
      ],
    );
  }

  /// Generates sample stock price data for a week.
  List<StockDataCandle> _getStockDataCandle() {
    final DateTime today = DateTime.now();
    return List.generate(7, (index) {
      double open = 145 + (index * 1.5);
      double close = open + (index % 2 == 0 ? 2.0 : -1.0);
      return StockDataCandle(
        today.subtract(Duration(days: index)),
        open,
        open + 3.0, // High
        open - 2.0, // Low
        close,
      );
    }).reversed.toList(); // Reverse for chronological order
  }

  @override
  void dispose() {
    _stockDataCandle.clear();
    super.dispose();
  }
}

/// Stock Data Model
class StockDataCandle {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  StockDataCandle(this.date, this.open, this.high, this.low, this.close);
}

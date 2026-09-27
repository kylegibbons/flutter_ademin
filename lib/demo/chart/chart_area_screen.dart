import 'dart:ui' as ui;

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

class ChartAreaScreen extends StatefulWidget {
  const ChartAreaScreen({super.key});

  @override
  State<ChartAreaScreen> createState() => _ChartAreaScreenState();
}

class _ChartAreaScreenState extends State<ChartAreaScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).columnChart; //update your page tittle here
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
                      lang.areaChart.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
                          label: lang.areaChart,
                          uri: RouteUri.chartArea,
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
                        // Line Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Line Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: BasicAreaChart(),
                            ),
                            codeView:
                                '''BasicAreaChart() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Spline Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Spline Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: SplineAreaChart(),
                            ),
                            codeView:
                                '''SplineAreaChart() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Line Stack Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Line Stack Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: StackAreaChart(),
                            ),
                            codeView:
                                '''StackAreaChart() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Spline Stack Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Spline Stack Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: SplineAreaStackChart(),
                            ),
                            codeView:
                                '''SplineAreaStackChart() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Step Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Step Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: StepAreaChartExample(),
                            ),
                            codeView:
                                '''StepAreaChartExample() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Range Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Range Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: RangeAreaChartExample(),
                            ),
                            codeView:
                                '''RangeAreaChartExample() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Spline Range Area Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Spline Range Area Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: SplineRangeAreaChartExample(),
                            ),
                            codeView:
                                '''SplineRangeAreaChartExample() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Area Zone Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Area Zone Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: AreaZoneChart(),
                            ),
                            codeView:
                                '''AreaZoneChart() source code can be found in the lib/demo/chart/chart_area_screen.dart file.''',
                            height: 400,
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

// AREA CHART //

// basic area chart

class StockData {
  final DateTime date;
  final double price;

  StockData(this.date, this.price);
}

List<StockData> stockData = getStockData();

class BasicAreaChart extends StatelessWidget {
  const BasicAreaChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Stock Price Movements',
        textStyle: chartTitleStyle,
        alignment: ChartAlignment.center,
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('dd/MM'),
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(text: 'Date', textStyle: chartTitleStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Price', textStyle: chartTitleStyle),
        labelFormat: '{value}\$', // Formatting the price with a dollar sign
      ),
      series: <CartesianSeries>[
        AreaSeries<StockData, DateTime>(
          dataSource: stockData, // Use the data
          xValueMapper: (StockData data, _) => data.date,
          yValueMapper: (StockData data, _) => data.price,
          color: kInfoColor.withValues(alpha: 0.5),
          borderColor: kInfoColor,
          borderWidth: 2,
        ),
      ],
    );
  }
}

class SplineAreaChart extends StatelessWidget {
  const SplineAreaChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Stock Price Movements',
        textStyle: chartTitleStyle,
        alignment: ChartAlignment.center,
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('dd/MM'),
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(text: 'Date', textStyle: chartTitleStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Price', textStyle: chartTitleStyle),
        labelFormat: '{value}\$', // Formatting the price with a dollar sign
      ),
      series: <CartesianSeries>[
        SplineAreaSeries<StockData, DateTime>(
          dataSource: stockData, // Use the data
          xValueMapper: (StockData data, _) => data.date,
          yValueMapper: (StockData data, _) => data.price,
          color: kSuccessColor.withValues(alpha: 0.5),
          borderColor: kInfoColor,
          borderWidth: 2,
        ),
      ],
    );
  }
}

List<StockData> getStockData() {
  return [
    StockData(DateTime(2025, 1, 1), 150),
    StockData(DateTime(2025, 1, 2), 155),
    StockData(DateTime(2025, 1, 3), 160),
    StockData(DateTime(2025, 1, 4), 165),
    StockData(DateTime(2025, 1, 5), 170),
    StockData(DateTime(2025, 1, 6), 180),
    StockData(DateTime(2025, 1, 7), 175),
    StockData(DateTime(2025, 1, 8), 190),
    StockData(DateTime(2025, 1, 9), 200),
    StockData(DateTime(2025, 1, 10), 210),
    StockData(DateTime(2025, 1, 11), 205),
    StockData(DateTime(2025, 1, 12), 215),
    StockData(DateTime(2025, 1, 13), 220),
    StockData(DateTime(2025, 1, 14), 225),
    StockData(DateTime(2025, 1, 15), 230),
    StockData(DateTime(2025, 1, 16), 240),
    StockData(DateTime(2025, 1, 17), 235),
    StockData(DateTime(2025, 1, 18), 245),
    StockData(DateTime(2025, 1, 19), 250),
    StockData(DateTime(2025, 1, 20), 240),
    StockData(DateTime(2025, 1, 21), 230),
    StockData(DateTime(2025, 1, 22), 220),
    StockData(DateTime(2025, 1, 23), 155),
    StockData(DateTime(2025, 1, 24), 225),
    StockData(DateTime(2025, 1, 25), 230),
    StockData(DateTime(2025, 1, 26), 240),
    StockData(DateTime(2025, 1, 27), 250),
    StockData(DateTime(2025, 1, 28), 260),
    StockData(DateTime(2025, 1, 29), 270),
    StockData(DateTime(2025, 1, 30), 280),
    StockData(DateTime(2025, 1, 31), 275),
    StockData(DateTime(2025, 2, 1), 285),
    StockData(DateTime(2025, 2, 2), 290),
    StockData(DateTime(2025, 2, 3), 300),
    StockData(DateTime(2025, 2, 4), 310),
    StockData(DateTime(2025, 2, 5), 320),
    StockData(DateTime(2025, 2, 6), 330),
    StockData(DateTime(2025, 2, 7), 325),
    StockData(DateTime(2025, 2, 8), 335),
    StockData(DateTime(2025, 2, 9), 340),
    StockData(DateTime(2025, 2, 10), 350),
  ];
}

// spline area stack chart

class SplineAreaStackChart extends StatefulWidget {
  const SplineAreaStackChart({super.key});

  @override
  State<SplineAreaStackChart> createState() => _SplineAreaStackChartState();
}

class _SplineAreaStackChartState extends State<SplineAreaStackChart> {
  late List<TemperatureDataSplineArea> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getTemperatureDataSplineArea();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Temperature Trends',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        maximum: 50,
        interval: 10,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <SplineAreaSeries>[
        SplineAreaSeries<TemperatureDataSplineArea, String>(
          name: 'Summer',
          dataSource: _chartData,
          xValueMapper: (TemperatureDataSplineArea temp, _) => temp.month,
          yValueMapper: (TemperatureDataSplineArea temp, _) => temp.summer,
          color: kWarningColor.withValues(alpha: 0.6),
          borderColor: kWarningColor,
          borderWidth: 2,
        ),
        SplineAreaSeries<TemperatureDataSplineArea, String>(
          name: 'Winter',
          dataSource: _chartData,
          xValueMapper: (TemperatureDataSplineArea temp, _) => temp.month,
          yValueMapper: (TemperatureDataSplineArea temp, _) => temp.winter,
          color: kSuccessColor.withValues(alpha: 0.6),
          borderColor: kSuccessColor,
          borderWidth: 2,
        ),
      ],
    );
  }

  /// Generate temperature data for 12 months
  List<TemperatureDataSplineArea> _getTemperatureDataSplineArea() {
    return [
      TemperatureDataSplineArea('Jan', 30, 5),
      TemperatureDataSplineArea('Feb', 32, 7),
      TemperatureDataSplineArea('Mar', 35, 10),
      TemperatureDataSplineArea('Apr', 38, 15),
      TemperatureDataSplineArea('May', 40, 20),
      TemperatureDataSplineArea('Jun', 38, 25),
      TemperatureDataSplineArea('Jul', 36, 28),
      TemperatureDataSplineArea('Aug', 35, 27),
      TemperatureDataSplineArea('Sep', 33, 22),
      TemperatureDataSplineArea('Oct', 30, 15),
      TemperatureDataSplineArea('Nov', 28, 10),
      TemperatureDataSplineArea('Dec', 27, 7),
    ];
  }

  @override
  void dispose() {
    _chartData.clear();
    super.dispose();
  }
}

/// Temperature Data Model
class TemperatureDataSplineArea {
  final String month;
  final double summer;
  final double winter;

  TemperatureDataSplineArea(this.month, this.summer, this.winter);
}

// stack area chart

class StackAreaChart extends StatelessWidget {
  const StackAreaChart({super.key});

  @override
  Widget build(BuildContext context) {
    // First data series
    final List<StockData> stockDataSeries1 = getStockData1();
    // Second data series
    final List<StockData> stockDataSeries2 = getStockData2();
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Stock Price Movement',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat('MMM dd'),
        intervalType: DateTimeIntervalType.days,
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(text: 'Date', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Price', textStyle: chartAxisLabelStyle),
        labelFormat: '\${value}', // Price formatting
      ),
      series: <CartesianSeries>[
        AreaSeries<StockData, DateTime>(
          name: 'Company A',
          dataSource: stockDataSeries1,
          xValueMapper: (StockData data, _) => data.date,
          yValueMapper: (StockData data, _) => data.price,
          color: kInfoColor.withValues(alpha: 0.5),
          borderColor: kInfoColor,
          borderWidth: 2,
          borderDrawMode: BorderDrawMode.top,
        ),
        AreaSeries<StockData, DateTime>(
          name: 'Company B',
          dataSource: stockDataSeries2,
          xValueMapper: (StockData data, _) => data.date,
          yValueMapper: (StockData data, _) => data.price,
          color: kSuccessColor.withValues(alpha: 0.5),
          borderColor: kSuccessColor,
          borderWidth: 2,
          borderDrawMode: BorderDrawMode.excludeBottom,
        ),
      ],
    );
  }
}

// Manually defined stock data for the first series
List<StockData> getStockData1() {
  return [
    StockData(DateTime(2025, 1, 1), 150),
    StockData(DateTime(2025, 1, 2), 170),
    StockData(DateTime(2025, 1, 3), 200),
    StockData(DateTime(2025, 1, 4), 220),
    StockData(DateTime(2025, 1, 5), 240),
    StockData(DateTime(2025, 1, 6), 280),
    StockData(DateTime(2025, 1, 7), 260),
    StockData(DateTime(2025, 1, 8), 300),
    StockData(DateTime(2025, 1, 9), 70),
    StockData(DateTime(2025, 1, 10), 140),
    StockData(DateTime(2025, 1, 11), 370),
    StockData(DateTime(2025, 1, 12), 400),
    StockData(DateTime(2025, 1, 13), 420),
    StockData(DateTime(2025, 1, 14), 450),
    StockData(DateTime(2025, 1, 15), 480),
    StockData(DateTime(2025, 1, 16), 500),
    StockData(DateTime(2025, 1, 17), 470),
    StockData(DateTime(2025, 1, 18), 530),
    StockData(DateTime(2025, 1, 19), 560),
    StockData(DateTime(2025, 1, 20), 600),
  ];
}

// Manually defined stock data for the second series
List<StockData> getStockData2() {
  return [
    StockData(DateTime(2025, 1, 1), 100),
    StockData(DateTime(2025, 1, 2), 110),
    StockData(DateTime(2025, 1, 3), 120),
    StockData(DateTime(2025, 1, 4), 130),
    StockData(DateTime(2025, 1, 5), 140),
    StockData(DateTime(2025, 1, 6), 150),
    StockData(DateTime(2025, 1, 7), 80),
    StockData(DateTime(2025, 1, 8), 100),
    StockData(DateTime(2025, 1, 9), 120),
    StockData(DateTime(2025, 1, 10), 140),
    StockData(DateTime(2025, 1, 11), 130),
    StockData(DateTime(2025, 1, 12), 150),
    StockData(DateTime(2025, 1, 13), 170),
    StockData(DateTime(2025, 1, 14), 190),
    StockData(DateTime(2025, 1, 15), 400),
    StockData(DateTime(2025, 1, 16), 590),
    StockData(DateTime(2025, 1, 17), 480),
    StockData(DateTime(2025, 1, 18), 400),
    StockData(DateTime(2025, 1, 19), 300),
    StockData(DateTime(2025, 1, 20), 260),
  ];
}

// step area chart

class StepAreaChartExample extends StatefulWidget {
  const StepAreaChartExample({super.key});

  @override
  State<StepAreaChartExample> createState() => _StepAreaChartExampleState();
}

class _StepAreaChartExampleState extends State<StepAreaChartExample> {
  late List<PowerConsumptionData> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getPowerConsumptionData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Electricity Consumption (kWh)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Power Consumption (kWh)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 200,
        maximum: 700,
        interval: 100,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <StepAreaSeries>[
        StepAreaSeries<PowerConsumptionData, String>(
          name: 'City A',
          dataSource: _chartData,
          xValueMapper: (PowerConsumptionData data, _) => data.month,
          yValueMapper: (PowerConsumptionData data, _) => data.cityA,
          color: kInfoColor.withValues(alpha: 0.9),
          borderColor: kSecondaryColor,
          borderWidth: 1,
        ),
        StepAreaSeries<PowerConsumptionData, String>(
          name: 'City B',
          dataSource: _chartData,
          xValueMapper: (PowerConsumptionData data, _) => data.month,
          yValueMapper: (PowerConsumptionData data, _) => data.cityB,
          color: kSuccessColor.withValues(alpha: 0.9),
          borderColor: kPrimaryColor,
          borderWidth: 1,
        ),
      ],
    );
  }

  /// Generates electricity consumption data for 12 months.
  List<PowerConsumptionData> _getPowerConsumptionData() {
    return [
      PowerConsumptionData('Jan', 350, 300),
      PowerConsumptionData('Feb', 380, 320),
      PowerConsumptionData('Mar', 500, 400),
      PowerConsumptionData('Apr', 520, 480),
      PowerConsumptionData('May', 550, 500),
      PowerConsumptionData('Jun', 580, 560),
      PowerConsumptionData('Jul', 600, 400),
      PowerConsumptionData('Aug', 630, 600),
      PowerConsumptionData('Sep', 610, 470),
      PowerConsumptionData('Oct', 580, 540),
      PowerConsumptionData('Nov', 540, 500),
      PowerConsumptionData('Dec', 500, 260),
    ];
  }

  @override
  void dispose() {
    _chartData.clear();
    super.dispose();
  }
}

/// Data Model for Power Consumption
class PowerConsumptionData {
  final String month;
  final double cityA;
  final double cityB;

  PowerConsumptionData(this.month, this.cityA, this.cityB);
}

// range area chart

class RangeAreaChartExample extends StatefulWidget {
  const RangeAreaChartExample({super.key});

  @override
  State<RangeAreaChartExample> createState() => _RangeAreaChartExampleState();
}

class _RangeAreaChartExampleState extends State<RangeAreaChartExample> {
  late List<TemperatureDataRange> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getTemperatureDataRange();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Temperature Range',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: -10,
        maximum: 40,
        interval: 10,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <CartesianSeries>[
        RangeAreaSeries<TemperatureDataRange, String>(
          name: 'Temperature Range',
          dataSource: _chartData,
          xValueMapper: (TemperatureDataRange data, _) => data.month,
          lowValueMapper: (TemperatureDataRange data, _) => data.minTemp,
          highValueMapper: (TemperatureDataRange data, _) => data.maxTemp,
          color: kInfoColor.withValues(alpha: 0.5),
          borderColor: kInfoColor,
          borderWidth: 2,
        ),
      ],
    );
  }

  /// Generates temperature range data.
  List<TemperatureDataRange> _getTemperatureDataRange() {
    return [
      TemperatureDataRange('Jan', -5, 10),
      TemperatureDataRange('Feb', 1, 12),
      TemperatureDataRange('Mar', 4, 18),
      TemperatureDataRange('Apr', 8, 22),
      TemperatureDataRange('May', 15, 28),
      TemperatureDataRange('Jun', 8, 26),
      TemperatureDataRange('Jul', 25, 38),
      TemperatureDataRange('Aug', 23, 36),
      TemperatureDataRange('Sep', 18, 30),
      TemperatureDataRange('Oct', 12, 24),
      TemperatureDataRange('Nov', 5, 18),
      TemperatureDataRange('Dec', 0, 12),
    ];
  }

  @override
  void dispose() {
    _chartData.clear();
    super.dispose();
  }
}

/// Data Model for Temperature Range
class TemperatureDataRange {
  final String month;
  final double minTemp;
  final double maxTemp;

  TemperatureDataRange(this.month, this.minTemp, this.maxTemp);
}

// spline range area chart

class SplineRangeAreaChartExample extends StatefulWidget {
  const SplineRangeAreaChartExample({super.key});

  @override
  State<SplineRangeAreaChartExample> createState() =>
      _SplineRangeAreaChartExampleState();
}

class _SplineRangeAreaChartExampleState
    extends State<SplineRangeAreaChartExample> {
  late List<ProductPriceData> _productAData;
  late List<ProductPriceData> _productBData;

  @override
  void initState() {
    super.initState();
    _productAData = _getProductAData();
    _productBData = _getProductBData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Price Range of Products',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Price', textStyle: chartAxisLabelStyle),
        numberFormat: NumberFormat.currency(locale: 'en_US', symbol: '\$'),
        minimum: 10,
        maximum: 80,
        interval: 10,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <CartesianSeries>[
        SplineRangeAreaSeries<ProductPriceData, String>(
          name: 'Product A',
          dataSource: _productAData,
          xValueMapper: (ProductPriceData data, _) => data.month,
          lowValueMapper: (ProductPriceData data, _) => data.minPrice,
          highValueMapper: (ProductPriceData data, _) => data.maxPrice,
          color: kErrorColor.withValues(alpha: 0.5),
          borderColor: kErrorColor,
          borderWidth: 2,
        ),
        SplineRangeAreaSeries<ProductPriceData, String>(
          name: 'Product B',
          dataSource: _productBData,
          xValueMapper: (ProductPriceData data, _) => data.month,
          lowValueMapper: (ProductPriceData data, _) => data.minPrice,
          highValueMapper: (ProductPriceData data, _) => data.maxPrice,
          color: kSuccessColor.withValues(alpha: 0.5),
          borderColor: kSuccessColor,
          borderWidth: 2,
        ),
      ],
    );
  }

  /// Generates product A price data
  List<ProductPriceData> _getProductAData() {
    return [
      ProductPriceData('Jan', 30, 45),
      ProductPriceData('Feb', 22, 37),
      ProductPriceData('Mar', 24, 39),
      ProductPriceData('Apr', 20, 35),
      ProductPriceData('May', 28, 43),
      ProductPriceData('Jun', 30, 45),
      ProductPriceData('Jul', 32, 47),
      ProductPriceData('Aug', 21, 36),
      ProductPriceData('Sep', 29, 44),
      ProductPriceData('Oct', 27, 42),
      ProductPriceData('Nov', 25, 40),
      ProductPriceData('Dec', 28, 42),
    ];
  }

  /// Generates product B price data (ensuring no intersection with A)
  List<ProductPriceData> _getProductBData() {
    return [
      ProductPriceData('Jan', 50, 65),
      ProductPriceData('Feb', 42, 57),
      ProductPriceData('Mar', 44, 59),
      ProductPriceData('Apr', 56, 71),
      ProductPriceData('May', 48, 63),
      ProductPriceData('Jun', 50, 65),
      ProductPriceData('Jul', 52, 67),
      ProductPriceData('Aug', 41, 56),
      ProductPriceData('Sep', 49, 64),
      ProductPriceData('Oct', 47, 62),
      ProductPriceData('Nov', 48, 63),
      ProductPriceData('Dec', 43, 58),
    ];
  }

  @override
  void dispose() {
    _productAData.clear();
    _productBData.clear();
    super.dispose();
  }
}

/// Data model for Product Price
class ProductPriceData {
  final String month;
  final double minPrice;
  final double maxPrice;

  ProductPriceData(this.month, this.minPrice, this.maxPrice);
}

// area zone chart

class TemperatureData {
  final String month;
  final double temperature;

  TemperatureData(this.month, this.temperature);
}

class AreaZoneChart extends StatelessWidget {
  const AreaZoneChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<TemperatureData> chartData = [
      TemperatureData('Jan', 5.0), // January: Cold winter temperatures
      TemperatureData('Feb', 6.0), // February: Slightly warmer than January
      TemperatureData('Mar', 10.0), // March: Spring starts
      TemperatureData('Apr', 15.0), // April: Pleasant spring weather
      TemperatureData('May', 20.0), // May: Warmer spring into early summer
      TemperatureData('Jun', 25.0), // June: Early summer, rainy season begins
      TemperatureData('Jul', 30.0), // July: Peak summer heat
      TemperatureData('Aug', 30.5), // August: Hottest month
      TemperatureData('Sep', 26.0), // September: Late summer, cooling down
      TemperatureData('Oct', 20.0), // October: Mild autumn
      TemperatureData('Nov', 14.0), // November: Cool autumn weather
      TemperatureData('Dec', 8.0), // December: Early winter, mild cold
    ];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'Average monthly temperature of Tokyo - 2024',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        // ignore: use_raw_strings
        labelFormat: '{value}°C',
        minimum: 0,
        maximum: 35,
        interval: 5,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: <CartesianSeries<TemperatureData, String>>[
        SplineAreaSeries<TemperatureData, String>(
          dataSource: chartData,
          xValueMapper: (TemperatureData sales, int index) => sales.month,
          yValueMapper: (TemperatureData sales, int index) => sales.temperature,
          name: 'Tokyo',
          onCreateShader: (ShaderDetails details) {
            return ui.Gradient.linear(
              details.rect.bottomLeft,
              details.rect.bottomRight,
              <Color>[
                kInfoColor,
                kSuccessColor,
                kSuccessColor,
                kWarningColor,
                kWarningColor,
                kErrorColor,
                kErrorColor,
                kInfoColor,
              ],
              <double>[0.165, 0.165, 0.416, 0.416, 0.666, 0.666, 0.918, 0.918],
            );
          },
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),

      /// To set the annotation content for Chart.
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
          widget: SizedBox(
            height: 80,
            width: 80,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.circle, color: kInfoColor, size: 13),
                    Text(' Winter', style: TextStyle(fontSize: kBodySmall)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.circle, color: kSuccessColor, size: 13),
                    Text(' Spring', style: TextStyle(fontSize: kBodySmall)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.circle, color: kWarningColor, size: 13),
                    Text(' Summer', style: TextStyle(fontSize: kBodySmall)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.circle, color: kErrorColor, size: 13),
                    Text(' Autumn', style: TextStyle(fontSize: kBodySmall)),
                  ],
                ),
              ],
            ),
          ),
          coordinateUnit: CoordinateUnit.percentage,
          x: '85%',
          y: '14%',
        ),
      ],
    );
  }
}

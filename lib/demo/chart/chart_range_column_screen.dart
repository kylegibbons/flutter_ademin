import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartRangeColumnScreen extends StatefulWidget {
  const ChartRangeColumnScreen({super.key});

  @override
  State<ChartRangeColumnScreen> createState() => _ChartRangeColumnScreenState();
}

class _ChartRangeColumnScreenState extends State<ChartRangeColumnScreen> {
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
                      lang.stepLineChart.toUpperCase(),
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
                          label: lang.stepLineChart,
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
                        // Basic Range Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Basic Range Column Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: TemperatureRangeChart(),
                            ),
                            codeView:
                                '''TemperatureRangeChart() source code can be found in the lib/demo/chart/chart_range_column_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Transpose Range Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Transpose Range Column Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: TransposedTemperatureChart(),
                            ),
                            codeView:
                                '''TransposedTemperatureChart() source code can be found in the lib/demo/chart/chart_range_column_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Range Column Chart with Track
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Range Column Chart with Track',
                            uiView: SizedBox(
                              height: 440,
                              child: RangeColumnChartWithTrack(),
                            ),
                            codeView:
                                '''RangeColumnChartWithTrack() source code can be found in the lib/demo/chart/chart_range_column_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Dynamic Range Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dynamic Range Column Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: DynamicRangeColumnChart(),
                            ),
                            codeView:
                                '''DynamicRangeColumnChart() source code can be found in the lib/demo/chart/chart_range_column_screen.dart file.''',
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

// RANGE COLUMN CHART //

// basic range column chart

class TemperatureRangeChart extends StatefulWidget {
  const TemperatureRangeChart({super.key});

  @override
  State<TemperatureRangeChart> createState() => _TemperatureRangeChartState();
}

class _TemperatureRangeChartState extends State<TemperatureRangeChart> {
  late List<RangeTemperatureData> _rangetemperatureData;

  @override
  void initState() {
    super.initState();
    _rangetemperatureData = _getRangeTemperatureData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Temperature Range in New York (°C)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Days', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 40,
        interval: 5,
      ),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      series: <RangeColumnSeries>[
        RangeColumnSeries<RangeTemperatureData, String>(
          name: 'Temperature Range',
          dataSource: _rangetemperatureData,
          xValueMapper: (RangeTemperatureData data, _) => data.day,
          lowValueMapper: (RangeTemperatureData data, _) => data.minTemp,
          highValueMapper: (RangeTemperatureData data, _) => data.maxTemp,
          color: kSecondaryColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  /// Sample Data
  List<RangeTemperatureData> _getRangeTemperatureData() {
    return [
      RangeTemperatureData('Mon', 12, 30),
      RangeTemperatureData('Tue', 15, 32),
      RangeTemperatureData('Wed', 14, 28),
      RangeTemperatureData('Thu', 10, 27),
      RangeTemperatureData('Fri', 18, 33),
      RangeTemperatureData('Sat', 16, 31),
      RangeTemperatureData('Sun', 13, 29),
    ];
  }

  @override
  void dispose() {
    _rangetemperatureData.clear();
    super.dispose();
  }
}

/// Data Model
class RangeTemperatureData {
  final String day;
  final double minTemp;
  final double maxTemp;

  RangeTemperatureData(this.day, this.minTemp, this.maxTemp);
}

// transpose range column chart

class TransposedTemperatureChart extends StatefulWidget {
  const TransposedTemperatureChart({super.key});

  @override
  State<TransposedTemperatureChart> createState() =>
      _TransposedTemperatureChartState();
}

class _TransposedTemperatureChartState
    extends State<TransposedTemperatureChart> {
  late List<TemperatureDataTranspose> _newYorkData;
  late List<TemperatureDataTranspose> _losAngelesData;

  @override
  void initState() {
    super.initState();
    _newYorkData = _getNewYorkData();
    _losAngelesData = _getLosAngelesData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Daily Temperature Range: NY vs. LA',
        textStyle: chartTitleStyle,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 5,
        maximum: 45,
        interval: 5,
        labelFormat: '{value}°C',
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
          text: 'Days of the Week',
          textStyle: chartAxisLabelStyle,
        ),
        isInversed: true, // Ensures the latest day appears at the top
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      isTransposed: true,
      series: <RangeColumnSeries>[
        RangeColumnSeries<TemperatureDataTranspose, String>(
          name: 'New York',
          dataSource: _newYorkData,
          lowValueMapper: (TemperatureDataTranspose data, _) => data.minTemp,
          highValueMapper: (TemperatureDataTranspose data, _) => data.maxTemp,
          xValueMapper: (TemperatureDataTranspose data, _) => data.day,
          color: kSuccessColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
        RangeColumnSeries<TemperatureDataTranspose, String>(
          name: 'Los Angeles',
          dataSource: _losAngelesData,
          lowValueMapper: (TemperatureDataTranspose data, _) => data.minTemp,
          highValueMapper: (TemperatureDataTranspose data, _) => data.maxTemp,
          xValueMapper: (TemperatureDataTranspose data, _) => data.day,
          color: kErrorColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  /// Sample Data for New York
  List<TemperatureDataTranspose> _getNewYorkData() {
    return [
      TemperatureDataTranspose('Mon', 12, 30),
      TemperatureDataTranspose('Tue', 15, 32),
      TemperatureDataTranspose('Wed', 14, 28),
      TemperatureDataTranspose('Thu', 10, 27),
      TemperatureDataTranspose('Fri', 18, 33),
      TemperatureDataTranspose('Sat', 16, 31),
      TemperatureDataTranspose('Sun', 13, 29),
    ];
  }

  /// Sample Data for Los Angeles
  List<TemperatureDataTranspose> _getLosAngelesData() {
    return [
      TemperatureDataTranspose('Mon', 18, 35),
      TemperatureDataTranspose('Tue', 20, 36),
      TemperatureDataTranspose('Wed', 19, 34),
      TemperatureDataTranspose('Thu', 17, 32),
      TemperatureDataTranspose('Fri', 21, 37),
      TemperatureDataTranspose('Sat', 22, 38),
      TemperatureDataTranspose('Sun', 20, 36),
    ];
  }

  @override
  void dispose() {
    _newYorkData.clear();
    _losAngelesData.clear();
    super.dispose();
  }
}

/// Data Model
class TemperatureDataTranspose {
  final String day;
  final double minTemp;
  final double maxTemp;

  TemperatureDataTranspose(this.day, this.minTemp, this.maxTemp);
}

// range column chart with track

class RangeColumnChartWithTrack extends StatefulWidget {
  const RangeColumnChartWithTrack({super.key});

  @override
  State<RangeColumnChartWithTrack> createState() =>
      _RangeColumnChartWithTrackState();
}

class _RangeColumnChartWithTrackState extends State<RangeColumnChartWithTrack> {
  late List<TemperatureDataRangeTrack> _temperatureDataRangeTrack;

  @override
  void initState() {
    super.initState();
    _temperatureDataRangeTrack = _getTemperatureDataRangeTrack();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Daily Temperature vs. Comfort Range',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Days', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 40,
        interval: 5,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <RangeColumnSeries>[
        // Temperature Data
        RangeColumnSeries<TemperatureDataRangeTrack, String>(
          name: 'Temperature',
          dataSource: _temperatureDataRangeTrack,
          xValueMapper: (TemperatureDataRangeTrack data, _) => data.day,
          lowValueMapper: (TemperatureDataRangeTrack data, _) => data.minTemp,
          highValueMapper: (TemperatureDataRangeTrack data, _) => data.maxTemp,
          color: kInfoColor,
          isTrackVisible: true, // Enables the track
          trackColor: kSuccessColor.withValues(
            alpha: 0.2,
          ), // Background track color
          // trackBorderColor: kSuccessColor, // Track border color
          // trackBorderWidth: 1.0,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }

  /// Sample Temperature Data
  List<TemperatureDataRangeTrack> _getTemperatureDataRangeTrack() {
    return [
      TemperatureDataRangeTrack('Mon', 12, 30),
      TemperatureDataRangeTrack('Tue', 15, 32),
      TemperatureDataRangeTrack('Wed', 14, 28),
      TemperatureDataRangeTrack('Thu', 10, 27),
      TemperatureDataRangeTrack('Fri', 18, 33),
      TemperatureDataRangeTrack('Sat', 16, 31),
      TemperatureDataRangeTrack('Sun', 13, 29),
    ];
  }

  @override
  void dispose() {
    _temperatureDataRangeTrack.clear();
    super.dispose();
  }
}

/// Data Model
class TemperatureDataRangeTrack {
  final String day;
  final double minTemp;
  final double maxTemp;

  TemperatureDataRangeTrack(this.day, this.minTemp, this.maxTemp);
}

// dynamic range column chart

class DynamicRangeColumnChart extends StatefulWidget {
  const DynamicRangeColumnChart({super.key});

  @override
  State<DynamicRangeColumnChart> createState() =>
      _DynamicRangeColumnChartState();
}

class _DynamicRangeColumnChartState extends State<DynamicRangeColumnChart> {
  Timer? _timer;
  List<_ChartDataDynamicRangeColumn>? _chartDataDynamicRangeColumn;

  @override
  Widget build(BuildContext context) {
    _buildChartData();
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _buildChartData();
      });
    });
    return _buildCartesianChart();
  }

  /// Return the Cartesian Chart with Range Column series.
  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Temperature Real-time Monitoring',
        textStyle: chartTitleStyle,
      ),
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Chamber', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        majorTickLines: MajorTickLines(color: Colors.transparent),
        axisLine: AxisLine(width: 0),
        minimum: 0,
        maximum: 100,
      ),
      series: _buildRangeColumnSeries(),
    );
  }

  /// Returns the list of Cartesian Range Column series.
  List<RangeColumnSeries<_ChartDataDynamicRangeColumn, num>>
  _buildRangeColumnSeries() {
    return <RangeColumnSeries<_ChartDataDynamicRangeColumn, num>>[
      RangeColumnSeries<_ChartDataDynamicRangeColumn, num>(
        dataSource: _chartDataDynamicRangeColumn,
        xValueMapper: (_ChartDataDynamicRangeColumn sales, int index) =>
            sales.x,
        lowValueMapper: (_ChartDataDynamicRangeColumn sales, int index) =>
            sales.y,
        highValueMapper: (_ChartDataDynamicRangeColumn sales, int index) =>
            sales.z,
        color: kErrorColor,
      ),
    ];
  }

  int _buildRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void _buildChartData() {
    _chartDataDynamicRangeColumn = <_ChartDataDynamicRangeColumn>[];
    for (int i = 1; i <= 7; i++) {
      _chartDataDynamicRangeColumn!.add(
        _ChartDataDynamicRangeColumn(
          i,
          _buildRandomInt(5, 45),
          _buildRandomInt(46, 95),
        ),
      );
    }
    _timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _chartDataDynamicRangeColumn!.clear();
  }
}

class _ChartDataDynamicRangeColumn {
  _ChartDataDynamicRangeColumn(this.x, this.y, this.z);
  final int x;
  final int y;
  final int z;
}

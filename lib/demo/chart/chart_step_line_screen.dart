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

class ChartStepLineScreen extends StatefulWidget {
  const ChartStepLineScreen({super.key});

  @override
  State<ChartStepLineScreen> createState() => _ChartStepLineScreenState();
}

class _ChartStepLineScreenState extends State<ChartStepLineScreen> {
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
                        // Single Step Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Single Step Line Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: InternetSpeedStepLineChart(),
                            ),
                            codeView:
                                '''InternetSpeedStepLineChart() source code can be found in the lib/demo/chart/chart_step_line_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Multiple Step Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multiple Step Line Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ElectricityTariffStepLineChart(),
                            ),
                            codeView:
                                '''ElectricityTariffStepLineChart() source code can be found in the lib/demo/chart/chart_step_line_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Dash Step Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dash Step Line Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ISPInternetSpeedChart(),
                            ),
                            codeView:
                                '''ISPInternetSpeedChart() source code can be found in the lib/demo/chart/chart_step_line_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Vertical Step Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Vertical Step Line Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: UnemploymentChart(),
                            ),
                            codeView:
                                '''UnemploymentChart() source code can be found in the lib/demo/chart/chart_step_line_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Animation Step Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Animation Step Line Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: AnimationStepLineChart(),
                            ),
                            codeView:
                                '''AnimationStepLineChart() source code can be found in the lib/demo/chart/chart_step_line_screen.dart file.''',
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

// STEP LINE CHART //

// basic step line chart

class InternetSpeedStepLineChart extends StatefulWidget {
  const InternetSpeedStepLineChart({super.key});

  @override
  State<InternetSpeedStepLineChart> createState() =>
      _InternetSpeedStepLineChartState();
}

class _InternetSpeedStepLineChartState
    extends State<InternetSpeedStepLineChart> {
  late List<InternetSpeedData> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getInternetSpeedData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Internet Speed Monitoring',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Time (Hours)', textStyle: chartAxisLabelStyle),
        interval: 1,
        minimum: 0,
        maximum: 10,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Speed (Mbps)', textStyle: chartAxisLabelStyle),
        minimum: 0,
        maximum: 100,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x hours : point.y Mbps',
      ),
      series: <CartesianSeries<InternetSpeedData, num>>[
        StepLineSeries<InternetSpeedData, num>(
          dataSource: _chartData,
          xValueMapper: (InternetSpeedData data, _) => data.time,
          yValueMapper: (InternetSpeedData data, _) => data.speed,
          name: 'Internet Speed',
          color: kInfoColor,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          markerSettings: MarkerSettings(isVisible: false),
        ),
      ],
    );
  }

  /// Sample Data: Internet Speed Changes Over 10 Hours
  List<InternetSpeedData> _getInternetSpeedData() {
    return [
      InternetSpeedData(0, 20),
      InternetSpeedData(1, 40),
      InternetSpeedData(2, 40),
      InternetSpeedData(3, 50),
      InternetSpeedData(4, 50),
      InternetSpeedData(5, 70),
      InternetSpeedData(6, 70),
      InternetSpeedData(7, 90),
      InternetSpeedData(8, 90),
      InternetSpeedData(9, 60),
      InternetSpeedData(10, 60),
    ];
  }

  @override
  void dispose() {
    _chartData.clear(); // Properly dispose of data
    super.dispose();
  }
}

/// Model Class: Internet Speed Data
class InternetSpeedData {
  InternetSpeedData(this.time, this.speed);
  final double time;
  final double speed;
}

// multiple step line chart

class ElectricityTariffStepLineChart extends StatefulWidget {
  const ElectricityTariffStepLineChart({super.key});

  @override
  State<ElectricityTariffStepLineChart> createState() =>
      _ElectricityTariffStepLineChartState();
}

class _ElectricityTariffStepLineChartState
    extends State<ElectricityTariffStepLineChart> {
  late List<TariffData> _cityATariff;
  late List<TariffData> _cityBTariff;

  @override
  void initState() {
    super.initState();
    _cityATariff = _getCityATariffData();
    _cityBTariff = _getCityBTariffData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Electricity Tariff Comparison (City A vs. City B)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Time (Months)', textStyle: chartAxisLabelStyle),
        interval: 1,
        minimum: 0,
        maximum: 12,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Tariff Rate (Cents per kWh)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 5,
        maximum: 35,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.y cents/kWh',
      ),
      series: <CartesianSeries<TariffData, num>>[
        StepLineSeries<TariffData, num>(
          dataSource: _cityATariff,
          xValueMapper: (TariffData data, _) => data.month,
          yValueMapper: (TariffData data, _) => data.rate,
          name: 'City A',
          color: kSecondaryColor,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          markerSettings: MarkerSettings(isVisible: false, width: 6, height: 6),
        ),
        StepLineSeries<TariffData, num>(
          dataSource: _cityBTariff,
          xValueMapper: (TariffData data, _) => data.month,
          yValueMapper: (TariffData data, _) => data.rate,
          name: 'City B',
          color: kErrorColor,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          markerSettings: MarkerSettings(isVisible: false, width: 6, height: 6),
        ),
      ],
    );
  }

  /// Sample Data: Tariff changes over 12 months for two cities.
  List<TariffData> _getCityATariffData() {
    return [
      TariffData(0, 15),
      TariffData(1, 18),
      TariffData(3, 18),
      TariffData(4, 22),
      TariffData(6, 22),
      TariffData(7, 25),
      TariffData(9, 25),
      TariffData(10, 30),
      TariffData(12, 30),
    ];
  }

  List<TariffData> _getCityBTariffData() {
    return [
      TariffData(0, 12),
      TariffData(2, 12),
      TariffData(3, 16),
      TariffData(5, 16),
      TariffData(6, 20),
      TariffData(8, 20),
      TariffData(9, 24),
      TariffData(11, 24),
      TariffData(12, 28),
    ];
  }

  @override
  void dispose() {
    _cityATariff.clear();
    _cityBTariff.clear();
    super.dispose();
  }
}

/// Model Class: Electricity Tariff Data
class TariffData {
  TariffData(this.month, this.rate);
  final int month;
  final double rate;
}

// dash step line chart

class ISPInternetSpeedChart extends StatefulWidget {
  const ISPInternetSpeedChart({super.key});

  @override
  State<ISPInternetSpeedChart> createState() => _ISPInternetSpeedChartState();
}

class _ISPInternetSpeedChartState extends State<ISPInternetSpeedChart> {
  late List<SpeedData> _isp1Data;
  late List<SpeedData> _isp2Data;
  late List<SpeedData> _isp3Data;
  late List<SpeedData> _isp4Data;

  @override
  void initState() {
    super.initState();
    _isp1Data = _getISP1SpeedData();
    _isp2Data = _getISP2SpeedData();
    _isp3Data = _getISP3SpeedData();
    _isp4Data = _getISP4SpeedData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'ISP Speed Comparison Over 12 Months',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        interval: 1,
        minimum: 1,
        maximum: 12,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Speed (Mbps)', textStyle: chartAxisLabelStyle),
        minimum: 10,
        maximum: 100,
      ),
      series: <CartesianSeries<SpeedData, num>>[
        _buildStepLineSeries(_isp1Data, 'ISP A', kInfoColor, [5, 5]),
        _buildStepLineSeries(_isp2Data, 'ISP B', kErrorColor, [10, 5]),
        _buildStepLineSeries(_isp3Data, 'ISP C', kSuccessColor, [2, 2]),
        _buildStepLineSeries(_isp4Data, 'ISP D', kPrimaryColor, [6, 3]),
      ],
    );
  }

  /// Function to create a Step Line Series with dashed lines
  StepLineSeries<SpeedData, num> _buildStepLineSeries(
    List<SpeedData> data,
    String name,
    Color color,
    List<double> dashPattern,
  ) {
    return StepLineSeries<SpeedData, num>(
      dataSource: data,
      xValueMapper: (SpeedData data, _) => data.month,
      yValueMapper: (SpeedData data, _) => data.speed,
      name: name,
      color: color,
      dashArray: dashPattern, // Creates dashed lines
      dataLabelSettings: DataLabelSettings(isVisible: true),
      markerSettings: MarkerSettings(isVisible: false),
    );
  }

  /// Sample Data: Internet Speeds for different ISPs over 12 months
  List<SpeedData> _getISP1SpeedData() {
    return [
      SpeedData(1, 50),
      SpeedData(3, 55),
      SpeedData(5, 52),
      SpeedData(6, 60),
      SpeedData(8, 62),
      SpeedData(10, 70),
      SpeedData(12, 75),
    ];
  }

  List<SpeedData> _getISP2SpeedData() {
    return [
      SpeedData(1, 40),
      SpeedData(2, 42),
      SpeedData(4, 45),
      SpeedData(6, 50),
      SpeedData(7, 48),
      SpeedData(9, 55),
      SpeedData(11, 60),
      SpeedData(12, 55),
    ];
  }

  List<SpeedData> _getISP3SpeedData() {
    return [
      SpeedData(1, 30),
      SpeedData(3, 35),
      SpeedData(5, 40),
      SpeedData(7, 42),
      SpeedData(8, 45),
      SpeedData(10, 50),
      SpeedData(12, 55),
    ];
  }

  List<SpeedData> _getISP4SpeedData() {
    return [
      SpeedData(1, 20),
      SpeedData(2, 22),
      SpeedData(4, 25),
      SpeedData(6, 30),
      SpeedData(8, 35),
      SpeedData(10, 40),
      SpeedData(12, 45),
    ];
  }

  @override
  void dispose() {
    _isp1Data.clear();
    _isp2Data.clear();
    _isp3Data.clear();
    _isp4Data.clear();
    super.dispose();
  }
}

/// Model Class: Internet Speed Data
class SpeedData {
  SpeedData(this.month, this.speed);
  final int month;
  final double speed;
}

// vertical step line chart

class UnemploymentChart extends StatefulWidget {
  const UnemploymentChart({super.key});

  @override
  State<UnemploymentChart> createState() => _UnemploymentChartState();
}

class _UnemploymentChartState extends State<UnemploymentChart> {
  late List<UnemploymentData> _indonesiaData;
  late List<UnemploymentData> _malaysiaData;

  @override
  void initState() {
    super.initState();
    _indonesiaData = _getIndonesiaData();
    _malaysiaData = _getMalaysiaData();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Unemployment Rate (2010 - 2024)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'Unemployment Rate (%)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 2.0,
        maximum: 8.0,
        interval: 1,
        labelFormat: '{value}%',
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Year', textStyle: chartAxisLabelStyle),
        isInversed: false, // Ensure correct timeline order
        minimum: 2010,
        maximum: 2024,
        interval: 2,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <StepLineSeries<UnemploymentData, double>>[
        StepLineSeries<UnemploymentData, double>(
          name: 'Indonesia',
          dataSource: _indonesiaData,
          xValueMapper: (UnemploymentData data, _) => data.rate,
          yValueMapper: (UnemploymentData data, _) => data.year,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          markerSettings: MarkerSettings(isVisible: true, width: 6, height: 6),
          color: kInfoColor,
        ),
        StepLineSeries<UnemploymentData, double>(
          name: 'Malaysia',
          dataSource: _malaysiaData,
          xValueMapper: (UnemploymentData data, _) => data.rate,
          yValueMapper: (UnemploymentData data, _) => data.year,
          dataLabelSettings: DataLabelSettings(isVisible: false),
          markerSettings: MarkerSettings(isVisible: true, width: 6, height: 6),
          color: kSuccessColor,
        ),
      ],
    );
  }

  /// Sample Data: Indonesia
  List<UnemploymentData> _getIndonesiaData() {
    return [
      UnemploymentData(2010, 6.8),
      UnemploymentData(2012, 6.5),
      UnemploymentData(2014, 5.9),
      UnemploymentData(2016, 5.5),
      UnemploymentData(2018, 5.2),
      UnemploymentData(2020, 7.1),
      UnemploymentData(2022, 5.9),
      UnemploymentData(2024, 5.3),
    ];
  }

  /// Sample Data: Malaysia
  List<UnemploymentData> _getMalaysiaData() {
    return [
      UnemploymentData(2010, 3.7),
      UnemploymentData(2012, 3.3),
      UnemploymentData(2014, 3.1),
      UnemploymentData(2016, 3.5),
      UnemploymentData(2018, 3.3),
      UnemploymentData(2020, 4.8),
      UnemploymentData(2022, 4.5),
      UnemploymentData(2024, 4.0),
    ];
  }

  @override
  void dispose() {
    _indonesiaData.clear();
    _malaysiaData.clear();
    super.dispose();
  }
}

/// Data Model
class UnemploymentData {
  final int year;
  final double rate;

  UnemploymentData(this.year, this.rate);
}

// animation step line chart

class AnimationStepLineChart extends StatefulWidget {
  const AnimationStepLineChart({super.key});

  @override
  State<AnimationStepLineChart> createState() => _AnimationStepLineChartState();
}

class _AnimationStepLineChartState extends State<AnimationStepLineChart> {
  Timer? _timer;
  List<_AnimationStepLineChartData>? _animationStepLinechartData;

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

  /// Return the Cartesian Chart with Step Line series.
  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
        text: 'Animated Step Line Chart',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(
          text: 'Time (Seconds)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Value', textStyle: chartAxisLabelStyle),
        majorTickLines: MajorTickLines(color: Colors.transparent),
        axisLine: AxisLine(width: 0),
        minimum: 0,
        maximum: 100,
      ),
      series: _buildStepLineSeries(),
    );
  }

  /// Returns the list of Cartesian Step Line series.
  List<StepLineSeries<_AnimationStepLineChartData, num>>
  _buildStepLineSeries() {
    return <StepLineSeries<_AnimationStepLineChartData, num>>[
      StepLineSeries<_AnimationStepLineChartData, num>(
        dataSource: _animationStepLinechartData,
        xValueMapper: (_AnimationStepLineChartData sales, int index) => sales.x,
        yValueMapper: (_AnimationStepLineChartData sales, int index) => sales.y,
      ),
    ];
  }

  int _buildRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void _buildChartData() {
    _animationStepLinechartData = <_AnimationStepLineChartData>[];
    for (int i = 0; i <= 10; i++) {
      _animationStepLinechartData!.add(
        _AnimationStepLineChartData(i, _buildRandomInt(5, 95)),
      );
    }
    _animationStepLinechartData![10] = _AnimationStepLineChartData(
      10,
      _animationStepLinechartData![9].y,
    );
    _timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _animationStepLinechartData!.clear();
  }
}

class _AnimationStepLineChartData {
  _AnimationStepLineChartData(this.x, this.y);
  final int x;
  final int y;
}

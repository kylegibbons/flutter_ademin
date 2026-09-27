import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/chart/chart.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSplineScreen extends StatefulWidget {
  const ChartSplineScreen({super.key});

  @override
  State<ChartSplineScreen> createState() => _ChartSplineScreenState();
}

class _ChartSplineScreenState extends State<ChartSplineScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).splineChart; //update your page tittle here
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
                      lang.splineChart.toUpperCase(),
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
                          label: lang.splineChart,
                          uri: RouteUri.chartSpline,
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
                        // Default Spline Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Default Spline Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: DefaultSplineChart(),
                            ),
                            codeView:
                                '''DefaultSplineChart() source code can be found in the lib/demo/chart/chart_spline_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Diverging Column chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Diverging Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: DashedSplineChart(),
                            ),
                            codeView:
                                '''DashedSplineChart() source code can be found in the lib/demo/chart/chart_spline_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Spline Types Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Spline Types Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: SplineTypesChart(),
                            ),
                            codeView:
                                '''SplineTypesChart() source code can be found in the lib/demo/chart/chart_spline_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Vertical Spline Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Vertical Spline Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: VerticalSplineChart(),
                            ),
                            codeView:
                                '''VerticalSplineChart() source code can be found in the lib/demo/chart/chart_spline_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Animation Spline Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Animation Spline Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: AnimationSplineChart(),
                            ),
                            codeView:
                                '''AnimationSplineChart() source code can be found in the lib/demo/chart/chart_spline_screen.dart file.''',
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

// Default Spline Chart

class DefaultSplineChart extends StatefulWidget {
  const DefaultSplineChart({super.key});

  @override
  State<DefaultSplineChart> createState() => _DefaultSplineChartState();
}

class _DefaultSplineChartState extends State<DefaultSplineChart> {
  // Define the data for the spline chart
  final List<_ChartData> chartData = [
    _ChartData(2017, 3),
    _ChartData(2018, 4),
    _ChartData(2019, 6),
    _ChartData(2020, 7),
    _ChartData(2021, 8),
    _ChartData(2022, 11),
    _ChartData(2023, 10),
    _ChartData(2024, 6),
  ];
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Yearly Sales Growth',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Year', textStyle: chartAxisLabelStyle),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Sales (in millions)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      series: <CartesianSeries<_ChartData, double>>[
        SplineSeries<_ChartData, double>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.year,
          yValueMapper: (_ChartData data, _) => data.sales,
          name: 'Sales',
          enableTooltip: true,
          isVisibleInLegend: false,
        ),
      ],
    );
  }
}

// Model class for the chart data
class _ChartData {
  _ChartData(this.year, this.sales);
  final double year;
  final double sales;
}

// Dashed Spline Chart

class DashedSplineChart extends StatefulWidget {
  const DashedSplineChart({super.key});

  @override
  State<DashedSplineChart> createState() => _DashedSplineChartState();
}

class _DashedSplineChartState extends State<DashedSplineChart> {
  // Data for the two spline series
  final List<_ChartData> series1Data = [
    _ChartData(2017, 3),
    _ChartData(2018, 4),
    _ChartData(2019, 6),
    _ChartData(2020, 7),
    _ChartData(2021, 8),
    _ChartData(2022, 11),
    _ChartData(2023, 14),
    _ChartData(2024, 8),
  ];

  final List<_ChartData> series2Data = [
    _ChartData(2017, 2),
    _ChartData(2018, 3),
    _ChartData(2019, 5),
    _ChartData(2020, 14),
    _ChartData(2021, 7),
    _ChartData(2022, 9),
    _ChartData(2023, 3),
    _ChartData(2024, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Yearly Sales Growth Comparison',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Year', textStyle: chartAxisLabelStyle),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Sales (in millions)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      series: <CartesianSeries<_ChartData, double>>[
        // First spline series with dashed lines
        SplineSeries<_ChartData, double>(
          dataSource: series1Data,
          xValueMapper: (_ChartData data, _) => data.year,
          yValueMapper: (_ChartData data, _) => data.sales,
          name: 'Product A',
          dashArray: [10, 5], // Dashed line pattern (10 pixels on, 5 off)
          color: kSecondaryColor,
          markerSettings: MarkerSettings(isVisible: true, height: 6, width: 6),
          enableTooltip: true,
        ),

        // Second spline series with a different dashed line pattern
        SplineSeries<_ChartData, double>(
          dataSource: series2Data,
          xValueMapper: (_ChartData data, _) => data.year,
          yValueMapper: (_ChartData data, _) => data.sales,
          name: 'Product B',
          dashArray: [5, 3], // Dashed line pattern (5 pixels on, 3 off)
          color: kSuccessColor,
          markerSettings: MarkerSettings(isVisible: true, height: 6, width: 6),
          enableTooltip: true,
        ),
      ],
    );
  }
}

// Spline Types Chart

class SplineTypesChart extends StatefulWidget {
  const SplineTypesChart({super.key});

  @override
  State<SplineTypesChart> createState() => _SplineTypesChartState();
}

class _SplineTypesChartState extends State<SplineTypesChart> {
  // Data for the spline chart
  final List<_ChartData> chartData = [
    _ChartData(2011, 0.05),
    _ChartData(2011.25, 0),
    _ChartData(2011.50, 0.03),
    _ChartData(2011.75, 0),
    _ChartData(2012, 0.04),
    _ChartData(2012.25, 0.02),
    _ChartData(2012.50, -0.01),
    _ChartData(2012.75, 0.01),
    _ChartData(2013, -0.08),
    _ChartData(2013.25, -0.02),
    _ChartData(2013.50, 0.03),
    _ChartData(2013.75, 0.05),
    _ChartData(2014, 0.04),
    _ChartData(2014.25, 0.02),
    _ChartData(2014.50, 0.04),
    _ChartData(2014.75, 0),
    _ChartData(2015, 0.02),
    _ChartData(2015.25, 0.10),
    _ChartData(2015.50, 0.09),
    _ChartData(2015.75, 0.11),
    _ChartData(2016, 0.12),
  ];

  // Current spline type
  SplineType _selectedSplineType = SplineType.natural;

  // Dropdown options for spline types
  final List<DropdownMenuItem<SplineType>> _dropdownItems = [
    DropdownMenuItem(value: SplineType.natural, child: Text('Natural')),
    DropdownMenuItem(value: SplineType.monotonic, child: Text('Monotonic')),
    DropdownMenuItem(value: SplineType.cardinal, child: Text('Cardinal')),
    DropdownMenuItem(value: SplineType.clamped, child: Text('Clamped')),
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        // Spline chart
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(
              text: 'Yearly Sales Growth',
              textStyle: chartTitleStyle,
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: NumericAxis(
              title: AxisTitle(text: 'Year', textStyle: chartTitleStyle),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'Sales (in millions)',
                textStyle: chartTitleStyle,
              ),
              maximum: 0.2,
            ),
            series: <CartesianSeries<_ChartData, double>>[
              SplineSeries<_ChartData, double>(
                dataSource: chartData,
                xValueMapper: (_ChartData data, _) => data.year,
                yValueMapper: (_ChartData data, _) => data.sales,
                splineType: _selectedSplineType,
                markerSettings: MarkerSettings(isVisible: true),
                enableTooltip: true,
                color: kErrorColor,
              ),
            ],
          ),
        ),

        // Dropdown menu to select the spline type
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Spline Type:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            SizedBox(width: kDefaultPadding),
            // CustomDropdownButton<SplineType>(
            //   label: 'Spline Type',
            //   isOutlined: true,
            //   color: kPrimaryColor,
            //   items: _dropdownItems,
            //   value: _selectedSplineType,
            //   onChanged: (SplineType? newType) {
            //     setState(() {
            //       _selectedSplineType = newType!;
            //     });
            //   },
            // ),
            SizedBox(
              width: 140,
              child: CustomDropdownFormField<SplineType>(
                items: _dropdownItems,
                initialValue: _selectedSplineType,
                onChanged: (SplineType? newType) {
                  setState(() {
                    _selectedSplineType = newType!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// vertical spline chart

class VerticalSplineChart extends StatefulWidget {
  const VerticalSplineChart({super.key});

  @override
  State<VerticalSplineChart> createState() => _VerticalSplineChartState();
}

class _VerticalSplineChartState extends State<VerticalSplineChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Weekly Temperature Trends',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      isTransposed: true, // set vertical
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 15,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(
          text: 'Days of the Week',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      series: <SplineSeries<WeatherData, String>>[
        // Spline series for New York
        SplineSeries<WeatherData, String>(
          dataSource: _getNewYorkWeatherData(),
          xValueMapper: (WeatherData data, _) => data.day,
          yValueMapper: (WeatherData data, _) => data.temperature,
          name: 'New York',
          markerSettings: MarkerSettings(isVisible: true, width: 6, height: 6),
          color: kInfoColor,
          width: 2,
        ),
        // Spline series for London
        SplineSeries<WeatherData, String>(
          dataSource: _getLondonWeatherData(),
          xValueMapper: (WeatherData data, _) => data.day,
          yValueMapper: (WeatherData data, _) => data.temperature,
          name: 'London',
          markerSettings: MarkerSettings(isVisible: true, width: 6, height: 6),
          color: kSuccessColor,
          width: 2,
        ),
      ],
    );
  }

  /// Returns weather data for New York.
  List<WeatherData> _getNewYorkWeatherData() {
    return [
      WeatherData('Mon', 22),
      WeatherData('Tue', 24),
      WeatherData('Wed', 19),
      WeatherData('Thu', 26),
      WeatherData('Fri', 23),
      WeatherData('Sat', 25),
      WeatherData('Sun', 20),
    ];
  }

  /// Returns weather data for London.
  List<WeatherData> _getLondonWeatherData() {
    return [
      WeatherData('Mon', 18),
      WeatherData('Tue', 20),
      WeatherData('Wed', 17),
      WeatherData('Thu', 21),
      WeatherData('Fri', 28),
      WeatherData('Sat', 22),
      WeatherData('Sun', 18),
    ];
  }
}

/// Data model for weather analysis
class WeatherData {
  WeatherData(this.day, this.temperature);
  final String day;
  final double temperature;
}

// Animation Spline Chart

class AnimationSplineChart extends StatefulWidget {
  const AnimationSplineChart({super.key});

  @override
  State<AnimationSplineChart> createState() => _AnimationSplineChartState();
}

class _AnimationSplineChartState extends State<AnimationSplineChart> {
  late List<_AnimationChartData> _chartData; // Chart data list
  Timer? _timer; // Timer to refresh data

  @override
  void initState() {
    super.initState();
    _chartData = _generateRandomData(); // Initial data generation
    _startDataRefreshTimer(); // Start timer to refresh data
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorTickLines: MajorTickLines(color: Colors.transparent),
        axisLine: AxisLine(width: 0),
        minimum: 0,
        maximum: 100,
      ),
      series: <SplineSeries<_AnimationChartData, int>>[
        SplineSeries<_AnimationChartData, int>(
          dataSource: _chartData,
          color: kInfoColor,
          xValueMapper: (_AnimationChartData data, _) => data.x,
          yValueMapper: (_AnimationChartData data, _) => data.y,
          markerSettings: MarkerSettings(isVisible: true),
        ),
      ],
    );
  }

  /// Generates random chart data.
  List<_AnimationChartData> _generateRandomData() {
    final Random random = Random();
    return List.generate(
      11,
      (index) => _AnimationChartData(index, random.nextInt(70) + 15),
    );
  }

  /// Starts a timer to refresh chart data every 2 seconds.
  void _startDataRefreshTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _chartData = _generateRandomData(); // Refresh data
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer
    super.dispose();
  }
}

/// Model class for chart data.
class _AnimationChartData {
  _AnimationChartData(this.x, this.y);
  final int x; // X-axis value
  final int y; // Y-axis value
}

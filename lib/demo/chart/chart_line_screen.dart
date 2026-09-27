import 'dart:async';
import 'dart:math';

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
import 'dart:ui' as ui;
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartLineScreen extends StatefulWidget {
  const ChartLineScreen({super.key});

  @override
  State<ChartLineScreen> createState() => _ChartLineScreenState();
}

class _ChartLineScreenState extends State<ChartLineScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).line; //update your page tittle here
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
            padding: const EdgeInsets.symmetric(
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
                  offset: const Offset(0, 1),
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
                      lang.line.toUpperCase(),
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
                          label: lang.line,
                          uri: RouteUri.chartLine,
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
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // line chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Line Chart',
                            uiView: LineChart(),
                            codeView:
                                '''LineChart() source code can be found in the lib/demo/chart/chart_line_screen.dart file.''',
                            height: 240,
                          ),
                        ),

                        // dash line chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dash Line Chart',
                            uiView: DashLineChart(),
                            codeView:
                                '''DashLineChart() source code can be found in the lib/demo/chart/chart_line_screen.dart file.''',
                            height: 240,
                          ),
                        ),

                        // Multi-colored Line Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multi-colored Line Chart',
                            uiView: MultiColorLineChart(),
                            codeView:
                                '''MultiColorLineChart() source code can be found in the lib/demo/chart/chart_line_screen.dart file.''',
                            height: 240,
                          ),
                        ),

                        // Line Zone Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Line Zone Chart',
                            uiView: LineZoneChart(),
                            codeView:
                                '''LineZoneChart() source code can be found in the lib/demo/chart/chart_line_screen.dart file.''',
                            height: 240,
                          ),
                        ),

                        // Line Zone Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dynamic Line Chart',
                            uiView: DynamicLineChart(),
                            codeView:
                                '''DynamicLineChart() source code can be found in the lib/demo/chart/chart_line_screen.dart file.''',
                            height: 240,
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

// dynamic line chart

class DynamicLineChart extends StatefulWidget {
  const DynamicLineChart({super.key});

  @override
  State<DynamicLineChart> createState() => _DynamicLineChartState();
}

class _DynamicLineChartState extends State<DynamicLineChart> {
  Timer? _timer;
  List<_ChartData>? _chartData;
  @override
  Widget build(BuildContext context) {
    _createChartData();
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _createChartData();
      });
    });
    return _buildCartesianChart();
  }

  /// Return the Cartesian Chart with Line series.
  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Frequency (Hz)',
        textStyle: chartTitleStyle,
        alignment: ChartAlignment.center,
      ),
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        majorTickLines: MajorTickLines(color: Colors.transparent),
        axisLine: AxisLine(width: 0),
        minimum: 0,
        maximum: 100,
      ),
      series: _buildLineSeries(),
    );
  }

  /// Returns the list of Cartesian Line series.
  List<LineSeries<_ChartData, num>> _buildLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
        dataSource: _chartData,
        xValueMapper: (_ChartData sales, int index) => sales.x,
        yValueMapper: (_ChartData sales, int index) => sales.y,
        markerSettings: MarkerSettings(isVisible: true),
        width: 4,
        color: kSuccessColor,
      ),
    ];
  }

  int _createRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void _createChartData() {
    _chartData = <_ChartData>[];
    for (int i = 0; i < 11; i++) {
      _chartData!.add(_ChartData(i, _createRandomInt(5, 95)));
    }
    _timer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _chartData!.clear();
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}

// Line Zone Chart
class LineZoneChart extends StatelessWidget {
  const LineZoneChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(
        text: 'Sales Data',
        textStyle: TextStyle(
          fontSize: kBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        alignment: ChartAlignment.center,
      ),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          name: 'Sales',
          dataSource: _salesData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),

          isVisibleInLegend: false,
          width: 4,

          // set lize zone
          onCreateShader: (ShaderDetails details) {
            return ui.Gradient.linear(
              details.rect.topCenter,
              details.rect.bottomCenter,
              <Color>[kSuccessColor, kWarningColor, kErrorColor],
              <double>[0.25, 0.50, 0.75],
            );
          },
        ),
      ],
    );
  }
}

// Multi-colored Line Chart

class MultiColorLineChart extends StatelessWidget {
  const MultiColorLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(
        text: 'Sales Data',
        textStyle: TextStyle(
          fontSize: kBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        alignment: ChartAlignment.center,
      ),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          name: 'Sales',
          dataSource: _salesData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          isVisibleInLegend: false,
          width: 4,
          pointColorMapper: (SalesData sales, _) =>
              sales.color, // Map color to each point
        ),
      ],
    );
  }
}

// Dash Line Chart
class DashLineChart extends StatelessWidget {
  const DashLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(
        text: 'Sales Data',
        textStyle: TextStyle(
          fontSize: kBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        alignment: ChartAlignment.center,
      ),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          name: 'Sales',
          dataSource: _salesData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          markerSettings: const MarkerSettings(isVisible: true),
          isVisibleInLegend: false,
          width: 4,
          color: kErrorColor,
          dashArray: const [4, 8], // set dash
        ),
      ],
    );
  }
}

// LINE CHART

class LineChart extends StatelessWidget {
  const LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(
        text: 'Sales Data',
        textStyle: TextStyle(
          fontSize: kBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        alignment: ChartAlignment.center,
      ),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          name: 'Sales',
          dataSource: _salesData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          markerSettings: const MarkerSettings(isVisible: true),
          isVisibleInLegend: false,
          width: 4,
          color: kPrimaryColor,
        ),
      ],
    );
  }
}

// sales data model
class SalesData {
  SalesData(this.year, this.sales, this.color);
  final String year;
  final double sales;
  final Color color;
}

// data mock up
final List<SalesData> _salesData = [
  SalesData('2017', 30, kPrimaryColor),
  SalesData('2018', 35, kPrimaryColor),
  SalesData('2019', 12, kSecondaryColor),
  SalesData('2020', 34, kInfoColor),
  SalesData('2021', 32, kSuccessColor),
  SalesData('2022', 40, kWarningColor),
  SalesData('2023', 44, kErrorColor),
  SalesData('2024', 40, kErrorColor),
];

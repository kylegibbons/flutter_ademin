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

class ChartErrorScreen extends StatefulWidget {
  const ChartErrorScreen({super.key});

  @override
  State<ChartErrorScreen> createState() => _ChartErrorScreenState();
}

class _ChartErrorScreenState extends State<ChartErrorScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).errorChart; //update your page tittle here
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
                      lang.errorChart.toUpperCase(),
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
                          label: lang.errorChart,
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
                        // Error Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Vertical Error Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: SalesErrorBarChart(),
                            ),
                            codeView:
                                '''SalesErrorBarChart() source code can be found in the lib/demo/chart/chart_error_bar_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Error Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Horizontal Error Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ClinicalTrialChart(),
                            ),
                            codeView:
                                '''ClinicalTrialChart() source code can be found in the lib/demo/chart/chart_error_bar_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Error Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Horizontal Vertical Error Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ExperimentErrorChart(),
                            ),
                            codeView:
                                '''ExperimentErrorChart() source code can be found in the lib/demo/chart/chart_error_bar_screen.dart file.''',
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

// ERROR BAR CHART //

// error bar chart: vertical mode

class SalesErrorBarChart extends StatefulWidget {
  const SalesErrorBarChart({super.key});

  @override
  State<SalesErrorBarChart> createState() => _SalesErrorBarChartState();
}

class _SalesErrorBarChartState extends State<SalesErrorBarChart> {
  late List<SalesDataError> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getSalesDataError();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SfCartesianChart(
      title: ChartTitle(text: 'Annual Sales Data', textStyle: chartTitleStyle),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Country', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Sales Count', textStyle: chartAxisLabelStyle),
        minimum: 30,
      ),
      series: <CartesianSeries<SalesDataError, dynamic>>[
        // Scatter Series to represent sales data
        ScatterSeries<SalesDataError, dynamic>(
          dataSource: _chartData,
          xValueMapper: (SalesDataError sales, int index) => sales.country,
          yValueMapper: (SalesDataError sales, int index) => sales.salesCount,
          name: 'Sales',
          animationDuration: 1000,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            width: 6,
            height: 6,
            color: kInfoColor,
            borderColor: Colors.transparent,
          ),
          color: kInfoColor,
        ),
        // Error Bar Series to show variation in sales data
        ErrorBarSeries<SalesDataError, dynamic>(
          dataSource: _chartData,
          xValueMapper: (SalesDataError sales, int index) => sales.country,
          yValueMapper: (SalesDataError sales, int index) => sales.salesCount,
          animationDuration: 1000,
          animationDelay: 1000,
          color: themeData.colorScheme.onSurface,
          type: ErrorBarType.fixed, // define type
          verticalErrorValue: 10,
          mode: RenderingMode.vertical, // define mode
          direction: Direction.both, // define direction
          width: 1.0,
        ),
      ],
    );
  }

  /// Generate sample sales data
  List<SalesDataError> _getSalesDataError() {
    return [
      SalesDataError('USA', 150),
      SalesDataError('UK', 120),
      SalesDataError('Germany', 180),
      SalesDataError('Japan', 140),
      SalesDataError('India', 170),
    ];
  }

  @override
  void dispose() {
    _chartData.clear(); // Dispose of data to prevent memory leaks
    super.dispose();
  }
}

/// Model class for sales data
class SalesDataError {
  SalesDataError(this.country, this.salesCount);
  final String country;
  final double salesCount;
}

// error bar chart: type fixed, vertical mode,

class ClinicalTrialChart extends StatefulWidget {
  const ClinicalTrialChart({super.key});

  @override
  State<ClinicalTrialChart> createState() => _ClinicalTrialChartState();
}

class _ClinicalTrialChartState extends State<ClinicalTrialChart> {
  late List<ClinicalTrialData> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getClinicalTrialData();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Age Groups vs. Recovery Rate',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x years: point.y%',
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Age Group', textStyle: chartAxisLabelStyle),
        minimum: 12,
        maximum: 80,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Recovery Rate (%)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 65,
        maximum: 100,
      ),
      series: <CartesianSeries<ClinicalTrialData, num>>[
        // Scatter plot for patient recovery rate
        ScatterSeries<ClinicalTrialData, num>(
          dataSource: _chartData,
          xValueMapper: (ClinicalTrialData data, _) => data.age,
          yValueMapper: (ClinicalTrialData data, _) => data.recoveryRate,
          name: 'Patients',
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.diamond,
            width: 8,
            height: 8,
            color: kErrorColor,
            borderColor: Colors.transparent,
          ),
          color: kErrorColor,
        ),

        // Error bars for age uncertainty
        ErrorBarSeries<ClinicalTrialData, num>(
          dataSource: _chartData,
          xValueMapper: (ClinicalTrialData data, _) => data.age,
          yValueMapper: (ClinicalTrialData data, _) => data.recoveryRate,
          type: ErrorBarType.fixed,
          mode: RenderingMode.horizontal, // Show error along X-axis (Age)
          direction: Direction.both,
          horizontalErrorValue: 2.5, // +/- 2.5 years of uncertainty
          color: themeData.colorScheme.onSurface,
          width: 1,
        ),
      ],
    );
  }

  /// Generate sample clinical trial data
  List<ClinicalTrialData> _getClinicalTrialData() {
    return [
      ClinicalTrialData(20, 85),
      ClinicalTrialData(25, 90),
      ClinicalTrialData(30, 88),
      ClinicalTrialData(35, 87),
      ClinicalTrialData(40, 83),
      ClinicalTrialData(50, 80),
      ClinicalTrialData(60, 78),
      ClinicalTrialData(70, 75),
    ];
  }

  @override
  void dispose() {
    _chartData.clear(); // Dispose data properly
    super.dispose();
  }
}

/// Model class for clinical trial data
class ClinicalTrialData {
  ClinicalTrialData(this.age, this.recoveryRate);
  final double age;
  final double recoveryRate;
}

// error bar chart: type fixed, rendering mode both, direction both

class ExperimentErrorChart extends StatefulWidget {
  const ExperimentErrorChart({super.key});

  @override
  State<ExperimentErrorChart> createState() => _ExperimentErrorChartState();
}

class _ExperimentErrorChartState extends State<ExperimentErrorChart> {
  late List<ExperimentData> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _getExperimentData();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Reaction Time vs. Temperature Change',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x min, point.y°C',
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'Reaction Time (minutes)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 50,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Temperature Change (°C)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 20,
        maximum: 100,
      ),
      series: <CartesianSeries<ExperimentData, num>>[
        // Scatter plot for reaction time vs. temperature change
        ScatterSeries<ExperimentData, num>(
          dataSource: _chartData,
          xValueMapper: (ExperimentData data, _) => data.time,
          yValueMapper: (ExperimentData data, _) => data.temperature,
          name: 'Experiment Data',
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            width: 6,
            height: 6,
            color: kInfoColor,
            borderColor: Colors.transparent,
          ),
          color: kInfoColor,
        ),
        // Error bars in both directions
        ErrorBarSeries<ExperimentData, num>(
          dataSource: _chartData,
          xValueMapper: (ExperimentData data, _) => data.time,
          yValueMapper: (ExperimentData data, _) => data.temperature,
          type: ErrorBarType.fixed,
          mode: RenderingMode.both, // Both horizontal & vertical error bars
          direction: Direction.both, // Bi-directional error bars
          horizontalErrorValue: 2, // ± 2 min uncertainty in time
          verticalErrorValue: 6, // ± 6°C uncertainty in temperature
          color: themeData.colorScheme.onSurface,
          width: 1,
        ),
      ],
    );
  }

  /// Generate sample experiment data
  List<ExperimentData> _getExperimentData() {
    return [
      ExperimentData(5, 30),
      ExperimentData(10, 45),
      ExperimentData(15, 50),
      ExperimentData(20, 65),
      ExperimentData(30, 80),
      ExperimentData(40, 90),
    ];
  }

  @override
  void dispose() {
    _chartData.clear(); // Dispose of data properly
    super.dispose();
  }
}

/// Model class for experiment data
class ExperimentData {
  ExperimentData(this.time, this.temperature);
  final double time;
  final double temperature;
}

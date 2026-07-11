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

class ChartScatterScreen extends StatefulWidget {
  const ChartScatterScreen({super.key});

  @override
  State<ChartScatterScreen> createState() => _ChartScatterScreenState();
}

class _ChartScatterScreenState extends State<ChartScatterScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).scatterChart; //update your page tittle here
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
                      lang.scatterChart.toUpperCase(),
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
                          label: lang.scatterChart,
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
                        // Basic Scatter Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Basic Scatter Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: BasicScatterChart(),
                            ),
                            codeView:
                                '''BasicScatterChart() source code can be found in the lib/demo/chart/chart_scatter_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // multi series scatter chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multi Shape Scatter Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: MultiScatterChart(),
                            ),
                            codeView:
                                '''MultiScatterChart() source code can be found in the lib/demo/chart/chart_scatter_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // multi series scatter chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multi Shape Scatter Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: PatientVitalsChart(),
                            ),
                            codeView:
                                '''PatientVitalsChart() source code can be found in the lib/demo/chart/chart_scatter_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // multi series scatter chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multi Series Scatter Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ExportGrowthRateChart(),
                            ),
                            codeView:
                                '''ExportGrowthRateChart() source code can be found in the lib/demo/chart/chart_scatter_screen.dart file.''',
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

// SCATTER CHART //

// basic scatter chart

class BasicScatterChart extends StatefulWidget {
  const BasicScatterChart({super.key});

  @override
  State<BasicScatterChart> createState() => _BasicScatterChartState();
}

class _BasicScatterChartState extends State<BasicScatterChart> {
  late List<_StudentPerformanceData> _chartData;

  @override
  void initState() {
    super.initState();
    _chartData = _generateData();
  }

  /// Generates sample data for the scatter chart
  List<_StudentPerformanceData> _generateData() {
    return <_StudentPerformanceData>[
      _StudentPerformanceData('Alice', 78, 6),
      _StudentPerformanceData('Bob', 20, 3),
      _StudentPerformanceData('Cathy', 88, 8),
      _StudentPerformanceData('David', 92, 9),
      _StudentPerformanceData('Eva', 55, 4),
      _StudentPerformanceData('Frank', 68, 5),
      _StudentPerformanceData('Grace', 74, 7),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Student Performance Analysis',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Study Hours: point.x\nMarkScored: point.y',
        canShowMarker: false,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Study Hours', textStyle: chartAxisLabelStyle),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        minimum: 2,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Marks Scored', textStyle: chartAxisLabelStyle),
        minimum: 0,
        maximum: 100,
      ),
      series: <ScatterSeries<_StudentPerformanceData, num>>[
        ScatterSeries<_StudentPerformanceData, num>(
          name: 'Study Hours vs Marks Scored',
          dataSource: _chartData,
          xValueMapper: (_StudentPerformanceData data, _) => data.studyHours,
          yValueMapper: (_StudentPerformanceData data, _) => data.marks,
          dataLabelMapper: (_StudentPerformanceData data, _) => data.name,
          color: kSecondaryColor,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 12,
            width: 12,
            color: kSecondaryColor,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _chartData.clear(); // Dispose of the data list
    super.dispose(); // Call parent dispose method
  }
}

/// Custom data class for student performance
class _StudentPerformanceData {
  _StudentPerformanceData(this.name, this.marks, this.studyHours);

  final String name; // Student name
  final int marks; // Marks scored by the student
  final int studyHours; // Hours studied
}

// multi series scatter chart

class MultiScatterChart extends StatefulWidget {
  const MultiScatterChart({super.key});

  @override
  State<MultiScatterChart> createState() => _MultiScatterChartState();
}

class _MultiScatterChartState extends State<MultiScatterChart> {
  late List<_CustomerData> _regularCustomers;
  late List<_CustomerData> _loyalCustomers;
  late List<_CustomerData> _highValueCustomers;

  @override
  void initState() {
    super.initState();
    // Initialize data for each customer segment
    _regularCustomers = _generateRegularCustomers();
    _loyalCustomers = _generateLoyalCustomers();
    _highValueCustomers = _generateHighValueCustomers();
  }

  /// Regular customers dataset
  List<_CustomerData> _generateRegularCustomers() {
    return [
      _CustomerData(2, 50), // 2 hours engagement, $50 spent
      _CustomerData(3, 70),
      _CustomerData(1.5, 30),
      _CustomerData(2.8, 60),
    ];
  }

  /// Loyal customers dataset
  List<_CustomerData> _generateLoyalCustomers() {
    return [
      _CustomerData(4, 120),
      _CustomerData(5, 150),
      _CustomerData(3.5, 100),
      _CustomerData(4.5, 130),
    ];
  }

  /// High-value customers dataset
  List<_CustomerData> _generateHighValueCustomers() {
    return [
      _CustomerData(6, 250),
      _CustomerData(7, 300),
      _CustomerData(5.5, 220),
      _CustomerData(6.5, 280),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Customer Engagement vs Spending Analysis',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Engagement: point.x hours \nSpending: \$point.y',
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'Engagement (Hours/Week)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 8,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Spending (\$)', textStyle: chartAxisLabelStyle),
        minimum: 0,
        maximum: 350,
      ),
      series: <ScatterSeries<_CustomerData, num>>[
        // Regular customers
        ScatterSeries<_CustomerData, num>(
          name: 'Regular Customers',
          dataSource: _regularCustomers,
          xValueMapper: (_CustomerData data, _) => data.engagement,
          yValueMapper: (_CustomerData data, _) => data.spending,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle, // Circle marker
            height: 10,
            width: 10,
            borderColor: kInfoColor,
            borderWidth: 2,
          ),
          color: kInfoColor.withValues(alpha: 0.6),
        ),
        // Loyal customers
        ScatterSeries<_CustomerData, num>(
          name: 'Loyal Customers',
          dataSource: _loyalCustomers,
          xValueMapper: (_CustomerData data, _) => data.engagement,
          yValueMapper: (_CustomerData data, _) => data.spending,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.diamond, // Diamond marker
            height: 12,
            width: 12,
            borderColor: kSuccessColor,
            borderWidth: 2,
          ),
          color: kSuccessColor.withValues(alpha: 0.6),
        ),
        // High-value customers
        ScatterSeries<_CustomerData, num>(
          name: 'High-Value Customers',
          dataSource: _highValueCustomers,
          xValueMapper: (_CustomerData data, _) => data.engagement,
          yValueMapper: (_CustomerData data, _) => data.spending,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle, // Triangle marker
            height: 10,
            width: 10,
            borderColor: kErrorColor,
            borderWidth: 2,
          ),
          color: kErrorColor.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of the data lists to release memory
    _regularCustomers.clear();
    _loyalCustomers.clear();
    _highValueCustomers.clear();
    super.dispose();
  }
}

/// Data model for customer engagement and spending
class _CustomerData {
  _CustomerData(this.engagement, this.spending);
  final double engagement; // Engagement in hours per week
  final double spending; // Spending in dollars
}

// multi series scatter chart (patient vital chart)

class PatientVitalsChart extends StatefulWidget {
  const PatientVitalsChart({super.key});

  @override
  State<PatientVitalsChart> createState() => _PatientVitalsChartState();
}

class _PatientVitalsChartState extends State<PatientVitalsChart> {
  late List<_PatientVitalData> _normalPatients;
  late List<_PatientVitalData> _elevatedPatients;
  late List<_PatientVitalData> _criticalPatients;

  @override
  void initState() {
    super.initState();
    // Initialize patient data for each category
    _normalPatients = _generateNormalPatients();
    _elevatedPatients = _generateElevatedPatients();
    _criticalPatients = _generateCriticalPatients();
  }

  /// Normal patients dataset
  List<_PatientVitalData> _generateNormalPatients() {
    return [
      _PatientVitalData(70, 120),
      _PatientVitalData(72, 118),
      _PatientVitalData(68, 115),
      _PatientVitalData(75, 122),
      _PatientVitalData(71, 119),
      _PatientVitalData(69, 117),
      _PatientVitalData(73, 121),
      _PatientVitalData(74, 123),
      _PatientVitalData(70, 116),
      _PatientVitalData(72, 120),
    ];
  }

  /// Elevated patients dataset
  List<_PatientVitalData> _generateElevatedPatients() {
    return [
      _PatientVitalData(80, 130),
      _PatientVitalData(85, 135),
      _PatientVitalData(78, 128),
      _PatientVitalData(83, 132),
      _PatientVitalData(82, 131),
      _PatientVitalData(81, 129),
      _PatientVitalData(84, 134),
      _PatientVitalData(79, 127),
      _PatientVitalData(86, 136),
      _PatientVitalData(80, 130),
    ];
  }

  /// Critical patients dataset
  List<_PatientVitalData> _generateCriticalPatients() {
    return [
      _PatientVitalData(95, 150),
      _PatientVitalData(100, 160),
      _PatientVitalData(92, 155),
      _PatientVitalData(98, 165),
      _PatientVitalData(97, 152),
      _PatientVitalData(94, 158),
      _PatientVitalData(96, 153),
      _PatientVitalData(99, 164),
      _PatientVitalData(93, 157),
      _PatientVitalData(95, 160),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Patient Vitals Monitoring',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Heart Rate: point.x bpm\nBlood Pressure: point.y mmHg',
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'Heart Rate (bpm)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 65,
        maximum: 102,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Blood Pressure (mmHg)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 110,
        maximum: 170,
      ),
      series: <ScatterSeries<_PatientVitalData, num>>[
        // Normal patients
        ScatterSeries<_PatientVitalData, num>(
          name: 'Normal',
          dataSource: _normalPatients,
          xValueMapper: (_PatientVitalData data, _) => data.heartRate,
          yValueMapper: (_PatientVitalData data, _) => data.bloodPressure,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle, // Circle marker
            height: 10,
            width: 10,
            color: kSuccessColor,
          ),
          color: kSuccessColor,
        ),
        // Elevated patients
        ScatterSeries<_PatientVitalData, num>(
          name: 'Elevated',
          dataSource: _elevatedPatients,
          xValueMapper: (_PatientVitalData data, _) => data.heartRate,
          yValueMapper: (_PatientVitalData data, _) => data.bloodPressure,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.diamond, // Diamond marker
            height: 12,
            width: 12,
            color: kWarningColor,
          ),
          color: kWarningColor,
        ),
        // Critical patients
        ScatterSeries<_PatientVitalData, num>(
          name: 'Critical',
          dataSource: _criticalPatients,
          xValueMapper: (_PatientVitalData data, _) => data.heartRate,
          yValueMapper: (_PatientVitalData data, _) => data.bloodPressure,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.triangle, // Triangle marker
            height: 10,
            width: 10,
            color: kErrorColor,
          ),
          color: kErrorColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of patient data
    _normalPatients.clear();
    _elevatedPatients.clear();
    _criticalPatients.clear();
    super.dispose();
  }
}

/// Data model for patient vitals
class _PatientVitalData {
  _PatientVitalData(this.heartRate, this.bloodPressure);
  final double heartRate; // Heart rate in bpm
  final double bloodPressure; // Blood pressure in mmHg
}

// multi series scatter chart (export growth chart)

class ExportGrowthRateChart extends StatefulWidget {
  const ExportGrowthRateChart({super.key});

  @override
  State<ExportGrowthRateChart> createState() => _ExportGrowthRateChartState();
}

class _ExportGrowthRateChartState extends State<ExportGrowthRateChart> {
  late List<_ProductGrowthData> _productAData;
  late List<_ProductGrowthData> _productBData;
  late List<_ProductGrowthData> _productCData;

  @override
  void initState() {
    super.initState();
    // Initialize product growth data
    _productAData = _generateProductAData();
    _productBData = _generateProductBData();
    _productCData = _generateProductCData();
  }

  /// Product A growth data
  List<_ProductGrowthData> _generateProductAData() {
    return [
      _ProductGrowthData(2018, 15),
      _ProductGrowthData(2019, 12),
      _ProductGrowthData(2020, 15),
      _ProductGrowthData(2021, 20),
      _ProductGrowthData(2022, 25),
      _ProductGrowthData(2023, 28),
      _ProductGrowthData(2024, 27),
    ];
  }

  /// Product B growth data
  List<_ProductGrowthData> _generateProductBData() {
    return [
      _ProductGrowthData(2018, 8),
      _ProductGrowthData(2019, 25),
      _ProductGrowthData(2020, 18),
      _ProductGrowthData(2021, 24),
      _ProductGrowthData(2022, 30),
      _ProductGrowthData(2023, 15),
      _ProductGrowthData(2024, 18),
    ];
  }

  /// Product C growth data
  List<_ProductGrowthData> _generateProductCData() {
    return [
      _ProductGrowthData(2018, 17),
      _ProductGrowthData(2019, 7),
      _ProductGrowthData(2020, 11),
      _ProductGrowthData(2021, 16),
      _ProductGrowthData(2022, 20),
      _ProductGrowthData(2023, 21),
      _ProductGrowthData(2024, 5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Export Growth Rate by Year',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.y% EGR in point.x',
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Year', textStyle: chartAxisLabelStyle),
        minimum: 2018,
        maximum: 2024,
        interval: 1,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Growth Percentage (%)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 35,
        interval: 5,
      ),
      series: <ScatterSeries<_ProductGrowthData, num>>[
        // Product A
        ScatterSeries<_ProductGrowthData, num>(
          name: 'Product A',
          dataSource: _productAData,
          xValueMapper: (_ProductGrowthData data, _) => data.year,
          yValueMapper: (_ProductGrowthData data, _) => data.percentage,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle, // Circle marker
            height: 10,
            width: 10,
            color: kSecondaryColor,
          ),
          color: kSecondaryColor,
        ),
        // Product B
        ScatterSeries<_ProductGrowthData, num>(
          name: 'Product B',
          dataSource: _productBData,
          xValueMapper: (_ProductGrowthData data, _) => data.year,
          yValueMapper: (_ProductGrowthData data, _) => data.percentage,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle, // Circle marker
            height: 10,
            width: 10,
            color: kSuccessColor,
          ),
          color: kSuccessColor,
        ),
        // Product C
        ScatterSeries<_ProductGrowthData, num>(
          name: 'Product C',
          dataSource: _productCData,
          xValueMapper: (_ProductGrowthData data, _) => data.year,
          yValueMapper: (_ProductGrowthData data, _) => data.percentage,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle, // Circle marker
            height: 10,
            width: 10,
            color: kErrorColor,
          ),
          color: kErrorColor,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose product data
    _productAData.clear();
    _productBData.clear();
    _productCData.clear();
    super.dispose();
  }
}

/// Data model for product growth data
class _ProductGrowthData {
  _ProductGrowthData(this.year, this.percentage);
  final int year; // Year
  final double percentage; // Growth percentage
}

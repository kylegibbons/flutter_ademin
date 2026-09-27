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
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBarScreen extends StatefulWidget {
  const ChartBarScreen({super.key});

  @override
  State<ChartBarScreen> createState() => _ChartBarScreenState();
}

class _ChartBarScreenState extends State<ChartBarScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).barChart; //update your page tittle here
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
    MediaQuery.of(context);

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
                      lang.barChart.toUpperCase(),
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
                          label: lang.barChart,
                          uri: RouteUri.chartBar,
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
                        // Basic Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Basic Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: BasicBarChart(),
                            ),
                            codeView:
                                '''BasicBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Spacing Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Spacing Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: SpacingBarChart(),
                            ),
                            codeView:
                                '''SpacingBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Diverging Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Diverging Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: DivergingBarChart(),
                            ),
                            codeView:
                                '''DivergingBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Track Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Track Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: TrackBarChart(),
                            ),
                            codeView:
                                '''TrackBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // StackedBar100Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Stacked Bar 100 Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: StackedBar100Chart(),
                            ),
                            codeView:
                                '''StackedBar100Chart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Marker Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Marker Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: MarkerBarChart(),
                            ),
                            codeView:
                                '''MarkerBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Dynamic Bar Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dynamic Bar Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: DynamicBarChart(),
                            ),
                            codeView:
                                '''DynamicBarChart() source code can be found in the lib/demo/chart/chart_bar_screen.dart file.''',
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

// BAR CHART //

// basic bar chart

class BasicBarChart extends StatelessWidget {
  final List<SalesData> salesData = [
    SalesData(
      month: 'Jan',
      productASales: 50,
      productBSales: 70,
      productCSales: 40,
    ),
    SalesData(
      month: 'Feb',
      productASales: 60,
      productBSales: 80,
      productCSales: 50,
    ),
    SalesData(
      month: 'Mar',
      productASales: 70,
      productBSales: 60,
      productCSales: 80,
    ),
    SalesData(
      month: 'Apr',
      productASales: 90,
      productBSales: 100,
      productCSales: 70,
    ),
    SalesData(
      month: 'May',
      productASales: 100,
      productBSales: 120,
      productCSales: 90,
    ),
  ];
  BasicBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Sales Data (Products A, B, C)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Months', textStyle: chartAxisLabelStyle),
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Sales (in units)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <BarSeries>[
        BarSeries<SalesData, String>(
          name: 'Product A',
          dataSource: salesData,
          xValueMapper: (SalesData data, _) => data.month,
          yValueMapper: (SalesData data, _) => data.productASales,
          color: kSecondaryColor,
        ),
        BarSeries<SalesData, String>(
          name: 'Product B',
          dataSource: salesData,
          xValueMapper: (SalesData data, _) => data.month,
          yValueMapper: (SalesData data, _) => data.productBSales,
          color: kSuccessColor,
        ),
        BarSeries<SalesData, String>(
          name: 'Product C',
          dataSource: salesData,
          xValueMapper: (SalesData data, _) => data.month,
          yValueMapper: (SalesData data, _) => data.productCSales,
          color: kWarningColor,
        ),
      ],
    );
  }
}

class SalesData {
  final String month;
  final int productASales;
  final int productBSales;
  final int productCSales;

  SalesData({
    required this.month,
    required this.productASales,
    required this.productBSales,
    required this.productCSales,
  });
}

// spacing bar chart

class SpacingBarChart extends StatelessWidget {
  final List<SalesDataSpacing> salesDataSpacing = [
    SalesDataSpacing(month: 'Jan', productASales: 50, productBSales: 70),
    SalesDataSpacing(month: 'Feb', productASales: 60, productBSales: 80),
    SalesDataSpacing(month: 'Mar', productASales: 70, productBSales: 60),
    SalesDataSpacing(month: 'Apr', productASales: 90, productBSales: 100),
    SalesDataSpacing(month: 'May', productASales: 100, productBSales: 120),
  ];
  SpacingBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Sales Data (Products A, B)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Months', textStyle: chartAxisLabelStyle),
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Sales (in units)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <BarSeries>[
        BarSeries<SalesDataSpacing, String>(
          name: 'Product A',
          dataSource: salesDataSpacing,
          xValueMapper: (SalesDataSpacing data, _) => data.month,
          yValueMapper: (SalesDataSpacing data, _) => data.productASales,
          color: kSecondaryColor,
          spacing: 0.2, // spacing
        ),
        BarSeries<SalesDataSpacing, String>(
          name: 'Product B',
          dataSource: salesDataSpacing,
          xValueMapper: (SalesDataSpacing data, _) => data.month,
          yValueMapper: (SalesDataSpacing data, _) => data.productBSales,
          color: kSuccessColor,
          spacing: 0.2, // spacing
        ),
      ],
    );
  }
}

class SalesDataSpacing {
  final String month;
  final int productASales;
  final int productBSales;

  SalesDataSpacing({
    required this.month,
    required this.productASales,
    required this.productBSales,
  });
}

// Diverging Bar Chart

class DivergingBarChart extends StatelessWidget {
  final List<ProfitLossData> data = [
    ProfitLossData(month: 'Jan', amount: 5000),
    ProfitLossData(month: 'Feb', amount: -3000),
    ProfitLossData(month: 'Mar', amount: 2000),
    ProfitLossData(month: 'Apr', amount: -1000),
    ProfitLossData(month: 'May', amount: 7000),
    ProfitLossData(month: 'Jun', amount: -2000),
    ProfitLossData(month: 'Jul', amount: 5000),
    ProfitLossData(month: 'Aug', amount: -1500),
  ];

  DivergingBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Profit and Loss',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Amount (\$)', textStyle: chartAxisLabelStyle),
        minimum: -4000,
        maximum: 8000,
        interval: 2000,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <BarSeries>[
        BarSeries<ProfitLossData, String>(
          dataSource: data,
          name: 'Profit/Loss',
          xValueMapper: (ProfitLossData data, _) => data.month,
          yValueMapper: (ProfitLossData data, _) => data.amount,
          pointColorMapper: (ProfitLossData data, _) =>
              data.amount >= 0 ? kPrimaryColor : kErrorColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}

class ProfitLossData {
  final String month;
  final int amount;

  ProfitLossData({required this.month, required this.amount});
}

// track bar chart

class TrackBarChart extends StatelessWidget {
  final List<WorkingHoursData> data = [
    WorkingHoursData(employeeName: 'Alice', hoursWorked: 40),
    WorkingHoursData(employeeName: 'Bob', hoursWorked: 35),
    WorkingHoursData(employeeName: 'Charlie', hoursWorked: 45),
    WorkingHoursData(employeeName: 'David', hoursWorked: 30),
    WorkingHoursData(employeeName: 'Hani', hoursWorked: 40),
    WorkingHoursData(employeeName: 'Eve', hoursWorked: 50),
    WorkingHoursData(employeeName: 'Uwais', hoursWorked: 40),
    WorkingHoursData(employeeName: 'Ana', hoursWorked: 50),
  ];
  TrackBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Weekly Working Hours of Employees',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Hours Worked', textStyle: chartAxisLabelStyle),
        minimum: 0,
        maximum: 60,
        interval: 10,
        majorGridLines: MajorGridLines(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <BarSeries>[
        BarSeries<WorkingHoursData, String>(
          dataSource: data,
          name: 'Working Hours',
          xValueMapper: (WorkingHoursData data, _) => data.employeeName,
          yValueMapper: (WorkingHoursData data, _) => data.hoursWorked,
          color: kInfoColor,
          isTrackVisible: true,
          trackColor: kTextColor.withValues(alpha: 0.2),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
      ],
    );
  }
}

class WorkingHoursData {
  final String employeeName;
  final int hoursWorked;

  WorkingHoursData({required this.employeeName, required this.hoursWorked});
}

// marker bar chart

class MarkerBarChart extends StatelessWidget {
  final List<DownloadData> downloadData = [
    DownloadData(productName: 'Spotify', downloads: 120, target: 100),
    DownloadData(productName: 'Netflix', downloads: 95, target: 110),
    DownloadData(productName: 'Canva', downloads: 80, target: 90),
    DownloadData(productName: 'Zoom', downloads: 105, target: 95),
    DownloadData(productName: 'Figma', downloads: 60, target: 70),
    DownloadData(productName: 'Discord', downloads: 90, target: 85),
    DownloadData(productName: 'Duolingo', downloads: 75, target: 75),
    DownloadData(productName: 'Adobe XD', downloads: 50, target: 60),
  ];
  MarkerBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Downloads vs. Targets for Digital Products',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0.7)),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Downloads in thousands',
          textStyle: chartAxisLabelStyle,
        ),
        majorGridLines: MajorGridLines(width: 0.7),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <CartesianSeries>[
        // Bar chart for actual downloads
        BarSeries<DownloadData, String>(
          name: 'Downloads',
          dataSource: downloadData,
          xValueMapper: (DownloadData data, _) => data.productName,
          yValueMapper: (DownloadData data, _) => data.downloads,
          color: kSuccessColor,
        ),
        // Marker for target downloads
        ScatterSeries<DownloadData, String>(
          name: 'Target',
          dataSource: downloadData,
          color: kErrorColor,
          xValueMapper: (DownloadData data, _) => data.productName,
          yValueMapper: (DownloadData data, _) => data.target,
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 10, // Marker size
            height: 10,
            shape: DataMarkerType.circle,
            borderColor: Colors.white,
            borderWidth: 0.5,
            color: kErrorColor, // Fill color for the marker
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
          ),
        ),
      ],
    );
  }
}

class DownloadData {
  final String productName;
  final int downloads;
  final int target;

  DownloadData({
    required this.productName,
    required this.downloads,
    required this.target,
  });
}

// dynamic data bar chart

class DynamicBarChart extends StatefulWidget {
  const DynamicBarChart({super.key});

  @override
  State<DynamicBarChart> createState() => _DynamicBarChartState();
}

class _DynamicBarChartState extends State<DynamicBarChart> {
  late List<_DynamicChartData> _chartData;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _buildChartData();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _buildChartData();
      });
    });
  }

  // Builds chart data dynamically with random values
  void _buildChartData() {
    _chartData = <_DynamicChartData>[];
    for (int i = 1; i <= 7; i++) {
      _chartData.add(_DynamicChartData('Device $i', _buildRandomInt(10, 95)));
    }
  }

  // Generates random integers within a range
  int _buildRandomInt(int min, int max) {
    return min + Random().nextInt(max - min + 1);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _chartData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'RPM Real Time Monitoring',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Devices', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'RPM (in thousands)',
          textStyle: chartAxisLabelStyle,
        ),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <BarSeries<_DynamicChartData, String>>[
        BarSeries<_DynamicChartData, String>(
          dataSource: _chartData,
          name: 'Device RPM',
          xValueMapper: (_DynamicChartData data, _) => data.productName,
          yValueMapper: (_DynamicChartData data, _) => data.downloads,
          color: kInfoColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

// Data model for the chart
class _DynamicChartData {
  final dynamic productName;
  final int downloads;

  _DynamicChartData(this.productName, this.downloads);
}

// Stacked Column 100 Chart
class StackedBar100Chart extends StatelessWidget {
  const StackedBar100Chart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<ExpenseData> expenseData = [
      ExpenseData('Jan', 35, 80, 25), // Marketing is low, Operations high
      ExpenseData('Feb', 50, 65, 30), // Balanced
      ExpenseData('Mar', 45, 75, 20), // Operations dominant
      ExpenseData('Apr', 60, 70, 40), // Slightly high marketing
      ExpenseData('May', 55, 60, 50), // Salaries catching up
      ExpenseData('Jun', 70, 90, 30), // Big operations growth
      ExpenseData('Jul', 50, 55, 25), // Dip in all
      // ExpenseData('Aug', 80, 100, 45), // Operations and marketing peak
      // ExpenseData('Sep', 65, 85, 50), // Salaries significant
      // ExpenseData('Oct', 40, 70, 35), // Marketing drop
      // ExpenseData('Nov', 75, 95, 60), // High overall
      // ExpenseData('Dec', 55, 65, 30), // Year-end adjustments
    ];

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Financial Breakdown (Last 7 Months)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Percentage', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
        labelFormat: '{value}%',
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<ExpenseData, String>>[
        // Marketing Expenses
        StackedBar100Series<ExpenseData, String>(
          dataSource: expenseData,
          xValueMapper: (ExpenseData data, _) => data.month,
          yValueMapper: (ExpenseData data, _) => data.marketingExpense,
          name: 'Marketing',
          color: kErrorColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        // Operational Expenses
        StackedBar100Series<ExpenseData, String>(
          dataSource: expenseData,
          xValueMapper: (ExpenseData data, _) => data.month,
          yValueMapper: (ExpenseData data, _) => data.operationalExpense,
          name: 'Operations',
          color: kInfoColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        // Employee Salaries
        StackedBar100Series<ExpenseData, String>(
          dataSource: expenseData,
          xValueMapper: (ExpenseData data, _) => data.month,
          yValueMapper: (ExpenseData data, _) => data.employeeSalaries,
          name: 'Salaries',
          color: kSuccessColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Model class for expense data
class ExpenseData {
  final String month;
  final double marketingExpense;
  final double operationalExpense;
  final double employeeSalaries;

  ExpenseData(
    this.month,
    this.marketingExpense,
    this.operationalExpense,
    this.employeeSalaries,
  );
}

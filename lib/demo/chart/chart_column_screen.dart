import 'dart:async';

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

class ChartColumnScreen extends StatefulWidget {
  const ChartColumnScreen({super.key});

  @override
  State<ChartColumnScreen> createState() => _ChartColumnScreenState();
}

class _ChartColumnScreenState extends State<ChartColumnScreen> {
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
                      lang.columnChart.toUpperCase(),
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
                          label: lang.columnChart,
                          uri: RouteUri.chartColumn,
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
                        // Default Column chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Default Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: DefaultColumnChart(),
                            ),
                            codeView:
                                '''DefaultColumnChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
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
                              child: DivergingColumChart(),
                            ),
                            codeView:
                                '''DivergingColumChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Clustered Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Clustered Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: ClusteredColumnChart(),
                            ),
                            codeView:
                                '''ClusteredColumnChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Stacked Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Stacked Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: StackedColumnChart(),
                            ),
                            codeView:
                                '''StackedColumnChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Stacked Column 100 Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Stacked Column 100 Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: StackedColumn100Chart(),
                            ),
                            codeView:
                                '''StackedColumn100Chart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Marker Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Marker Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: MarkerColumnChart(),
                            ),
                            codeView:
                                '''MarkerColumnChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Dumbbell Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dumbbell Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: DumbbellChart(),
                            ),
                            codeView:
                                '''DumbbellChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
                            height: 400,
                          ),
                        ),

                        // Dynamic Column Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dynamic Column Chart',
                            uiView: SizedBox(
                              height: 400,
                              child: DynamicColumnChart(),
                            ),
                            codeView:
                                '''DynamicColumnChart() source code can be found in the lib/demo/chart/chart_column_screen.dart file.''',
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

// Default Column Chart

class DefaultColumnChart extends StatelessWidget {
  const DefaultColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<InflationData> inflationData = [
      InflationData('Jan', 0.8),
      InflationData('Feb', 0.9),
      InflationData('Mar', 0.7),
      InflationData('Apr', 0.5),
      InflationData('May', 0.6),
      InflationData('Jun', 0.4),
      InflationData('Jul', 0.8),
      InflationData('Aug', 0.7),
      InflationData('Sep', 0.6),
      InflationData('Oct', 0.5),
      InflationData('Nov', 0.4),
      InflationData('Dec', 0.9),
    ];

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Indonesia Monthly Inflation Rate',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Inflation (%)', textStyle: chartAxisLabelStyle),
        labelFormat: '{value}%',
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ColumnSeries<InflationData, String>>[
        ColumnSeries<InflationData, String>(
          dataSource: inflationData,
          xValueMapper: (InflationData data, _) => data.month,
          yValueMapper: (InflationData data, _) => data.inflation,
          name: 'Inflation',
          color: kSuccessColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          borderRadius: chartTopRadius,
        ),
      ],
    );
  }
}

// inflation data model

class InflationData {
  final String month;
  final double inflation;

  InflationData(this.month, this.inflation);
}

// modified axis base

class DivergingColumChart extends StatelessWidget {
  const DivergingColumChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<CountryData> populationGrowthData = [
      CountryData('India', 1.2),
      CountryData('China', -0.2),
      CountryData('USA', 0.7),
      CountryData('Russia', -0.5),
      CountryData('Brazil', 0.4),
      CountryData('Japan', -0.3),
      CountryData('Nigeria', 2.5),
      CountryData('Germany', 0.1),
    ];
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Population Growth Rate of Countries',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Country', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Growth Rate (%)',
          textStyle: chartAxisLabelStyle,
        ),
        labelFormat: '{value}%',
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ColumnSeries<CountryData, String>>[
        ColumnSeries<CountryData, String>(
          dataSource: populationGrowthData,
          xValueMapper: (CountryData data, _) => data.country,
          yValueMapper: (CountryData data, _) => data.growthRate,
          pointColorMapper: (CountryData data, _) =>
              data.growthRate >= 0 ? kInfoColor : kErrorColor,
          name: 'Growth Rate',
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class CountryData {
  final String country;
  final double growthRate;

  CountryData(this.country, this.growthRate);
}

// Clustered Column Chart

class ClusteredColumnChart extends StatelessWidget {
  const ClusteredColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<FinancialData> financialData = [
      FinancialData('Jan', 50, 200, 30),
      FinancialData('Feb', 40, 190, 25),
      FinancialData('Mar', 60, 220, 35),
      FinancialData('Apr', 45, 210, 28),
      FinancialData('May', 55, 230, 32),
      FinancialData('Jun', 50, 240, 40),
      // FinancialData('Jul', 65, 250, 45),
      // FinancialData('Aug', 70, 260, 50),
      // FinancialData('Sep', 55, 240, 38),
      // FinancialData('Oct', 60, 250, 42),
      // FinancialData('Nov', 50, 220, 30),
      // FinancialData('Dec', 75, 270, 55),
    ];
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Financial Condition',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Amount (in \$ millions)',
          textStyle: chartAxisLabelStyle,
        ),
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<FinancialData, String>>[
        // Net Profit series
        ColumnSeries<FinancialData, String>(
          dataSource: financialData,
          xValueMapper: (FinancialData data, _) => data.month,
          yValueMapper: (FinancialData data, _) => data.netProfit,
          name: 'Net Profit',
          color: kSuccessColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          spacing: 0.2,
          borderRadius: chartTopRadius,
        ),
        // Revenue series
        ColumnSeries<FinancialData, String>(
          dataSource: financialData,
          xValueMapper: (FinancialData data, _) => data.month,
          yValueMapper: (FinancialData data, _) => data.revenue,
          name: 'Revenue',
          color: kInfoColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          spacing: 0.2,
          borderRadius: chartTopRadius,
        ),
        // Free Cash Flow series
        ColumnSeries<FinancialData, String>(
          dataSource: financialData,
          xValueMapper: (FinancialData data, _) => data.month,
          yValueMapper: (FinancialData data, _) => data.freeCashFlow,
          name: 'Free Cash Flow',
          color: kWarningColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          spacing: 0.2,
          borderRadius: chartTopRadius,
        ),
      ],
    );
  }
}

class FinancialData {
  final String month;
  final double netProfit;
  final double revenue;
  final double freeCashFlow;

  FinancialData(this.month, this.netProfit, this.revenue, this.freeCashFlow);
}

// Stacked Column Chart

class StackedColumnChart extends StatelessWidget {
  const StackedColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<ExpenseData> expenseData = [
      ExpenseData('Jan', 40, 60, 30),
      ExpenseData('Feb', 35, 55, 25),
      ExpenseData('Mar', 50, 70, 35),
      ExpenseData('Apr', 45, 65, 30),
      ExpenseData('May', 60, 80, 40),
      ExpenseData('Jun', 50, 75, 35),
      ExpenseData('Jul', 65, 85, 45),
      ExpenseData('Aug', 70, 90, 50),
      ExpenseData('Sep', 55, 70, 38),
      ExpenseData('Oct', 60, 80, 40),
      ExpenseData('Nov', 50, 65, 30),
      ExpenseData('Dec', 75, 95, 55),
    ];
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Financial Breakdown (2024)',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Expense (in \$ thousands)',
          textStyle: chartAxisLabelStyle,
        ),
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<ExpenseData, String>>[
        // Marketing Expenses
        StackedColumnSeries<ExpenseData, String>(
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
        StackedColumnSeries<ExpenseData, String>(
          dataSource: expenseData,
          xValueMapper: (ExpenseData data, _) => data.month,
          yValueMapper: (ExpenseData data, _) => data.operationalExpense,
          name: 'Operations',
          color: kSecondaryColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        // Employee Salaries
        StackedColumnSeries<ExpenseData, String>(
          dataSource: expenseData,
          xValueMapper: (ExpenseData data, _) => data.month,
          yValueMapper: (ExpenseData data, _) => data.employeeSalaries,
          name: 'Salaries',
          color: kPrimaryColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(fontSize: 10, color: Colors.white),
          ),
          borderRadius: chartTopRadius,
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

// Stacked Column 100 Chart
class StackedColumn100Chart extends StatelessWidget {
  const StackedColumn100Chart({super.key});

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
      ExpenseData('Aug', 80, 100, 45), // Operations and marketing peak
      ExpenseData('Sep', 65, 85, 50), // Salaries significant
      ExpenseData('Oct', 40, 70, 35), // Marketing drop
      ExpenseData('Nov', 75, 95, 60), // High overall
      ExpenseData('Dec', 55, 65, 30), // Year-end adjustments
    ];

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Financial Breakdown (100% Stacked)',
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
        StackedColumn100Series<ExpenseData, String>(
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
        StackedColumn100Series<ExpenseData, String>(
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
        StackedColumn100Series<ExpenseData, String>(
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

// Marker Column Chart

class MarkerColumnChart extends StatelessWidget {
  const MarkerColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Data source for the chart
    final List<MarketData> marketData = [
      MarketData('Q1', 50, 55), // Actual: 50, Target: 55
      MarketData('Q2', 70, 65), // Actual: 70, Target: 65
      MarketData('Q3', 60, 75), // Actual: 60, Target: 75
      MarketData('Q4', 80, 85), // Actual: 80, Target: 85
      MarketData('Q5', 90, 95), // Actual: 90, Target: 95
      MarketData('Q6', 75, 85), // Actual: 75, Target: 85
      MarketData('Q7', 85, 90), // Actual: 85, Target: 90
      MarketData('Q8', 95, 100), // Actual: 95, Target: 100
    ];

    return SfCartesianChart(
      title: ChartTitle(
        text: 'Actual vs Target Market Data',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Quarter', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Values', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
      ),
      series: <CartesianSeries>[
        // Actual data (Column series)
        ColumnSeries<MarketData, String>(
          dataSource: marketData,
          xValueMapper: (MarketData data, _) => data.quarter,
          yValueMapper: (MarketData data, _) => data.actual,
          name: 'Actual',
          color: kSuccessColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          borderRadius: chartTopRadius,
        ),
        // Target data (Markers - ScatterSeries)
        ScatterSeries<MarketData, String>(
          dataSource: marketData,
          xValueMapper: (MarketData data, _) => data.quarter,
          yValueMapper: (MarketData data, _) => data.target,
          name: 'Target',
          color: kErrorColor,
          markerSettings: MarkerSettings(
            isVisible: true,
            width: 12, // Marker size
            height: 10,
            shape: DataMarkerType.rectangle,
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

// Model class for market data
class MarketData {
  final String quarter;
  final double actual;
  final double target;

  MarketData(this.quarter, this.actual, this.target);
}

// Dynamic Column Chart

class DynamicColumnChart extends StatefulWidget {
  const DynamicColumnChart({super.key});

  @override
  State<DynamicColumnChart> createState() => _DynamicColumnChartState();
}

class _DynamicColumnChartState extends State<DynamicColumnChart> {
  // Data source for the chart
  List<RealTimeData> _chartData = [];
  late Timer _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the chart data
    _chartData = [
      RealTimeData('A', 20),
      RealTimeData('B', 30),
      RealTimeData('C', 40),
      RealTimeData('D', 50),
    ];

    // Start the timer for real-time updates
    _timer = Timer.periodic(Duration(seconds: 1), _updateDataSource);
  }

  void _updateDataSource(Timer timer) {
    setState(() {
      // Simulate real-time data updates
      _chartData[_counter % _chartData.length].value =
          (_chartData[_counter % _chartData.length].value + 10) % 100;

      _counter++;
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Real-Time Monitoring',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Device', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Output (rpm)', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(dashArray: [5, 5]),
        minimum: 0, // Fixed minimum value
        maximum: 100, // Fixed maximum value
        interval: 20, // Y-axis tick interval
      ),
      series: <CartesianSeries>[
        ColumnSeries<RealTimeData, String>(
          dataSource: _chartData,
          xValueMapper: (RealTimeData data, _) => data.category,
          yValueMapper: (RealTimeData data, _) => data.value,
          name: 'Value',
          color: Colors.blue,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          borderRadius: chartTopRadius,
        ),
      ],
    );
  }
}

// Model class for real-time data
class RealTimeData {
  final String category;
  double value;

  RealTimeData(this.category, this.value);
}

// Dumbbell Chart

class DumbbellChart extends StatelessWidget {
  // Data source for the chart
  final List<DumbbellData> data = [
    DumbbellData('2008', 3000, 4000),
    DumbbellData('2009', 3500, 4500),
    DumbbellData('2010', 2000, 8000),
    DumbbellData('2011', 4000, 6000),
    DumbbellData('2012', 3000, 5000),
    DumbbellData('2013', 4500, 7000),
    DumbbellData('2014', 3500, 5000),
  ];
  DumbbellChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Sales Expansion', textStyle: chartTitleStyle),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Year', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Sales', textStyle: chartAxisLabelStyle),
        minimum: 1000,
        maximum: 9000,
        interval: 1000,
      ),
      series: <CartesianSeries>[
        // RangeColumnSeries to show vertical dumbbell connections
        RangeColumnSeries<DumbbellData, String>(
          dataSource: data,
          width: 0.02,
          xValueMapper: (DumbbellData item, _) => item.category,
          lowValueMapper: (DumbbellData item, _) => item.lowValue,
          highValueMapper: (DumbbellData item, _) => item.highValue,
          pointColorMapper: (_, _) => kTextColor,
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
          borderRadius: BorderRadius.circular(4),
          name: 'Range',
          isVisibleInLegend: false,
        ),
        // ScatterSeries for the low values
        ScatterSeries<DumbbellData, String>(
          dataSource: data,
          xValueMapper: (DumbbellData item, _) => item.category,
          yValueMapper: (DumbbellData item, _) => item.lowValue,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 10,
            width: 10,
            shape: DataMarkerType.circle,
            color: kInfoColor,
            borderWidth: 0,
          ),
          color: kInfoColor,
          name: 'Actual Sales',
        ),
        // ScatterSeries for the high values
        ScatterSeries<DumbbellData, String>(
          dataSource: data,
          xValueMapper: (DumbbellData item, _) => item.category,
          yValueMapper: (DumbbellData item, _) => item.highValue,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 10,
            width: 10,
            shape: DataMarkerType.circle,
            color: kErrorColor,
            borderWidth: 0,
          ),
          color: kErrorColor,
          name: 'Target Sales',
        ),
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
    );
  }
}

// Model class for the data
class DumbbellData {
  final String category; // E.g., year
  final double lowValue; // Lower point of the dumbbell
  final double highValue; // Upper point of the dumbbell

  DumbbellData(this.category, this.lowValue, this.highValue);
}

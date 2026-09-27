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
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartBubbleScreen extends StatefulWidget {
  const ChartBubbleScreen({super.key});

  @override
  State<ChartBubbleScreen> createState() => _ChartBubbleScreenState();
}

class _ChartBubbleScreenState extends State<ChartBubbleScreen> {
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
                      lang.bubbleChart.toUpperCase(),
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
                          label: lang.bubbleChart,
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
                        // Basic Bubble Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Basic Bubble Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: BasicBubbleChart(),
                            ),
                            codeView:
                                '''BasicBubbleChart() source code can be found in the lib/demo/chart/chart_bubble_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Color Bubble Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Color Bubble Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: ColorBubbleChart(),
                            ),
                            codeView:
                                '''ColorBubbleChart() source code can be found in the lib/demo/chart/chart_bubble_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Gradient Bubble Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Gradient Bubble Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: GradientBubbleChart(),
                            ),
                            codeView:
                                '''GradientBubbleChart() source code can be found in the lib/demo/chart/chart_bubble_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Multiple Series Bubble Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Multiple Series Bubble Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: MultipleSeriesBubbleChart(),
                            ),
                            codeView:
                                '''MultipleSeriesBubbleChart() source code can be found in the lib/demo/chart/chart_bubble_screen.dart file.''',
                            height: 440,
                          ),
                        ),

                        // Dynamic Bubble Chart
                        SizedBox(
                          width: calculateCardWidth_2(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Dynamic Bubble Chart',
                            uiView: SizedBox(
                              height: 440,
                              child: DynamicBubbleChart(),
                            ),
                            codeView:
                                '''DynamicBubbleChart() source code can be found in the lib/demo/chart/chart_bubble_screen.dart file.''',
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

// BUBBLE CHART //

// basic bubble chart

class BasicBubbleChart extends StatelessWidget {
  final List<GDPData> data = [
    GDPData(country: 'USA', gdp: 21.43, population: 331),
    GDPData(country: 'China', gdp: 14.34, population: 1440),
    GDPData(country: 'Japan', gdp: 5.08, population: 126),
    GDPData(country: 'Germany', gdp: 3.85, population: 83),
    GDPData(country: 'India', gdp: 2.87, population: 1400),
  ];
  BasicBubbleChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'GDP vs Population (Bubble Size: GDP)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Country', textStyle: chartAxisLabelStyle),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'GDP (in Trillions)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 25,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format:
            'Country: point.x\nGDP: \$point.y Trillion\nPopulation: point.size Million',
        canShowMarker: false,
      ),
      series: <CartesianSeries>[
        BubbleSeries<GDPData, String>(
          dataSource: data,
          name: 'GDP vs Population',
          xValueMapper: (GDPData data, _) => data.country,
          yValueMapper: (GDPData data, _) => data.gdp,
          sizeValueMapper: (GDPData data, _) => data.population,
          color: kSecondaryColor,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class GDPData {
  final String country;
  final double gdp; // GDP in Trillions
  final double population; // Population in Millions

  GDPData({required this.country, required this.gdp, required this.population});
}

// color bubble chart

class ColorBubbleChart extends StatelessWidget {
  final List<GeographicalData> data = [
    GeographicalData(
      country: 'USA',
      gdpPerCapita: 63000,
      lifeExpectancy: 79,
      population: 331,
      pointColor: kPrimaryColor,
    ),
    GeographicalData(
      country: 'China',
      gdpPerCapita: 15500,
      lifeExpectancy: 77,
      population: 1440,
      pointColor: kSecondaryColor,
    ),
    GeographicalData(
      country: 'Japan',
      gdpPerCapita: 41000,
      lifeExpectancy: 84,
      population: 126,
      pointColor: kInfoColor,
    ),
    GeographicalData(
      country: 'Germany',
      gdpPerCapita: 47000,
      lifeExpectancy: 81,
      population: 83,
      pointColor: kSuccessColor,
    ),
    GeographicalData(
      country: 'India',
      gdpPerCapita: 3000,
      lifeExpectancy: 70,
      population: 1400,
      pointColor: kWarningColor,
    ),
    GeographicalData(
      country: 'Brazil',
      gdpPerCapita: 9000,
      lifeExpectancy: 75,
      population: 213,
      pointColor: kErrorColor,
    ),
  ];

  ColorBubbleChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Population, Life Expectancy, and GDP per Capita',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format:
            'Life Expectancy: point.y years\nPopulation: point.size million\nGDP: \$point.xValue',
        canShowMarker: false,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(
          text: 'GDP Per Capita (USD)',
          textStyle: chartAxisLabelStyle,
        ),
        numberFormat: NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 0,
        ),
        minimum: 0,
        maximum: 70000,
        interval: 10000,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Life Expectancy (Years)',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 60,
        maximum: 90,
        interval: 5,
      ),
      series: <BubbleSeries>[
        BubbleSeries<GeographicalData, num>(
          dataSource: data,
          xValueMapper: (GeographicalData data, _) => data.gdpPerCapita,
          yValueMapper: (GeographicalData data, _) => data.lifeExpectancy,
          sizeValueMapper: (GeographicalData data, _) => data.population,
          pointColorMapper: (GeographicalData data, _) => data.pointColor,
          dataLabelMapper: (GeographicalData data, _) =>
              data.country, // Country name
          name: 'Details',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class GeographicalData {
  final String country;
  final double gdpPerCapita; // GDP per capita (USD)
  final double lifeExpectancy; // Life expectancy (years)
  final double population; // Population in millions
  final Color pointColor; // Country color

  GeographicalData({
    required this.country,
    required this.gdpPerCapita,
    required this.lifeExpectancy,
    required this.population,
    required this.pointColor,
  });
}

// bubble with gradient

class GradientBubbleChart extends StatelessWidget {
  final List<SalesDataGradient> data = [
    SalesDataGradient(
      region: 'North America',
      revenue: 4500,
      salespeople: 120,
      salesVolume: 155,
    ),
    SalesDataGradient(
      region: 'Europe',
      revenue: 3200,
      salespeople: 95,
      salesVolume: 135,
    ),
    SalesDataGradient(
      region: 'Asia',
      revenue: 3800,
      salespeople: 140,
      salesVolume: 170,
    ),
    SalesDataGradient(
      region: 'South America',
      revenue: 2900,
      salespeople: 70,
      salesVolume: 130,
    ),
    SalesDataGradient(
      region: 'Australia',
      revenue: 4100,
      salespeople: 80,
      salesVolume: 120,
    ),
  ];

  GradientBubbleChart({super.key});

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
  );

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Sales Performance Across Regions (January)',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Revenue', textStyle: chartAxisLabelStyle),
        minimum: 2000,
        maximum: 5000,
        numberFormat: NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 0,
        ),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Number of Active Salespeople',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 50,
        maximum: 160,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format:
            'Revenue: point.x\nSales people: point.y\nSales volume: point.size',
        canShowMarker: false,
      ),
      series: <BubbleSeries<SalesDataGradient, double>>[
        BubbleSeries<SalesDataGradient, double>(
          dataSource: data,
          name: 'Sales Performance',
          xValueMapper: (SalesDataGradient sales, _) => sales.revenue,
          yValueMapper: (SalesDataGradient sales, _) => sales.salespeople,
          sizeValueMapper: (SalesDataGradient sales, _) => sales.salesVolume,
          dataLabelMapper: (SalesDataGradient sales, _) => sales.region,
          gradient: LinearGradient(
            colors: [kSecondaryColor, kInfoColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class SalesDataGradient {
  final String region;
  final double revenue; // Average daily sales
  final int salespeople; // Number of active salespeople
  final int salesVolume; // Total sales volume

  SalesDataGradient({
    required this.region,
    required this.revenue,
    required this.salespeople,
    required this.salesVolume,
  });
}

// multiple series bubble chart

class MultipleSeriesBubbleChart extends StatelessWidget {
  const MultipleSeriesBubbleChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Product Performance Analysis',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'Revenue: point.x\nRating: point.y\nUnits Sold: point.size',
        canShowMarker: false,
      ),
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Revenue', textStyle: chartAxisLabelStyle),
        numberFormat: NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 0,
        ),
        minimum: 0,
        maximum: 80000,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Average Customer Rating',
          textStyle: chartAxisLabelStyle,
        ),
        minimum: 0,
        maximum: 5,
        interval: 1,
      ),
      series: <BubbleSeries<ProductData, num>>[
        BubbleSeries<ProductData, num>(
          name: 'Electronics',
          dataSource: getElectronicsData(),
          xValueMapper: (ProductData data, _) => data.revenue,
          yValueMapper: (ProductData data, _) => data.rating,
          sizeValueMapper: (ProductData data, _) => data.unitsSold,
          color: kSecondaryColor,
          maximumRadius: 15,
        ),
        BubbleSeries<ProductData, num>(
          name: 'Fashion',
          dataSource: getFashionData(),
          xValueMapper: (ProductData data, _) => data.revenue,
          yValueMapper: (ProductData data, _) => data.rating,
          sizeValueMapper: (ProductData data, _) => data.unitsSold,
          color: Colors.pink,
        ),
        BubbleSeries<ProductData, num>(
          name: 'Home Appliances',
          dataSource: getHomeApplianceData(),
          xValueMapper: (ProductData data, _) => data.revenue,
          yValueMapper: (ProductData data, _) => data.rating,
          sizeValueMapper: (ProductData data, _) => data.unitsSold,
          color: kSuccessColor,
        ),
        BubbleSeries<ProductData, num>(
          name: 'Sports Equipment',
          dataSource: getSportsData(),
          xValueMapper: (ProductData data, _) => data.revenue,
          yValueMapper: (ProductData data, _) => data.rating,
          sizeValueMapper: (ProductData data, _) => data.unitsSold,
          color: kWarningColor,
        ),
      ],
    );
  }

  List<ProductData> getElectronicsData() {
    return [
      ProductData(1000, 2.2, 40000),
      ProductData(8500, 4.5, 75000),
      ProductData(1200, 4.0, 60000),
    ];
  }

  List<ProductData> getFashionData() {
    return [
      ProductData(2000, 3.8, 10000),
      ProductData(2500, 1.0, 20000),
      ProductData(6000, 3.9, 45000),
    ];
  }

  List<ProductData> getHomeApplianceData() {
    return [
      ProductData(800, 1.5, 55000),
      ProductData(3900, 1.3, 70000),
      ProductData(400, 2.9, 55000),
    ];
  }

  List<ProductData> getSportsData() {
    return [
      ProductData(700, 2.9, 11000),
      ProductData(800, 3.9, 28500),
      ProductData(250, 1.8, 2600),
    ];
  }
}

class ProductData {
  final int unitsSold; // Bubble size
  final double rating; // Y-axis
  final int revenue; // X-axis

  ProductData(this.unitsSold, this.rating, this.revenue);
}

// dynamic bubble chart

class DynamicBubbleChart extends StatefulWidget {
  const DynamicBubbleChart({super.key});

  @override
  State<DynamicBubbleChart> createState() => _DynamicBubbleChartState();
}

class _DynamicBubbleChartState extends State<DynamicBubbleChart> {
  Timer? _timer;
  List<_DynamicBubbleChartData>? _chartData;

  @override
  void initState() {
    _chartData = _generateInitialData();
    super.initState();
    _startDataUpdates();
  }

  /// Simulates periodic updates to the chart data every 2 seconds.
  void _startDataUpdates() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _chartData = _generateDynamicData();
      });
    });
  }

  /// Generates initial static data.
  List<_DynamicBubbleChartData> _generateInitialData() {
    return <_DynamicBubbleChartData>[
      _DynamicBubbleChartData('Zone 1', 45, 2.5),
      _DynamicBubbleChartData('Zone 2', 60, 3.0),
      _DynamicBubbleChartData('Zone 3', 30, 1.8),
      _DynamicBubbleChartData('Zone 4', 50, 2.2),
      _DynamicBubbleChartData('Zone 5', 70, 3.5),
      _DynamicBubbleChartData('Zone 6', 80, 4.0),
      _DynamicBubbleChartData('Zone 7', 55, 2.7),
    ];
  }

  /// Generates dynamic data for real-time updates.
  List<_DynamicBubbleChartData> _generateDynamicData() {
    final Random random = Random();
    return List<_DynamicBubbleChartData>.generate(7, (index) {
      return _DynamicBubbleChartData(
        'Zone ${index + 1}',
        random.nextInt(100), // Random AQI (Air Quality Index)
        random.nextDouble() * 3 + 1, // Random pollution level (bubble size)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCartesianChart();
  }

  /// Builds the Cartesian Bubble Chart.
  SfCartesianChart _buildCartesianChart() {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Real-Time Environmental Monitoring',
        textStyle: chartTitleStyle,
      ),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: false),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'City Zones', textStyle: chartAxisLabelStyle),
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: 'Air Quality Index (AQI)',
          textStyle: chartAxisLabelStyle,
        ),
        majorTickLines: MajorTickLines(color: Colors.transparent),
        minimum: 0,
        maximum: 120,
      ),
      series: _buildBubbleSeries(),
    );
  }

  /// Creates the Bubble Series for the chart.
  List<BubbleSeries<_DynamicBubbleChartData, String>> _buildBubbleSeries() {
    return <BubbleSeries<_DynamicBubbleChartData, String>>[
      BubbleSeries<_DynamicBubbleChartData, String>(
        dataSource: _chartData!,
        xValueMapper: (_DynamicBubbleChartData data, _) => data.zone,
        yValueMapper: (_DynamicBubbleChartData data, _) => data.aqi,
        sizeValueMapper: (_DynamicBubbleChartData data, _) => data.pollution,
        color: kInfoColor,
        dataLabelMapper: (_DynamicBubbleChartData data, _) =>
            '${data.zone}\nAQI: ${data.aqi}\nPollution: ${data.pollution.toStringAsFixed(1)}',
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    _timer?.cancel();
    _chartData?.clear();
    super.dispose();
  }
}

/// Custom Data Class for Bubble Chart
class _DynamicBubbleChartData {
  _DynamicBubbleChartData(this.zone, this.aqi, this.pollution);

  final String zone; // City zone (X-axis label)
  final int aqi; // Air Quality Index (Y-axis value)
  final double pollution; // Pollution Level (bubble size)
}

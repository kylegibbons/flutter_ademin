import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Global chart title style
TextStyle chartTitleStyle = TextStyle(
  fontSize: kBodyMedium, // Adjust font size as needed
  fontWeight: FontWeight.w500, // Adjust font weight
);

// global axis label style
TextStyle chartAxisLabelStyle = TextStyle(
  fontSize: kBodyMedium,
  fontWeight: FontWeight.w500,
);

// column top border radius

final BorderRadius chartTopRadius = BorderRadius.only(
  topLeft: Radius.circular(defaultRadius / 2),
  topRight: Radius.circular(defaultRadius / 2),
);

// column bottom border radius

final BorderRadius chartBottomRadius = BorderRadius.only(
  bottomLeft: Radius.circular(defaultRadius / 2),
  bottomRight: Radius.circular(defaultRadius / 2),
);

// bar border radius

final BorderRadius chartBarRadius = BorderRadius.only(
  topRight: Radius.circular(defaultRadius / 2),
  bottomRight: Radius.circular(defaultRadius / 2),
);

// Gradient area chart

class GradientAreaChart extends StatelessWidget {
  final chartData = <_SalesChartData>[
    _SalesChartData('Jan', 35),
    _SalesChartData('Feb', 28),
    _SalesChartData('Mar', 34),
    _SalesChartData('Apr', 32),
    _SalesChartData('May', 40),
  ];

  GradientAreaChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Monthly Sales Analysis',
        textStyle: chartTitleStyle,
      ),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        labelFormat: '{value}k',
        title: AxisTitle(text: 'Sales', textStyle: chartAxisLabelStyle),
      ),
      series: <CartesianSeries<_SalesChartData, String>>[
        SplineAreaSeries<_SalesChartData, String>(
          dataSource: chartData,
          xValueMapper: (_SalesChartData data, _) => data.month,
          yValueMapper: (_SalesChartData data, _) => data.sales,
          gradient: LinearGradient(
            colors: [
              kSuccessColor.withValues(alpha: 0.6),
              kSuccessColor.withValues(alpha: 0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderWidth: 2,
          borderGradient: LinearGradient(colors: [kSuccessColor, kInfoColor]),
        ),
      ],
    );
  }
}

class _SalesChartData {
  _SalesChartData(this.month, this.sales);
  final String month;
  final double sales;
}

// modified axis value

class ModifiedAxisAreaChart extends StatefulWidget {
  const ModifiedAxisAreaChart({super.key});

  @override
  State<ModifiedAxisAreaChart> createState() => _ModifiedAxisAreaChartState();
}

class _ModifiedAxisAreaChartState extends State<ModifiedAxisAreaChart> {
  String _selectedAxis = '-2 (modified)';
  double _crossAt = -2;

  final List<String> _axisOptions = ['-2 (modified)', '0 (default)'];

  final List<ChartSampleData> _chartData = [
    ChartSampleData(x: 'Iceland', y: 1.13),
    ChartSampleData(x: 'Algeria', y: 1.7),
    ChartSampleData(x: 'Singapore', y: 1.82),
    ChartSampleData(x: 'Malaysia', y: 1.37),
    ChartSampleData(x: 'Moldova', y: -1.05),
    ChartSampleData(x: 'American Samoa', y: -1.3),
    ChartSampleData(x: 'Latvia', y: -1.1),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text('Axis base value:', style: TextStyle(fontSize: 16)),
              SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedAxis,
                items: _axisOptions
                    .map(
                      (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAxis = value!;
                    _crossAt = value == '-2 (modified)' ? -2 : 0;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            title: ChartTitle(text: 'Population growth rate of countries'),
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              crossesAt: _crossAt,
            ),
            primaryYAxis: NumericAxis(
              minimum: -2,
              maximum: 3,
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(size: 0),
            ),
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: '',
              canShowMarker: false,
            ),
            series: [
              AreaSeries<ChartSampleData, String>(
                dataSource: _chartData,
                xValueMapper: (data, _) => data.x,
                yValueMapper: (data, _) => data.y,
                color: kInfoColor.withValues(alpha: 0.6),
                borderColor: kInfoColor,
                markerSettings: MarkerSettings(isVisible: true),
                animationDuration: 1000, // 1-second animation
              ),
            ],
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

class ChartSampleData {
  ChartSampleData({required this.x, required this.y});
  final String x;
  final double y;
}

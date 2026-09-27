import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyPortfolioStats extends StatefulWidget {
  const MyPortfolioStats({super.key});

  @override
  State<MyPortfolioStats> createState() => _MyPortfolioStatsState();
}

class _MyPortfolioStatsState extends State<MyPortfolioStats> {
  late List<PortfolioStats> _allData;
  late List<PortfolioStats> _filteredData;

  String _selectedRange = '1M';

  @override
  void initState() {
    super.initState();
    _allData = _generateDummyData();
    _filteredData = _filterDataByRange(_selectedRange);
  }

  List<PortfolioStats> _generateDummyData() {
    final List<PortfolioStats> data = [];
    final DateTime start = DateTime.now().subtract(Duration(days: 365));
    final random = Random();
    double value = 38000;

    for (int i = 0; i <= 365; i++) {
      value += random.nextDouble() * 200 - 100;
      data.add(
        PortfolioStats(
          start.add(Duration(days: i)),
          double.parse((value).toStringAsFixed(2)),
        ),
      );
    }

    return data;
  }

  List<PortfolioStats> _filterDataByRange(String range) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (range) {
      case '1M':
        startDate = now.subtract(Duration(days: 30));
        break;
      case '6M':
        startDate = now.subtract(Duration(days: 180));
        break;
      case '1Y':
        startDate = now.subtract(Duration(days: 365));
        break;
      default:
        return _allData;
    }

    return _allData.where((data) => data.date.isAfter(startDate)).toList();
  }

  void _onRangeSelected(String range) {
    setState(() {
      _selectedRange = range;
      _filteredData = _filterDataByRange(range);
    });
  }

  double _getInterval() {
    switch (_selectedRange) {
      case '1M':
        return 1; // daily
      case '6M':
        return 10; // semi-monthly
      case '1Y':
      case 'ALL':
        return 30; // monthly
      default:
        return 7; // fallback
    }
  }

  DateFormat _getDateFormat() {
    switch (_selectedRange) {
      case '1M':
        return DateFormat.MMMd(); // Jan 30
      case '6M':
        return DateFormat.MMMd(); // Jan 30
      case '1Y':
      case 'ALL':
        return DateFormat.MMM(); // Jan
      default:
        return DateFormat.yMMMd(); // Jan 30, 2024
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate = _filteredData.first.date;
    DateTime endDate = DateTime.now();
    final themeData = Theme.of(context);
    return SizedBox(
      height: 422,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Portfolio Statistics'.toUpperCase(),
                    style: TextStyle(
                      fontSize: kBodyMedium,
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  _buildRangeButtons(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding / 4,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    minimum: _selectedRange == 'ALL' ? null : startDate,
                    maximum: _selectedRange == 'ALL' ? null : endDate,
                    dateFormat: _getDateFormat(),
                    intervalType: DateTimeIntervalType.days,
                    interval: _getInterval(),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    majorGridLines: const MajorGridLines(width: 0),
                    // labelRotation: -45, // Optional: tilt labels to avoid overlap
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: '\$ (thousands)',
                      textStyle: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodySmall,
                      ),
                    ),
                    numberFormat: NumberFormat.compact(),
                    majorGridLines: const MajorGridLines(
                      width: 0.3,
                      // dashArray: [4, 4],
                    ),
                    axisLine: AxisLine(width: 0),
                  ),
                  series: <CartesianSeries>[
                    SplineAreaSeries<PortfolioStats, DateTime>(
                      dataSource: _filteredData,
                      xValueMapper: (datum, _) => datum.date,
                      yValueMapper: (datum, _) => datum.value,
                      gradient: LinearGradient(
                        colors: [
                          kInfoColor.withValues(alpha: 0.3),
                          kInfoColor.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderColor: kInfoColor,
                      borderWidth: 2,
                      animationDuration: 800,
                    ),
                  ],
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    tooltipAlignment: ChartAlignment.near,
                    tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
                    lineDashArray: [4, 4],
                    lineWidth: 0.6,
                    lineColor: kTextColor,
                    tooltipSettings: InteractiveTooltip(
                      enable: true,
                      format: 'point.x : \$point.y',
                      color: themeData.colorScheme.surface,
                      textStyle: TextStyle(
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enableSelectionZooming: true,
                    enableDoubleTapZooming: true,
                    enableMouseWheelZooming: true,
                    enablePanning: true,
                    zoomMode: ZoomMode.x,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeButtons() {
    const ranges = ['1M', '6M', '1Y', 'ALL'];
    return Row(
      children: ranges.map((range) {
        bool isSelected = _selectedRange == range;
        return GestureDetector(
          onTap: () => _onRangeSelected(range),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? kPrimaryColor
                  : kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(defaultRadius),
              // border:
              //     isSelected ? Border.all(color: Colors.grey.shade200) : null,
            ),
            child: Text(
              range,
              style: TextStyle(
                fontSize: kBodySmall,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : kPrimaryColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

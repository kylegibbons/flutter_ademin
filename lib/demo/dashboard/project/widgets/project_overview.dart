import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_data.dart';
import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/chart/chart.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

// project overview chart

class ProjectOverviewChart extends StatefulWidget {
  const ProjectOverviewChart({super.key});

  @override
  State<ProjectOverviewChart> createState() => _ProjectOverviewChartState();
}

class _ProjectOverviewChartState extends State<ProjectOverviewChart> {
  String selectedTimeRange = '1H'; // Default selected time range
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Card(
      child: SizedBox(
        height: 675,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header + time range
            CardHeader(
              kText: 'Project Overview',
              kWidget: mediaQueryData.size.width < kScreenWidthSm
                  ? PeriodPopUpMenu()
                  : Padding(
                      padding: EdgeInsetsDirectional.only(end: kDefaultPadding),
                      child: _buildTimeRangeSelector(),
                    ),
            ),

            Container(
              decoration: BoxDecoration(color: kTableHeaderColor),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1.5 * kDefaultPadding,
              ),
              child: AdaptiveWrap(
                breakpoints: {
                  kScreenWidthSm / 2: 1, // set breakpoint for 1 column layout,
                  kScreenWidthSm: 2, // set breakpoint for 2 column layout
                  kScreenWidthMd: 4, // set breakpoint for 4 column layout
                },
                columnRatios: const [
                  0.25, // set column A as 25% width
                  0.25, // set column B as 25% width
                  0.25, // set column C as 25% width
                  0.25, // set column D as 25% width
                ],
                spacing: kDefaultPadding, // spacing
                runSpacing: 2 * kDefaultPadding, // run spacing
                children: [
                  ProjectOverviewCard(
                    title: 'Number of Projects',
                    value: '5,651',
                  ),
                  ProjectOverviewCard(title: 'Active Projects', value: '1,223'),
                  ProjectOverviewCard(title: 'Revenue', value: '\$248.39k'),
                  ProjectOverviewCard(
                    title: 'Working tasks',
                    value: '9,531h',
                    valueColor: Colors.teal,
                  ),
                ],
              ),
            ),

            SizedBox(height: kDefaultPadding),

            // chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  primaryXAxis: CategoryAxis(
                    majorTickLines: MajorTickLines(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  margin: EdgeInsets.zero,
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 120,
                    interval: 20,
                    majorTickLines: MajorTickLines(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  axes: <ChartAxis>[
                    NumericAxis(
                      name: 'revenueAxis',
                      opposedPosition: true,
                      minimum: 0,
                      maximum: 180,
                      interval: 20,
                      labelFormat: '\${value}K',
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                  ],
                  series: <CartesianSeries>[
                    // Revenue - Line series
                    SplineAreaSeries<ProjectData, String>(
                      dataSource: getProjectData(),
                      xValueMapper: (ProjectData data, _) => data.month,
                      yValueMapper: (ProjectData data, _) => data.revenue,
                      name: 'Revenue',
                      yAxisName: 'revenueAxis',
                      color: kWarningColor.withValues(alpha: 0.05),
                      borderColor: kWarningColor,
                      dashArray: <double>[4, 4],
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        color: kWarningColor,
                        shape: DataMarkerType.circle,
                        height: 4,
                        width: 4,
                        borderWidth: 0.4,
                        borderColor: kWarningColor,
                      ),
                    ),
                    // Number of Projects - Column series
                    ColumnSeries<ProjectData, String>(
                      dataSource: getProjectData(),
                      xValueMapper: (ProjectData data, _) => data.month,
                      yValueMapper: (ProjectData data, _) => data.projects,
                      name: 'Number of Projects',
                      borderRadius: chartTopRadius,
                      color: kPrimaryColor,
                      width: 0.6,
                    ),
                    // Active Projects - Column series
                    ColumnSeries<ProjectData, String>(
                      dataSource: getProjectData(),
                      xValueMapper: (ProjectData data, _) => data.month,
                      yValueMapper: (ProjectData data, _) =>
                          data.activeProjects,
                      name: 'Active Projects',
                      color: kSuccessColor,
                      width: 0.6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the time range selector buttons
  Widget _buildTimeRangeSelector() {
    List<String> timeRanges = ['1H', '7D', '1M', '1Y', 'ALL'];
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Row(
        children: timeRanges.map((range) {
          bool isSelected = selectedTimeRange == range;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTimeRange = range;
                // In a real app, this would trigger data fetching for the selected range
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? themeData.colorScheme.surface
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(defaultRadius),
                // border:
                //     isSelected ? Border.all(color: Colors.grey.shade200) : null,
              ),
              child: Text(
                range,
                style: TextStyle(
                  fontSize: kBodySmall,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? kSecondaryColor
                      : themeData.colorScheme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

//project overview card

class ProjectOverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const ProjectOverviewCard({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: kBodyLarge,
            fontWeight: FontWeight.bold,
            color: valueColor ?? themeData.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text(title, style: TextStyle(fontSize: kBodyMedium)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/project/data/dashboard_project_data.dart';
import 'package:flutkit_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutkit_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';

// Project Status

class ProjectStatusOverview extends StatefulWidget {
  const ProjectStatusOverview({super.key});

  @override
  State<ProjectStatusOverview> createState() => _ProjectStatusOverviewState();
}

class _ProjectStatusOverviewState extends State<ProjectStatusOverview> {
  int get totalProjects => data.fold(0, (sum, item) => sum + item.projects);

  String? selectedValue = 'all_time';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 560,
        child: Column(
          children: [
            // header
            CardHeader(kText: 'Projects Status', kWidget: TimeFilterDropdown()),

            SizedBox(height: kDefaultPadding),

            /// Donut Chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: SfCircularChart(
                  margin: EdgeInsets.zero,
                  legend: Legend(isVisible: false),
                  series: <CircularSeries>[
                    DoughnutSeries<ProjectStatusData, String>(
                      dataSource: data,
                      xValueMapper: (ProjectStatusData status, _) =>
                          status.status,
                      yValueMapper: (ProjectStatusData status, _) =>
                          status.projects,
                      pointColorMapper: (ProjectStatusData status, _) =>
                          status.color,
                      innerRadius: '80%',
                      radius: '100%',
                    ),
                  ],
                ),
              ),
            ),

            /// Total Projects + Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  totalProjects.toString(),
                  style: TextStyle(
                    fontSize: kHeadlineSmall,
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: kDefaultPadding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Projects'),
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: kSuccessColor),
                        SizedBox(width: kDefaultPadding / 4),
                        Text('+3 New', style: TextStyle(color: kSuccessColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: kDefaultPadding),

            /// Breakdown
            ...data.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2,
                  horizontal: kDefaultPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      color: item.color,
                      margin: EdgeInsets.only(right: kDefaultPadding / 2),
                    ),
                    Text(
                      item.status,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${NumberFormat('#,###').format(item.projects)} Projects',
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${NumberFormat('#,###').format(item.tasks)} tasks',
                      style: TextStyle(color: item.color),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}

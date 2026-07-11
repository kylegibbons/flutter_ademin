import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/image.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableColumnResizingScreen extends StatefulWidget {
  const TableColumnResizingScreen({super.key});

  @override
  State<TableColumnResizingScreen> createState() =>
      _TableColumnResizingScreenState();
}

class _TableColumnResizingScreenState extends State<TableColumnResizingScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).resizingTable; //update your page tittle here
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
                      lang.resizingTable.toUpperCase(),
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
                        BreadcrumbItem(label: lang.tables, uri: ''),
                        BreadcrumbItem(
                          label: lang.resizingTable,
                          uri: RouteUri.tableColumnResizing,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ShowCodeCard(
                  cardTitle: 'Resizing Column Table',
                  description:
                      "This feature enables the interactive resizing of columns by dragging the column header's right border.",
                  uiView: ResizingColumnTable(),
                  codeView:
                      '''ResizingColumnTable() source code can be found in the lib/demo/table/table_column_resizing_screen.dart file.''',
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

class ResizingColumnTable extends StatefulWidget {
  const ResizingColumnTable({super.key});

  @override
  State<ResizingColumnTable> createState() => _ResizingColumnTableState();
}

class _ResizingColumnTableState extends State<ResizingColumnTable> {
  late ProjectDataSource _projectDataSource;

  late Map<String, double> columnWidths = {
    'name': double.nan,
    'lead': double.nan,
    'progress': double.nan,
    'assignees': double.nan,
    'status': double.nan,
    'dueDate': double.nan,
  };

  List<Project> _projects = <Project>[];

  @override
  void initState() {
    super.initState();
    _projects = getProjectsData();
    _projectDataSource = ProjectDataSource(
      projects: _projects,
      context: context,
    );
  }

  // mock data

  List<Project> getProjectsData() {
    return [
      Project(
        name: 'Mobile App Redesign',
        lead: {'avatar': 'assets/images/avatar_1.jpg', 'name': 'Emma Wilson'},
        progress: 80,
        assignees: [
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Alice'},
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Bob'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Charlie'},
          {'image': 'assets/images/avatar_5.jpg', 'label': 'David'},
        ],
        status: 'In Progress',
        dueDate: '06 Sept 2025',
      ),
      Project(
        name: 'E-commerce Website Development',
        lead: {
          'avatar': 'assets/images/avatar_6.jpg',
          'name': 'Michael Johnson',
        },
        progress: 45,
        assignees: [
          {'image': 'assets/images/avatar_7.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_8.jpg', 'label': 'Ethan'},
        ],
        status: 'In Progress',
        dueDate: '20 Oct 2025',
      ),
      Project(
        name: 'AI Chatbot Integration',
        lead: {'avatar': 'assets/images/avatar_3.jpg', 'name': 'Sarah Lee'},
        progress: 60,
        assignees: [
          {'image': 'assets/images/avatar_9.jpg', 'label': 'Daniel'},
          {'image': 'assets/images/avatar_10.jpg', 'label': 'Olivia'},
          {'image': 'assets/images/avatar_11.jpg', 'label': 'Noah'},
        ],
        status: 'On Hold',
        dueDate: '15 Nov 2025',
      ),
      Project(
        name: 'Cloud Migration Strategy',
        lead: {
          'avatar': 'assets/images/avatar_4.jpg',
          'name': 'James Anderson',
        },
        progress: 35,
        assignees: [
          {'image': 'assets/images/avatar_5.jpg', 'label': 'Liam'},
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Emma'},
        ],
        status: 'Pending',
        dueDate: '12 Dec 2025',
      ),
      Project(
        name: 'HR Management System',
        lead: {'avatar': 'assets/images/avatar_5.jpg', 'name': 'Jessica Brown'},
        progress: 100,
        assignees: [
          {'image': 'assets/images/avatar_1.jpg', 'label': 'Benjamin'},
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Ella'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Lucas'},
        ],
        status: 'Completed',
        dueDate: '05 Jan 2026',
      ),
      Project(
        name: 'Mobile App Redesign',
        lead: {'avatar': 'assets/images/avatar_6.jpg', 'name': 'Emma Wilson'},
        progress: 80,
        assignees: [
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Alice'},
          {'image': 'assets/images/avatar_7.jpg', 'label': 'Bob'},
          {'image': 'assets/images/avatar_8.jpg', 'label': 'Charlie'},
          {'image': 'assets/images/avatar_9.jpg', 'label': 'David'},
        ],
        status: 'In Progress',
        dueDate: '06 Sept 2025',
      ),
      Project(
        name: 'E-commerce Website Development',
        lead: {
          'avatar': 'assets/images/avatar_10.jpg',
          'name': 'Michael Johnson',
        },
        progress: 45,
        assignees: [
          {'image': 'assets/images/avatar_11.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Ethan'},
        ],
        status: 'In Progress',
        dueDate: '20 Oct 2025',
      ),
      Project(
        name: 'AI Chatbot Integration',
        lead: {'avatar': 'assets/images/avatar_3.jpg', 'name': 'Sarah Lee'},
        progress: 60,
        assignees: [
          {'image': 'assets/images/avatar_5.jpg', 'label': 'Daniel'},
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Olivia'},
          {'image': 'assets/images/avatar_1.jpg', 'label': 'Noah'},
        ],
        status: 'On Hold',
        dueDate: '15 Nov 2025',
      ),
      Project(
        name: 'Cloud Migration Strategy',
        lead: {
          'avatar': 'assets/images/avatar_11.jpg',
          'name': 'James Anderson',
        },
        progress: 35,
        assignees: [
          {'image': 'assets/images/avatar_10.jpg', 'label': 'Liam'},
          {'image': 'assets/images/avatar_9.jpg', 'label': 'Emma'},
        ],
        status: 'Pending',
        dueDate: '12 Dec 2025',
      ),
      Project(
        name: 'HR Management System',
        lead: {'avatar': 'assets/images/avatar_8.jpg', 'name': 'Jessica Brown'},
        progress: 100,
        assignees: [
          {'image': 'assets/images/avatar_7.jpg', 'label': 'Benjamin'},
          {'image': 'assets/images/avatar_6.jpg', 'label': 'Ella'},
          {'image': 'assets/images/avatar_5.jpg', 'label': 'Lucas'},
        ],
        status: 'Completed',
        dueDate: '05 Jan 2026',
      ),
      Project(
        name: 'Marketing Campaign Automation',
        lead: {'avatar': 'assets/images/avatar_4.jpg', 'name': 'Mark Evans'},
        progress: 55,
        assignees: [
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Liam'},
        ],
        status: 'In Progress',
        dueDate: '22 Feb 2026',
      ),
      Project(
        name: 'Marketing Campaign Automation',
        lead: {'avatar': 'assets/images/avatar_1.jpg', 'name': 'Mark Evans'},
        progress: 55,
        assignees: [
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Liam'},
          {'image': 'assets/images/avatar_5.jpg', 'label': 'Ava'},
          {'image': 'assets/images/avatar_6.jpg', 'label': 'Ethan'},
        ],
        status: 'In Progress',
        dueDate: '22 Feb 2026',
      ),
      Project(
        name: 'Inventory Management System',
        lead: {'avatar': 'assets/images/avatar_7.jpg', 'name': 'David Roberts'},
        progress: 70,
        assignees: [
          {'image': 'assets/images/avatar_8.jpg', 'label': 'Ava'},
          {'image': 'assets/images/avatar_9.jpg', 'label': 'Ethan'},
        ],
        status: 'Canceled',
        dueDate: '10 Mar 2026',
      ),
      Project(
        name: 'Customer Feedback Portal',
        lead: {
          'avatar': 'assets/images/avatar_10.jpg',
          'name': 'Sophia Martinez',
        },
        progress: 40,
        assignees: [
          {'image': 'assets/images/avatar_11.jpg', 'label': 'Olivia'},
          {'image': 'assets/images/avatar_2.jpg', 'label': 'Noah'},
        ],
        status: 'Pending',
        dueDate: '15 Apr 2026',
      ),
      Project(
        name: 'Marketing Campaign Automation',
        lead: {'avatar': 'assets/images/avatar_1.jpg', 'name': 'Mark Evans'},
        progress: 15,
        assignees: [
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Liam'},
        ],
        status: 'In Progress',
        dueDate: '22 Feb 2026',
      ),
      Project(
        name: 'Inventory Management System',
        lead: {'avatar': 'assets/images/avatar_5.jpg', 'name': 'David Roberts'},
        progress: 70,
        assignees: [
          {'image': 'assets/images/avatar_6.jpg', 'label': 'Ava'},
          {'image': 'assets/images/avatar_7.jpg', 'label': 'Ethan'},
          {'image': 'assets/images/avatar_10.jpg', 'label': 'Sophia'},
        ],
        status: 'Canceled',
        dueDate: '10 Mar 2026',
      ),
      Project(
        name: 'Marketing Campaign Automation',
        lead: {'avatar': 'assets/images/avatar_1.jpg', 'name': 'Mark Evans'},
        progress: 20,
        assignees: [
          {'image': 'assets/images/avatar_3.jpg', 'label': 'Sophia'},
          {'image': 'assets/images/avatar_4.jpg', 'label': 'Liam'},
        ],
        status: 'In Progress',
        dueDate: '22 Feb 2026',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0;
    double headerRowHeight = 44.0;
    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _projectDataSource,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        allowColumnsResizing: true,
        onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
          setState(() {
            columnWidths[details.column.columnName] = details.width;
          });
          return true;
        },
        allowSorting: true,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
        columns: [
          GridColumn(
            columnName: 'name',
            width: columnWidths['name']!,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Project Name',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'lead',
            width: columnWidths['lead']!,
            minimumWidth: 160,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Project Lead',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'progress',
            width: columnWidths['progress']!,
            minimumWidth: 110,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Progress',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'assignees',
            width: columnWidths['assignees']!,
            minimumWidth: 110,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Assignees',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'status',
            width: columnWidths['status']!,
            minimumWidth: 90,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Status',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'dueDate',
            width: columnWidths['dueDate']!,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Due Date',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectDataSource extends DataGridSource {
  ProjectDataSource({required List<Project> projects, required this.context}) {
    dataGridRows = projects
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<Map<String, String>>(
                columnName: 'lead',
                value: dataGridRow.lead,
              ),
              DataGridCell<int>(
                columnName: 'progress',
                value: dataGridRow.progress,
              ),
              DataGridCell<List<Map<String, String>>>(
                columnName: 'assignees',
                value: dataGridRow.assignees,
              ),
              DataGridCell<String>(
                columnName: 'status',
                value: dataGridRow.status,
              ),
              DataGridCell<String>(
                columnName: 'dueDate',
                value: dataGridRow.dueDate,
              ),
            ],
          ),
        )
        .toList();
  }

  final BuildContext context;
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataCell) {
        if (dataCell.columnName == 'lead') {
          final Map<String, String> lead =
              dataCell.value as Map<String, String>;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(lead['avatar']!),
                  radius: 16,
                ),
                const SizedBox(width: 0.5 * kDefaultPadding),
                Text(
                  lead['name']!,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface, // ✅ Uses context
                  ),
                ),
              ],
            ),
          );
        } else if (dataCell.columnName == 'assignees') {
          final List<Map<String, String>> assignees =
              dataCell.value as List<Map<String, String>>;
          return Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: GroupAvatarToolTip(
              items: assignees,
              avatarRadius: 16.0,
              overlapOffset: 18.0,
              maxItems: 3,
              localAvatar: true,
            ),
          );
        } else if (dataCell.columnName == 'status') {
          return Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: CustomBadge(
              kText: dataCell.value.toString(),
              kColor: _getStatusColor(dataCell.value.toString()),
              isRounded: true,
            ),
          );
        } else if (dataCell.columnName == 'progress') {
          final double progress =
              ((dataCell.value as num?)?.toDouble() ?? 0.0).clamp(0.0, 100.0) /
              100;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: LinearProgress(
                    value: progress, // ✅ Ensures valid double between 0.0 - 1.0
                    color: _getProgressColor(
                      (progress * 100),
                    ), // ✅ Uses correct color logic
                    backgroundColor: Colors.blueGrey.shade100,
                    height: 6,
                    borderRadius: BorderRadius.circular(50),
                    semanticsLabel: 'Loading progress',
                    isAnimated: true, // ✅ Keeps animation enabled
                    animationDuration: const Duration(seconds: 3),
                    curve: Curves.easeInOut,
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Text(
                  '${(progress * 100).toInt()}%', // ✅ Shows whole number percentage
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              dataCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface, // ✅ Uses context
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  // progress color helper

  Color _getProgressColor(double progress) {
    if (progress < 25) {
      return kErrorColor;
    } else if (progress < 50) {
      return kWarningColor;
    } else if (progress < 100) {
      return kSecondaryColor;
    } else {
      return kSuccessColor;
    }
  }

  // status color helper

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return kSecondaryColor;
      case 'Pending':
        return kWarningColor;
      case 'Completed':
        return kSuccessColor;
      case 'On Hold':
        return kTextColor;
      case 'Canceled':
        return kErrorColor;
      default:
        return Colors.grey;
    }
  }
}

// Data source

class Project {
  final String name;
  final Map<String, String> lead; // Contains 'avatar' and 'name'
  final int progress;
  final List<Map<String, String>> assignees;
  final String status;
  final String dueDate;

  Project({
    required this.name,
    required this.lead, // ✅ Contains {'avatar': ..., 'name': ...}
    required this.progress,
    required this.assignees,
    required this.status,
    required this.dueDate,
  });
}

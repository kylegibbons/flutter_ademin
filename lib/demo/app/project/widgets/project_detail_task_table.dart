import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_task_overview.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/image.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProjectDetailTaskTable extends StatefulWidget {
  final List<ProjectTask> tasks;
  final List<Member> members;
  final int? rowsPerPage;

  const ProjectDetailTaskTable({
    super.key,
    required this.tasks,
    required this.members,
    this.rowsPerPage,
  });

  @override
  State<ProjectDetailTaskTable> createState() => _ProjectDetailTaskTableState();
}

// Height of the DataPager widget.
final double _dataPagerHeight = 60.0;

class _ProjectDetailTaskTableState extends State<ProjectDetailTaskTable> {
  int rowsPerPage = 15;
  @override
  Widget build(BuildContext context) {
    // data source
    final dataSource = ProjectDetailTaskDataSource(
      tasks: widget.tasks,
      members: widget.members,
      rowsPerPage: rowsPerPage,
      context: context,
    );

    final themeData = Theme.of(context);

    return Card(
      child: Column(
        children: [
          // header
          CardHeader(
            kText: 'Tasks',
            // kanban view button
            kWidget: Padding(
              padding: const EdgeInsets.only(right: kDefaultPadding / 2),
              child: CustomIconButton(
                icon: Icons.view_kanban_outlined,
                iconColor: themeData.colorScheme.onSurface,
                onTap: () {},
                shape: ButtonShape.circle,
                tooltipMessage: 'Kanban View',
              ),
            ),
          ),

          SizedBox(height: kDefaultPadding),

          // task overview metrics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: TaskStatusOverview(
              tasks: widget.tasks,
              memberId: 'm1', // current user ID
            ),
          ),

          // table
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: buildDataGrid(dataSource),
          ),

          // Data pager for pagination
          SizedBox(
            height: _dataPagerHeight,
            child: SfDataPagerTheme(
              data: SfDataPagerThemeData(
                itemBorderRadius: BorderRadius.circular(defaultRadius),
                selectedItemColor: kPrimaryColor,
                itemTextStyle: const TextStyle(
                  fontSize: kBodyMedium, // Customize font size
                ),
                selectedItemTextStyle: const TextStyle(
                  fontSize: kBodyMedium,
                  fontWeight: FontWeight.w600, // Bold for active page
                  color: Colors.white, // Customize selected text color
                ),
              ),
              child: SfDataPager(
                delegate: dataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,

                pageCount: (widget.tasks.length / rowsPerPage)
                    .ceil()
                    .toDouble(),
                availableRowsPerPage: [
                  15,
                  widget.tasks.length,
                ], // Options for rows per page
                onRowsPerPageChanged: (value) {
                  if (value != null) {
                    setState(() {
                      rowsPerPage = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataGrid(ProjectDetailTaskDataSource dataSource) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row
    final mediaQueryData = MediaQuery.of(context);

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: dataSource,
        columnWidthMode: mediaQueryData.size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        allowSorting: mediaQueryData.size.width < kScreenWidthMd ? false : true,
        allowFiltering: mediaQueryData.size.width < kScreenWidthMd
            ? false
            : true,
        columns: [
          GridColumn(
            columnName: 'title',
            width: 200,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Title',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'status',
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
            columnName: 'startDate',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Start Date',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'dueDate',
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
          GridColumn(
            columnName: 'assignedTo',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Assigned To',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'tags',
            width: 240,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Tags',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'priority',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Priority',
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

// Project Task Data Source

class ProjectDetailTaskDataSource extends DataGridSource {
  final List<ProjectTask> _allTasks;
  final List<Member> _members;
  final int rowsPerPage;
  final BuildContext context;

  List<DataGridRow> _rows = [];

  ProjectDetailTaskDataSource({
    required List<ProjectTask> tasks,
    required List<Member> members,
    required this.rowsPerPage,
    required this.context,
  }) : _allTasks = tasks,
       _members = members {
    _updateRows(0); // load first page
  }

  void _updateRows(int pageIndex) {
    final startIndex = pageIndex * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage).clamp(0, _allTasks.length);

    final currentTasks = _allTasks.sublist(startIndex, endIndex);
    _rows = currentTasks.map((task) {
      final assignedTo = task.assignedMemberIds
          .map((id) {
            final member = _members.firstWhere(
              (m) => m.id == id,
              orElse: () =>
                  Member(id: '', name: 'Unknown', role: '', avatarUrl: ''),
            );
            return member.name;
          })
          .join(', ');

      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'title', value: task.title),
          DataGridCell<String>(columnName: 'status', value: task.status),
          DataGridCell<String>(
            columnName: 'startDate',
            value: DateFormat('dd MMM yyyy').format(task.startDate),
          ),
          DataGridCell<String>(
            columnName: 'dueDate',
            value: DateFormat('dd MMM yyyy').format(task.dueDate),
          ),
          DataGridCell<String>(columnName: 'assignedTo', value: assignedTo),
          DataGridCell<List>(columnName: 'tags', value: task.tags),
          DataGridCell<String>(columnName: 'priority', value: task.priority),
        ],
      );
    }).toList();

    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == 'assignedTo') {
          // Get the assigned member IDs from the cell value
          final assignedMemberNames = cell.value?.toString().split(', ') ?? [];
          final assignedMembers = _members
              .where((member) => assignedMemberNames.contains(member.name))
              .toList();

          return Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: AssigneeAvatarStack(
              assignees: assignedMembers,
              localImg: true,
            ),
          );
        } else if (cell.columnName == 'status') {
          final status = cell.value.toString().toTaskStatus();

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: CustomBadge(
              kText: status.label,
              kColor: status.color,
              isRounded: true,
            ),
          );
        } else if (cell.columnName == 'tags') {
          final List tags = cell.value ?? [];

          return Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: Wrap(
              spacing: kDefaultPadding / 8,
              runSpacing: kDefaultPadding / 4,
              children: tags.map<Widget>((tag) {
                return CustomBadge(
                  kText: tag.toString(),
                  kColor: themeData.colorScheme.onSurface,
                  isSoft: true,
                  isRounded: true,
                );
              }).toList(),
            ),
          );
        } else if (cell.columnName == 'priority') {
          final priority = cell.value.toString().toPriority();

          return Center(
            child: CustomBadge(
              kText: priority.label,
              kColor: priority.color,
              isOutlined: true,
              isRounded: true,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                cell.value.toString(),
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updateRows(newPageIndex);
    return true;
  }
}

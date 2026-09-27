import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_data.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';
import 'package:flutkit_ademin/demo/app/task/dialogs/add_task_form.dart';
import 'package:flutkit_ademin/demo/app/task/dialogs/view_task.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/animation/animation.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/image.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TaskListTable extends StatefulWidget {
  final List<ProjectTask> tasks;
  final List<Member> members;
  final int? rowsPerPage;

  const TaskListTable({
    super.key,
    required this.tasks,
    required this.members,
    this.rowsPerPage,
  });

  @override
  State<TaskListTable> createState() => _TaskListTableState();
}

// helper for opening the add-task dialog from the screen level
void _showAddTaskDialog(BuildContext context) async {
  final result = await showDialog<TaskFormData>(
    context: context,
    builder: (BuildContext context) {
      return const AddTaskDialog();
    },
  );

  if (result != null) {
    // After creating task show the view dialog with same data
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (ctx) => ViewTaskDialog(taskData: result),
    );

    // Note: the board widget itself handles inserting new tasks into the groups
    // via its own _showAddTaskDialog method. This screen-level helper is only
    // used for the toolbar button which doesn't have direct access to the
    // board's controller.
  }
}

// Height of the DataPager widget.
final double _dataPagerHeight = 60.0;

// Returns icon based on task status

class _TaskListTableState extends State<TaskListTable> {
  int rowsPerPage = 15;
  @override
  Widget build(BuildContext context) {
    // data source
    final dataSource = ProjectTaskDataSource(
      tasks: widget.tasks,
      members: widget.members,
      rowsPerPage: rowsPerPage,
      context: context,
    );
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;

    return Column(
      children: [
        TaskStatusSummary(
          tasks: widget.tasks,
          memberId: 'm1', // current user ID
        ),
        SizedBox(height: kDefaultPadding),
        Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  children: [
                    // new task
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kErrorColor,
                            tooltipMessage: 'New Task',
                            onTap: () {
                              _showAddTaskDialog(context);
                            },
                          )
                        : FlatButton(
                            kText: 'New Task',
                            bgColor: kErrorColor,
                            kTextColor: Colors.white,
                            kLeadingIcon: Icons.add_outlined,
                            onPressed: () {
                              _showAddTaskDialog(context);
                            },
                          ),

                    Spacer(),

                    // search bar
                    SizedBox(
                      width: 240,
                      child: SoftSearchBar(hintText: 'Search tasks'),
                    ),
                  ],
                ),
              ),

              SizedBox(child: buildDataGrid(dataSource)),

              // Data pager for pagination
              SizedBox(
                height: _dataPagerHeight,
                child: SfDataPagerTheme(
                  data: SfDataPagerThemeData(
                    itemTextStyle: const TextStyle(
                      fontSize: kBodyMedium, // Customize font size
                    ),
                    selectedItemTextStyle: const TextStyle(
                      fontSize: kBodyMedium,
                      fontWeight: FontWeight.w600, // Bold for active page
                      color: Colors.white, // Customize selected text color
                    ),
                    selectedItemColor: kPrimaryColor, // Active page background
                    itemBorderRadius: BorderRadius.circular(defaultRadius),
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
        ),
      ],
    );
  }

  Widget buildDataGrid(ProjectTaskDataSource dataSource) {
    double rowHeight = tableRowHeight; // Height per row
    double headerRowHeight = tableHeaderRowHeight; // Height of the header row
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: ClipRect(
        clipper: CustomLeftClipper(),
        child: SfDataGrid(
          source: dataSource,
          allowSorting: isMobile ? false : true,
          columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
              ? ColumnWidthMode.none
              : ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.horizontal,
          headerGridLinesVisibility: GridLinesVisibility.horizontal,
          rowHeight: rowHeight,
          headerRowHeight: headerRowHeight,
          shrinkWrapRows: true,
          allowFiltering: true,
          verticalScrollPhysics: NeverScrollableScrollPhysics(),
          onCellTap: (DataGridCellTapDetails details) {
            final rowIndex = details.rowColumnIndex.rowIndex;

            // Skip header row (rowIndex 0)
            if (rowIndex == 0) return;

            final pageIndex = dataSource._currentPageIndex;
            // Subtract 1 to account for header row offset
            final globalIndex = pageIndex * rowsPerPage + (rowIndex - 1);

            if (globalIndex < dataSource._allTasks.length) {
              final task = dataSource._allTasks[globalIndex];
              final assignees = task.assignedMemberIds
                  .map((id) {
                    final member = widget.members.firstWhere(
                      (m) => m.id == id,
                      orElse: () => Member(
                        id: '',
                        name: 'Unknown',
                        role: '',
                        avatarUrl: '',
                      ),
                    );
                    return member.name;
                  })
                  .where((name) => name.isNotEmpty)
                  .toList();

              final taskData = TaskFormData(
                title: task.title,
                description: task.description,
                startDate: DateFormat(
                  'EEEE, d MMMM yyyy',
                ).format(task.startDate),
                dueDate: DateFormat('EEEE, d MMMM yyyy').format(task.dueDate),
                priority: task.priority,
                status: task.status,
                assignees: assignees,
                tags: task.tags,
                checklist: task.checklistIds
                    .map((id) {
                      final item = mockProjectDatas.checklists.firstWhere(
                        (c) => c.id == id,
                        orElse: () => ProjectChecklistItem(
                          id: '',
                          title: 'Unknown',
                          isDone: false,
                        ),
                      );
                      return TaskChecklistItemData(
                        id: item.id,
                        title: item.title,
                        isDone: item.isDone,
                      );
                    })
                    .where((item) => item.title.isNotEmpty)
                    .toList(),
                attachments: task.attachmentIds.map((id) {
                  final attachment = mockProjectDatas.attachments.firstWhere(
                    (a) => a.id == id,
                    orElse: () => ProjectAttachment(
                      id: '',
                      name: 'Unknown',
                      url: '',
                      fileType: '',
                      fileSize: 0,
                      uploadedAt: DateTime.now(),
                    ),
                  );
                  return attachment.url.isNotEmpty
                      ? attachment.url
                      : attachment.name;
                }).toList(),
                activities: task.activityIds.map((id) {
                  final activity = mockProjectDatas.activities.firstWhere(
                    (a) => a.id == id,
                    orElse: () => ProjectActivity(
                      id: '',
                      type: '',
                      description: 'Unknown activity',
                      memberId: '',
                      timestamp: DateTime.now(),
                    ),
                  );
                  return activity.description;
                }).toList(),
                discussions: task.discussionIds.map((id) {
                  final discussion = mockProjectDatas.discussions.firstWhere(
                    (d) => d.id == id,
                    orElse: () => ProjectDiscussion(
                      id: '',
                      taskId: '',
                      memberId: '',
                      message: 'Unknown discussion',
                      createdAt: DateTime.now(),
                    ),
                  );
                  return discussion.message;
                }).toList(),
                activityEntries: task.activityIds.map((id) {
                  final activity = mockProjectDatas.activities.firstWhere(
                    (a) => a.id == id,
                    orElse: () => ProjectActivity(
                      id: '',
                      type: '',
                      description: 'Unknown activity',
                      memberId: '',
                      timestamp: DateTime.now(),
                    ),
                  );
                  final member = mockProjectDatas.members.firstWhere(
                    (m) => m.id == activity.memberId,
                    orElse: () => Member(
                      id: '',
                      name: 'Unknown',
                      role: '',
                      avatarUrl: '',
                    ),
                  );
                  return TaskLogEntryData(
                    text: activity.description,
                    timestamp: activity.timestamp,
                    memberName: member.name,
                    memberAvatarUrl: member.avatarUrl,
                  );
                }).toList(),
                discussionEntries: task.discussionIds.map((id) {
                  final discussion = mockProjectDatas.discussions.firstWhere(
                    (d) => d.id == id,
                    orElse: () => ProjectDiscussion(
                      id: '',
                      taskId: '',
                      memberId: '',
                      message: 'Unknown discussion',
                      createdAt: DateTime.now(),
                    ),
                  );
                  final member = mockProjectDatas.members.firstWhere(
                    (m) => m.id == discussion.memberId,
                    orElse: () => Member(
                      id: '',
                      name: 'Unknown',
                      role: '',
                      avatarUrl: '',
                    ),
                  );
                  return TaskLogEntryData(
                    text: discussion.message,
                    timestamp: discussion.createdAt,
                    memberName: member.name,
                    memberAvatarUrl: member.avatarUrl,
                  );
                }).toList(),
              );

              // opening view task dialog

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ViewTaskDialog(taskData: taskData);
                },
              );
            }
          },
          columns: [
            GridColumn(
              columnName: 'title',
              label: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Title',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              minimumWidth: 200,
            ),
            GridColumn(
              columnName: 'status',
              label: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Status',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              minimumWidth: 120,
            ),
            GridColumn(
              columnName: 'startDate',
              label: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
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
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
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
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Assigned To',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'tags',
              label: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tags',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              minimumWidth: 180,
            ),
            GridColumn(
              columnName: 'priority',
              label: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Priority',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              minimumWidth: 120,
              maximumWidth: 120,
            ),
          ],
        ),
      ),
    );
  }
}

// Task Table Data Source

class ProjectTaskDataSource extends DataGridSource {
  final List<ProjectTask> _allTasks;
  final List<Member> _members;
  final int rowsPerPage;
  final BuildContext context;
  int _currentPageIndex = 0;

  List<DataGridRow> _rows = [];

  ProjectTaskDataSource({
    required List<ProjectTask> tasks,
    required this._members,
    required this.rowsPerPage,
    required this.context,
  }) : _allTasks = tasks {
    _updateRows(0); // load first page
  }

  void _updateRows(int pageIndex) {
    _currentPageIndex = pageIndex;
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

          return Center(
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
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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

class TaskStatusSummary extends StatelessWidget {
  final List<ProjectTask> tasks;
  final String memberId;

  const TaskStatusSummary({
    required this.tasks,
    required this.memberId,
    super.key,
  });

  Map<TaskStatus, int> getTaskCountByStatus(List<ProjectTask> tasks) {
    return _countByStatus(tasks);
  }

  Map<TaskStatus, int> getMyTaskCountByStatus(
    List<ProjectTask> tasks,
    String memberId,
  ) {
    return _countByStatus(tasks, memberId: memberId);
  }

  Map<TaskStatus, int> _countByStatus(
    List<ProjectTask> tasks, {
    String? memberId,
  }) {
    final counts = {for (final status in statusOrder) status: 0};

    for (final task in tasks) {
      if (memberId != null && !task.assignedMemberIds.contains(memberId)) {
        continue;
      }

      final status = task.status.toTaskStatus();
      counts[status] = (counts[status] ?? 0) + 1;
    }

    return counts;
  }

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxl) return 5;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final totalByStatus = getTaskCountByStatus(tasks);
    final myByStatus = getMyTaskCountByStatus(tasks, memberId);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);

    return GridView.builder(
      shrinkWrap: true, // Ensures it takes only the space it needs
      physics:
          const NeverScrollableScrollPhysics(), // Disable scroll if inside another scroll view
      itemCount: statusOrder.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        mainAxisExtent: 120,
      ),
      itemBuilder: (context, index) {
        final status = statusOrder[index];
        return TaskStatusCard(
          label: status.label,
          totalCount: totalByStatus[status] ?? 0,
          myCount: myByStatus[status] ?? 0,
          color: status.color,
          icon: Icon(status.icon, color: status.iconColor),
        );
      },
    );
  }
}

// status card

class TaskStatusCard extends StatelessWidget {
  final String label;
  final int totalCount;
  final int myCount;
  final Color color;
  final Icon icon;

  const TaskStatusCard({
    required this.label,
    required this.totalCount,
    required this.myCount,
    required this.color,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
                  Spacer(flex: 2),

                  // task count
                  Row(
                    children: [
                      Text(
                        '$totalCount ',
                        style: TextStyle(
                          fontSize: kHeadlineSmall,
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: kHeadlineSmall,
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),

                  // my tasks
                  Row(
                    children: [
                      Text(
                        'My Tasks: ',
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                      Text(
                        myCount.toString(),
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          fontWeight: FontWeight.w500,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.1),
                radius: 28,
                child: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

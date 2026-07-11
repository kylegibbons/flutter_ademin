import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/app/task/widgets/task_gantt_chart.dart';
import 'package:flutter_ademin/demo/app/task/widgets/task_gantt_summary.dart';
import 'package:flutter_ademin/demo/app/task/widgets/task_gantt_toolbar.dart';
import 'package:flutter_gantt/flutter_gantt.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/task/dialogs/view_task.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:intl/intl.dart';

class TaskGanttChartScreen extends StatefulWidget {
  const TaskGanttChartScreen({super.key});

  @override
  State<TaskGanttChartScreen> createState() => _TaskGanttChartScreenState();
}

class _TaskGanttChartScreenState extends State<TaskGanttChartScreen> {
  final ProjectDetails project = mockProjectDatas;
  late final GanttController _ganttController;
  late final List<GanttActivity> _ganttActivities;
  GanttTimelineView _selectedTimelineView = GanttTimelineView.month;

  @override
  void initState() {
    super.initState();
    _ganttController = GanttController(
      startDate: project.startDate,
      daysViews: 30,
    );
    _ganttActivities = project.tasks.map(_toGanttActivity).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updatePageTitle('Task Gantt Chart | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    _ganttController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          PageHeader(
            title: 'TASK GANTT CHART',
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: 'Task Gantt Chart', uri: ''),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // task summary
                TaskGanttSummary(project: project),
                const SizedBox(height: kDefaultPadding),

                // gantt chart
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      // header + toolbar
                      CardHeader(
                        kText: 'Project Timeline',
                        kWidget: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: kDefaultPadding,
                          ),
                          child: GanttToolbar(
                            controller: _ganttController,
                            selectedView: _selectedTimelineView,
                            taskCount: project.tasks.length,
                            onAutoFit: _autoFitTimeline,
                            onViewChanged: _applyTimelineView,
                          ),
                        ),
                      ),

                      //  chart
                      TaskGanttChart(
                        controller: _ganttController,
                        activities: _ganttActivities,
                        milestones: project.milestones,
                        selectedView: _selectedTimelineView,
                        onTaskChanged: _handleActivityChanged,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const PortalFooter(),
        ],
      ),
    );
  }

  double _taskProgress(ProjectTask task, ProjectDetails project) {
    if (task.status.toTaskStatus() == TaskStatus.completed) return 100;
    if (task.progress != null) return task.progress!.clamp(0, 100).toDouble();
    return task
        .progressFromChecklists(project.checklists)
        .clamp(0, 100)
        .toDouble();
  }

  void _autoFitTimeline() {
    final startDate = _timelineStartDate;
    final endDate = _timelineEndDate;

    setState(() {
      _ganttController.startDate = startDate;
      _ganttController.daysViews = endDate.difference(startDate).inDays + 1;
      _ganttController.update();
    });
  }

  void _applyTimelineView(GanttTimelineView view) {
    setState(() {
      _selectedTimelineView = view;
      _ganttController.daysViews = view.days;
      _ganttController.update();
    });
  }

  DateTime get _timelineStartDate {
    final dates = [
      project.startDate,
      ...project.tasks.map((task) => task.startDate),
      ...project.milestones.map((milestone) => milestone.dueDate),
    ];
    return DateUtils.dateOnly(dates.reduce((a, b) => a.isBefore(b) ? a : b));
  }

  DateTime get _timelineEndDate {
    final dates = [
      project.endDate,
      ...project.tasks.map((task) => task.dueDate),
      ...project.milestones.map((milestone) => milestone.dueDate),
    ];
    return DateUtils.dateOnly(dates.reduce((a, b) => a.isAfter(b) ? a : b));
  }

  GanttActivity _toGanttActivity(ProjectTask task) {
    final status = task.status.toTaskStatus();
    final progress = _taskProgress(task, project);

    return GanttActivity(
      key: task.id,
      start: task.startDate,
      end: task.dueDate,
      title: task.title,
      tooltip:
          '${task.title}\n${DateFormat('dd MMM yyyy').format(task.startDate)} - ${DateFormat('dd MMM yyyy').format(task.dueDate)}\nProgress ${progress.toStringAsFixed(0)}%',
      color: status.color,
      onCellTap: (_) => _showTaskDetail(task),
      actions: [
        GanttActivityAction(
          icon: Icons.visibility_outlined,
          iconSize: 14,
          iconColor: kTextColor,
          tooltip: 'View task',
          onTap: () => _showTaskDetail(task),
        ),
      ],
    );
  }

  void _handleActivityChanged(
    GanttActivity activity,
    DateTime? start,
    DateTime? end,
  ) {
    if (start != null) activity.start = start;
    if (end != null) activity.end = end;
    _ganttController.update();
  }

  void _showTaskDetail(ProjectTask task) {
    showDialog(
      context: context,
      builder: (context) => ViewTaskDialog(taskData: _toTaskFormData(task)),
    );
  }

  TaskFormData _toTaskFormData(ProjectTask task) {
    final memberById = {
      for (final member in project.members) member.id: member,
    };

    final assigneeNames = task.assignedMemberIds
        .map((id) => memberById[id]?.name)
        .whereType<String>()
        .toList();

    final checklistItems = project.checklists
        .where((item) => task.checklistIds.contains(item.id))
        .map(
          (item) => TaskChecklistItemData(
            id: item.id,
            title: item.title,
            isDone: item.isDone,
          ),
        )
        .toList();

    final attachmentNames = project.attachments
        .where((attachment) => task.attachmentIds.contains(attachment.id))
        .map((attachment) => attachment.name)
        .toList();

    final activityEntries = project.activities
        .where((activity) => task.activityIds.contains(activity.id))
        .map((activity) {
          final member = memberById[activity.memberId];
          return TaskLogEntryData(
            text: '${activity.type}: ${activity.description}',
            timestamp: activity.timestamp,
            memberName: member?.name ?? 'Activity',
            memberAvatarUrl: member?.avatarUrl ?? '',
          );
        })
        .toList();

    final discussionEntries = project.discussions
        .where((discussion) => task.discussionIds.contains(discussion.id))
        .map((discussion) {
          final member = memberById[discussion.memberId];
          return TaskLogEntryData(
            text: discussion.message,
            timestamp: discussion.createdAt,
            memberName: member?.name ?? 'Comment',
            memberAvatarUrl: member?.avatarUrl ?? '',
          );
        })
        .toList();

    return TaskFormData(
      title: task.title,
      description: task.description,
      startDate: DateFormat('EEEE, d MMMM yyyy').format(task.startDate),
      dueDate: DateFormat('EEEE, d MMMM yyyy').format(task.dueDate),
      priority: task.priority,
      status: task.status,
      assignees: assigneeNames,
      tags: task.tags,
      checklist: checklistItems,
      attachments: attachmentNames,
      activities: activityEntries.map((entry) => entry.text).toList(),
      discussions: discussionEntries.map((entry) => entry.text).toList(),
      activityEntries: activityEntries,
      discussionEntries: discussionEntries,
    );
  }
}

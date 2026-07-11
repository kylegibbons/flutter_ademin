import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/task/dialogs/add_task_form.dart';
import 'package:flutter_ademin/demo/app/task/dialogs/view_task.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/image.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:intl/intl.dart';

class TaskKanbarBoard extends StatefulWidget {
  const TaskKanbarBoard({super.key});

  @override
  State<TaskKanbarBoard> createState() => _TaskKanbarBoardState();
}

class _TaskKanbarBoardState extends State<TaskKanbarBoard> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
    onMoveGroupItem: (groupId, fromIndex, toIndex) {},
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
  );

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();

    // Get data from mockProjectDatas.tasks
    final tasks = mockProjectDatas.tasks;

    final Set<TaskStatus> availableStatuses = tasks
        .map((task) => task.status.toTaskStatus())
        .toSet();

    // Loop according to statusOrder order, only if status is in data
    for (final status in statusOrder) {
      if (availableStatuses.contains(status)) {
        final group = AppFlowyGroupData(
          id: status.key,
          name: status.key,
          items: List<AppFlowyGroupItem>.from(
            tasks
                .where((task) => task.status.toTaskStatus() == status)
                .map((task) => ProjectTaskItem(task))
                .toList(),
          ),
        );
        controller.addGroup(group);
      }
    }
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  // add task card dialog

  void _showAddCardDialog(BuildContext context) async {
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

      // Optionally convert result to ProjectTask and insert it to board list.
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: themeData.scaffoldBackgroundColor,
      stretchGroupHeight: false,
      boardCornerRadius: defaultRadius,
    );
    return Scrollbar(
      thumbVisibility: true,
      interactive: true,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 1.5 * kDefaultPadding,
        ),
        child: AppFlowyBoard(
          controller: controller,
          leading: SizedBox(width: kDefaultPadding),
          trailing: SizedBox(width: kDefaultPadding),
          cardBuilder: (context, group, groupItem) {
            debugPrint('Item type: ${groupItem.runtimeType}');
            if (groupItem is ProjectTaskItem) {
              return AppFlowyGroupCard(
                key: ValueKey(groupItem.task.id),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color: themeData.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 0.5,
                      blurRadius: 0.9,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: _buildTaskCard(groupItem.task),
              );
            }

            // Placeholder fallback
            return const AppFlowyGroupCard(child: SizedBox.shrink());
          },
          boardScrollController: boardController,
          footerBuilder: (context, columnData) {
            return AppFlowyGroupFooter(
              icon: const Icon(Icons.add, size: 20),
              title: const Text('Add a card'),
              height: 54,
              margin: config.groupBodyPadding,
              onAddButtonClick: () {
                // Open a dialog with a form to create a new ProjectTask
                _showAddCardDialog(context);
              },
            );
          },
          headerBuilder: (context, columnData) {
            final int taskCount =
                controller
                    .getGroupController(columnData.headerData.groupId)
                    ?.items
                    .length ??
                0;

            final status = columnData.headerData.groupName.toTaskStatus();

            return AppFlowyGroupHeader(
              title: Expanded(
                child: Row(
                  children: [
                    Text(
                      status.label.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding / 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 2,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: status.color,
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      child: Text(
                        '$taskCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: kBodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // addIcon: const Icon(Icons.add, size: 20),
              moreIcon: CustomPopupMenu<String>(
                onSelected: (value) => debugPrint('Selected: $value'),
                items: [
                  //  menu
                  PopupMenuItemData(
                    value: 'copy',
                    text: 'Copy list',
                    icon: Icons.copy_outlined,
                  ),

                  PopupMenuItemData(
                    value: 'move',
                    text: 'Move list',
                    icon: Icons.arrow_forward,
                  ),
                  PopupMenuItemData(
                    value: 'watch',
                    text: 'Watch',
                    icon: Icons.visibility_outlined,
                  ),

                  PopupMenuItemData(
                    value: 'archive',
                    text: 'Archive list',
                    icon: Icons.delete_outline,
                    iconColor: kErrorColor,
                    textStyle: TextStyle(color: kErrorColor),
                  ),
                ],

                // icon
                icon: Icons.more_vert,
              ),

              height: 48,
              margin: config.groupBodyPadding,
            );
          },
          groupConstraints: const BoxConstraints.tightFor(width: 320),
          config: config,
        ),
      ),
    );
  }

  Widget _buildTaskCard(ProjectTask task) {
    final themeData = Theme.of(context);
    final taskProgress = task.progressFromChecklists(
      mockProjectDatas.checklists,
    );
    final assignedMembers = mockProjectDatas.members
        .where((m) => task.assignedMemberIds.contains(m.id))
        .toList();
    final priority = task.priority.toPriority();

    return InkWell(
      onTap: () {
        // Convert ProjectTask to TaskFormData
        final assigneeNames = task.assignedMemberIds
            .map(
              (id) =>
                  mockProjectDatas.members.firstWhere((m) => m.id == id).name,
            )
            .toList();

        // resolve related entities for view
        final checklistItems = mockProjectDatas.checklists
            .where((c) => task.checklistIds.contains(c.id))
            .map(
              (c) => TaskChecklistItemData(
                id: c.id,
                title: c.title,
                isDone: c.isDone,
              ),
            )
            .toList();

        final attachmentNames = mockProjectDatas.attachments
            .where((a) => task.attachmentIds.contains(a.id))
            .map((a) => a.name)
            .toList();

        final activityList = mockProjectDatas.activities
            .where((a) => task.activityIds.contains(a.id))
            .map((a) => '${a.type}: ${a.description}')
            .toList();
        final activityEntries = mockProjectDatas.activities
            .where((a) => task.activityIds.contains(a.id))
            .map((a) {
              final member = mockProjectDatas.members.firstWhere(
                (m) => m.id == a.memberId,
              );
              return TaskLogEntryData(
                text: '${a.type}: ${a.description}',
                timestamp: a.timestamp,
                memberName: member.name,
                memberAvatarUrl: member.avatarUrl,
              );
            })
            .toList();

        final discussionList = mockProjectDatas.discussions
            .where((d) => task.discussionIds.contains(d.id))
            .map((d) {
              final member = mockProjectDatas.members.firstWhere(
                (m) => m.id == d.memberId,
              );
              return '${member.name}: ${d.message}';
            })
            .toList();
        final discussionEntries = mockProjectDatas.discussions
            .where((d) => task.discussionIds.contains(d.id))
            .map((d) {
              final member = mockProjectDatas.members.firstWhere(
                (m) => m.id == d.memberId,
              );
              return TaskLogEntryData(
                text: d.message,
                timestamp: d.createdAt,
                memberName: member.name,
                memberAvatarUrl: member.avatarUrl,
              );
            })
            .toList();

        final taskFormData = TaskFormData(
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
          activities: activityList,
          discussions: discussionList,
          activityEntries: activityEntries,
          discussionEntries: discussionEntries,
        );

        // Buka ViewTaskDialog dengan data
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ViewTaskDialog(taskData: taskFormData);
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // task title
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: kBodyMedium + 1,
                      color: themeData.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.more_horiz_outlined),
              ],
            ),
          ),

          // task description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              task.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // progress
                Tooltip(
                  message: 'Progress',
                  preferBelow: false,
                  child: Text(
                    '${taskProgress.toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // due date
                Tooltip(
                  message: 'Due Date',
                  preferBelow: false,
                  child: Text(DateFormat('dd MMM, yyyy').format(task.dueDate)),
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 3),

          // linear progress indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: LinearProgress(
              value: taskProgress / 100,
              color: kSuccessColor,
              backgroundColor: Colors.blueGrey.shade50,
              height: 6,
              borderRadius: BorderRadius.circular(defaultRadius),
              semanticsLabel: 'Loading progress',
              isAnimated: true, // set animation to true
              animationDuration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // priority
                Tooltip(
                  message: 'Priority',
                  preferBelow: false,
                  child: CustomBadge(
                    kText: priority.label,
                    kColor: priority.color,
                    isRounded: true,
                    isSoft: true,
                  ),
                ),

                // assignee avatar
                AssigneeAvatarStack(
                  assignees: assignedMembers,
                  size: 28,
                  localImg: true,
                ),
              ],
            ),
          ),

          SizedBox(height: kDefaultPadding),
          Divider(height: 0, color: Colors.blueGrey.shade50),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Task Id
                Tooltip(
                  message: 'Task ID',
                  preferBelow: false,
                  child: Text(
                    '#${task.id.toUpperCase()}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                Spacer(),
                // discussion
                Icon(Icons.forum_outlined, size: 16),
                SizedBox(width: kDefaultPadding / 4),

                Text(
                  task.discussionCount.toString(),
                  style: TextStyle(fontSize: kBodySmall),
                ),
                SizedBox(width: kDefaultPadding / 2),

                // attachment
                Icon(Icons.attach_file_outlined, size: 16),
                SizedBox(width: kDefaultPadding / 4),

                Text(
                  task.attachmentCount.toString(),
                  style: TextStyle(fontSize: kBodySmall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Wrapper so that ProjectTask can be an item on AppFlowyBoard
class ProjectTaskItem extends AppFlowyGroupItem {
  final ProjectTask task;

  ProjectTaskItem(this.task);

  @override
  String get id => task.id;
}

// HexColor extension remains as before
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:intl/intl.dart';

class ProjectDetailHeader extends StatelessWidget {
  const ProjectDetailHeader({super.key, required this.project});

  final ProjectDetails project;

  String _formatDate(DateTime date) => DateFormat.yMMMd().format(date);

  String _formatProgress(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
    final completedTasks = project.tasks
        .where((task) => task.status.toTaskStatus() == TaskStatus.completed)
        .length;
    final totalTasks = project.tasks.length;
    final openTasks = totalTasks - completedTasks;
    final progress = totalTasks == 0 ? 0.0 : completedTasks / totalTasks * 100;
    final progressText = _formatProgress(progress);
    final priority = project.priority.toPriority();
    final status = project.status.toTaskStatus();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                project.title,
                style: TextStyle(
                  fontSize: isMobile ? kTitleMedium : kTitleLarge,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Row(
              children: [
                isMobile
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: kDefaultPadding,
                        ),
                        child: CustomIconButton(
                          icon: Icons.add,
                          buttonColor: kInfoColor,
                          iconColor: Colors.white,
                          onTap: () {},
                        ),
                      )
                    : FlatButton(
                        kLeadingIcon: Icons.add,
                        kText: 'New Task',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),
                const SizedBox(width: kDefaultPadding),
                const _ProjectActionsDropdown(),
              ],
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding / 2),
        Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.group_outlined,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
                const SizedBox(width: kDefaultPadding / 4),
                Text(
                  project.client,
                  style: const TextStyle(
                    fontSize: kBodyMedium,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            _HeaderDateItem(
              label: 'Start Date: ',
              value: _formatDate(project.startDate),
            ),
            _HeaderDateItem(
              label: 'Dute Date: ',
              value: _formatDate(project.endDate),
            ),
            CustomBadge(
              kText: priority.label,
              kColor: priority.color,
              kFontSize: kLabelMedium,
              isRounded: true,
            ),
            CustomBadge(
              kText: status.label,
              kColor: status.color,
              kFontSize: kLabelMedium,
              isRounded: true,
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Project Progress: ',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.75)),
            ),
            Text('$progressText%', style: const TextStyle(color: Colors.white)),
            const Spacer(),
            Text(
              '$openTasks/$totalTasks',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              ' Open Tasks',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.75)),
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding / 2),
        LinearProgress(
          value: progress / 100,
          color: kSuccessColor,
          backgroundColor: Colors.white,
          height: 10,
          borderRadius: BorderRadius.circular(50),
          semanticsLabel: 'Loading progress',
          isAnimated: true,
          animationDuration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}

class _HeaderDateItem extends StatelessWidget {
  const _HeaderDateItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: kBodyMedium,
            color: Colors.white.withValues(alpha: 0.75),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: kBodyMedium,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProjectActionsDropdown extends StatelessWidget {
  const _ProjectActionsDropdown();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return PopupMenuButton<_ProjectAction>(
      onSelected: (action) {
        switch (action) {
          case _ProjectAction.pin:
            break;
          case _ProjectAction.edit:
            break;
          case _ProjectAction.copy:
            break;
          case _ProjectAction.notStarted:
            break;
          case _ProjectAction.onHold:
            break;
          case _ProjectAction.cancelled:
            break;
          case _ProjectAction.finished:
            break;
          case _ProjectAction.export:
            break;
          case _ProjectAction.viewAsCustomer:
            break;
          case _ProjectAction.delete:
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: _ProjectAction.pin,
          child: Text('Pin Project'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.edit,
          child: Text('Edit Project'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.copy,
          child: Text('Copy Project'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: _ProjectAction.notStarted,
          child: Text('Mark as Not Started'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.onHold,
          child: Text('Mark as On Hold'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.cancelled,
          child: Text('Mark as Cancelled'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.finished,
          child: Text('Mark as Finished'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: _ProjectAction.export,
          child: Text('Export project data'),
        ),
        const PopupMenuItem(
          value: _ProjectAction.viewAsCustomer,
          child: Text('View project as customer'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: _ProjectAction.delete,
          child: Text('Delete Project', style: TextStyle(color: kErrorColor)),
        ),
      ],
      child: isMobile
          ? CustomIconButton(
              icon: Icons.more_vert,
              iconColor: themeData.colorScheme.onSurface,
              buttonColor: themeData.colorScheme.surfaceContainerHighest,
            )
          : Container(
              height: mediumHeight,
              padding: const EdgeInsetsDirectional.only(
                start: kDefaultPadding,
                end: kDefaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: themeData.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Row(
                children: [
                  Text(
                    'More',
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: themeData.colorScheme.onSurface,
                  ),
                ],
              ),
            ),
    );
  }
}

enum _ProjectAction {
  pin,
  edit,
  copy,
  notStarted,
  onHold,
  cancelled,
  finished,
  export,
  viewAsCustomer,
  delete,
}

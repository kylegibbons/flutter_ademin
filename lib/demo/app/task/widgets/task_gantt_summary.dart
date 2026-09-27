import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/progress.dart';
import 'package:intl/intl.dart';

class TaskGanttSummary extends StatelessWidget {
  final ProjectDetails project;

  const TaskGanttSummary({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final completedTasks = project.tasks
        .where((task) => task.status.toTaskStatus() == TaskStatus.completed)
        .length;
    final progress = project.tasks.isEmpty
        ? 0.0
        : completedTasks / project.tasks.length;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ResponsiveWrap(
          spacing: 2 * kDefaultPadding,
          runSpacing: kDefaultPadding,
          columnRatios: [1 / 4, 3 / 4],
          breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
          useScreenWidth: true,
          crossAlignment: WrapCrossAlignment.center,
          children: [
            // title + client
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontSize: kTitleMedium,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Text(
                  project.client,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ResponsiveWrap(
              spacing: 2 * kDefaultPadding,
              runSpacing: kDefaultPadding,
              columnRatios: [2 / 9, 2 / 9, 2 / 9, 1 / 3],
              breakpoints: {
                kScreenWidthXl: 1,
                kScreenWidthXxl: 2,
                kScreenWidthXxxl: 4,
              },
              useScreenWidth: true,
              crossAlignment: WrapCrossAlignment.center,
              children: [
                // start date
                _SummaryMetric(
                  label: 'Start Date',
                  value: DateFormat('dd MMM yyyy').format(project.startDate),
                  icon: Icons.play_circle_outline,
                ),

                // end date
                _SummaryMetric(
                  label: 'End Date',
                  value: DateFormat('dd MMM yyyy').format(project.endDate),
                  icon: Icons.flag_outlined,
                ),

                // milestone
                _SummaryMetric(
                  label: 'Milestones',
                  value: '${project.milestones.length}',
                  icon: Icons.timeline_outlined,
                ),

                // tasks progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Completed Tasks',
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: kBodyMedium,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' ($completedTasks / ${project.tasks.length} tasks)',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                            fontSize: kBodySmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    LinearProgress(
                      value: progress,
                      color: kSuccessColor,
                      height: 12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// summary metric widget

class _SummaryMetric extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: themeData.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Icon(icon, color: themeData.colorScheme.primary, size: 20),
        ),
        const SizedBox(width: kDefaultPadding / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: kTextColor,
                fontSize: kBodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontSize: kBodyMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

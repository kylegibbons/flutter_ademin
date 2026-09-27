import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';

class TaskStatusOverview extends StatelessWidget {
  final List<ProjectTask> tasks;
  final String memberId;
  final bool isGrid;

  const TaskStatusOverview({
    required this.tasks,
    required this.memberId,
    this.isGrid = true,
    super.key,
  });

  Map<TaskStatus, int> getTaskCountByStatus(List<ProjectTask> tasks) {
    final Map<TaskStatus, int> statusCounts = {};
    for (final status in statusOrder) {
      statusCounts[status] = tasks
          .where((task) => task.status.toTaskStatus() == status)
          .length;
    }
    return statusCounts;
  }

  Map<TaskStatus, int> getMyTaskCountByStatus(
    List<ProjectTask> tasks,
    String memberId,
  ) {
    final Map<TaskStatus, int> myCounts = {};
    for (final status in statusOrder) {
      myCounts[status] = tasks
          .where(
            (task) =>
                task.status.toTaskStatus() == status &&
                task.assignedMemberIds.contains(memberId),
          )
          .length;
    }
    return myCounts;
  }

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXl) return 5;
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

    return isGrid
        ? GridView.builder(
            shrinkWrap: true, // Ensures it takes only the space it needs
            physics:
                const NeverScrollableScrollPhysics(), // Disable scroll if inside another scroll view
            itemCount: statusOrder.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: kDefaultPadding,
              mainAxisSpacing: kDefaultPadding,
              mainAxisExtent: 74,
            ),
            itemBuilder: (context, index) {
              final status = statusOrder[index];
              return TaskStatusCard(
                label: status.label,
                totalCount: totalByStatus[status] ?? 0,
                myCount: myByStatus[status] ?? 0,
                color: status.color,
              );
            },
          )
        : ListView.builder(
            shrinkWrap:
                true, // Only if nested inside another scrollable (e.g. Column or ListView)
            physics:
                const NeverScrollableScrollPhysics(), // Prevent conflict if inside a scroll view
            itemCount: statusOrder.length,
            itemBuilder: (context, index) {
              final status = statusOrder[index];
              final bool isLastItem = index == statusOrder.length - 1;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: isLastItem ? 0 : kDefaultPadding / 2,
                ),
                child: TaskStatusCard(
                  label: status.label,
                  totalCount: totalByStatus[status] ?? 0,
                  myCount: myByStatus[status] ?? 0,
                  color: status.color,
                ),
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

  const TaskStatusCard({
    required this.label,
    required this.totalCount,
    required this.myCount,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: themeData.colorScheme.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$totalCount ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: kBodyMedium,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: label.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            'My Tasks: $myCount',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: kBodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

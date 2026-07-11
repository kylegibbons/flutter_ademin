import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/dialogs/delete_warning.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_grid_header.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProjectGridView extends StatelessWidget {
  const ProjectGridView({
    super.key,
    required this.controller,
    required this.crossAxisCount,
  });

  final ProjectController controller;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: controller.visibleprojects.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: kDefaultPadding,
        mainAxisSpacing: kDefaultPadding,
        mainAxisExtent: 416,
      ),
      itemBuilder: (_, index) {
        return ProjectCard(
          project: controller.visibleprojects[index],
          onTap: () {
            GoRouter.of(context).go(RouteUri.projectDetail);
          },
        );
      },
    );
  }
}

// Contains the Project class

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final themeData = Theme.of(context);
    const double avatarSize = 32; // avatar diameter
    const double overlap = 8; // how much each avatar overlaps
    final int avatarCount = project.teamMemberAvatars.length;
    final double totalWidth = avatarCount > 1
        ? avatarSize + (avatarCount - 1) * (avatarSize - overlap)
        : avatarSize;
    double percentage = (project.completedTasks * 100) / project.totalTasks;
    String formattedPercentage = percentage % 1 == 0
        ? percentage.toStringAsFixed(0)
        : percentage.toStringAsFixed(2);
    final priority = project.priority.toPriority();

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            /// Title and projects Summary
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      top: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    child: Text(
                      project.title,
                      style: TextStyle(
                        fontSize: kBodyMedium + 1,
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                  child: CustomPopupMenu(
                    onSelected: (value) async {
                      switch (value) {
                        case 'view':
                          // Navigation to project details
                          GoRouter.of(context).go(RouteUri.projectDetail);
                          break;

                        case 'edit':
                          // Navigate to edit page
                          GoRouter.of(context).go(RouteUri.projectList);
                          break;

                        case 'delete':
                          // show warning dialog
                          showDialog(
                            context: context,
                            builder: (context) =>
                                CustomDialog(content: DeleteWarningDialog()),
                          );
                          break;
                      }
                    },
                    items: [
                      PopupMenuItemData(
                        value: 'view',
                        icon: Icons.visibility_outlined,
                        iconSize: 16,
                        text: 'View',
                      ),
                      PopupMenuItemData(
                        value: 'edit',
                        icon: Icons.edit_outlined,
                        iconSize: 16,
                        text: 'Edit',
                        showDividerAfter: true,
                      ),
                      PopupMenuItemData(
                        value: 'delete',
                        icon: Icons.delete_outline,
                        iconSize: 16,
                        iconColor: kErrorColor,
                        text: 'Delete',
                        textStyle: TextStyle(color: kErrorColor),
                      ),
                    ],
                    icon: Icons.more_vert,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(text: 'Total '),
                        TextSpan(
                          text:
                              '${project.completedTasks}/${project.totalTasks}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        const TextSpan(text: ' tasks completed'),
                      ],
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  /// Team & Priority
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // team
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Team :',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          SizedBox(
                            height: avatarSize,
                            width: avatarCount > 5
                                ? avatarSize +
                                      (4 * (avatarSize - overlap)) +
                                      (avatarSize - overlap)
                                : totalWidth,
                            child: Stack(
                              children: [
                                ...project.teamMemberAvatars
                                    .asMap()
                                    .entries
                                    .where((entry) => entry.key < 5)
                                    .map((entry) {
                                      final index = entry.key;
                                      if (index < 4 || avatarCount <= 5) {
                                        // show avatar
                                        return Positioned(
                                          left: index * (avatarSize - overlap),
                                          child: CircleAvatar(
                                            radius: avatarSize / 2,
                                            backgroundImage: AssetImage(
                                              entry.value,
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Avatar 4th
                                        final remaining = avatarCount - 4;
                                        return Positioned(
                                          left: 4 * (avatarSize - overlap),
                                          child: CircleAvatar(
                                            radius: avatarSize / 2,
                                            backgroundColor:
                                                Colors.grey.shade100,
                                            child: Text(
                                              '+$remaining',
                                              style: TextStyle(
                                                color: kOnSurfaceLight,
                                                fontWeight: FontWeight.w500,
                                                fontSize: kBodyMedium,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // priority
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Priority :',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          CustomBadge(
                            kText: priority.label,
                            kColor: priority.color,
                            isSoft: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding),

                  /// Description
                  Text(
                    'Description :',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: kDefaultPadding),

                  /// Progress
                  Text(
                    'Status :',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  LinearProgressIndicator(
                    value: project.completedTasks / project.totalTasks,
                    color: kSuccessColor,
                    backgroundColor: Colors.grey.shade300,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),

                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '$formattedPercentage%',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kSuccessColor,
                          ),
                        ),
                        TextSpan(
                          text: ' Completed',
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding),

                  /// Dates
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateColumn(
                        'Assigned Date',
                        dateFormat.format(project.assignedDate),
                        context,
                        true,
                      ),
                      _buildDateColumn(
                        'Due Date',
                        dateFormat.format(project.dueDate),
                        context,
                        false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateColumn(String label, String date, context, bool isStart) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: isStart
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text('$label :', style: TextStyle(fontSize: kBodySmall)),
        const SizedBox(height: kDefaultPadding / 2),
        Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeData.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

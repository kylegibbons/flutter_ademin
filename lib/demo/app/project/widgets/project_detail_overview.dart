import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_attachment_overview.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_task_overview.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';

class ProjectDetailOverview extends StatelessWidget {
  const ProjectDetailOverview({
    super.key,
    required this.mediaQueryData,
    required this.themeData,
    required this.project,
  });

  final MediaQueryData mediaQueryData;
  final ThemeData themeData;
  final ProjectDetails project;

  String formatDate(DateTime date) => DateFormat.yMMMd().format(date);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - kDefaultPadding;
        final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
        return Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.7
                  : constraints.maxWidth * 1,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // project overview table
                    CardHeader(kText: 'Project Overview'),
                    SizedBox(height: kDefaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final itemWidth = isMobile
                              ? constraints.maxWidth
                              : constraints.maxWidth / 2 - kDefaultPadding;

                          return Wrap(
                            spacing: kDefaultPadding,
                            runSpacing: kDefaultPadding / 2,
                            children: [
                              buildOverviewItem(
                                'Project #',
                                project.id,
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Client',
                                project.client,
                                isLink: true,
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Billing Type',
                                'Task Hours',
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Status',
                                project.status,
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Date Created',
                                formatDate(project.dateCreated),
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Start Date',
                                formatDate(project.startDate),
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Deadline',
                                formatDate(project.endDate),
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Total Logged Hours',
                                '00:00',
                                width: itemWidth,
                              ),
                              buildOverviewItem(
                                'Tags',
                                '',
                                width: itemWidth,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: project.tags
                                      .map(
                                        (tag) => CustomBadge(
                                          kColor:
                                              themeData.colorScheme.onSurface,
                                          kText: tag,
                                          isSoft: true,
                                          isRounded: true,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 1.5 * kDefaultPadding),

                    // project description
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        'Descriptions',
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(project.description),
                    ),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.3
                  : constraints.maxWidth * 1,
              child: Column(
                children: [
                  // task overview
                  Card(
                    child: Column(
                      children: [
                        // title
                        CardHeader(
                          kText: 'Task Overview',
                          kWidget: CustomIconButton(
                            icon: Icons.more_vert,
                            onTap: () {},
                            iconColor: themeData.colorScheme.onSurface,
                            shape: ButtonShape.circle,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          child: TaskStatusOverview(
                            tasks: project.tasks,
                            memberId: 'm1', // current user ID
                            isGrid: false,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),

                  SizedBox(height: kDefaultPadding),

                  // Attachment Overview
                  Card(
                    child: Column(
                      children: [
                        // title
                        CardHeader(
                          kText: 'Attachment Overview',
                          kWidget: CustomIconButton(
                            icon: Icons.more_vert,
                            onTap: () {},
                            iconColor: themeData.colorScheme.onSurface,
                            shape: ButtonShape.circle,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          child: AttachmentOverview(
                            attachments: project.attachments,
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // overview item

  Widget buildOverviewItem(
    String label,
    String value, {
    bool isLink = false,
    Widget? child,
    double? width,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle()),
          const SizedBox(height: kDefaultPadding / 4),
          child ??
              (isLink
                  ? InkWell(
                      onTap: () {},
                      child: Text(
                        value,
                        style: TextStyle(
                          color: kInfoColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    )),
        ],
      ),
    );
  }
}

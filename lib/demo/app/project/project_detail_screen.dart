import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_activity.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_attachment.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_header.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_overview.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_detail_task_table.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/widgets/base_ui/tab.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).project(1); //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ProjectDetails project = mockProjectDatas;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //content
          Stack(
            children: [
              // header
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                    image: AssetImage(project.bgImage),
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 2 * kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header
                    ProjectDetailHeader(project: project),

                    SizedBox(height: 1.5 * kDefaultPadding),

                    // tabs
                    HorizontalTabBar(
                      indicatorColor: Colors.white.withValues(alpha: 0.1),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      labelStyle: const TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w500,
                      ),
                      isPill: true,
                      tabs: [
                        // overview tab
                        TabBarItem(
                          label: 'Overview',
                          icon: Icons.dashboard_outlined,
                          content: ProjectDetailOverview(
                            mediaQueryData: mediaQueryData,
                            themeData: themeData,
                            project: project,
                          ),
                        ),
                        TabBarItem(
                          label: 'Tasks',
                          icon: Icons.check_circle_outline,
                          content: ProjectDetailTaskTable(
                            tasks: mockProjectDatas.tasks,
                            members: mockProjectDatas.members,
                          ),
                        ),
                        TabBarItem(
                          label: 'Activity',
                          icon: Icons.view_kanban_outlined,
                          content: ProjectDetailActivityTimeline(
                            activities: project.activities,
                            memberMap: {for (var m in project.members) m.id: m},
                          ),
                        ),
                        TabBarItem(
                          label: 'Attachments',
                          icon: Icons.document_scanner_outlined,
                          content: ProjectDetailAttachment(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

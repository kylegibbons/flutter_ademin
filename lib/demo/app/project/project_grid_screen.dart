import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_grid_header.dart';
import 'package:flutter_ademin/demo/app/project/widgets/project_grid_view.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class ProjectGridScreen extends StatefulWidget {
  const ProjectGridScreen({super.key});

  @override
  State<ProjectGridScreen> createState() => _ProjectGridScreenState();
}

class _ProjectGridScreenState extends State<ProjectGridScreen> {
  late ProjectController controller;
  @override
  void initState() {
    super.initState();

    controller = ProjectController(
      allProjects: projects,
    ); // Define `projects` as a list of Project
    controller.addListener(() => setState(() {}));

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).projectList; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxxl) return 6;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;

    final GlobalKey<PopupMenuButtonState> popupSearchbar =
        GlobalKey<PopupMenuButtonState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // page header
          PageHeader(
            title:
                '${lang.project(1).toUpperCase()} ${lang.gridView.toUpperCase()}',
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(
                label: '${lang.project(1)} ${lang.gridView}',
                uri: '',
              ),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // header
                ProjectGridHeader(
                  isMobile: isMobile,
                  popupSearchbar: popupSearchbar,
                  themeData: themeData,
                  mediaQueryData: mediaQueryData,
                  controller: controller,
                ),
                const SizedBox(height: kDefaultPadding),

                // gridview
                ProjectGridView(
                  controller: controller,
                  crossAxisCount: crossAxisCount,
                ),

                // load more button
                if (controller.canLoadMore)
                  Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding),
                    child: CustomOutlinedButton(
                      kText: 'Load More',
                      outlineColor: kSuccessColor,
                      isRounded: true,
                      onPressed: controller.loadMore,
                    ),
                  ),
              ],
            ),
          ),

          //footer
          // const PortalFooter(),
        ],
      ),
    );
  }
}

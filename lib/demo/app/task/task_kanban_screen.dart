import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/project/project_models.dart';
import 'package:flutkit_ademin/demo/app/task/dialogs/add_task_form.dart';
import 'package:flutkit_ademin/demo/app/task/dialogs/view_task.dart';
import 'package:flutkit_ademin/demo/app/task/widgets/task_kanban_board.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class TaskKanbanScreen extends StatefulWidget {
  const TaskKanbanScreen({super.key});

  @override
  State<TaskKanbanScreen> createState() => _TaskKanbanScreenState();
}

class _TaskKanbanScreenState extends State<TaskKanbanScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).kanbanBoard; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // helper for opening the add-task dialog from the screen level
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

      // Note: the board widget itself handles inserting new tasks into the groups
      // via its own _showAddCardDialog method. This screen-level helper is only
      // used for the toolbar button which doesn't have direct access to the
      // board's controller.
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;
    final GlobalKey<PopupMenuButtonState> popupKanbanSearchbar =
        GlobalKey<PopupMenuButtonState>();

    return PortalMasterLayout(
      body: Column(
        children: [
          // header
          PageHeader(
            title: lang.task.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.task, uri: ''),
            ],
          ),

          //content
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withValues(alpha: 0.2),
            ),
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // new task
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kPrimaryColor,
                            tooltipMessage: 'New Task',
                            onTap: () {
                              _showAddCardDialog(context);
                            },
                          )
                        : FlatButton(
                            kText: 'New Task',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              _showAddCardDialog(context);
                            },
                            kLeadingIcon: Icons.add_outlined,
                          ),

                    Spacer(),

                    // search bar
                    isMobile
                        ? PopupMenuButton(
                            key: popupKanbanSearchbar,
                            splashRadius: 0.0,
                            tooltip: '',
                            position: PopupMenuPosition.under,
                            color: themeData.colorScheme.surface,
                            constraints: BoxConstraints(
                              maxWidth:
                                  mediaQueryData.size.width <= kScreenWidthMd
                                  ? mediaQueryData.size.width
                                  : 360,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                enabled: false,
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: OutlineSearchBar(
                                    hintText: 'Search tasks',
                                    autofocus: true,
                                  ),
                                ),
                              ),
                            ],
                            child: CustomIconButton(
                              icon: Icons.search,
                              iconColor: kTextColor,
                              buttonColor: themeData.colorScheme.surface,
                              onTap: () {
                                popupKanbanSearchbar.currentState
                                    ?.showButtonMenu();
                              },
                              isOutlined: true,
                            ),
                          )
                        : SizedBox(
                            width: 240,
                            child: OutlineSearchBar(hintText: 'Search tasks'),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.only(top: kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: 0.2),
              ),
              child: TaskKanbarBoard(),
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

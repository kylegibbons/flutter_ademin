import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/base_ui/list.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).list; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    // List of tasks to pass to TaskList
    List<Map<String, dynamic>> tasks = [
      {
        'kIcon': Icons.copy_all_outlined,
        'kText': 'Send over all the documentation.',
      },
      {
        'kIcon': Icons.insert_drive_file_outlined,
        'kText': 'Send the billing agreement.',
      },
      {
        'kIcon': Icons.support_agent_outlined,
        'kText': 'Give customer support.',
      },
      {
        'kIcon': Icons.chat_outlined,
        'kText': 'Meeting with client to review the submission form.',
      },
      {
        'kIcon': Icons.email_outlined,
        'kText': 'Follow up via email with project updates.',
      },
      {
        'kIcon': Icons.check_circle_outline,
        'kText': 'Verify client feedback and confirm revisions.',
      },
      {
        'kIcon': Icons.design_services_outlined,
        'kText': 'Prepare design mockups for next sprint.',
      },
      {
        'kIcon': Icons.cloud_upload_outlined,
        'kText': 'Upload finalized assets to the shared drive.',
      },
      {
        'kIcon': Icons.analytics_outlined,
        'kText': 'Review analytics and performance metrics.',
      },
      {
        'kIcon': Icons.schedule_outlined,
        'kText': 'Schedule follow-up meeting with the marketing team.',
      },
    ];

    // List of tasks to pass to TaskList
    List<Map<String, dynamic>> bulletNumberTasks = [
      {'kText': 'Send over all the documentation.'},
      {'kText': 'Send the billing agreement.'},
      {'kText': 'Give customer support.'},
      {'kText': 'Meeting with client to review the submission form.'},
      {'kText': 'Follow up via email with project updates.'},
      {'kText': 'Verify client feedback and confirm revisions.'},
      {'kText': 'Prepare design mockups for next sprint.'},
      {'kText': 'Upload finalized assets to the shared drive.'},
      {'kText': 'Review analytics and performance metrics.'},
      {'kText': 'Schedule follow-up meeting with the marketing team.'},
    ];

    // List of tasks to pass to TaskList
    List<Map<String, dynamic>> tasksDisabled = [
      {
        'kIcon': Icons.copy_all_outlined,
        'kText': 'Send over all the documentation.',
        'disabled': false,
      },
      {
        'kIcon': Icons.insert_drive_file_outlined,
        'kText': 'Send the billing agreement.',
        'disabled': false,
      },
      {
        'kIcon': Icons.support_agent_outlined,
        'kText': 'Give customer support.',
        'disabled': false,
      },
      {
        'kIcon': Icons.chat_outlined,
        'kText': 'Meeting with client to review the submission form.',
        'disabled': true, // set as disabled
      },
      {
        'kIcon': Icons.email_outlined,
        'kText': 'Follow up via email with project updates.',
        'disabled': false,
      },
      {
        'kIcon': Icons.check_circle_outline,
        'kText': 'Verify client feedback and confirm revisions.',
        'disabled': true, // set as disabled
      },
      {
        'kIcon': Icons.design_services_outlined,
        'kText': 'Prepare design mockups for next sprint.',
        'disabled': false,
      },
      {
        'kIcon': Icons.cloud_upload_outlined,
        'kText': 'Upload finalized assets to the shared drive.',
        'disabled': true, // set as disabled
      },
      {
        'kIcon': Icons.analytics_outlined,
        'kText': 'Review analytics and performance metrics.',
        'disabled': false,
      },
      {
        'kIcon': Icons.schedule_outlined,
        'kText': 'Schedule follow-up meeting with the marketing team.',
        'disabled': true, // set as disabled
      },
    ];

    // List of tasks to pass to TaskList with priorities
    List<Map<String, dynamic>> badgeTask = [
      {
        'kText': 'Send the billing agreement',
        'disabled': false,
        'badgeText': 'high',
        'badgeColor': kErrorColor,
      },
      {
        'kText': 'Send over all the documentation.',
        'disabled': false,
        'badgeText': 'medium',
        'badgeColor': kInfoColor,
      },
      {
        'kText': 'Meeting with client to review the design',
        'disabled': false,
        'badgeText': 'low',
        'badgeColor': kSuccessColor,
      },
      {
        'kText': 'Check ticket and give customer support',
        'disabled': false,
        'badgeText': 'high',
        'badgeColor': kErrorColor,
      },
      {
        'kText': 'Approve the new marketing strategy',
        'disabled': false,
        'badgeText': 'medium',
        'badgeColor': kInfoColor,
      },
      {
        'kText': 'Prepare the budget report',
        'disabled': false,
        'badgeText': 'low',
        'badgeColor': kSuccessColor,
      },
      {
        'kText': 'Conduct performance reviews',
        'disabled': false,
        'badgeText': 'high',
        'badgeColor': kErrorColor,
      },
      {
        'kText': 'Update website content and SEO metadata',
        'disabled': false,
        'badgeText': 'medium',
        'badgeColor': kInfoColor,
      },
      {
        'kText': 'Organize client feedback session',
        'disabled': false,
        'badgeText': 'low',
        'badgeColor': kSuccessColor,
      },
      {
        'kText': 'Prepare presentation for quarterly review',
        'disabled': false,
        'badgeText': 'high',
        'badgeColor': kErrorColor,
      },
    ];

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.list.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.baseUI, uri: ''),
                        BreadcrumbItem(label: lang.list, uri: RouteUri.list),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    int numberOfCardsPerRow = getNumberOfCardsPerRow_3(context);
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // custom list
                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Custom List',
                            description:
                                'Use <code>CustomList()</code> to set a custom list. Each list items can have its own icon.',
                            uiView: CustomList(data: tasks),
                            height: 600,
                            codeView: '''
CustomList(
  data: tasks,
)

// List of tasks to pass to TaskList
List<Map<String, dynamic>> tasks = [
  {
    'kIcon': Icons.copy_all_outlined,
    'kText': 'Send over all the documentation.',
  },
  {
    'kIcon': Icons.insert_drive_file_outlined,
    'kText': 'Send the billing agreement.',
  },
  {
    'kIcon': Icons.support_agent_outlined,
    'kText': 'Give customer support.',
  },
  {
    'kIcon': Icons.chat_outlined,
    'kText': 'Meeting with client to review the submission form.',
  },
  {
    'kIcon': Icons.email_outlined,
    'kText': 'Follow up via email with project updates.',
  },
  {
    'kIcon': Icons.check_circle_outline,
    'kText': 'Verify client feedback and confirm revisions.',
  },
  {
    'kIcon': Icons.design_services_outlined,
    'kText': 'Prepare design mockups for next sprint.',
  },
  {
    'kIcon': Icons.cloud_upload_outlined,
    'kText': 'Upload finalized assets to the shared drive.',
  },
  {
    'kIcon': Icons.analytics_outlined,
    'kText': 'Review analytics and performance metrics.',
  },
  {
    'kIcon': Icons.schedule_outlined,
    'kText': 'Schedule follow-up meeting with the marketing team.',
  },
];
''',
                          ),
                        ),

                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Bullet List',
                            description:
                                'Use <code>CustomList()</code>, and add <code>globalIcon</code> argument to set a bullet list, with global icon.',
                            uiView: CustomList(
                              data: bulletNumberTasks,
                              globalIcon:
                                  Icons.check_circle_outline, // set global icon
                            ),
                            height: 600,
                            codeView: '''
CustomList(
  data: bulletNumberTasks,
  globalIcon: Icons.check_circle_outline, // set global icon
),

// List of tasks to pass to TaskList
List<Map<String, dynamic>> bulletNumberTasks = [
  {
    'kText': 'Send over all the documentation.',
  },
  {
    'kText': 'Send the billing agreement.',
  },
  {
    'kText': 'Give customer support.',
  },
  {
    'kText': 'Meeting with client to review the submission form.',
  },
  {
    'kText': 'Follow up via email with project updates.',
  },
  {
    'kText': 'Verify client feedback and confirm revisions.',
  },
  {
    'kText': 'Prepare design mockups for next sprint.',
  },
  {
    'kText': 'Upload finalized assets to the shared drive.',
  },
  {
    'kText': 'Review analytics and performance metrics.',
  },
  {
    'kText': 'Schedule follow-up meeting with the marketing team.',
  },
];
''',
                          ),
                        ),

                        // Number List
                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Number List',
                            description:
                                'Use <code>CustomList()</code>, and add <code>isNumber: true</code> argument to set a number list.',
                            uiView: CustomList(
                              data: bulletNumberTasks,
                              isNumber: true, // set as number list
                            ),
                            height: 600,
                            codeView: '''
CustomList(
  data: bulletNumberTasks,
  isNumber: true, // set as number list
),

// List of tasks to pass to TaskList
List<Map<String, dynamic>> bulletNumberTasks = [
  {
    'kText': 'Send over all the documentation.',
  },
  {
    'kText': 'Send the billing agreement.',
  },
  {
    'kText': 'Give customer support.',
  },
  {
    'kText': 'Meeting with client to review the submission form.',
  },
  {
    'kText': 'Follow up via email with project updates.',
  },
  {
    'kText': 'Verify client feedback and confirm revisions.',
  },
  {
    'kText': 'Prepare design mockups for next sprint.',
  },
  {
    'kText': 'Upload finalized assets to the shared drive.',
  },
  {
    'kText': 'Review analytics and performance metrics.',
  },
  {
    'kText': 'Schedule follow-up meeting with the marketing team.',
  },
];
''',
                          ),
                        ),

                        // active list
                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Active List',
                            description:
                                'Use <code>CustomList()</code>, and add <code>isActiveList: true</code> to set an active list: add hover effects and an active state to change the background color of list items.',
                            uiView: CustomList(
                              data: tasks,
                              isActiveList: true, // set as active list
                            ),
                            height: 600,
                            codeView: '''
ActiveList(data: tasks),

// List of tasks to pass to TaskList
List<Map<String, dynamic>> tasks = [
  {
    'kIcon': Icons.copy_all_outlined,
    'kText': 'Send over all the documentation.',
  },
  {
    'kIcon': Icons.insert_drive_file_outlined,
    'kText': 'Send the billing agreement.',
  },
  {
    'kIcon': Icons.support_agent_outlined,
    'kText': 'Give customer support.',
  },
  {
    'kIcon': Icons.chat_outlined,
    'kText': 'Meeting with client to review the submission form.',
  },
  {
    'kIcon': Icons.email_outlined,
    'kText': 'Follow up via email with project updates.',
  },
  {
    'kIcon': Icons.check_circle_outline,
    'kText': 'Verify client feedback and confirm revisions.',
  },
  {
    'kIcon': Icons.design_services_outlined,
    'kText': 'Prepare design mockups for next sprint.',
  },
  {
    'kIcon': Icons.cloud_upload_outlined,
    'kText': 'Upload finalized assets to the shared drive.',
  },
  {
    'kIcon': Icons.analytics_outlined,
    'kText': 'Review analytics and performance metrics.',
  },
  {
    'kIcon': Icons.schedule_outlined,
    'kText': 'Schedule follow-up meeting with the marketing team.',
  },
];
''',
                          ),
                        ),
                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Active List with Disable Items',
                            description:
                                'Use <code>CustomList()</code> to set an active list. Include a <code>disabled: true</code> field in your data list. This field will determine whether an item is disabled, which will be unclickable, and the text color will be grey-out.',
                            uiView: CustomList(
                              data: tasksDisabled,
                              isActiveList: true,
                            ),
                            height: 600,
                            codeView: '''
CustomList(
                        data: tasksDisabled,
                        isActiveList: true,
                      ),

// List of tasks to pass to TaskList
List<Map<String, dynamic>> tasksDisabled = [
{
  'kIcon': Icons.copy_all_outlined,
  'kText': 'Send over all the documentation.',
  'disabled': false,
},
{
  'kIcon': Icons.insert_drive_file_outlined,
  'kText': 'Send the billing agreement.',
  'disabled': false,
},
{
  'kIcon': Icons.support_agent_outlined,
  'kText': 'Give customer support.',
  'disabled': false,
},
{
  'kIcon': Icons.chat_outlined,
  'kText': 'Meeting with client to review the submission form.',
  'disabled': true, // set as disabled
},
{
  'kIcon': Icons.email_outlined,
  'kText': 'Follow up via email with project updates.',
  'disabled': false,
},
{
  'kIcon': Icons.check_circle_outline,
  'kText': 'Verify client feedback and confirm revisions.',
  'disabled': true, // set as disabled
},
{
  'kIcon': Icons.design_services_outlined,
  'kText': 'Prepare design mockups for next sprint.',
  'disabled': false,
},
{
  'kIcon': Icons.cloud_upload_outlined,
  'kText': 'Upload finalized assets to the shared drive.',
  'disabled': true, // set as disabled
},
{
  'kIcon': Icons.analytics_outlined,
  'kText': 'Review analytics and performance metrics.',
  'disabled': false,
},
{
  'kIcon': Icons.schedule_outlined,
  'kText': 'Schedule follow-up meeting with the marketing team.',
  'disabled': true, // set as disabled
},
];
''',
                          ),
                        ),

                        SizedBox(
                          width: calculateCardWidth_3(
                            context,
                            constraints,
                            numberOfCardsPerRow,
                          ),
                          child: ShowCodeCard(
                            cardTitle: 'Badge List',
                            description:
                                'Use <code>CustomList()</code>, and add <code>hasBadge: true</code> to set list with badge. Add <code>badgeText</code> and <code>badgeColor</code> in data.',
                            uiView: CustomList(
                              data: badgeTask,
                              isActiveList: true,
                              hasBadge: true, // set as badge list
                            ),
                            height: 600,
                            codeView: '''
CustomList(
  data: badgeTask,
  isActiveList: true,
  hasBadge: true, // set as badge list
),

// List of tasks to pass to TaskList with priorities
List<Map<String, dynamic>> badgeTask = [
  {
    'kText': 'Send the billing agreement',
    'disabled': false,
    'badgeText': 'high',
    'badgeColor': kErrorColor,
  },
  {
    'kText': 'Send over all the documentation.',
    'disabled': false,
    'badgeText': 'medium',
    'badgeColor': kInfoColor,
  },
  {
    'kText': 'Meeting with client to review the design',
    'disabled': false,
    'badgeText': 'low',
    'badgeColor': kSuccessColor,
  },
  {
    'kText': 'Check ticket and give customer support',
    'disabled': false,
    'badgeText': 'high',
    'badgeColor': kErrorColor,
  },
  {
    'kText': 'Approve the new marketing strategy',
    'disabled': false,
    'badgeText': 'medium',
    'badgeColor': kInfoColor,
  },
  {
    'kText': 'Prepare the budget report',
    'disabled': false,
    'badgeText': 'low',
    'badgeColor': kSuccessColor,
  },
  {
    'kText': 'Conduct performance reviews',
    'disabled': false,
    'badgeText': 'high',
    'badgeColor': kErrorColor,
  },
  {
    'kText': 'Update website content and SEO metadata',
    'disabled': false,
    'badgeText': 'medium',
    'badgeColor': kInfoColor,
  },
  {
    'kText': 'Organize client feedback session',
    'disabled': false,
    'badgeText': 'low',
    'badgeColor': kSuccessColor,
  },
  {
    'kText': 'Prepare presentation for quarterly review',
    'disabled': false,
    'badgeText': 'high',
    'badgeColor': kErrorColor,
  },
];
''',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

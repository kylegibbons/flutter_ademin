import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/sidebar.dart';

final sidebarMenuConfigs = [
  // Dashboard
  SidebarMenuConfig(
    uri: '',
    icon: Icons.view_kanban,
    iconSize: 20,
    title: (context) => Lang.of(context).dashboard,
    fontSize: kBodyLarge,
    children: [
      // Level 2
      SidebarMenuConfig(
        uri: RouteUri.dashboardAnalytics,
        title: (context) => Lang.of(context).analytics,
      ),
      SidebarMenuConfig(
        uri: RouteUri.dashboardCrm,
        title: (context) => Lang.of(context).crm,
      ),
      SidebarMenuConfig(
        uri: RouteUri.dashboardEcommerce,
        title: (context) => Lang.of(context).ecommerce,
      ),

      SidebarMenuConfig(
        uri: RouteUri.dashboardCrypto,
        title: (context) => Lang.of(context).crypto,
      ),

      SidebarMenuConfig(
        uri: RouteUri.dashboardProject,
        title: (context) => Lang.of(context).project(2),
      ),

      SidebarMenuConfig(
        uri: RouteUri.dashboardNft,
        title: (context) => Lang.of(context).nft,
      ),
      SidebarMenuConfig(
        uri: RouteUri.dashboardSaas,
        title: (context) => Lang.of(context).saas,
      ),
    ],
  ),

  // Apps
  SidebarMenuConfig(
    uri: '',
    icon: Icons.apps_outlined,
    iconSize: 20,
    title: (context) => Lang.of(context).apps(2),
    fontSize: kBodyLarge,
    children: [
      // calendar (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.calendar,
        title: (context) => Lang.of(context).calendar,
      ),

      // chat (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.chat,
        title: (context) => Lang.of(context).chat,
      ),

      // documentation (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.documentation,
        title: (context) => Lang.of(context).documentation,
      ),

      // email (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.email,
        title: (context) => Lang.of(context).email,
      ),

      // file manager (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.fileManager,
        title: (context) => Lang.of(context).fileManager,
      ),
      // integration (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.integration,
        title: (context) => Lang.of(context).integration,
      ),

      // User Management (Level 2 - Leaf)
      SidebarMenuConfig(
        uri: RouteUri.userManagement,
        title: (context) => Lang.of(context).userManagement,
      ),

      // Billing and Subscription (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).subscription,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.pricing,
            icon: Icons.remove,
            title: (context) => Lang.of(context).pricing,
          ),
          SidebarMenuConfig(
            uri: RouteUri.billing,
            icon: Icons.remove,
            title: (context) => Lang.of(context).billing,
          ),
          SidebarMenuConfig(
            uri: RouteUri.subscriptionManagement,
            icon: Icons.remove,
            title: (context) => Lang.of(context).management,
          ),
        ],
      ),

      // project app (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).project(2),
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.projectList,
            icon: Icons.remove,
            title: (context) => Lang.of(context).gridView,
          ),
          SidebarMenuConfig(
            uri: RouteUri.projectDetail,
            icon: Icons.remove,
            title: (context) => Lang.of(context).detail,
          ),
          SidebarMenuConfig(
            uri: RouteUri.createProject,
            icon: Icons.remove,
            title: (context) => Lang.of(context).createProject,
          ),
        ],
      ),

      // task app (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).task,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.kanbanBoard,
            icon: Icons.remove,
            title: (context) => Lang.of(context).kanbanBoard,
          ),
          SidebarMenuConfig(
            uri: RouteUri.ganttChart,
            icon: Icons.remove,
            title: (context) => Lang.of(context).ganttChart,
          ),
          SidebarMenuConfig(
            uri: RouteUri.taskListView,
            icon: Icons.remove,
            title: (context) => Lang.of(context).listView,
          ),
        ],
      ),

      // Crypto App (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).crypto,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.cryptoTransactions,
            icon: Icons.remove,
            title: (context) => Lang.of(context).transactions,
          ),
          SidebarMenuConfig(
            uri: RouteUri.cryptoBuySell,
            icon: Icons.remove,
            title: (context) => Lang.of(context).buySell,
          ),
          SidebarMenuConfig(
            uri: RouteUri.cryptoWallet,
            icon: Icons.remove,
            title: (context) => Lang.of(context).myWallet,
          ),
        ],
      ),

      // Invoice (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).invoices(2),
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.invoiceList,
            icon: Icons.remove,
            title: (context) =>
                '${Lang.of(context).invoices(2)} ${Lang.of(context).list}',
          ),
          SidebarMenuConfig(
            uri: RouteUri.invoiceCreate,
            icon: Icons.remove,
            title: (context) => 'Create ${Lang.of(context).invoices(1)}',
          ),
          SidebarMenuConfig(
            uri: RouteUri.invoiceDetail,
            icon: Icons.remove,
            title: (context) =>
                '${Lang.of(context).invoices(1)} ${Lang.of(context).detail}',
          ),
        ],
      ),

      // Support Ticket (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) =>
            '${Lang.of(context).support(1)} ${Lang.of(context).ticket(2)}',
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.ticketList,
            icon: Icons.remove,
            title: (context) =>
                '${Lang.of(context).ticket(2)} ${Lang.of(context).list}',
          ),
          SidebarMenuConfig(
            uri: RouteUri.createTicket,
            icon: Icons.remove,
            title: (context) =>
                '${Lang.of(context).create} ${Lang.of(context).ticket(1)} ',
          ),
          SidebarMenuConfig(
            uri: RouteUri.ticketDetail,
            icon: Icons.remove,
            title: (context) =>
                '${Lang.of(context).ticket(1)} ${Lang.of(context).detail}',
          ),
        ],
      ),
    ],
  ),

  // Authentication
  SidebarMenuConfig(
    uri: '',
    icon: Icons.account_circle_outlined,
    iconSize: 20,
    title: (context) => Lang.of(context).authentication,
    fontSize: kBodyLarge,
    children: [
      // sign in (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).signin,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicSignIn,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderSignIn,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // sign up (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).signup,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicSignUp,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderSignUp,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // password reset (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).passwordReset,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicPasswordReset,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderPasswordReset,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // password create (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).passwordCreate,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicPasswordCreate,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderPasswordCreate,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // 2 Step Verification (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).twoStepsVerification,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicTwoStepsVerification,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderTwoStepsVerification,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // screen lock (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).screenLock,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicScreenLock,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderScreenLock,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
      // logout (Level 2 - Parent)
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).logout,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.basicLogout,
            icon: Icons.remove,
            title: (context) => Lang.of(context).basic,
          ),
          SidebarMenuConfig(
            uri: RouteUri.sliderLogout,
            icon: Icons.remove,
            title: (context) => Lang.of(context).slider,
          ),
        ],
      ),
    ],
  ),

  // Pages
  SidebarMenuConfig(
    uri: '',
    icon: Icons.library_books_rounded,
    iconSize: 20,
    title: (context) => Lang.of(context).pages(2),
    fontSize: kBodyLarge,
    children: [
      // Level 2 (Leaf)
      SidebarMenuConfig(
        uri: RouteUri.starterpage,
        title: (context) => Lang.of(context).starterPage,
      ),

      SidebarMenuConfig(
        uri: RouteUri.profile,
        title: (context) => Lang.of(context).profile,
      ),
      SidebarMenuConfig(
        uri: RouteUri.team,
        title: (context) => Lang.of(context).team,
      ),
      SidebarMenuConfig(
        uri: RouteUri.timeline,
        title: (context) => Lang.of(context).timeline,
      ),
      SidebarMenuConfig(
        uri: RouteUri.faqs,
        title: (context) => Lang.of(context).faqs,
      ),
      SidebarMenuConfig(
        uri: RouteUri.gallery,
        title: (context) => Lang.of(context).gallery,
      ),
      SidebarMenuConfig(
        uri: RouteUri.maintenance,
        title: (context) => Lang.of(context).maintenance,
      ),
      SidebarMenuConfig(
        uri: RouteUri.notifications,
        title: (context) => Lang.of(context).notifications,
      ),
      SidebarMenuConfig(
        uri: RouteUri.comingSoon,
        title: (context) => Lang.of(context).comingSoon,
      ),
      SidebarMenuConfig(
        uri: RouteUri.searchResult,
        title: (context) => Lang.of(context).searchResult,
      ),
      SidebarMenuConfig(
        uri: RouteUri.settings,
        title: (context) => Lang.of(context).settings,
      ),
      SidebarMenuConfig(
        uri: RouteUri.privacyPolicy,
        title: (context) => Lang.of(context).privacyPolicy,
      ),
      SidebarMenuConfig(
        uri: RouteUri.termsConditions,
        title: (context) => Lang.of(context).termConditions,
      ),
      SidebarMenuConfig(
        uri: '',
        title: (context) => Lang.of(context).error,
        children: [
          // Level 3
          SidebarMenuConfig(
            uri: RouteUri.error404,
            icon: Icons.remove,
            title: (context) => Lang.of(context).error404,
          ),
          SidebarMenuConfig(
            uri: RouteUri.error500,
            icon: Icons.remove,
            title: (context) => Lang.of(context).error500,
          ),
          SidebarMenuConfig(
            uri: RouteUri.error503,
            icon: Icons.remove,
            title: (context) => Lang.of(context).error503,
          ),
        ],
      ),
    ],
  ),

  // Base UI
  SidebarMenuConfig(
    uri: '',
    icon: Icons.splitscreen_outlined,
    iconSize: 20,
    title: (context) => Lang.of(context).baseUI,
    fontSize: kBodyLarge,
    children: [
      // Level 2 (Leaf)
      SidebarMenuConfig(
        uri: RouteUri.layoutBaseUi,
        title: (context) => Lang.of(context).layout,
      ),
      SidebarMenuConfig(
        uri: RouteUri.accordion,
        title: (context) => Lang.of(context).accordion,
      ),
      SidebarMenuConfig(
        uri: RouteUri.alert,
        title: (context) => Lang.of(context).alerts,
      ),
      SidebarMenuConfig(
        uri: RouteUri.badge,
        title: (context) => Lang.of(context).badge,
      ),
      SidebarMenuConfig(
        uri: RouteUri.button,
        title: (context) => Lang.of(context).buttons(2),
      ),
      SidebarMenuConfig(
        uri: RouteUri.card,
        title: (context) => Lang.of(context).cards,
      ),
      SidebarMenuConfig(
        uri: RouteUri.carousel,
        title: (context) => Lang.of(context).carousels,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chip,
        title: (context) => Lang.of(context).chip,
      ),
      SidebarMenuConfig(
        uri: RouteUri.dialog,
        title: (context) => Lang.of(context).dialog,
      ),
      SidebarMenuConfig(
        uri: RouteUri.dropdown,
        title: (context) => Lang.of(context).dropdown,
      ),
      // SidebarMenuConfig(
      //   uri: RouteUri.embed,
      //   title: (context) => Lang.of(context).embed,
      // ),
      SidebarMenuConfig(
        uri: RouteUri.image,
        title: (context) => Lang.of(context).image,
      ),
      SidebarMenuConfig(
        uri: RouteUri.list,
        title: (context) => Lang.of(context).list,
      ),
      SidebarMenuConfig(
        uri: RouteUri.progress,
        title: (context) => Lang.of(context).progress,
      ),
      SidebarMenuConfig(
        uri: RouteUri.ribbon,
        title: (context) => Lang.of(context).ribbon,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tab,
        title: (context) => Lang.of(context).tab,
      ),
      SidebarMenuConfig(
        uri: RouteUri.toast,
        title: (context) => Lang.of(context).toast,
      ),
      SidebarMenuConfig(
        uri: RouteUri.typography,
        title: (context) => Lang.of(context).typography,
      ),
    ],
  ),

  // form sidebar menu
  SidebarMenuConfig(
    uri: '',
    icon: Icons.edit_note_rounded,
    iconSize: 20,
    title: (context) => Lang.of(context).forms(2),
    fontSize: kBodyLarge,
    children: [
      // Semua ini adalah Level 2 (Leaf)
      SidebarMenuConfig(
        uri: RouteUri.basicElement,
        title: (context) => Lang.of(context).basicElement,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formDropdown,
        title: (context) => Lang.of(context).formDropdown,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formEditor,
        title: (context) => Lang.of(context).formEditor,
      ),
      SidebarMenuConfig(
        uri: RouteUri.fileUpload,
        title: (context) => Lang.of(context).fileUpload,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formControl,
        title: (context) => Lang.of(context).formControl,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formPicker,
        title: (context) => Lang.of(context).picker,
      ),
      SidebarMenuConfig(
        uri: RouteUri.inputMask,
        title: (context) => Lang.of(context).inputMask,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formSlider,
        title: (context) => Lang.of(context).slider,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formValidation,
        title: (context) => Lang.of(context).validation,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formWizard,
        title: (context) => Lang.of(context).wizard,
      ),
      SidebarMenuConfig(
        uri: RouteUri.formLayout,
        title: (context) => Lang.of(context).formLayout,
      ),
    ],
  ),

  // chart
  SidebarMenuConfig(
    uri: '',
    icon: Icons.show_chart,
    iconSize: 20,
    title: (context) => Lang.of(context).chart,
    fontSize: kBodyLarge,
    children: [
      // Semua ini adalah Level 2 (Leaf)
      SidebarMenuConfig(
        uri: RouteUri.chartLine,
        title: (context) => Lang.of(context).line,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartColumn,
        title: (context) => Lang.of(context).columnChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartSpline,
        title: (context) => Lang.of(context).splineChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartArea,
        title: (context) => Lang.of(context).areaChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartBar,
        title: (context) => Lang.of(context).barChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartBubble,
        title: (context) => Lang.of(context).bubbleChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartScatter,
        title: (context) => Lang.of(context).scatterChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartError,
        title: (context) => Lang.of(context).errorChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartStepLine,
        title: (context) => Lang.of(context).stepLineChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartRangeColumn,
        title: (context) => Lang.of(context).rangeColumnChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartFinancial,
        title: (context) => Lang.of(context).financialChart,
      ),
      SidebarMenuConfig(
        uri: RouteUri.chartHistogram,
        title: (context) => Lang.of(context).histogramChart,
      ),
    ],
  ),

  // table
  SidebarMenuConfig(
    uri: '',
    icon: Icons.table_chart_outlined,
    iconSize: 20,
    title: (context) => Lang.of(context).tables,
    fontSize: kBodyLarge,
    children: [
      // Semua ini adalah Level 2 (Leaf)
      SidebarMenuConfig(
        uri: RouteUri.tableBasic,
        title: (context) => Lang.of(context).basicTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableDragDrop,
        title: (context) => Lang.of(context).dragColumnTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableStackedHeader,
        title: (context) => Lang.of(context).stackedHeaderTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableCheckboxColumn,
        title: (context) => Lang.of(context).checkboxColumbTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableEditable,
        title: (context) => Lang.of(context).editableTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableFiltering,
        title: (context) => Lang.of(context).filteringTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableSummaries,
        title: (context) => Lang.of(context).summariesTable,
      ),
      SidebarMenuConfig(
        uri: RouteUri.tableColumnResizing,
        title: (context) => Lang.of(context).resizingTable,
      ),
    ],
  ),
];

import 'package:flutkit_ademin/demo/app/subscription/subscription_management_screen.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_billing_screen.dart';
import 'package:flutkit_ademin/demo/app/documentation/documentation_screen.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_create_screen.dart';
import 'package:flutkit_ademin/demo/app/task/task_gantt_screen.dart';
import 'package:flutkit_ademin/demo/page/notifications/notifications_screen.dart';
import 'package:flutkit_ademin/demo/app/user_management/user_management_screen.dart';
import 'package:flutkit_ademin/demo/page/error/error_404_screen.dart';
import 'package:flutkit_ademin/demo/page/error/error_500_screen.dart';
import 'package:flutkit_ademin/demo/page/error/error_503_screen.dart';
import 'package:flutkit_ademin/demo/page/settings/settings_screen.dart';
import 'package:flutkit_ademin/ai_reference/ai_reference_screen.dart';
import 'package:flutkit_ademin/providers/user_data_provider.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_screen.dart';
import 'package:flutkit_ademin/demo/app/chat/chat_screen.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_buy_sell_screen.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_my_wallet_screen.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_transactions_screen.dart';
import 'package:flutkit_ademin/demo/app/email/email_screen.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_screen.dart';
import 'package:flutkit_ademin/demo/app/integration/integration_screen.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_create_screen.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_details_screen.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_list_view_screen.dart';
import 'package:flutkit_ademin/demo/app/project/project_create_screen.dart';
import 'package:flutkit_ademin/demo/app/project/project_detail_screen.dart';
import 'package:flutkit_ademin/demo/app/project/project_grid_screen.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_details_screen.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_list_view_screen.dart';
import 'package:flutkit_ademin/demo/app/task/task_kanban_screen.dart';
import 'package:flutkit_ademin/demo/app/task/task_list_view_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_logout_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_password_create_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_password_reset_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_screen_lock_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_sign_up_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_two_steps_verification_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_logout_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_password_create_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_password_reset_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_screen_lock_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_sign_in_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_sign_up_screen.dart';
import 'package:flutkit_ademin/demo/authentication/slider_two_steps_verification_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/accordion_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/alert_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/badge_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/button_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/card_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/carousel_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/chip_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/dropdown_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/embed_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/image_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/dialog_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/layout_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/list_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/progress_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/ribbon_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/tab_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/toast_screen.dart';
import 'package:flutkit_ademin/demo/base_ui/typography_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_bar_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_area_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_bubble_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_column_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_error_bar_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_financial_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_histogram_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_line_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_range_column_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_scatter_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_spline_screen.dart';
import 'package:flutkit_ademin/demo/chart/chart_step_line_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/analytics/dashboard_analytics_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/dashboard_crm_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/crypto/dashboard_crypto_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/dashboard_nft_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/dashboard_saas_screen.dart';
import 'package:flutkit_ademin/demo/form/form_basic_element_screen.dart';
import 'package:flutkit_ademin/demo/form/form_file_upload_screen.dart';
import 'package:flutkit_ademin/demo/form/form_control_screen.dart';
import 'package:flutkit_ademin/demo/form/form_editor_screen.dart';
import 'package:flutkit_ademin/demo/form/form_input_mask_screen.dart';
import 'package:flutkit_ademin/demo/form/form_layout_screen.dart';
import 'package:flutkit_ademin/demo/form/form_picker_screen.dart';
import 'package:flutkit_ademin/demo/form/form_dropdown_screen.dart';
import 'package:flutkit_ademin/demo/form/form_slider_screen.dart';
import 'package:flutkit_ademin/demo/form/form_wizard_screen.dart';
import 'package:flutkit_ademin/demo/page/coming_soon/coming_soon_screen.dart';
import 'package:flutkit_ademin/demo/dashboard/project/dashboard_project_screen.dart';
import 'package:flutkit_ademin/demo/authentication/basic_sign_in_screen.dart';
import 'package:flutkit_ademin/demo/page/faqs/faqs_screen.dart';
import 'package:flutkit_ademin/demo/page/gallery/gallery_screen.dart';
import 'package:flutkit_ademin/demo/page/test-ignore/labs_page_screen.dart';
import 'package:flutkit_ademin/demo/page/maintenance/maintenance_screen.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_pricing_screen.dart';
import 'package:flutkit_ademin/demo/page/privacy_policy/privacy_policy_screen.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_screen.dart';
import 'package:flutkit_ademin/demo/page/search/search_result_screen.dart';
import 'package:flutkit_ademin/demo/page/starter_page/starter_page_screen.dart';
import 'package:flutkit_ademin/demo/page/team/team_screen.dart';
import 'package:flutkit_ademin/demo/page/test-ignore/smart_footer_screen.dart';
import 'package:flutkit_ademin/demo/page/term_condition/term_condition_screen.dart';
import 'package:flutkit_ademin/demo/page/timeline/timeline_screen.dart';
import 'package:flutkit_ademin/demo/table/table_basic_screen.dart';
import 'package:flutkit_ademin/demo/table/table_checkbox_column_screen.dart';
import 'package:flutkit_ademin/demo/table/table_column_drag_screen.dart';
import 'package:flutkit_ademin/demo/table/table_column_resizing_screen.dart';
import 'package:flutkit_ademin/demo/table/table_editable_screen.dart';
import 'package:flutkit_ademin/demo/table/table_filtering_screen.dart';
import 'package:flutkit_ademin/demo/table/table_stacked_header_screen.dart';
import 'package:flutkit_ademin/demo/table/table_summaries_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutkit_ademin/demo/form/form_validation_screen.dart';

class RouteUri {
  static String home = '/';
  static String dashboardProject = '/dashboard-project';
  static String starterpage = '/starter-page';
  static String fileUpload = '/file-upload';
  static String formLayout = '/form-layout';
  static String formEditor = '/form-editor';
  static String badge = '/ui-badge';
  static String button = '/ui-button';
  static String alert = '/ui-alert';
  static String card = '/ui-card';
  static String carousel = '/ui-carousel';
  static String chip = '/ui-chip';
  static String dropdown = '/ui-dropdown';
  static String image = '/ui-image';
  static String tab = '/ui-tab';
  static String accordion = '/ui-accordion';
  static String dialog = '/ui-dialog';
  static String sliding = '/ui-sliding';
  static String progress = '/ui-progress';
  static String toast = '/ui-toast';
  static String embed = '/ui-embed';
  static String typography = '/ui-typography';
  static String list = '/ui-list';
  static String ribbon = '/ui-ribbon';
  static String layoutBaseUi = '/ui-layout';
  static String basicElement = '/form-basic-element';
  static String formDropdown = '/form-dropdown';
  static String formControl = '/form-control';
  static String formPicker = '/form-picker';
  static String inputMask = '/form-input-mask';
  static String formSlider = '/form-slider';
  static String formValidation = '/form-validation';
  static String formWizard = '/form-wizard';
  static String chartLine = '/chart-line';
  static String chartColumn = '/chart-column';
  static String chartSpline = '/chart-spline';
  static String chartArea = '/chart-area';
  static String chartBar = '/chart-bar';
  static String chartBubble = '/chart-bubble';
  static String chartScatter = '/chart-scatter';
  static String chartError = '/chart-error';
  static String chartStepLine = '/chart-step-line';
  static String chartRangeColumn = '/chart-range-column';
  static String chartFinancial = '/chart-financial';
  static String chartHistogram = '/chart-histogram';
  static String tableBasic = '/table-basic';
  static String tableDragDrop = '/table-drag-drop-column';
  static String tableStackedHeader = '/table-stacked-header';
  static String tableCheckboxColumn = '/table-checkbox-column';
  static String tableEditable = '/table-editable';
  static String tableFiltering = '/table-filtering';
  static String tableSummaries = '/table-summaries';
  static String tableColumnResizing = '/table-column-resizing';
  static String tableStyling = '/table-styling';
  static String basicSignIn = '/basic-sign-in';
  static String sliderSignIn = '/slider-sign-in';
  static String basicSignUp = '/basic-sign-up';
  static String sliderSignUp = '/slider-sign-up';
  static String basicPasswordReset = '/basic-password-reset';
  static String sliderPasswordReset = '/slider-password-reset';
  static String basicPasswordCreate = '/basic-password-create';
  static String sliderPasswordCreate = '/slider-password-create';
  static String basicScreenLock = '/basic-screen-lock';
  static String sliderScreenLock = '/slider-screen-lock';
  static String basicLogout = '/basic-logout';
  static String sliderLogout = '/slider-logout';
  static String basicTwoStepsVerification = '/basic-two-steps-verification';
  static String sliderTwoStepsVerification = '/slider-two-steps-verification';
  static String team = '/team';
  static String profile = '/profile';
  static String timeline = '/timeline';
  static String faqs = '/faqs';
  static String pricing = '/pricing';
  static String gallery = '/gallery';
  static String testPage = '/test-page';
  static String maintenance = '/maintenance';
  static String comingSoon = '/coming-soon';
  static String searchResult = '/search-result';
  static String privacyPolicy = '/privacy-policy';
  static String termsConditions = '/terms-conditions';
  static String calendar = '/calendar';
  static String chat = '/chat';
  static String chat1 = '/chat1';
  static String email = '/email';
  static String projectList = '/project-list';
  static String projectDetail = '/project-detail';
  static String createProject = '/create-project';
  static String kanbanBoard = '/kanban-board';
  static String taskListView = '/task-list-view';
  static String cryptoTransactions = '/crypto-transactions';
  static String cryptoBuySell = '/crypto-buy-sell';
  static String cryptoWallet = '/crypto-wallet';
  static String invoiceList = '/invoice-list';
  static String invoiceCreate = '/invoice-create';
  static String invoiceDetail = '/invoice-details';
  static String ticketList = '/ticket-list';
  static String createTicket = '/create-ticket';
  static String ticketDetail = '/ticket-details';
  static String dashboardAnalytics = '/dashboard-analytics';
  static String dashboardCrm = '/dashboard-crm';
  static String dashboardEcommerce = '/dashboard-ecommerce';
  static String dashboardCrypto = '/dashboard-crypto';
  static String dashboardNft = '/dashboard-nft';
  static String labsPage = '/page-labs';
  static String fileManager = '/file-manager';
  static String integration = '/integration';
  static String aiAssistant = '/ai-assistant';
  static String dashboardSaas = '/dashboard-saas';
  static String error404 = '/error-404';
  static String error500 = '/error-500';
  static String error503 = '/error-503';
  static String userManagement = '/user-management';
  static String subscriptionManagement = '/subscription-management';
  static String notifications = '/notifications';
  static String settings = '/settings';
  static String billing = '/billing';
  static String aiReference = '/ai-reference';
  static String documentation = '/documentation';
  static String ganttChart = '/gantt-chart';
}

GoRouter appRouter(UserDataController userDataProvider) {
  return GoRouter(
    initialLocation: RouteUri.home,
    errorPageBuilder: (context, state) =>
        NoTransitionPage<void>(key: state.pageKey, child: Error404Screen()),
    routes: [
      GoRoute(
        path: RouteUri.home,
        redirect: (context, state) => RouteUri.dashboardAnalytics,
      ),
      GoRoute(
        path: RouteUri.dashboardProject,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardProjectScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.fileUpload,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FileUploadScreen(),
        ),
      ),

      GoRoute(
        path: RouteUri.starterpage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: StarterPageScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formLayout,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormLayoutScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formEditor,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormEditorScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.badge,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: BadgeScreen()),
      ),
      GoRoute(
        path: RouteUri.chip,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ChipScreen()),
      ),
      GoRoute(
        path: RouteUri.button,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ButtonScreen()),
      ),
      GoRoute(
        path: RouteUri.alert,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: AlertScreen()),
      ),
      GoRoute(
        path: RouteUri.card,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: CardScreen()),
      ),
      GoRoute(
        path: RouteUri.carousel,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: CarouselScreen()),
      ),
      GoRoute(
        path: RouteUri.dropdown,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: DropdownScreen()),
      ),
      GoRoute(
        path: RouteUri.image,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ImageScreen()),
      ),
      GoRoute(
        path: RouteUri.tab,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: TabScreen()),
      ),
      GoRoute(
        path: RouteUri.accordion,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: AccordionScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dialog,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: DialogScreen()),
      ),
      GoRoute(
        path: RouteUri.progress,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ProgressScreen()),
      ),
      GoRoute(
        path: RouteUri.toast,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ToastScreen()),
      ),
      GoRoute(
        path: RouteUri.embed,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: EmbedScreen()),
      ),
      GoRoute(
        path: RouteUri.typography,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TypographyScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.list,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ListScreen()),
      ),
      GoRoute(
        path: RouteUri.ribbon,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: RibbonScreen()),
      ),
      GoRoute(
        path: RouteUri.basicElement,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormBasicElement(),
        ),
      ),
      GoRoute(
        path: RouteUri.formDropdown,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormDropDownScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formControl,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormCheckboxRadioScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formPicker,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormPickerScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.inputMask,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormInputMaskScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formSlider,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormSliderScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formValidation,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormValidationScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.formWizard,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FormWizardScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartLine,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartLineScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartColumn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartColumnScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartSpline,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartSplineScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartArea,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartAreaScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartBar,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ChartBarScreen()),
      ),
      GoRoute(
        path: RouteUri.chartBubble,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartBubbleScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartScatter,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartScatterScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartError,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartErrorScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartStepLine,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartStepLineScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartRangeColumn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartRangeColumnScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartFinancial,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartFinancialScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chartHistogram,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ChartHistogramScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableBasic,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicTableScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableDragDrop,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ColumnDragTableScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableStackedHeader,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: StackedHeaderTableScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableCheckboxColumn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TableCheckboxColumnScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableEditable,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TableEditableScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableFiltering,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TableFilteringScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableSummaries,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TableSummariesScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.tableColumnResizing,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TableColumnResizingScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicSignIn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicSignInScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderSignIn,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderSignInScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicSignUp,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicSignUpScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderSignUp,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderSignUpScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicPasswordReset,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicPasswordResetScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderPasswordReset,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderPasswordResetScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicPasswordCreate,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicPasswordCreateScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderPasswordCreate,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderPasswordCreateScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicScreenLock,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicScreenLockScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderScreenLock,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderScreenLockScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicLogout,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicLogoutScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderLogout,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderLogoutScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.basicTwoStepsVerification,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: BasicTwoStepsVerificationScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.sliderTwoStepsVerification,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SliderTwoStepsVerificationScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.team,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: TeamScreen()),
      ),
      GoRoute(
        path: RouteUri.profile,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ProfileScreen()),
      ),
      GoRoute(
        path: RouteUri.timeline,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: TimelineScreen()),
      ),
      GoRoute(
        path: RouteUri.faqs,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: FaqsScreen()),
      ),
      GoRoute(
        path: RouteUri.pricing,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: PricingScreen()),
      ),
      GoRoute(
        path: RouteUri.gallery,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: GalleryScreen()),
      ),
      GoRoute(
        path: RouteUri.testPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SmartFooterPage(),
        ),
      ),
      GoRoute(
        path: RouteUri.maintenance,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: MaintenanceScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.comingSoon,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ComingSoonScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.searchResult,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SearchResultScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.privacyPolicy,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: PrivacyPolicyScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.termsConditions,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TermConditionScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.chat,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: ChatScreen()),
      ),

      GoRoute(
        path: RouteUri.email,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: EmailScreen()),
      ),
      GoRoute(
        path: RouteUri.projectList,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ProjectGridScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.projectDetail,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ProjectDetailScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.createProject,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ProjectCreateScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.kanbanBoard,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TaskKanbanScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.taskListView,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TaskListViewScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.cryptoTransactions,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CryptoTransactionsScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.cryptoBuySell,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CryptoBuySellScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.cryptoWallet,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CryptoMyWalletScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.invoiceList,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: InvoiceListViewScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.invoiceCreate,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: InvoiceCreateScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.invoiceDetail,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: InvoiceDetailsScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.ticketList,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TicketListViewScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.createTicket,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TicketCreateScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.ticketDetail,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TicketDetailsScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dashboardAnalytics,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardAnalyticsScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dashboardCrm,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardCrmScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dashboardEcommerce,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardEcommerceScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dashboardCrypto,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardCryptoScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.dashboardNft,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardNftScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.layoutBaseUi,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: LayoutScreen()),
      ),
      GoRoute(
        path: RouteUri.labsPage,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: LabsPageScreen()),
      ),
      GoRoute(
        path: RouteUri.fileManager,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: FileManagerScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.integration,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: IntegrationScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.calendar,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: CalendarScreen()),
      ),

      GoRoute(
        path: RouteUri.dashboardSaas,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DashboardSaasScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.error404,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: Error404Screen()),
      ),
      GoRoute(
        path: RouteUri.error500,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: Error500Screen()),
      ),
      GoRoute(
        path: RouteUri.error503,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: Error503Screen()),
      ),
      GoRoute(
        path: RouteUri.userManagement,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: UserManagementScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.subscriptionManagement,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: SubscriptionManagementScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.notifications,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: NotificationsScreen(),
        ),
      ),

      GoRoute(
        path: RouteUri.settings,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: SettingsScreen()),
      ),

      GoRoute(
        path: RouteUri.billing,
        pageBuilder: (context, state) =>
            NoTransitionPage<void>(key: state.pageKey, child: BillingScreen()),
      ),

      GoRoute(
        path: RouteUri.aiReference,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: AiReferenceScreen(),
        ),
      ),

      GoRoute(
        path: RouteUri.documentation,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: DocumentationScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.ganttChart,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: TaskGanttChartScreen(),
        ),
      ),
    ],

    //redirect to handle sign in.
    redirect: (context, state) {
      if (!AppSettings.enableAuth) return null;
      if (unrestrictedRoutes.contains(state.matchedLocation)) {
        return null;
      } else if (publicRoutes.contains(state.matchedLocation)) {
        // Is public route.
        if (userDataProvider.isUserLoggedIn()) {
          // User is logged in, redirect to home page.
          return RouteUri.home;
        }
      } else {
        // Not public route.
        if (!userDataProvider.isUserLoggedIn()) {
          // User is not logged in, redirect to login page.
          return RouteUri.sliderSignIn;
        }
      }

      return null;
    },
  );
}

// Unrestricted Route

List<String> unrestrictedRoutes = [
  RouteUri.basicLogout,
  RouteUri.sliderLogout,
  RouteUri.sliderSignIn, // Remove this line for actual authentication flow.
  RouteUri.sliderSignUp, // Remove this line for actual authentication flow.
];

List<String> publicRoutes = [
  // RouteUri.sliderSignIn, // Enable this line for actual authentication flow.
  // RouteUri.sliderSignUp, // Enable this line for actual authentication flow.
];

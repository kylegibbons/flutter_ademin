import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/alert.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).alerts; //update your page tittle here
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
    final mediaQueryData = MediaQuery.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            padding: EdgeInsets.symmetric(
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
                  offset: Offset(0, 1),
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
                      lang.alerts.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
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
                        BreadcrumbItem(label: lang.alerts, uri: RouteUri.alert),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth =
                        constraints.maxWidth - kDefaultPadding;
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // Default alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Default Alerts',
                            description:
                                "Use <code>Alert()</code> to show a default alert.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
),
''',
                          ),
                        ),

                        // Borderless alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Borderless Alerts',
                            description:
                                "Use <code>Alert()</code> to show an alert. Add <code>isOutlined: false</code> argument to disable border.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                  isOutlined: false,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                  isOutlined: false,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                  isOutlined: false,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                  isOutlined: false,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                  isOutlined: false,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                  isOutlined: false,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                  isOutlined: false,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                  isOutlined: false,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
  isOutlined: false,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
  isOutlined: false,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
  isOutlined: false,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
  isOutlined: false,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
  isOutlined: false,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
  isOutlined: false,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
  isOutlined: false,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
  isOutlined: false,
),
''',
                          ),
                        ),

                        // Dismissible alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Dismissible Alerts',
                            description:
                                "Use <code>Alert()</code> to show an alert. Add <code>isDismissible: true</code> argument to set dismissible alerts.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                  isDismissible: true,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                  isDismissible: true,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                  isDismissible: true,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                  isDismissible: true,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                  isDismissible: true,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                  isDismissible: true,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                  isDismissible: true,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                  isDismissible: true,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
  isDismissible: true,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
  isDismissible: true,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
  isDismissible: true,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
  isDismissible: true,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
  isDismissible: true,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
  isDismissible: true,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
  isDismissible: true,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
  isDismissible: true,
),
''',
                          ),
                        ),

                        // Outlined alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Outlined Alerts',
                            description:
                                "Use <code>Alert()</code> to show a default alert. Add <code>isOutlined: true</code> argument to set outlined alerts.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                  isDismissible: true,
                                  isOutlined: true,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
),
''',
                          ),
                        ),

                        // Solid alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Solid Alerts',
                            description:
                                "Use <code>Alert()</code> to show a default alert. Add <code>isSolid: true</code> argument to set solid alerts.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                  isDismissible: true,
                                  isSolid: true,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                  isDismissible: true,
                                  isSolid: true,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
),
''',
                          ),
                        ),

                        // Solid alerts
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Icon Alerts',
                            description:
                                "Use <code>Alert()</code> to show a default alert. Add <code>kIcon</code> argument to set an icon alert.",
                            uiView: Wrap(
                              runSpacing: kDefaultPadding,
                              children: [
                                // primary alert
                                Alert(
                                  htmlContent:
                                      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
                                  kColor: kPrimaryColor,
                                  isDismissible: true,
                                  kIcon: Icons.add_circle_outline,
                                ),

                                // secondary alert
                                Alert(
                                  htmlContent:
                                      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
                                  kColor: kSecondaryColor,
                                  isDismissible: true,
                                  isOutlined: false,
                                  kIcon: Icons.shopping_cart_checkout,
                                ),

                                // success alert
                                Alert(
                                  htmlContent:
                                      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
                                  kColor: kSuccessColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                  kIcon: Icons.check,
                                ),

                                // error alert
                                Alert(
                                  htmlContent:
                                      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
                                  kColor: kErrorColor,
                                  isDismissible: true,
                                  isSolid: true,
                                  kIcon: Icons.error_outline,
                                ),

                                // warning alert
                                Alert(
                                  htmlContent:
                                      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
                                  kColor: kWarningColor,
                                  isDismissible: true,
                                  kIcon: Icons.warning_outlined,
                                ),

                                // info alert
                                Alert(
                                  htmlContent:
                                      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
                                  kColor: kInfoColor,
                                  isDismissible: true,
                                  isOutlined: false,
                                  kIcon: Icons.info,
                                ),

                                // light alert
                                Alert(
                                  htmlContent:
                                      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
                                  kColor: kTextColor,
                                  isDismissible: true,
                                  isOutlined: true,
                                  kIcon: Icons.fluorescent,
                                ),

                                //dark alert
                                Alert(
                                  htmlContent:
                                      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
                                  kColor: themeData.colorScheme.onSurface,
                                  isDismissible: true,
                                  isSolid: true,
                                  kIcon: Icons.contrast_outlined,
                                ),
                              ],
                            ),
                            codeView: '''
// primary alert
Alert(
  htmlContent:
      "<b>Hi!</b> A simple <b>primary alert</b> — check it out!",
  kColor: kPrimaryColor,
  isDismissible: true,
  kIcon: Icons.add_circle_outline,
),

// secondary alert
Alert(
  htmlContent:
      "<b>How are you!</b> A simple <b>secondary alert</b> — check it out!",
  kColor: kSecondaryColor,
  isDismissible: true,
  isOutlined: false,
  kIcon: Icons.shopping_cart_checkout,
),

// success alert
Alert(
  htmlContent:
      "<b>Yey!</b> Everything worked! A simple <b>success alert</b> — check it out!",
  kColor: kSuccessColor,
  isDismissible: true,
  isOutlined: true,
  kIcon: Icons.check,
),

// error alert
Alert(
  htmlContent:
      "<b>Something is very wrong!</b> A simple <b>error alert</b> — check it out!",
  kColor: kErrorColor,
  isDismissible: true,
  isSolid: true,
  kIcon: Icons.error_outline,
),

// warning alert
Alert(
  htmlContent:
      "<b>Uh oh, something went wrong!</b> A simple <b>warning alert</b> — check it out!",
  kColor: kWarningColor,
  isDismissible: true,
  kIcon: Icons.warning_outlined,
),

// info alert
Alert(
  htmlContent:
      "<b>Don't forget it!</b> A simple <b>info alert</b> — check it out!",
  kColor: kInfoColor,
  isDismissible: true,
  isOutlined: false,
  kIcon: Icons.info,
),

// light alert
Alert(
  htmlContent:
      "<b>Mind Your Step!</b> A simple <b>light alert</b> — check it out!",
  kColor: kTextColor,
  isDismissible: true,
  isOutlined: true,
  kIcon: Icons.fluorescent,
),

//dark alert
Alert(
  htmlContent:
      "<b>Did you know?</b> A simple <b>dark alert</b> — check it out!",
  kColor: themeData.colorScheme.onSurface,
  isDismissible: true,
  isSolid: true,
  kIcon: Icons.contrast_outlined,
),
''',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).badge; //update your page tittle here
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
                  color: themeData.colorScheme.onSurface.withValues(alpha: 0.1),
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
                      lang.badge.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
                        BreadcrumbItem(label: lang.badge, uri: RouteUri.badge),
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
                //custom badges
                LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth =
                        constraints.maxWidth - kDefaultPadding;
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // custom badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Custom Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. This custom badge has multiple arguments to suit your design needs.',
                            uiView: Wrap(
                              spacing: kDefaultPadding / 2,
                              runSpacing: kDefaultPadding / 2,
                              children: [
                                // Badge for primary color
                                CustomBadge(
                                  kText: 'Primary',
                                  kColor: kPrimaryColor,
                                ),

                                // Badge for secondary color
                                CustomBadge(
                                  kText: 'Secondary',
                                  kColor: kSecondaryColor,
                                ),

                                // Badge for success status
                                CustomBadge(
                                  kText: 'Success',
                                  kColor: kSuccessColor,
                                ),

                                // Badge for informational status
                                CustomBadge(kText: 'Info', kColor: kInfoColor),

                                // Badge for warning status
                                CustomBadge(
                                  kText: 'Warning',
                                  kColor: kWarningColor,
                                ),

                                // Badge for error status
                                CustomBadge(
                                  kText: 'Error',
                                  kColor: kErrorColor,
                                ),

                                // Badge for dark color
                                CustomBadge(
                                  kText: 'Dark',
                                  kColor: Colors.black,
                                ),
                              ],
                            ),
                            codeView: '''
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: Colors.black,
),
''',
                          ),
                        ),

                        // soft badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Soft Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code>isSoft: true</code> argument to set as soft badge.',
                            uiView: Wrap(
                              spacing: kDefaultPadding / 2,
                              runSpacing: kDefaultPadding / 2,
                              children: [
                                // Badge for primary color
                                CustomBadge(
                                  kText: 'Primary',
                                  kColor: kPrimaryColor,
                                  isSoft: true,
                                ),

                                // Badge for secondary color
                                CustomBadge(
                                  kText: 'Secondary',
                                  kColor: kSecondaryColor,
                                  isSoft: true,
                                ),

                                // Badge for success status
                                CustomBadge(
                                  kText: 'Success',
                                  kColor: kSuccessColor,
                                  isSoft: true,
                                ),

                                // Badge for informational status
                                CustomBadge(
                                  kText: 'Info',
                                  kColor: kInfoColor,
                                  isSoft: true,
                                ),

                                // Badge for warning status
                                CustomBadge(
                                  kText: 'Warning',
                                  kColor: kWarningColor,
                                  isSoft: true,
                                ),

                                // Badge for error status
                                CustomBadge(
                                  kText: 'Error',
                                  kColor: kErrorColor,
                                  isSoft: true,
                                ),

                                // Badge for dark color
                                CustomBadge(
                                  kText: 'Dark',
                                  kColor: themeData.colorScheme.onSurface,
                                  isSoft: true,
                                ),
                              ],
                            ),
                            codeView: '''
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isSoft: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isSoft: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isSoft: true,
),
''',
                          ),
                        ),

                        // outlined badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Outlined Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code>isOutlined: true</code> argument to set as an outlined badge.',
                            uiView: Wrap(
                              spacing: kDefaultPadding / 2,
                              runSpacing: kDefaultPadding / 2,
                              children: [
                                // Badge for primary color
                                CustomBadge(
                                  kText: 'Primary',
                                  kColor: kPrimaryColor,
                                  isOutlined: true,
                                ),

                                // Badge for secondary color
                                CustomBadge(
                                  kText: 'Secondary',
                                  kColor: kSecondaryColor,
                                  isOutlined: true,
                                ),

                                // Badge for success status
                                CustomBadge(
                                  kText: 'Success',
                                  kColor: kSuccessColor,
                                  isOutlined: true,
                                ),

                                // Badge for informational status
                                CustomBadge(
                                  kText: 'Info',
                                  kColor: kInfoColor,
                                  isOutlined: true,
                                ),

                                // Badge for warning status
                                CustomBadge(
                                  kText: 'Warning',
                                  kColor: kWarningColor,
                                  isOutlined: true,
                                ),

                                // Badge for error status
                                CustomBadge(
                                  kText: 'Error',
                                  kColor: kErrorColor,
                                  isOutlined: true,
                                ),

                                // Badge for dark color
                                CustomBadge(
                                  kText: 'Dark',
                                  kColor: themeData.colorScheme.onSurface,
                                  isOutlined: true,
                                ),
                              ],
                            ),
                            codeView: '''
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isOutlined: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isOutlined: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isOutlined: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isOutlined: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isOutlined: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isOutlined: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isOutlined: true,
),
''',
                          ),
                        ),

                        // Rounded badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Rounded Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code>isRounded: true</code> argument to set as a rounded badge.',
                            uiView: Wrap(
                              spacing: kDefaultPadding / 2,
                              runSpacing: kDefaultPadding / 2,
                              children: [
                                // Badge for primary color
                                CustomBadge(
                                  kText: 'Primary',
                                  kColor: kPrimaryColor,
                                  isRounded: true,
                                ),

                                // Badge for secondary color
                                CustomBadge(
                                  kText: 'Secondary',
                                  kColor: kSecondaryColor,
                                  isRounded: true,
                                ),

                                // Badge for success status
                                CustomBadge(
                                  kText: 'Success',
                                  kColor: kSuccessColor,
                                  isRounded: true,
                                ),

                                // Badge for informational status
                                CustomBadge(
                                  kText: 'Info',
                                  kColor: kInfoColor,
                                  isSoft: true,
                                  isRounded: true,
                                ),

                                // Badge for warning status
                                CustomBadge(
                                  kText: 'Warning',
                                  kColor: kWarningColor,
                                  isSoft: true,
                                  isRounded: true,
                                ),

                                // Badge for error status
                                CustomBadge(
                                  kText: 'Error',
                                  kColor: kErrorColor,
                                  isOutlined: true,
                                  isRounded: true,
                                ),

                                // Badge for dark color
                                CustomBadge(
                                  kText: 'Dark',
                                  kColor: themeData.colorScheme.onSurface,
                                  isOutlined: true,
                                  isRounded: true,
                                ),
                              ],
                            ),
                            codeView: '''
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isRounded: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isRounded: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isRounded: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  isRounded: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isSoft: true,
  isRounded: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isOutlined: true,
  isRounded: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isOutlined: true,
  isRounded: true,
),
''',
                          ),
                        ),

                        // Border badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Border Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code> leftBorder: true</code> argument to set left border, Add <code> rightBorder: true</code> argument to set right border.',
                            uiView: Column(
                              children: [
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT BORDER BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isSoft: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isSoft: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isSoft: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isSoft: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isSoft: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isSoft: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isSoft: true,
                                      rightBorder: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT BORDER ROUNDED BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isSoft: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isSoft: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isSoft: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isSoft: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isSoft: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isSoft: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isSoft: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT BORDER OUTLINED BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isOutlined: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isOutlined: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isOutlined: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isOutlined: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isOutlined: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isOutlined: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isOutlined: true,
                                      rightBorder: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT BORDER ROUNDED OUTLINED BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      leftBorder: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isOutlined: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isOutlined: true,
                                      isRounded: true,
                                      rightBorder: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            codeView: '''
// SOFT BORDER BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
  leftBorder: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
  leftBorder: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
  leftBorder: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  leftBorder: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isSoft: true,
  rightBorder: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isSoft: true,
  rightBorder: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isSoft: true,
  rightBorder: true,
),


// SOFT BORDER ROUNDED BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isSoft: true,
  isRounded: true,
  rightBorder: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isSoft: true,
  isRounded: true,
  rightBorder: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isSoft: true,
  isRounded: true,
  rightBorder: true,
),

// SOFT BORDER OUTLINED BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isOutlined: true,
  leftBorder: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isOutlined: true,
  leftBorder: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isOutlined: true,
  leftBorder: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isOutlined: true,
  leftBorder: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isOutlined: true,
  rightBorder: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isOutlined: true,
  rightBorder: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isOutlined: true,
  rightBorder: true,
),

// SOFT BORDER ROUNDED OUTLINED BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isOutlined: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isOutlined: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isOutlined: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isOutlined: true,
  isRounded: true,
  leftBorder: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isOutlined: true,
  isRounded: true,
  rightBorder: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isOutlined: true,
  isRounded: true,
  rightBorder: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isOutlined: true,
  isRounded: true,
  rightBorder: true,
),
''',
                          ),
                        ),

                        // dismissible badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Dismissible Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code>isDismissible: true</code> argument to set as dismissible badge. Try pushing close icon.',
                            uiView: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOLID DISMISSIBLE BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isDismissible: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isDismissible: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isDismissible: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isDismissible: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isRounded: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: Colors.black,
                                      isRounded: true,
                                      isDismissible: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT DISMISSIBLE BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // OUTLINED DISMISSIBLE BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isRounded: true,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isRounded: true,
                                      isOutlined: true,
                                      isDismissible: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // BORDER DISMISSIBLE BUTTONS
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isSoft: true,
                                      leftBorder: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isSoft: true,
                                      leftBorder: true,
                                      isRounded: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isSoft: true,
                                      rightBorder: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isSoft: true,
                                      rightBorder: true,
                                      isRounded: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isOutlined: true,
                                      leftBorder: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isOutlined: true,
                                      leftBorder: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isOutlined: true,
                                      rightBorder: true,
                                      isDismissible: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isRounded: true,
                                      isOutlined: true,
                                      rightBorder: true,
                                      isDismissible: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            codeView: '''
// SOLID DISMISSIBLE BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isDismissible: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isDismissible: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isDismissible: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isDismissible: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isRounded: true,
  isDismissible: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isDismissible: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: Colors.black,
  isRounded: true,
  isDismissible: true,
),

// SOFT DISMISSIBLE BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
  isDismissible: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
  isDismissible: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
  isDismissible: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  isDismissible: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
),

// OUTLINED DISMISSIBLE BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isOutlined: true,
  isDismissible: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isOutlined: true,
  isDismissible: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isOutlined: true,
  isDismissible: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isOutlined: true,
  isDismissible: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isRounded: true,
  isOutlined: true,
  isDismissible: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isOutlined: true,
  isDismissible: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isRounded: true,
  isOutlined: true,
  isDismissible: true,
),

// BORDER DISMISSIBLE BUTTONS
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
  leftBorder: true,
  isDismissible: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
  leftBorder: true,
  isRounded: true,
  isDismissible: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
  rightBorder: true,
  isDismissible: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  rightBorder: true,
  isRounded: true,
  isDismissible: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isOutlined: true,
  leftBorder: true,
  isDismissible: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isOutlined: true,
  leftBorder: true,
  isDismissible: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isOutlined: true,
  rightBorder: true,
  isDismissible: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isRounded: true,
  isOutlined: true,
  rightBorder: true,
  isDismissible: true,
),
''',
                          ),
                        ),

                        // tagstyle badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Tag Style Badges',
                            description:
                                'Use <code>CustomBadge()</code> to set a custom badge. Add <code>isTagStyle: true</code> argument to set with tag style.',
                            uiView: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOLID  TAG STYLE BUTTON
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isRounded: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: Colors.black,
                                      isRounded: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),
                                  ],
                                ),
                                SizedBox(height: kDefaultPadding),
                                Wrap(
                                  spacing: kDefaultPadding / 2,
                                  runSpacing: kDefaultPadding / 2,
                                  children: [
                                    // SOFT  TAG STYLE BUTTON
                                    // Badge for primary color
                                    CustomBadge(
                                      kText: 'Primary',
                                      kColor: kPrimaryColor,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for secondary color
                                    CustomBadge(
                                      kText: 'Secondary',
                                      kColor: kSecondaryColor,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for success status
                                    CustomBadge(
                                      kText: 'Success',
                                      kColor: kSuccessColor,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for informational status
                                    CustomBadge(
                                      kText: 'Info',
                                      kColor: kInfoColor,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for warning status
                                    CustomBadge(
                                      kText: 'Warning',
                                      kColor: kWarningColor,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for error status
                                    CustomBadge(
                                      kText: 'Error',
                                      kColor: kErrorColor,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),

                                    // Badge for dark color
                                    CustomBadge(
                                      kText: 'Dark',
                                      kColor: themeData.colorScheme.onSurface,
                                      isRounded: true,
                                      isSoft: true,
                                      isDismissible: true,
                                      isTagStyle: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            codeView: '''
// SOLID  TAG STYLE BUTTON
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isRounded: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: Colors.black,
  isRounded: true,
  isDismissible: true,
  isTagStyle: true,
),

// SOFT  TAG STYLE BUTTON
// Badge for primary color
CustomBadge(
  kText: 'Primary',
  kColor: kPrimaryColor,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for secondary color
CustomBadge(
  kText: 'Secondary',
  kColor: kSecondaryColor,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for success status
CustomBadge(
  kText: 'Success',
  kColor: kSuccessColor,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for informational status
CustomBadge(
  kText: 'Info',
  kColor: kInfoColor,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for warning status
CustomBadge(
  kText: 'Warning',
  kColor: kWarningColor,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for error status
CustomBadge(
  kText: 'Error',
  kColor: kErrorColor,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),

// Badge for dark color
CustomBadge(
  kText: 'Dark',
  kColor: themeData.colorScheme.onSurface,
  isRounded: true,
  isSoft: true,
  isDismissible: true,
  isTagStyle: true,
),
''',
                          ),
                        ),
                        // tagstyle badge
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Button with Badges',
                            description:
                                'To add a badge to a button, wrap the button with <code>Badge()</code>.',
                            uiView: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              children: [
                                // Custom icon button with badge
                                Badge(
                                  backgroundColor: kErrorColor,
                                  label: Text(
                                    '8',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: CustomIconButton(
                                    icon: Icons.notifications_none,
                                    buttonColor: kTableHeaderColor,
                                    iconColor: themeData.colorScheme.onSurface,
                                    shape: ButtonShape.circle,
                                    onTap: () {},
                                  ),
                                ),

                                // Custom square icon button with badge
                                Badge(
                                  backgroundColor: kSuccessColor,
                                  label: Text(
                                    '5',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: CustomIconButton(
                                    icon: Icons.menu,
                                    buttonColor: kPrimaryColor,
                                    iconColor: Colors.white,
                                    onTap: () {},
                                  ),
                                ),

                                // flat button with badge
                                Badge(
                                  backgroundColor: kErrorColor,
                                  label: Text(
                                    '5',
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: FlatButton(
                                    kText: 'Inbox',
                                    bgColor: kInfoColor,
                                    kTextColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
// Custom icon button with badge
Badge(
  backgroundColor: kErrorColor,
  label: Text(
    '8',
    style: const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w500,
    ),
  ),
  child: CustomIconButton(
    icon: Icons.notifications_none,
    buttonColor: kTableHeaderColor,
    iconColor:
        themeData.colorScheme.onSurface,
    shape: ButtonShape.circle,
    onTap: () {},
  ),
),

// Custom square icon button with badge
Badge(
  backgroundColor: kSuccessColor,
  label: Text(
    '5',
    style: const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w500,
    ),
  ),
  child: CustomIconButton(
    icon: Icons.menu,
    buttonColor: kPrimaryColor,
    iconColor: Colors.white,
    onTap: () {},
  ),
),

// flat button with badge

Badge(
  backgroundColor: kErrorColor,
  label: Text(
    '5',
    style: const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w500,
    ),
  ),
  child: FlatButton(
    kText: 'Inbox',
    bgColor: kInfoColor,
    kTextColor: Colors.white,
    onPressed: () {},
  ),
),
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
          PortalFooter(),
        ],
      ),
    );
  }
}

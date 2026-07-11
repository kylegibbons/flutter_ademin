import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).buttons(2); //update your page tittle here
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
                      lang.buttons(2).toUpperCase(),
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
                        BreadcrumbItem(
                          label: lang.buttons(2),
                          uri: RouteUri.button,
                        ),
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
                // Elevated Buttons
                ShowCodeCard(
                  cardTitle: 'Elevated Buttons',
                  description:
                      'Use <code>CustomElevatedButton()</code> to set elevated button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      CustomElevatedButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Secondary button
                      CustomElevatedButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Success button
                      CustomElevatedButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Info button
                      CustomElevatedButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Warning button
                      CustomElevatedButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Error button
                      CustomElevatedButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Dark button
                      CustomElevatedButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        onPressed: () {},
                      ),

                      //Light button
                      CustomElevatedButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        onPressed: () {},
                      ),

                      //Disabled button
                      CustomElevatedButton(
                        kText: 'Disabled',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
CustomElevatedButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Secondary button
CustomElevatedButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Success button
CustomElevatedButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Info button
CustomElevatedButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Warning button
CustomElevatedButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Error button
CustomElevatedButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// Dark button
CustomElevatedButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  onPressed: () {},
),

//Light button
CustomElevatedButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  onPressed: () {},
),

//Disabled button
CustomElevatedButton(
  kText: 'Disabled',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Elevated Rounded Buttons
                ShowCodeCard(
                  cardTitle: 'Elevated Rounded Buttons',
                  description:
                      'Use <code>CustomElevatedButton()</code> to set elevated button. Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      CustomElevatedButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Secondary button
                      CustomElevatedButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Success button
                      CustomElevatedButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Info button
                      CustomElevatedButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Warning button
                      CustomElevatedButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Error button
                      CustomElevatedButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Dark button
                      CustomElevatedButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      //Light button
                      CustomElevatedButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        isRounded: true, // set as rounded
                        onPressed: () {},
                      ),

                      // Disabled button
                      CustomElevatedButton(
                        kText: "Disabled",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true, // set as rounded
                        onPressed: null, // set as disabled
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
CustomElevatedButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Secondary button
CustomElevatedButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Success button
CustomElevatedButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Info button
CustomElevatedButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Warning button
CustomElevatedButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Error button
CustomElevatedButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Dark button
CustomElevatedButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  isRounded: true, // set as rounded
  onPressed: () {},
),

//Light button
CustomElevatedButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  isRounded: true, // set as rounded
  onPressed: () {},
),

// Disabled button
CustomElevatedButton(
  kText: "Disabled",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true, // set as rounded
  onPressed: null, // set as disabled
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Elevated Buttons with Icon
                ShowCodeCard(
                  cardTitle: 'Elevated Buttons with Icon',
                  description:
                      'Use <code>CustomElevatedButton()</code> to set elevated button. Add <code>kLeadingIcon</code> to set leading icon, and or <code>kTrailingIcon</code> to set trailing icon.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      CustomElevatedButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        onPressed: () {},
                      ),

                      // Secondary button
                      CustomElevatedButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        onPressed: () {},
                      ),

                      // Success button
                      CustomElevatedButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.access_alarm,
                        onPressed: () {},
                      ),

                      // Info button
                      CustomElevatedButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.access_alarm_outlined,
                        onPressed: () {},
                      ),

                      // Warning button
                      CustomElevatedButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Error button
                      CustomElevatedButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Dark button
                      CustomElevatedButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Light button
                      CustomElevatedButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Disabled button
                      CustomElevatedButton(
                        kText: 'Disabled',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.access_alarm,
                        onPressed: null, // set as disabled
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
CustomElevatedButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  onPressed: () {},
),

// Secondary button
CustomElevatedButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  onPressed: () {},
),

// Success button
CustomElevatedButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.access_alarm,
  onPressed: () {},
),

// Info button
CustomElevatedButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.access_alarm_outlined,
  onPressed: () {},
),

// Warning button
CustomElevatedButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// Error button
CustomElevatedButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// Dark button
CustomElevatedButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

//Light button
CustomElevatedButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// Disabled button
CustomElevatedButton(
  kText: 'Disabled',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.access_alarm,
  onPressed: null, // set as disabled
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Full Width Elevated Buttons
                ShowCodeCard(
                  cardTitle: 'Full Width Elevated Buttons',
                  description:
                      'Use <code>CustomElevatedButton()</code> to set an elevated button. Then add <code>isFullWidth: true</code> argument to set it as full width button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      CustomElevatedButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Secondary button
                      CustomElevatedButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Success button
                      CustomElevatedButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Info button
                      CustomElevatedButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Warning button
                      CustomElevatedButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Error button
                      CustomElevatedButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Dark button
                      CustomElevatedButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      //Light button
                      CustomElevatedButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Disabled button
                      CustomElevatedButton(
                        kText: 'Disabled',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: null, // set as disabled
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
CustomElevatedButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary button
CustomElevatedButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Success button
CustomElevatedButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Info button
CustomElevatedButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Warning button
CustomElevatedButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Error button
CustomElevatedButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Dark button
CustomElevatedButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

//Light button
CustomElevatedButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Disabled button
CustomElevatedButton(
  kText: 'Disabled',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: null, // set as disabled
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Flat Buttons
                ShowCodeCard(
                  cardTitle: 'Flat Buttons',
                  description:
                      'Use <code>FlatButton()</code> to set a flat button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary
                      FlatButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // secondary
                      FlatButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // success
                      FlatButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // info
                      FlatButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // warning
                      FlatButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // error
                      FlatButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // dark
                      FlatButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        onPressed: () {},
                      ),

                      // light
                      FlatButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        onPressed: () {},
                      ),

                      // Disabled
                      FlatButton(
                        kText: 'Disabled',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// secondary
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// success
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// info
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// warning
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// error
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  onPressed: () {},
),

// dark
FlatButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  onPressed: () {},
),

// light
FlatButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  onPressed: () {},
),

// Disabled
FlatButton(
  kText: 'Disabled',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Flat Rounded Buttons
                ShowCodeCard(
                  cardTitle: 'Flat Rounded Buttons',
                  description:
                      'Use <code>FlatButton()</code> to set a flat button. Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary
                      FlatButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // secondary
                      FlatButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // success
                      FlatButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // info
                      FlatButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // warning
                      FlatButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // error
                      FlatButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // dark
                      FlatButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // light
                      FlatButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // disabled
                      FlatButton(
                        kText: 'Disabled',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// secondary
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// success
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// info
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// warning
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// error
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// dark
FlatButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  isRounded: true,
  onPressed: () {},
),

// light
FlatButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  isRounded: true,
  onPressed: () {},
),

// disabled
FlatButton(
  kText: 'Disabled',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Flat Buttons with Icon
                ShowCodeCard(
                  cardTitle: 'Flat Buttons with Icon',
                  description:
                      'Use <code>FlatButton()</code> to set a flat button. Add <code>kLeadingIcon</code> to set leading icon, and or <code>kTrailingIcon</code> to set trailing icon.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary
                      FlatButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // secondary
                      FlatButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // success
                      FlatButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // info
                      FlatButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // warning
                      FlatButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // error
                      FlatButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // dark
                      FlatButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // light
                      FlatButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // disabled
                      FlatButton(
                        kText: 'Disabled',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// secondary
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// success
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// info
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// warning
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// error
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  onPressed: () {},
),

// dark
FlatButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// light
FlatButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  onPressed: () {},
),

// disabled
FlatButton(
  kText: 'Disabled',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Full Width Flat Buttons
                ShowCodeCard(
                  cardTitle: 'Full Width Flat Buttons',
                  description:
                      'Use <code>FlatButton()</code> to set an elevated button. Then add <code>isFullWidth: true</code> argument to set it as full width button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      FlatButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Secondary button
                      FlatButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Success button
                      FlatButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Info button
                      FlatButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Warning button
                      FlatButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Error button
                      FlatButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Dark button
                      FlatButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kTextColor: themeData.colorScheme.surface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      //Light button
                      FlatButton(
                        kText: 'Light',
                        bgColor: themeData.colorScheme.surface,
                        kTextColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Disabled button
                      FlatButton(
                        kText: "Disabled",
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        isFullWidth: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary button
FlatButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Success button
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Info button
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Warning button
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Error button
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Dark button
FlatButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kTextColor: themeData.colorScheme.surface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

//Light button
FlatButton(
  kText: 'Light',
  bgColor: themeData.colorScheme.surface,
  kTextColor: themeData.colorScheme.onSurface,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Disabled button
FlatButton(
  kText: "Disabled",
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  isFullWidth: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Outline Buttons
                ShowCodeCard(
                  cardTitle: 'Outlined Buttons',
                  description:
                      'Use <code>CustomOutlinedButton()</code> to set an outlined button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      CustomOutlinedButton(
                        kText: 'Primary',
                        outlineColor: kPrimaryColor,
                        onPressed: () {},
                      ),

                      // secondary button
                      CustomOutlinedButton(
                        kText: 'Secondary',
                        outlineColor: kSecondaryColor,
                        onPressed: () {},
                      ),

                      // success button
                      CustomOutlinedButton(
                        kText: 'Success',
                        outlineColor: kSuccessColor,
                        onPressed: () {},
                      ),

                      // info button
                      CustomOutlinedButton(
                        kText: 'Info',
                        outlineColor: kInfoColor,
                        onPressed: () {},
                      ),

                      // warning button
                      CustomOutlinedButton(
                        kText: 'Warning',
                        outlineColor: kWarningColor,
                        onPressed: () {},
                      ),

                      // error button
                      CustomOutlinedButton(
                        kText: 'Error',
                        outlineColor: kErrorColor,
                        onPressed: () {},
                      ),

                      // dark button
                      CustomOutlinedButton(
                        kText: 'Dark',
                        outlineColor: themeData.colorScheme.onSurface,
                        onPressed: () {},
                      ),

                      // disabled button
                      CustomOutlinedButton(
                        kText: 'Disabled',
                        outlineColor: kSuccessColor,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: kPrimaryColor,
  onPressed: () {},
),

// secondary button
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  onPressed: () {},
),

// success button
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  onPressed: () {},
),

// info button
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  onPressed: () {},
),

// warning button
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  onPressed: () {},
),

// error button
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  onPressed: () {},
),

// dark button
CustomOutlinedButton(
  kText: 'Dark',
  outlineColor: themeData.colorScheme.onSurface,
  onPressed: () {},
),

// disabled button
CustomOutlinedButton(
  kText: 'Disabled',
  outlineColor: kSuccessColor,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Outline Rounded Buttons
                ShowCodeCard(
                  cardTitle: 'Outlined Rounded Buttons',
                  description:
                      'Use <code>CustomOutlinedButton()</code> to set an outlined button. Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      CustomOutlinedButton(
                        kText: 'Primary',
                        outlineColor: kPrimaryColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // secondary button
                      CustomOutlinedButton(
                        kText: 'Secondary',
                        outlineColor: kSecondaryColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // success button
                      CustomOutlinedButton(
                        kText: 'Success',
                        outlineColor: kSuccessColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // info button
                      CustomOutlinedButton(
                        kText: 'Info',
                        outlineColor: kInfoColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // warning button
                      CustomOutlinedButton(
                        kText: 'Warning',
                        outlineColor: kWarningColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // error button
                      CustomOutlinedButton(
                        kText: 'Error',
                        outlineColor: kErrorColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // dark button
                      CustomOutlinedButton(
                        kText: 'Dark',
                        outlineColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // disabled button
                      CustomOutlinedButton(
                        kText: 'Disabled',
                        outlineColor: kInfoColor,
                        isRounded: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: kPrimaryColor,
  isRounded: true,
  onPressed: () {},
),

// secondary button
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  isRounded: true,
  onPressed: () {},
),

// success button
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  isRounded: true,
  onPressed: () {},
),

// info button
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  isRounded: true,
  onPressed: () {},
),

// warning button
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  isRounded: true,
  onPressed: () {},
),

// error button
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  isRounded: true,
  onPressed: () {},
),

// dark button
CustomOutlinedButton(
  kText: 'Dark',
  outlineColor: themeData.colorScheme.onSurface,
  isRounded: true,
  onPressed: () {},
),

// disabled button
CustomOutlinedButton(
  kText: 'Disabled',
  outlineColor: kInfoColor,
  isRounded: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Outline Buttons with icon
                ShowCodeCard(
                  cardTitle: 'Outlined Buttons with Icon',
                  description:
                      'Use <code>CustomOutlinedButton()</code> to set an outlined button. Add <code>kLeadingIcon</code> to set leading icon, and or <code>kTrailingIcon</code> to set trailing icon.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      CustomOutlinedButton(
                        kText: 'Primary',
                        outlineColor: kPrimaryColor,
                        kLeadingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // secondary button
                      CustomOutlinedButton(
                        kText: 'Secondary',
                        outlineColor: kSecondaryColor,
                        isRounded: true,
                        kLeadingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // success button
                      CustomOutlinedButton(
                        kText: 'Success',
                        outlineColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // info button
                      CustomOutlinedButton(
                        kText: 'Info',
                        outlineColor: kInfoColor,
                        isRounded: true,
                        kTrailingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // warning button
                      CustomOutlinedButton(
                        kText: 'Warning',
                        outlineColor: kWarningColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // error button
                      CustomOutlinedButton(
                        kText: 'Error',
                        outlineColor: kErrorColor,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // dark button
                      CustomOutlinedButton(
                        kText: 'Dark',
                        outlineColor: themeData.colorScheme.onSurface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // disabled button
                      CustomOutlinedButton(
                        kText: 'disabled',
                        outlineColor: kWarningColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: kPrimaryColor,
  kLeadingIcon: Icons.replay,
  onPressed: () {},
),

// secondary button
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  isRounded: true,
  kLeadingIcon: Icons.replay,
  onPressed: () {},
),

// success button
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  onPressed: () {},
),

// info button
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  isRounded: true,
  kTrailingIcon: Icons.replay,
  onPressed: () {},
),

// warning button
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// error button
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// dark button
CustomOutlinedButton(
  kText: 'Dark',
  outlineColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// disabled button
CustomOutlinedButton(
  kText: 'disabled',
  outlineColor: kWarningColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Full Width Outlined Buttons
                ShowCodeCard(
                  cardTitle: 'Full Width Outlined Buttons',
                  description:
                      'Use <code>CustomOutlinedButton()</code> to set an elevated button. Then add <code>isFullWidth: true</code> argument to set it as full width button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      CustomOutlinedButton(
                        kText: 'Primary',
                        outlineColor: kPrimaryColor,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Secondary button
                      CustomOutlinedButton(
                        kText: "Secondary",
                        outlineColor: kSecondaryColor,
                        isRounded: true,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Success button
                      CustomOutlinedButton(
                        kText: 'Success',
                        outlineColor: kSuccessColor,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Info button
                      CustomOutlinedButton(
                        kText: 'Info',
                        outlineColor: kInfoColor,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Warning button
                      CustomOutlinedButton(
                        kText: 'Warning',
                        outlineColor: kWarningColor,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Error button
                      CustomOutlinedButton(
                        kText: 'Error',
                        outlineColor: kErrorColor,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Dark button
                      CustomOutlinedButton(
                        kText: 'Dark',
                        outlineColor: themeData.colorScheme.onSurface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Disabled button
                      CustomOutlinedButton(
                        kText: 'Disabled',
                        outlineColor: kErrorColor,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: kPrimaryColor,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary button
CustomOutlinedButton(
  kText: "Secondary",
  outlineColor: kSecondaryColor,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Success button
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Info button
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Warning button
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Error button
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Dark button
CustomOutlinedButton(
  kText: 'Dark',
  outlineColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Disabled button
CustomOutlinedButton(
  kText: 'Disabled',
  outlineColor: kErrorColor,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Soft Buttons
                ShowCodeCard(
                  cardTitle: 'Soft Buttons',
                  description:
                      'Use <code>SoftButton()</code> to set a soft button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      SoftButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        onPressed: () {},
                      ),

                      // secondary button
                      SoftButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        onPressed: () {},
                      ),

                      // success button
                      SoftButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        onPressed: () {},
                      ),

                      // info button
                      SoftButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        onPressed: () {},
                      ),

                      // warning button
                      SoftButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        onPressed: () {},
                      ),

                      // error button
                      SoftButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        onPressed: () {},
                      ),

                      // dark button
                      SoftButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        onPressed: () {},
                      ),

                      // disabled button
                      SoftButton(
                        kText: 'Disabled',
                        bgColor: kPrimaryColor,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
SoftButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  onPressed: () {},
),

// secondary button
SoftButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  onPressed: () {},
),

// success button
SoftButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  onPressed: () {},
),

// info button
SoftButton(
  kText: 'Info',
  bgColor: kInfoColor,
  onPressed: () {},
),

// warning button
SoftButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  onPressed: () {},
),

// error button
SoftButton(
  kText: 'Error',
  bgColor: kErrorColor,
  onPressed: () {},
),

// dark button
SoftButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  onPressed: () {},
),

// disabled button
SoftButton(
  kText: 'Disabled',
  bgColor: kPrimaryColor,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Soft Rounded Buttons
                ShowCodeCard(
                  cardTitle: 'Soft Rounded Buttons',
                  description:
                      'Use <code>SoftButton()</code> to set a soft button. Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      SoftButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // secondary button
                      SoftButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // success button
                      SoftButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // info button
                      SoftButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // warning button
                      SoftButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // error button
                      SoftButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // dark button
                      SoftButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Disabled button
                      SoftButton(
                        kText: 'Disabled',
                        bgColor: kSecondaryColor,
                        isRounded: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
SoftButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  isRounded: true,
  onPressed: () {},
),

// secondary button
SoftButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  isRounded: true,
  onPressed: () {},
),

// success button
SoftButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  isRounded: true,
  onPressed: () {},
),

// info button
SoftButton(
  kText: 'Info',
  bgColor: kInfoColor,
  isRounded: true,
  onPressed: () {},
),

// warning button
SoftButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  isRounded: true,
  onPressed: () {},
),

// error button
SoftButton(
  kText: 'Error',
  bgColor: kErrorColor,
  isRounded: true,
  onPressed: () {},
),

// dark button
SoftButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  isRounded: true,
  onPressed: () {},
),

// disabled button
SoftButton(
  kText: 'Disabled',
  bgColor: kSecondaryColor,
  isRounded: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Soft Buttons with Icon
                ShowCodeCard(
                  cardTitle: 'Soft Buttons with Icon',
                  description:
                      'Use <code>SoftButton()</code> to set a soft button. Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary button
                      SoftButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kLeadingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // secondary button
                      SoftButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        isRounded: true,
                        kLeadingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // success button
                      SoftButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // info button
                      SoftButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        isRounded: true,
                        kTrailingIcon: Icons.replay,
                        onPressed: () {},
                      ),

                      // warning button
                      SoftButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // error button
                      SoftButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // dark button
                      SoftButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // disabled button
                      SoftButton(
                        kText: 'Disabled',
                        bgColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// primary button
SoftButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.replay,
  onPressed: () {},
),

// secondary button
SoftButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  isRounded: true,
  kLeadingIcon: Icons.replay,
  onPressed: () {},
),

// success button
SoftButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  onPressed: () {},
),

// info button
SoftButton(
  kText: 'Info',
  bgColor: kInfoColor,
  isRounded: true,
  kTrailingIcon: Icons.replay,
  onPressed: () {},
),

// warning button
SoftButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// error button
SoftButton(
  kText: 'Error',
  bgColor: kErrorColor,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// dark button
SoftButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// disabled button
SoftButton(
  kText: 'Disabled',
  bgColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                // Full Width Soft Buttons
                ShowCodeCard(
                  cardTitle: 'Full Width Soft Buttons',
                  description:
                      'Use <code>SoftButton()</code> to set an elevated button. Then add <code>isFullWidth: true</code> argument to set it as full width button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button
                      SoftButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Secondary button
                      SoftButton(
                        kText: "Secondary",
                        bgColor: kSecondaryColor,
                        isRounded: true,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Success button
                      SoftButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Info button
                      SoftButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Warning button
                      SoftButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Error button
                      SoftButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Dark button
                      SoftButton(
                        kText: 'Dark',
                        bgColor: themeData.colorScheme.onSurface,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Disabled button
                      SoftButton(
                        kText: 'Disabled',
                        bgColor: kInfoColor,
                        isRounded: true,
                        kLeadingIcon: Icons.access_alarm,
                        isFullWidth: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button
SoftButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary button
SoftButton(
  kText: "Secondary",
  bgColor: kSecondaryColor,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Success button
SoftButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Info button
SoftButton(
  kText: 'Info',
  bgColor: kInfoColor,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: () {},
),

// Warning button
SoftButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Error button
SoftButton(
  kText: 'Error',
  bgColor: kErrorColor,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Dark button
SoftButton(
  kText: 'Dark',
  bgColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Disabled button
SoftButton(
  kText: 'Disabled',
  bgColor: kInfoColor,
  isRounded: true,
  kLeadingIcon: Icons.access_alarm,
  isFullWidth: true,
  onPressed: null,
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Gradient Buttons
                ShowCodeCard(
                  cardTitle: 'Gradient Buttons',
                  description:
                      'Use <code>GradientButton()</code> to set a gradient button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button with gradient background
                      GradientButton(
                        kText: 'Primary',
                        bgColor: [Colors.cyan, Colors.greenAccent],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Secondary button with gradient background
                      GradientButton(
                        kText: 'Secondary',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Success button with gradient background
                      GradientButton(
                        kText: 'Success',
                        bgColor: [Colors.blue, Colors.deepPurple],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Info button with gradient background
                      GradientButton(
                        kText: 'Info',
                        bgColor: [Colors.pinkAccent, Colors.orangeAccent],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Warning button with gradient background
                      GradientButton(
                        kText: 'Warning',
                        bgColor: [Colors.lightBlue, Colors.blue],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Error button with gradient background
                      GradientButton(
                        kText: 'Error',
                        bgColor: [Colors.green, Colors.yellowAccent],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),

                      // Dark button with gradient background
                      GradientButton(
                        kText: 'Dark',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button with gradient background
GradientButton(
  kText: 'Primary',
  bgColor: [Colors.cyan, Colors.greenAccent],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Secondary button with gradient background
GradientButton(
  kText: 'Secondary',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Success button with gradient background
GradientButton(
  kText: 'Success',
  bgColor: [Colors.blue, Colors.deepPurple],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Info button with gradient background
GradientButton(
  kText: 'Info',
  bgColor: [Colors.pinkAccent, Colors.orangeAccent],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Warning button with gradient background
GradientButton(
  kText: 'Warning',
  bgColor: [Colors.lightBlue, Colors.blue],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Error button with gradient background
GradientButton(
  kText: 'Error',
  bgColor: [Colors.green, Colors.yellowAccent],
  kTextColor: Colors.white,
  onPressed: () {},
),

// Dark button with gradient background
GradientButton(
  kText: 'Dark',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  onPressed: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Gradient Rounded Buttons
                ShowCodeCard(
                  cardTitle: 'Gradient Rounded Buttons',
                  description:
                      'Use <code>GradientButton()</code> to set a gradient rounded button.  Add <code>isRounded: true</code> parameter.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button with gradient background
                      GradientButton(
                        kText: 'Primary',
                        bgColor: [Colors.cyan, Colors.greenAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Secondary button with gradient background
                      GradientButton(
                        kText: 'Secondary',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Success button with gradient background
                      GradientButton(
                        kText: 'Success',
                        bgColor: [Colors.blue, Colors.deepPurple],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Info button with gradient background
                      GradientButton(
                        kText: 'Info',
                        bgColor: [Colors.pinkAccent, Colors.orangeAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Warning button with gradient background
                      GradientButton(
                        kText: 'Warning',
                        bgColor: [Colors.lightBlue, Colors.blue],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Error button with gradient background
                      GradientButton(
                        kText: 'Error',
                        bgColor: [Colors.green, Colors.yellowAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),

                      // Dark button with gradient background
                      GradientButton(
                        kText: 'Dark',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        isRounded: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button with gradient background
GradientButton(
  kText: 'Primary',
  bgColor: [Colors.cyan, Colors.greenAccent],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Secondary button with gradient background
GradientButton(
  kText: 'Secondary',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Success button with gradient background
GradientButton(
  kText: 'Success',
  bgColor: [Colors.blue, Colors.deepPurple],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Info button with gradient background
GradientButton(
  kText: 'Info',
  bgColor: [Colors.pinkAccent, Colors.orangeAccent],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Warning button with gradient background
GradientButton(
  kText: 'Warning',
  bgColor: [Colors.lightBlue, Colors.blue],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Error button with gradient background
GradientButton(
  kText: 'Error',
  bgColor: [Colors.green, Colors.yellowAccent],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),

// Dark button with gradient background
GradientButton(
  kText: 'Dark',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  isRounded: true,
  onPressed: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Gradient Buttons with Icon
                ShowCodeCard(
                  cardTitle: 'Gradient Buttons with Icon',
                  description:
                      'Use <code>GradientButton()</code> to set a gradient button.  Add <code>kLeadingIcon</code> to set leading icon, and or <code>kTrailingIcon</code> to set trailing icon.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button with gradient background
                      GradientButton(
                        kText: 'Primary',
                        bgColor: [Colors.cyan, Colors.greenAccent],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // Secondary button with gradient background
                      GradientButton(
                        kText: 'Secondary',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // Success button with gradient background
                      GradientButton(
                        kText: 'Success',
                        bgColor: [Colors.blue, Colors.deepPurple],
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // Info button with gradient background
                      GradientButton(
                        kText: 'Info',
                        bgColor: [Colors.pinkAccent, Colors.orangeAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.person_2_outlined,
                        onPressed: () {},
                      ),

                      // Warning button with gradient background
                      GradientButton(
                        kText: 'Warning',
                        bgColor: [Colors.lightBlue, Colors.blue],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Error button with gradient background
                      GradientButton(
                        kText: 'Error',
                        bgColor: [Colors.green, Colors.yellowAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),

                      // Dark button with gradient background
                      GradientButton(
                        kText: 'Dark',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button with gradient background
GradientButton(
  kText: 'Primary',
  bgColor: [Colors.cyan, Colors.greenAccent],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// Secondary button with gradient background
GradientButton(
  kText: 'Secondary',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// Success button with gradient background
GradientButton(
  kText: 'Success',
  bgColor: [Colors.blue, Colors.deepPurple],
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// Info button with gradient background
GradientButton(
  kText: 'Info',
  bgColor: [Colors.pinkAccent, Colors.orangeAccent],
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.person_2_outlined,
  onPressed: () {},
),

// Warning button with gradient background
GradientButton(
  kText: 'Warning',
  bgColor: [Colors.lightBlue, Colors.blue],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),

// Error button with gradient background
GradientButton(
  kText: 'Error',
  bgColor: [Colors.green, Colors.yellowAccent],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  onPressed: () {},
),

// Dark button with gradient background
GradientButton(
  kText: 'Dark',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  onPressed: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Full Width Gradient Buttons
                ShowCodeCard(
                  cardTitle: 'Full Width Gradient Buttons',
                  description:
                      'Use <code>GradientButton()</code> to set a gradient button. Then add <code>isFullWidth: true</code> argument to set it as full width button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // Primary button with gradient background
                      GradientButton(
                        kText: 'Primary',
                        bgColor: [Colors.cyan, Colors.greenAccent],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Secondary button with gradient background
                      GradientButton(
                        kText: 'Secondary',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Success button with gradient background
                      GradientButton(
                        kText: 'Success',
                        bgColor: [Colors.blue, Colors.deepPurple],
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Info button with gradient background
                      GradientButton(
                        kText: 'Info',
                        bgColor: [Colors.pinkAccent, Colors.orangeAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.person_2_outlined,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Warning button with gradient background
                      GradientButton(
                        kText: 'Warning',
                        bgColor: [Colors.lightBlue, Colors.blue],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Error button with gradient background
                      GradientButton(
                        kText: 'Error',
                        bgColor: [Colors.green, Colors.yellowAccent],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),

                      // Dark button with gradient background
                      GradientButton(
                        kText: 'Dark',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isFullWidth: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// Primary button with gradient background
GradientButton(
  kText: 'Primary',
  bgColor: [Colors.cyan, Colors.greenAccent],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary button with gradient background
GradientButton(
  kText: 'Secondary',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  isFullWidth: true,
  onPressed: () {},
),

// Success button with gradient background
GradientButton(
  kText: 'Success',
  bgColor: [Colors.blue, Colors.deepPurple],
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  isFullWidth: true,
  onPressed: () {},
),

// Info button with gradient background
GradientButton(
  kText: 'Info',
  bgColor: [Colors.pinkAccent, Colors.orangeAccent],
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.person_2_outlined,
  isFullWidth: true,
  onPressed: () {},
),

// Warning button with gradient background
GradientButton(
  kText: 'Warning',
  bgColor: [Colors.lightBlue, Colors.blue],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Error button with gradient background
GradientButton(
  kText: 'Error',
  bgColor: [Colors.green, Colors.yellowAccent],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),

// Dark button with gradient background
GradientButton(
  kText: 'Dark',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isFullWidth: true,
  onPressed: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Fancy Icon Button
                ShowCodeCard(
                  cardTitle: 'Fancy Icon Button',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CardDescription(
                        content:
                            'Use <code>FancyIconButton()</code> to set button with icon (fancy style).',
                      ),
                      const SizedBox(height: 0.5 * kDefaultPadding),

                      // LEADING FANCY ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kLeadingIcon: Icons.add_circle_outline,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kLeadingIcon: Icons.shopping_cart_checkout,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kLeadingIcon: Icons.check,
                            onPressed: () {},
                          ),

                          //info button
                          FancyIconButton(
                            kText: 'Info',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kLeadingIcon: Icons.info_outline,
                            onPressed: () {},
                          ),

                          // Warning Button
                          FancyIconButton(
                            kText: 'Warning',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kLeadingIcon: Icons.warning_outlined,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kLeadingIcon: Icons.error_outline,
                            onPressed: () {},
                          ),

                          // Dark Button
                          FancyIconButton(
                            kText: 'Dark',
                            kTextColor: themeData.colorScheme.surface,
                            bgColor: themeData.colorScheme.onSurface,
                            kLeadingIcon: Icons.contrast_outlined,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Disabled',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kLeadingIcon: Icons.add_circle_outline,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),

                      const SizedBox(height: kDefaultPadding),

                      // ROUNDED LEADING FANCY ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kLeadingIcon: Icons.add_circle_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kLeadingIcon: Icons.shopping_cart_checkout,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kLeadingIcon: Icons.check,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          //info button
                          FancyIconButton(
                            kText: 'Info',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kLeadingIcon: Icons.info_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Warning Button
                          FancyIconButton(
                            kText: 'Warning',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kLeadingIcon: Icons.warning_outlined,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kLeadingIcon: Icons.error_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          FancyIconButton(
                            kText: 'Dark',
                            kTextColor: themeData.colorScheme.surface,
                            bgColor: themeData.colorScheme.onSurface,
                            kLeadingIcon: Icons.contrast_outlined,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Disabled',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kLeadingIcon: Icons.shopping_cart_checkout,
                            isRounded: true,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),

                      const SizedBox(height: kDefaultPadding),

                      // TRAILING FANCY ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kTrailingIcon: Icons.add_circle_outline,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kTrailingIcon: Icons.shopping_cart_checkout,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kTrailingIcon: Icons.check,
                            onPressed: () {},
                          ),

                          //info button
                          FancyIconButton(
                            kText: 'Info',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kTrailingIcon: Icons.info_outline,
                            onPressed: () {},
                          ),

                          // Warning Button
                          FancyIconButton(
                            kText: 'Warning',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kTrailingIcon: Icons.warning_outlined,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kTrailingIcon: Icons.error_outline,
                            onPressed: () {},
                          ),

                          FancyIconButton(
                            kText: 'Dark',
                            kTextColor: themeData.colorScheme.surface,
                            bgColor: themeData.colorScheme.onSurface,
                            kTrailingIcon: Icons.contrast_outlined,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kTrailingIcon: Icons.check,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),

                      const SizedBox(height: kDefaultPadding),

                      // ROUNDED FANCY ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kTrailingIcon: Icons.add_circle_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kTrailingIcon: Icons.shopping_cart_checkout,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kTrailingIcon: Icons.check,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          //info button
                          FancyIconButton(
                            kText: 'Info',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kTrailingIcon: Icons.info_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Warning Button
                          FancyIconButton(
                            kText: 'Warning',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kTrailingIcon: Icons.warning_outlined,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kTrailingIcon: Icons.error_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Dark Button
                          FancyIconButton(
                            kText: 'Dark',
                            kTextColor: themeData.colorScheme.surface,
                            bgColor: themeData.colorScheme.onSurface,
                            kTrailingIcon: Icons.contrast_outlined,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Disabled',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kTrailingIcon: Icons.info_outline,
                            isRounded: true,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding),

                      // LEADING + TRAILING ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.add_circle_outline,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.shopping_cart_checkout,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.check,
                            onPressed: () {},
                          ),

                          //info button
                          FancyIconButton(
                            kText: 'Info',
                            kTextColor: Colors.white,
                            bgColor: kInfoColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.info_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Warning Button
                          FancyIconButton(
                            kText: 'Warning',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.warning_outlined,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.error_outline,
                            isRounded: true,
                            onPressed: () {},
                          ),

                          // Dark Button
                          FancyIconButton(
                            kText: 'Dark',
                            kTextColor: themeData.colorScheme.surface,
                            bgColor: themeData.colorScheme.onSurface,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.contrast_outlined,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Disabled',
                            kTextColor: Colors.white,
                            bgColor: kWarningColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.warning_outlined,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),

                      const SizedBox(height: kDefaultPadding),

                      // Full width FANCY ICON BUTTON
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Primary Button
                          FancyIconButton(
                            kText: 'Primary',
                            kTextColor: Colors.white,
                            bgColor: kPrimaryColor,
                            kLeadingIcon: Icons.add_circle_outline,
                            isFullWidth: true,
                            onPressed: () {},
                          ),

                          // Secondary Button
                          FancyIconButton(
                            kText: 'Secondary',
                            kTextColor: Colors.white,
                            bgColor: kSecondaryColor,
                            kTrailingIcon: Icons.shopping_cart_checkout,
                            isRounded: true,
                            isFullWidth: true,
                            onPressed: () {},
                          ),

                          // Success Button
                          FancyIconButton(
                            kText: 'Success',
                            kTextColor: Colors.white,
                            bgColor: kSuccessColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.check,
                            isFullWidth: true,
                            onPressed: () {},
                          ),

                          // Error Button
                          FancyIconButton(
                            kText: 'Error',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.error_outline,
                            isRounded: true,
                            isFullWidth: true,
                            onPressed: () {},
                          ),

                          // Disabled Button
                          FancyIconButton(
                            kText: 'Disabled',
                            kTextColor: Colors.white,
                            bgColor: kErrorColor,
                            kLeadingIcon: Icons.person_outline,
                            kTrailingIcon: Icons.error_outline,
                            isRounded: true,
                            isFullWidth: true,
                            onPressed: null, // set as disabled
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// LEADING FANCY ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.add_circle_outline,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kLeadingIcon: Icons.shopping_cart_checkout,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kLeadingIcon: Icons.check,
  onPressed: () {},
),

//info button
FancyIconButton(
  kText: 'Info',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.info_outline,
  onPressed: () {},
),

// Warning Button
FancyIconButton(
  kText: 'Warning',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kLeadingIcon: Icons.warning_outlined,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.error_outline,
  onPressed: () {},
),

// Dark Button
FancyIconButton(
  kText: 'Dark',
  kTextColor: themeData.colorScheme.surface,
  bgColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.contrast_outlined,
  onPressed: () {},
),

// Disabled Button
FancyIconButton(
  kText: 'Disabled',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.add_circle_outline,
  onPressed: null, // set as disabled
),

// ROUNDED LEADING FANCY ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.add_circle_outline,
  isRounded: true,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kLeadingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kLeadingIcon: Icons.check,
  isRounded: true,
  onPressed: () {},
),

//info button
FancyIconButton(
  kText: 'Info',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.info_outline,
  isRounded: true,
  onPressed: () {},
),

// Warning Button
FancyIconButton(
  kText: 'Warning',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kLeadingIcon: Icons.warning_outlined,
  isRounded: true,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.error_outline,
  isRounded: true,
  onPressed: () {},
),

// Dark Button
FancyIconButton(
  kText: 'Dark',
  kTextColor: themeData.colorScheme.surface,
  bgColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.contrast_outlined,
  isRounded: true,
  onPressed: () {},
),

// Disabled Button
FancyIconButton(
  kText: 'Disabled',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kLeadingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  onPressed: null, // set as disabled
),

// TRAILING FANCY ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kTrailingIcon: Icons.add_circle_outline,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kTrailingIcon: Icons.check,
  onPressed: () {},
),

//info button
FancyIconButton(
  kText: 'Info',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kTrailingIcon: Icons.info_outline,
  onPressed: () {},
),

// Warning Button
FancyIconButton(
  kText: 'Warning',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kTrailingIcon: Icons.warning_outlined,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kTrailingIcon: Icons.error_outline,
  onPressed: () {},
),

// Dark Button
FancyIconButton(
  kText: 'Dark',
  kTextColor: themeData.colorScheme.surface,
  bgColor: themeData.colorScheme.onSurface,
  kTrailingIcon: Icons.contrast_outlined,
  onPressed: () {},
),

// Disabled Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kTrailingIcon: Icons.check,
  onPressed: null, // set as disabled
),

// ROUNDED FANCY ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kTrailingIcon: Icons.add_circle_outline,
  isRounded: true,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kTrailingIcon: Icons.check,
  isRounded: true,
  onPressed: () {},
),

//info button
FancyIconButton(
  kText: 'Info',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kTrailingIcon: Icons.info_outline,
  isRounded: true,
  onPressed: () {},
),

// Warning Button
FancyIconButton(
  kText: 'Warning',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kTrailingIcon: Icons.warning_outlined,
  isRounded: true,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kTrailingIcon: Icons.error_outline,
  isRounded: true,
  onPressed: () {},
),

// Dark Button
FancyIconButton(
  kText: 'Dark',
  kTextColor: themeData.colorScheme.surface,
  bgColor: themeData.colorScheme.onSurface,
  kTrailingIcon: Icons.contrast_outlined,
  isRounded: true,
  onPressed: () {},
),

// Disabled Button
FancyIconButton(
  kText: 'Disabled',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.warning_outlined,
  onPressed: null, // set as disabled
),

// LEADING + TRAILING ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.add_circle_outline,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.check,
  onPressed: () {},
),

//info button
FancyIconButton(
  kText: 'Info',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.info_outline,
  isRounded: true,
  onPressed: () {},
),

// Warning Button
FancyIconButton(
  kText: 'Warning',
  kTextColor: Colors.white,
  bgColor: kWarningColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.warning_outlined,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.error_outline,
  isRounded: true,
  onPressed: () {},
),

FancyIconButton(
  kText: 'Dark',
  kTextColor: themeData.colorScheme.surface,
  bgColor: themeData.colorScheme.onSurface,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.contrast_outlined,
  onPressed: () {},
),

// FULL WIDTH FANCY ICON BUTTON

// Primary Button
FancyIconButton(
  kText: 'Primary',
  kTextColor: Colors.white,
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.add_circle_outline,
  isFullWidth: true,
  onPressed: () {},
),

// Secondary Button
FancyIconButton(
  kText: 'Secondary',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Success Button
FancyIconButton(
  kText: 'Success',
  kTextColor: Colors.white,
  bgColor: kSuccessColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.check,
  isFullWidth: true,
  onPressed: () {},
),

// Error Button
FancyIconButton(
  kText: 'Error',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.error_outline,
  isRounded: true,
  isFullWidth: true,
  onPressed: () {},
),

// Disabled Button
FancyIconButton(
  kText: 'Disabled',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.person_outline,
  kTrailingIcon: Icons.error_outline,
  isRounded: true,
  isFullWidth: true,
    onPressed: null, // set as disabled
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Animated Buttons
                ShowCodeCard(
                  cardTitle: 'Animated Buttons',
                  description:
                      'Add <code>isAnimated: true</code> to set an animated button. Try hovering the button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // custom elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // custom rounded elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.access_alarm,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // rounded flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        isRounded: true,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // custom outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kInfoColor,
                        kTrailingIcon: Icons.replay,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // custom rounded outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        isRounded: true,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kPrimaryColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // rounded soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kErrorColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isRounded: true,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // rounded gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kInfoColor,
                        kLeadingIcon: Icons.info_outline,
                        isAnimated: true,
                        onPressed: () {},
                      ),

                      // rounded fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kSecondaryColor,
                        kTrailingIcon: Icons.shopping_cart_checkout,
                        isRounded: true,
                        isAnimated: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// custom elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  isAnimated: true,
  onPressed: () {},
),

// custom rounded elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.access_alarm,
  isAnimated: true,
  onPressed: () {},
),

// flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  isAnimated: true,
  onPressed: () {},
),

// rounded flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  isRounded: true,
  isAnimated: true,
  onPressed: () {},
),

// custom outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kInfoColor,
  kTrailingIcon: Icons.replay,
  isAnimated: true,
  onPressed: () {},
),

// custom rounded outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  isRounded: true,
  isAnimated: true,
  onPressed: () {},
),

// soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isAnimated: true,
  onPressed: () {},
),

// rounded soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kErrorColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  isAnimated: true,
  onPressed: () {},
),

// gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  isAnimated: true,
  onPressed: () {},
),

// rounded gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  isAnimated: true,
  onPressed: () {},
),

// fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.info_outline,
  isAnimated: true,
  onPressed: () {},
),

// rounded fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  isAnimated: true,
  onPressed: () {},
),


''',
                ),

                SizedBox(height: kDefaultPadding),

                //Loading Buttons
                ShowCodeCard(
                  cardTitle: 'Loading Buttons',
                  description:
                      'Add <code>isLoading: true</code> to set a loading button. Loading button provides visual feedback to users when an action is being processed. Try pressing the button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // custom elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        isLoading: isLoading,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // custom rounded elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.access_alarm,
                        isLoading: isLoading,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        isLoading: isLoading,
                        loadingText: 'Updating...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // rounded flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        isRounded: true,
                        isLoading: isLoading,
                        loadingText: 'Updating...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // custom outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kInfoColor,
                        kTrailingIcon: Icons.replay,
                        isLoading: isLoading,
                        loadingText: 'Processing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // custom rounded outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        isRounded: true,
                        isLoading: isLoading,
                        loadingText: 'Processing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kPrimaryColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isLoading: isLoading,
                        loadingText: 'Accessing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // rounded soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kErrorColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isRounded: true,
                        isLoading: isLoading,
                        loadingText: 'Accessing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        isLoading: isLoading,
                        loadingText: 'Processing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // rounded gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        isLoading: isLoading,
                        loadingText: 'Processing...',
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kInfoColor,
                        kLeadingIcon: Icons.info_outline,
                        isLoading: isLoading,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),

                      // rounded fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kSecondaryColor,
                        kTrailingIcon: Icons.shopping_cart_checkout,
                        isRounded: true,
                        isLoading: isLoading,
                        onPressed: () async {
                          setState(() => isLoading = true);
                          await Future.delayed(const Duration(seconds: 4));
                          setState(() => isLoading = false);
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// custom elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  isLoading: isLoading,
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// custom rounded elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.access_alarm,
  isLoading: isLoading,
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  isLoading: isLoading,
  loadingText: 'Updating...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// rounded flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  isRounded: true,
  isLoading: isLoading,
  loadingText: 'Updating...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// custom outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kInfoColor,
  kTrailingIcon: Icons.replay,
  isLoading: isLoading,
  loadingText: 'Processing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// custom rounded outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  isRounded: true,
  isLoading: isLoading,
  loadingText: 'Processing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isLoading: isLoading,
  loadingText: 'Accessing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// rounded soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kErrorColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  isLoading: isLoading,
  loadingText: 'Accessing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  isLoading: isLoading,
  loadingText: 'Processing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// rounded gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  isLoading: isLoading,
  loadingText: 'Processing...',
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.info_outline,
  isLoading: isLoading,
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),

// rounded fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  isLoading: isLoading,
  onPressed: () async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 4));
    setState(() => isLoading = false);
  },
),


''',
                ),

                SizedBox(height: kDefaultPadding),

                //Custom Icon Buttons
                ShowCodeCard(
                  cardTitle: 'Custom Icon Buttons',
                  description:
                      'Use <code>CustomIconButton()</code> to set a custom icon button, add <code>useFontAwesome: true</code> to switch to FontAwesome, add <code>shape: ButtonShape.circle</code> to switch to circle button.',
                  height: 400,
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // send button
                          CustomIconButton(
                            icon: Icons.send_outlined,
                            buttonColor: kPrimaryColor,
                            iconColor: Colors.white,
                            onTap: () {},
                          ),

                          // help button
                          CustomIconButton(
                            icon: Icons.question_answer,
                            buttonColor: kErrorColor,
                            iconColor: Colors.white,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),

                          // new chat button with tooltip
                          CustomIconButton(
                            icon: Icons.add,
                            buttonColor: kSuccessColor.withValues(alpha: 0.1),
                            iconColor: kSuccessColor,
                            tooltipMessage: 'New Chat',
                            onTap: () {},
                          ),

                          // emoji button
                          CustomIconButton(
                            icon: Icons.emoji_emotions_outlined,
                            onTap: () {},
                          ),

                          // attachment button
                          CustomIconButton(
                            icon: Icons.attach_file,
                            onTap: () {},
                          ),

                          // search button
                          CustomIconButton(
                            icon: Icons.search_outlined,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),

                          // info button
                          CustomIconButton(
                            icon: Icons.info_outline,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // github button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.github,
                            buttonColor: const Color(0xff181717),
                            iconColor: Colors.white,
                            onTap: () {},
                          ),

                          // google button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.google,
                            buttonColor: const Color(0xffDB4437),
                            iconColor: Colors.white,
                            onTap: () {},
                          ),

                          // facebook button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.facebook,
                            buttonColor: const Color(0xff1877F2),
                            iconColor: Colors.white,
                            onTap: () {},
                          ),

                          // apple button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.apple,
                            buttonColor: const Color(0xff1877F2),
                            iconColor: Colors.white,
                            onTap: () {},
                          ),

                          // github button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.github,
                            buttonColor: const Color(0xff181717),
                            iconColor: Colors.white,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),

                          // google button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.google,
                            buttonColor: const Color(0xffDB4437),
                            iconColor: Colors.white,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),

                          // facebook button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.facebook,
                            buttonColor: const Color(0xff1877F2),
                            iconColor: Colors.white,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),

                          // apple button
                          CustomIconButton(
                            useFontAwesome: true,
                            icon: FontAwesomeIcons.apple,
                            buttonColor: const Color(0xff1877F2),
                            iconColor: Colors.white,
                            shape: ButtonShape.circle,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// send button
CustomIconButton(
  icon: Icons.send_outlined,
  buttonColor: kPrimaryColor,
  iconColor: Colors.white,
  onTap: () {},
),

// help button
CustomIconButton(
  icon: Icons.question_answer,
  buttonColor: kErrorColor,
  iconColor: Colors.white,
  shape: ButtonShape.circle,
  onTap: () {},
),

// new chat button with tooltip
CustomIconButton(
  icon: Icons.add,
  buttonColor: kSuccessColor.withValues(alpha: 0.1),
  iconColor: kSuccessColor,
  tooltipMessage: 'New Chat',
  onTap: () {},
),

// emoji button
CustomIconButton(
  icon: Icons.emoji_emotions_outlined,
  onTap: () {},
),

// attachment button
CustomIconButton(
  icon: Icons.attach_file,
  onTap: () {},
),

// search button
CustomIconButton(
  icon: Icons.search_outlined,
  shape: ButtonShape.circle,
  onTap: () {},
),

// info button
CustomIconButton(
  icon: Icons.info_outline,
  shape: ButtonShape.circle,
  onTap: () {},
),

// github button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.github,
  buttonColor: const Color(0xff181717),
  iconColor: Colors.white,
  onTap: () {},
),

// google button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.google,
  buttonColor: const Color(0xffDB4437),
  iconColor: Colors.white,
  onTap: () {},
),

// facebook button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.facebook,
  buttonColor: const Color(0xff1877F2),
  iconColor: Colors.white,
  onTap: () {},
),

// apple button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.apple,
  buttonColor: const Color(0xff1877F2),
  iconColor: Colors.white,
  onTap: () {},
),

// github button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.github,
  buttonColor: const Color(0xff181717),
  iconColor: Colors.white,
  shape: ButtonShape.circle,
  onTap: () {},
),

// google button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.google,
  buttonColor: const Color(0xffDB4437),
  iconColor: Colors.white,
  shape: ButtonShape.circle,
  onTap: () {},
),

// facebook button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.facebook,
  buttonColor: const Color(0xff1877F2),
  iconColor: Colors.white,
  shape: ButtonShape.circle,
  onTap: () {},
),

// apple button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.apple,
  buttonColor: const Color(0xff1877F2),
  iconColor: Colors.white,
  shape: ButtonShape.circle,
  onTap: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Button Size
                ShowCodeCard(
                  cardTitle: 'Button Size',
                  description:
                      'Use <code>size: ButtonSize.small</code> to set small button, <code>size: ButtonSize.medium</code> for medium button, <code>size: ButtonSize.large</code> for large button',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // custom elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // custom rounded elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        isRounded: true,
                        kTrailingIcon: Icons.access_alarm,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ),

                      // custom elevated button
                      CustomElevatedButton(
                        kText: 'Elevated Button',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.access_alarm,
                        kTrailingIcon: Icons.check,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // rounded flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        kTrailingIcon: Icons.person_2_outlined,
                        isRounded: true,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ),

                      // flat button
                      FlatButton(
                        kText: 'Flat Button',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.person_2_outlined,
                        kTrailingIcon: Icons.check,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // custom outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kInfoColor,
                        kTrailingIcon: Icons.replay,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // custom rounded outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kSuccessColor,
                        kTrailingIcon: Icons.replay,
                        isRounded: true,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ),
                      // custom outlined button
                      CustomOutlinedButton(
                        kText: 'Outlined Button',
                        outlineColor: kErrorColor,
                        kLeadingIcon: Icons.replay,
                        kTrailingIcon: Icons.check,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kPrimaryColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // rounded soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kErrorColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        isRounded: true,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ),

                      // soft button
                      SoftButton(
                        kText: 'Soft Button',
                        bgColor: kSecondaryColor,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.arrow_forward,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.deepPurple, Colors.purple],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // rounded gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.orangeAccent, Colors.red],
                        kTextColor: Colors.white,
                        isRounded: true,
                        kLeadingIcon: Icons.person_2_outlined,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ), // gradient button
                      GradientButton(
                        kText: 'Gradient Button',
                        bgColor: [Colors.redAccent, Colors.orange],
                        kTextColor: Colors.white,
                        kLeadingIcon: Icons.workspace_premium_outlined,
                        kTrailingIcon: Icons.check,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kInfoColor,
                        kLeadingIcon: Icons.info_outline,
                        size: ButtonSize.small,
                        onPressed: () {},
                      ),

                      // rounded fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kSecondaryColor,
                        kTrailingIcon: Icons.shopping_cart_checkout,
                        isRounded: true,
                        size: ButtonSize.medium,
                        onPressed: () {},
                      ), // fancy icon button
                      FancyIconButton(
                        kText: 'Fancy Icon Button',
                        kTextColor: Colors.white,
                        bgColor: kErrorColor,
                        kLeadingIcon: Icons.info_outline,
                        kTrailingIcon: Icons.check,
                        size: ButtonSize.large,
                        onPressed: () {},
                      ),

                      // github button
                      CustomIconButton(
                        useFontAwesome: true,
                        icon: FontAwesomeIcons.github,
                        buttonColor: const Color(0xff181717),
                        iconColor: Colors.white,
                        size: ButtonSize.small,
                        onTap: () {},
                      ),

                      // google button
                      CustomIconButton(
                        useFontAwesome: true,
                        icon: FontAwesomeIcons.google,
                        buttonColor: const Color(0xffDB4437),
                        iconColor: Colors.white,
                        onTap: () {},
                      ),

                      // facebook button
                      CustomIconButton(
                        useFontAwesome: true,
                        icon: FontAwesomeIcons.facebook,
                        buttonColor: const Color(0xff1877F2),
                        iconColor: Colors.white,
                        size: ButtonSize.large,
                        onTap: () {},
                      ),
                    ],
                  ),
                  codeView: '''
// custom elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  size: ButtonSize.small,
  onPressed: () {},
),

// custom rounded elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  isRounded: true,
  kTrailingIcon: Icons.access_alarm,
  size: ButtonSize.medium,
  onPressed: () {},
),

// custom elevated button
CustomElevatedButton(
  kText: 'Elevated Button',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.access_alarm,
  kTrailingIcon: Icons.check,
  size: ButtonSize.large,
  onPressed: () {},
),

// flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  size: ButtonSize.small,
  onPressed: () {},
),

// rounded flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  kTrailingIcon: Icons.person_2_outlined,
  isRounded: true,
  size: ButtonSize.medium,
  onPressed: () {},
),

// flat button
FlatButton(
  kText: 'Flat Button',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  kLeadingIcon: Icons.person_2_outlined,
  kTrailingIcon: Icons.check,
  size: ButtonSize.large,
  onPressed: () {},
),

// custom outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kInfoColor,
  kTrailingIcon: Icons.replay,
  size: ButtonSize.small,
  onPressed: () {},
),

// custom rounded outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kSuccessColor,
  kTrailingIcon: Icons.replay,
  isRounded: true,
  size: ButtonSize.medium,
  onPressed: () {},
),
// custom outlined button
CustomOutlinedButton(
  kText: 'Outlined Button',
  outlineColor: kErrorColor,
  kLeadingIcon: Icons.replay,
  kTrailingIcon: Icons.check,
  size: ButtonSize.large,
  onPressed: () {},
),

// soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kPrimaryColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  size: ButtonSize.small,
  onPressed: () {},
),

// rounded soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kErrorColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  isRounded: true,
  size: ButtonSize.medium,
  onPressed: () {},
),

// soft button
SoftButton(
  kText: 'Soft Button',
  bgColor: kSecondaryColor,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.arrow_forward,
  size: ButtonSize.large,
  onPressed: () {},
),

// gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.deepPurple, Colors.purple],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  size: ButtonSize.small,
  onPressed: () {},
),

// rounded gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.orangeAccent, Colors.red],
  kTextColor: Colors.white,
  isRounded: true,
  kLeadingIcon: Icons.person_2_outlined,
  size: ButtonSize.medium,
  onPressed: () {},
), // gradient button
GradientButton(
  kText: 'Gradient Button',
  bgColor: [Colors.redAccent, Colors.orange],
  kTextColor: Colors.white,
  kLeadingIcon: Icons.workspace_premium_outlined,
  kTrailingIcon: Icons.check,
  size: ButtonSize.large,
  onPressed: () {},
),

// fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kInfoColor,
  kLeadingIcon: Icons.info_outline,
  size: ButtonSize.small,
  onPressed: () {},
),

// rounded fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kSecondaryColor,
  kTrailingIcon: Icons.shopping_cart_checkout,
  isRounded: true,
  size: ButtonSize.medium,
  onPressed: () {},
), 

// fancy icon button
FancyIconButton(
  kText: 'Fancy Icon Button',
  kTextColor: Colors.white,
  bgColor: kErrorColor,
  kLeadingIcon: Icons.info_outline,
  kTrailingIcon: Icons.check,
  size: ButtonSize.large,
  onPressed: () {},
),

// github button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.github,
  buttonColor: const Color(0xff181717),
  iconColor: Colors.white,
  size: ButtonSize.small,
  onTap: () {},
),

// google button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.google,
  buttonColor: const Color(0xffDB4437),
  iconColor: Colors.white,
  onTap: () {},
),

// facebook button
CustomIconButton(
  useFontAwesome: true,
  icon: FontAwesomeIcons.facebook,
  buttonColor: const Color(0xff1877F2),
  iconColor: Colors.white,
  size: ButtonSize.large,
  onTap: () {},
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Custom Popup Menu
                ShowCodeCard(
                  cardTitle: 'Custom Popup Menu',
                  description:
                      'Use <code>CustomPopupMenu</code> to set a custom pop up menu.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // custom child
                      CustomPopupMenu<String>(
                        onSelected: (value) => debugPrint('Selected: $value'),

                        items: [
                          // profile menu
                          PopupMenuItemData(
                            value: 'profile',
                            text: 'View Profile',
                            icon: Icons.person_outline,
                            showDividerAfter: true,
                          ),

                          // edit menu
                          PopupMenuItemData(
                            value: 'edit',
                            text: 'Edit',
                            icon: Icons.edit,
                          ),

                          // share menu
                          PopupMenuItemData(
                            value: 'share',
                            text: 'Share',
                            icon: Icons.share,
                          ),

                          // delete menu
                          PopupMenuItemData(
                            value: 'delete',
                            text: 'Delete',
                            icon: Icons.delete_outline,
                            iconColor: kErrorColor,
                            textStyle: TextStyle(color: kErrorColor),
                            enabled: false,
                          ),
                        ],

                        // icon button
                        child: CustomIconButton(
                          icon: Icons.more_vert,
                          buttonColor: kSuccessColor.withValues(alpha: 0.1),
                          iconColor: kSuccessColor,
                          tooltipMessage: 'Options',
                        ),
                      ),

                      // custom popup menu data
                      CustomPopupMenu<String>(
                        onSelected: (value) => debugPrint('Selected: $value'),

                        items: [
                          // profile menu with custom child
                          PopupMenuItemData(
                            value: 'profile',
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                  'assets/images/avatar_2.jpg',
                                ),
                              ),
                              title: const Text(
                                'Umar Hamzah',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: const Text('View your Github account'),
                              dense: true,
                            ),
                            showDividerAfter: true,
                          ),

                          // edit menu
                          PopupMenuItemData(
                            value: 'edit',
                            text: 'Edit',
                            icon: Icons.add,
                          ),

                          // share menu
                          PopupMenuItemData(
                            value: 'share',
                            text: 'Share',
                            icon: Icons.share,
                          ),

                          // delete menu
                          PopupMenuItemData(
                            value: 'delete',
                            text: 'Delete',
                            icon: Icons.delete_outline,
                            iconColor: kErrorColor,
                            textStyle: TextStyle(color: kErrorColor),
                          ),
                        ],

                        // icon button
                        child: CustomIconButton(
                          useFontAwesome: true,
                          icon: FontAwesomeIcons.github,
                          buttonColor: const Color(0xff181717),
                          iconColor: Colors.white,
                          shape: ButtonShape.circle,
                        ),
                      ),
                    ],
                  ),
                  codeView: '''
// custom child
CustomPopupMenu<String>(
  onSelected: (value) => debugPrint('Selected: \$value'),
  items: [
    // profile menu
    PopupMenuItemData(
      value: 'profile',
      text: 'View Profile',
      icon: Icons.person_outline,
      showDividerAfter: true,
    ),

    // edit menu
    PopupMenuItemData(
      value: 'edit',
      text: 'Edit',
      icon: Icons.edit,
    ),

    // share menu
    PopupMenuItemData(
      value: 'share',
      text: 'Share',
      icon: Icons.share,
    ),

    // delete menu
    PopupMenuItemData(
      value: 'delete',
      text: 'Delete',
      icon: Icons.delete_outline,
      iconColor: kErrorColor,
      textStyle: TextStyle(color: kErrorColor),
      enabled: false,
    ),
  ],

  // icon button
  child: CustomIconButton(
    icon: Icons.more_vert,
    buttonColor: kSuccessColor.withValues(alpha: 0.1),
    iconColor: kSuccessColor,
    tooltipMessage: 'Options',
  ),
),

// custom popup menu data
CustomPopupMenu<String>(
  onSelected: (value) => debugPrint('Selected: \$value'),
  items: [
    // profile menu with custom child
    PopupMenuItemData(
      value: 'profile',
      child: ListTile(
        leading: const CircleAvatar(
          radius: 18,
          backgroundImage:
              AssetImage('assets/images/avatar_2.jpg'),
        ),
        title: const Text(
          'Umar Hamzah',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text('View your Github account'),
        dense: true,
      ),
      showDividerAfter: true,
    ),

    // edit menu
    PopupMenuItemData(
      value: 'edit',
      text: 'Edit',
      icon: Icons.add,
    ),

    // share menu
    PopupMenuItemData(
      value: 'share',
      text: 'Share',
      icon: Icons.share,
    ),

    // delete menu
    PopupMenuItemData(
      value: 'delete',
      text: 'Delete',
      icon: Icons.delete_outline,
      iconColor: kErrorColor,
      textStyle: TextStyle(color: kErrorColor),
    ),
  ],

  // icon button
  child: CustomIconButton(
    useFontAwesome: true,
    icon: FontAwesomeIcons.github,
    buttonColor: const Color(0xff181717),
    iconColor: Colors.white,
    shape: ButtonShape.circle,
  ),
),
''',
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

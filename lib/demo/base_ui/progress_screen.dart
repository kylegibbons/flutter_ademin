import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).progress; //update your page tittle here
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
                      lang.progress.toUpperCase(),
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
                        BreadcrumbItem(
                          label: lang.progress,
                          uri: RouteUri.progress,
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                double availableWidth = constraints.maxWidth - kDefaultPadding;
                return Wrap(
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // Linear Progress Indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Linear Progress Indicator',
                        description:
                            'Use <code>LinearProgress()</code> to set a linear progress indicator. You can set several arguments to customize it.',
                        uiView: Column(
                          children: [
                            LinearProgress(value: 0.10, color: kPrimaryColor),
                            SizedBox(height: kDefaultPadding),
                            LinearProgress(value: 0.25, color: kSecondaryColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: 0.50, color: kInfoColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: 0.60, color: kSuccessColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: 0.75, color: kWarningColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: 0.95, color: kErrorColor),
                          ],
                        ),
                        codeView: '''
LinearProgress(
  value: 0.10,
  color: kPrimaryColor,
),

LinearProgress(
  value: 0.25,
  color: kSecondaryColor,
),
  
LinearProgress(
  value: 0.50,
  color: kInfoColor,
),
  
LinearProgress(
  value: 0.60,
  color: kSuccessColor,
),
  
LinearProgress(
  value: 0.75,
  color: kWarningColor,
),
  
LinearProgress(
  value: 0.95,
  color: kErrorColor,
),
''',
                      ),
                    ),

                    // Animated Linear Progress Indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Animated Linear Progress Indicator',
                        description:
                            'Use <code>LinearProgress()</code>, and add <code>isAnimated: true</code> argument to set an animated linear progress indicator.',
                        uiView: Column(
                          children: [
                            LinearProgress(
                              value: 0.10,
                              color: kPrimaryColor,
                              isAnimated: true, // set animation
                              curve: Curves.linear,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                              isAnimated: true, // set animation
                              curve: Curves.easeInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.50,
                              color: kInfoColor,
                              isAnimated: true, // set animation
                              curve: Curves.bounceIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.60,
                              color: kSuccessColor,
                              isAnimated: true, // set animation
                              curve: Curves.bounceInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.75,
                              color: kWarningColor,
                              isAnimated: true, // set animation
                              curve: Curves.easeInOutCirc,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.95,
                              color: kErrorColor,
                              isAnimated: true, // set animation
                              curve: Curves.elasticIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                          ],
                        ),
                        codeView: '''
LinearProgress(
  value: 0.10,
  color: kPrimaryColor,
  isAnimated: true, // set animation
  curve: Curves.linear,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.25,
  color: kSecondaryColor,
  isAnimated: true, // set animation
  curve: Curves.easeInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.50,
  color: kInfoColor,
  isAnimated: true, // set animation
  curve: Curves.bounceIn,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.60,
  color: kSuccessColor,
  isAnimated: true, // set animation
  curve: Curves.bounceInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.75,
  color: kWarningColor,
  isAnimated: true, // set animation
  curve: Curves.easeInOutCirc,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.95,
  color: kErrorColor,
  isAnimated: true, // set animation
  curve: Curves.elasticIn,
  animationDuration: Duration(milliseconds: 4000),
),
''',
                      ),
                    ),

                    // Linear Progress Indicator with Label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Linear Progress Indicator with Label',
                        description:
                            'Use <code>LinearProgress()</code>, and add <code>showPercentage: true</code> argument to set a linear progress indicator with label.',
                        uiView: Column(
                          children: [
                            LinearProgress(
                              value: 0.10,
                              color: kPrimaryColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.linear,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.easeInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.50,
                              color: kInfoColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.bounceIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.60,
                              color: kSuccessColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.bounceInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.75,
                              color: kWarningColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.easeInOutCirc,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.95,
                              color: kErrorColor,
                              showPercentage: true, // show percentage
                              height: 12,
                              isAnimated: true,
                              curve: Curves.elasticIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                          ],
                        ),
                        codeView: '''
LinearProgress(
  value: 0.10,
  color: kPrimaryColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.linear,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.25,
  color: kSecondaryColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.easeInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.50,
  color: kInfoColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.bounceIn,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.60,
  color: kSuccessColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.bounceInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.75,
  color: kWarningColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.easeInOutCirc,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.95,
  color: kErrorColor,
  showPercentage: true, // show percentage
  height: 12,
  isAnimated: true,
  curve: Curves.elasticIn,
  animationDuration: Duration(milliseconds: 4000),
),
''',
                      ),
                    ),
                    // Indeterminate Progress Indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Indeterminate Progress Indicator',
                        description:
                            'Use <code>LinearProgress()</code>, and set value as <code>null</code> to set an indeterminate linear progress indicator. You can use this as loading indicator.',
                        uiView: Column(
                          children: [
                            LinearProgress(value: null, color: kPrimaryColor),
                            SizedBox(height: kDefaultPadding),
                            LinearProgress(value: null, color: kSecondaryColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: null, color: kInfoColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: null, color: kSuccessColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: null, color: kWarningColor),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(value: null, color: kErrorColor),
                          ],
                        ),
                        codeView: '''
LinearProgress(
  value: null,
  color: kPrimaryColor,
),

LinearProgress(
  value: null,
  color: kSecondaryColor,
),

LinearProgress(
  value: null,
  color: kInfoColor,
),

LinearProgress(
  value: null,
  color: kSuccessColor,
),

LinearProgress(
  value: null,
  color: kWarningColor,
),

LinearProgress(
  value: null,
  color: kErrorColor,
),
''',
                      ),
                    ),

                    // Linear Progress Indicator with Height
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Linear Progress Indicator with Custom Height',
                        description:
                            'Use <code>LinearProgress()</code>, and add <code>height</code> argument to set a linear progress indicator with custom height.',
                        uiView: Column(
                          children: [
                            LinearProgress(
                              value: 0.10,
                              color: kPrimaryColor,
                              showPercentage: true,
                              height: 12, // set height
                              isAnimated: true,
                              curve: Curves.linear,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                              showPercentage: true,
                              height: 16, // set height
                              isAnimated: true,
                              curve: Curves.easeInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.50,
                              color: kInfoColor,
                              showPercentage: true,
                              height: 18, // set height
                              isAnimated: true,
                              curve: Curves.bounceIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.60,
                              color: kSuccessColor,
                              showPercentage: true,
                              height: 20, // set height
                              isAnimated: true,
                              curve: Curves.bounceInOut,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.75,
                              color: kWarningColor,
                              showPercentage: true,
                              height: 22, // set height
                              isAnimated: true,
                              curve: Curves.easeInOutCirc,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            LinearProgress(
                              value: 0.95,
                              color: kErrorColor,
                              showPercentage: true,
                              height: 24, // set height
                              isAnimated: true,
                              curve: Curves.elasticIn,
                              animationDuration: Duration(milliseconds: 4000),
                            ),
                          ],
                        ),
                        codeView: '''
LinearProgress(
  value: 0.10,
  color: kPrimaryColor,
  showPercentage: true,
  height: 12, // set height
  isAnimated: true,
  curve: Curves.linear,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.25,
  color: kSecondaryColor,
  showPercentage: true,
  height: 16, // set height
  isAnimated: true,
  curve: Curves.easeInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.50,
  color: kInfoColor,
  showPercentage: true,
  height: 18, // set height
  isAnimated: true,
  curve: Curves.bounceIn,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.60,
  color: kSuccessColor,
  showPercentage: true,
  height: 20, // set height
  isAnimated: true,
  curve: Curves.bounceInOut,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.75,
  color: kWarningColor,
  showPercentage: true,
  height: 22, // set height
  isAnimated: true,
  curve: Curves.easeInOutCirc,
  animationDuration: Duration(milliseconds: 4000),
),

LinearProgress(
  value: 0.95,
  color: kErrorColor,
  showPercentage: true,
  height: 24, // set height
  isAnimated: true,
  curve: Curves.elasticIn,
  animationDuration: Duration(milliseconds: 4000),
),''',
                      ),
                    ),

                    // progress card
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Progress Card Indicator',
                        description:
                            'Use <code>ProgressCard()</code> to set a progress card, showing the status of a task with a progress bar, percentage, and estimated time remaining.',
                        uiView: Column(
                          children: [
                            ProgressCard(
                              value: 0.3,
                              label: "Update in progress...",
                              timeLeft: "1 min left",
                              color: kInfoColor,
                            ),
                            SizedBox(height: kDefaultPadding),
                            ProgressCard(
                              value: 0.6,
                              label: "Saving in progress...",
                              timeLeft: "45s left",
                              color: kSuccessColor,
                            ),
                            SizedBox(height: kDefaultPadding),
                            ProgressCard(
                              value: 0.82,
                              label: "Download in progress...",
                              timeLeft: "25s left",
                              color: kErrorColor,
                            ),
                          ],
                        ),
                        codeView: '''
ProgressCard(
  value: 0.3,
  label: "Update in progress...",
  timeLeft: "1 min left",
  color: kInfoColor,
),

ProgressCard(
  value: 0.6,
  label: "Saving in progress...",
  timeLeft: "45s left",
  color: kSuccessColor,
),

ProgressCard(
  value: 0.82,
  label: "Download in progress...",
  timeLeft: "25s left",
  color: kErrorColor,
),
''',
                      ),
                    ),

                    // circular progress indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Circular Progress Indicator',
                        description:
                            'Use <code>CircularProgress()</code> to set a circular progress indicator. You can set the value, color, background color, and other properties.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          runSpacing: kDefaultPadding,
                          children: [
                            CircularProgress(value: 0.15, color: kPrimaryColor),
                            CircularProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                            ),
                            CircularProgress(value: 0.35, color: kInfoColor),
                            CircularProgress(value: 0.45, color: kSuccessColor),
                            CircularProgress(value: 0.65, color: kWarningColor),
                            CircularProgress(value: 0.85, color: kErrorColor),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: 0.15,
  color: kPrimaryColor,
),
CircularProgress(
  value: 0.25,
  color: kSecondaryColor,
),
CircularProgress(
  value: 0.35,
  color: kInfoColor,
),
CircularProgress(
  value: 0.45,
  color: kSuccessColor,
),
CircularProgress(
  value: 0.65,
  color: kWarningColor,
),
CircularProgress(
  value: 0.85,
  color: kErrorColor,
),
''',
                      ),
                    ),

                    // animated circular progress indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Animated Circular Progress Indicator',
                        description:
                            'Use <code>CircularProgress()</code>, and add <code>isAnimated: true</code> argument to set an animated circular progress indicator.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            CircularProgress(
                              value: 0.15,
                              color: kPrimaryColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.35,
                              color: kInfoColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.45,
                              color: kSuccessColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.65,
                              color: kWarningColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.85,
                              color: kErrorColor,
                              isAnimated: true, // set animation to true
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: 0.15,
  color: kPrimaryColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.25,
  color: kSecondaryColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.35,
  color: kInfoColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.45,
  color: kSuccessColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.65,
  color: kWarningColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.85,
  color: kErrorColor,
  isAnimated: true, // set animation to true
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Circular Progress Indicator with Label',
                        description:
                            'Use <code>CircularProgress()</code>, and add <code> showPercentage: true</code> argument to set a circular progress indicator with label.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            CircularProgress(
                              value: 0.15,
                              showPercentage: true, // show label
                              color: kPrimaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.25,
                              showPercentage: true, // show label
                              color: kSecondaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.35,
                              showPercentage: true, // show label
                              color: kInfoColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.45,
                              showPercentage: true, // show label
                              color: kSuccessColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.65,
                              showPercentage: true, // show label
                              color: kWarningColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.85,
                              showPercentage: true, // show label
                              color: kErrorColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: 0.15,
  showPercentage: true, // show label
  color: kPrimaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.25,
  showPercentage: true, // show label
  color: kSecondaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.35,
  showPercentage: true, // show label
  color: kInfoColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.45,
  showPercentage: true, // show label
  color: kSuccessColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.65,
  showPercentage: true, // show label
  color: kWarningColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.85,
  showPercentage: true, // show label
  color: kErrorColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Circular Progress Indicator with Custom Radius',
                        description:
                            'Use <code>CircularProgress()</code>, and add <code>radius</code> argument to set a circular progress indicator with custom radius.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          runSpacing: kDefaultPadding,
                          children: [
                            CircularProgress(
                              value: 0.15,
                              radius: 16, // set radius
                              showPercentage: true,
                              color: kPrimaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.25,
                              radius: 18, // set radius
                              showPercentage: true,
                              color: kSecondaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.35,
                              radius: 20, // set radius
                              showPercentage: true,
                              color: kInfoColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.45,
                              radius: 22, // set radius
                              showPercentage: true,
                              color: kSuccessColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.65,
                              radius: 24, // set radius
                              showPercentage: true,
                              color: kWarningColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.85,
                              radius: 26, // set radius
                              showPercentage: true,
                              color: kErrorColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: 0.15,
  radius: 16, // set radius
  showPercentage: true,
  color: kPrimaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.25,
  radius: 18, // set radius
  showPercentage: true,
  color: kSecondaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.35,
  radius: 20, // set radius
  showPercentage: true,
  color: kInfoColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.45,
  radius: 22, // set radius
  showPercentage: true,
  color: kSuccessColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.65,
  radius: 24, // set radius
  showPercentage: true,
  color: kWarningColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
CircularProgress(
  value: 0.85,
  radius: 26, // set radius
  showPercentage: true,
  color: kErrorColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Circular Progress Indicator with Custom Label Style',
                        description:
                            'Use <code>CircularProgress()</code>, and add <code> percentageTextStyle</code> argument to set a circular progress indicator with custom label style.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            CircularProgress(
                              value: 0.15,
                              radius: 16,
                              showPercentage: true,
                              color: kPrimaryColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.25,
                              radius: 18,
                              showPercentage: true,
                              color: kSecondaryColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.35,
                              radius: 20, // set radius
                              showPercentage: true,
                              color: kInfoColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.45,
                              radius: 22, // set radius
                              showPercentage: true,
                              color: kSuccessColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.65,
                              radius: 24, // set radius
                              showPercentage: true,
                              color: kWarningColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                            CircularProgress(
                              value: 0.85,
                              radius: 26, // set radius
                              showPercentage: true,
                              color: kErrorColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: 0.15,
  radius: 16,
  showPercentage: true,
  color: kPrimaryColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),

CircularProgress(
  value: 0.25,
  radius: 18,
  showPercentage: true,
  color: kSecondaryColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),

CircularProgress(
  value: 0.35,
  radius: 20, // set radius
  showPercentage: true,
  color: kInfoColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),

CircularProgress(
  value: 0.45,
  radius: 22, // set radius
  showPercentage: true,
  color: kSuccessColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),

CircularProgress(
  value: 0.65,
  radius: 24, // set radius
  showPercentage: true,
  color: kWarningColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),

CircularProgress(
  value: 0.85,
  radius: 26, // set radius
  showPercentage: true,
  color: kErrorColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
),
''',
                      ),
                    ),

                    // Indeterminate circular progress indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Indeterminate Circular Progress Indicator',
                        description:
                            'Use <code>CircularProgress()</code>, and set value as <code>null</code> to set an indeterminate circular progress indicator. You can use this as loading indicator.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            CircularProgress(
                              value: null, // set null
                              color: kPrimaryColor,
                            ),
                            CircularProgress(
                              value: null,
                              radius: 18,
                              color: kSecondaryColor,
                            ),
                            CircularProgress(
                              value: null,
                              radius: 20,
                              color: kInfoColor,
                            ),
                            CircularProgress(
                              value: null,
                              radius: 22,
                              color: kSuccessColor,
                            ),
                            CircularProgress(
                              value: null,
                              radius: 24,
                              color: kWarningColor,
                            ),
                            CircularProgress(
                              value: null,
                              radius: 26,
                              color: kErrorColor,
                            ),
                          ],
                        ),
                        codeView: '''
CircularProgress(
  value: null, // set null
  color: kPrimaryColor,
),

CircularProgress(
  value: null,
  radius: 18,
  color: kSecondaryColor,
),

CircularProgress(
  value: null,
  radius: 20,
  color: kInfoColor,
),

CircularProgress(
  value: null,
  radius: 22,
  color: kSuccessColor,
),

CircularProgress(
  value: null,
  radius: 24,
  color: kWarningColor,
),

CircularProgress(
  value: null,
  radius: 26,
  color: kErrorColor,
),
''',
                      ),
                    ),

                    // Advanced Circular Progress Indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Advanced Circular Progress Indicator',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, add <code>style: CircularIndicatorStyle.segmented</code> argument to set as segmented circular progress indicator.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: 0.15,
                              color: kPrimaryColor,
                            ),
                            AdvancedCircularProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                            ),
                            AdvancedCircularProgress(
                              value: 0.35,
                              color: kInfoColor,
                            ),
                            AdvancedCircularProgress(
                              value: 0.45,
                              color: kSuccessColor,
                              style: CircularIndicatorStyle
                                  .segmented, // set as segmented
                              segmentCount: 10, // set segmented count
                            ),
                            AdvancedCircularProgress(
                              value: 0.65,
                              color: kWarningColor,
                              style: CircularIndicatorStyle
                                  .segmented, // set as segmented
                              segmentCount: 20, // set segmented count
                            ),
                            AdvancedCircularProgress(
                              value: 0.85,
                              color: kErrorColor,
                              style: CircularIndicatorStyle
                                  .segmented, // set as segmented
                              segmentCount: 30, // set segmented count
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: 0.15,
  color: kPrimaryColor,
),

AdvancedCircularProgress(
  value: 0.25,
  color: kSecondaryColor,
),

AdvancedCircularProgress(
  value: 0.35,
  color: kInfoColor,
),

AdvancedCircularProgress(
  value: 0.45,
  color: kSuccessColor,
  style: CircularIndicatorStyle
      .segmented, // set as segmented
  segmentCount: 10, // set segmented count
),

AdvancedCircularProgress(
  value: 0.65,
  color: kWarningColor,
  style: CircularIndicatorStyle
      .segmented, // set as segmented
  segmentCount: 20, // set segmented count
),

AdvancedCircularProgress(
  value: 0.85,
  color: kErrorColor,
  style: CircularIndicatorStyle
      .segmented, // set as segmented
  segmentCount: 30, // set segmented count
),
''',
                      ),
                    ),

                    // Animated Advanced Circular Progress Indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Animated Advanced Circular Progress Indicator',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, and add <code>isAnimated: true</code> argument to set animated advanced circular progress indicator.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: 0.15,
                              color: kPrimaryColor,
                              isAnimated: true, // set as animated
                            ),
                            AdvancedCircularProgress(
                              value: 0.25,
                              color: kSecondaryColor,
                              isAnimated: true, // set as animated
                            ),
                            AdvancedCircularProgress(
                              value: 0.35,
                              color: kInfoColor,
                              isAnimated: true, // set as animated
                            ),
                            AdvancedCircularProgress(
                              value: 0.45,
                              color: kSuccessColor,
                              style: CircularIndicatorStyle.segmented,
                              segmentCount: 10,
                              isAnimated: true, // set as animated
                            ),
                            AdvancedCircularProgress(
                              value: 0.65,
                              color: kWarningColor,
                              style: CircularIndicatorStyle.segmented,
                              segmentCount: 20,
                              isAnimated: true, // set as animated
                            ),
                            AdvancedCircularProgress(
                              value: 0.85,
                              color: kErrorColor,
                              style: CircularIndicatorStyle.segmented,
                              segmentCount: 30,
                              isAnimated: true, // set as animated
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: 0.15,
  color: kPrimaryColor,
  isAnimated: true, // set as animated
),

AdvancedCircularProgress(
  value: 0.25,
  color: kSecondaryColor,
  isAnimated: true, // set as animated
),

AdvancedCircularProgress(
  value: 0.35,
  color: kInfoColor,
  isAnimated: true, // set as animated
),

AdvancedCircularProgress(
  value: 0.45,
  color: kSuccessColor,
  style: CircularIndicatorStyle.segmented,
  segmentCount: 10,
  isAnimated: true, // set as animated
),

AdvancedCircularProgress(
  value: 0.65,
  color: kWarningColor,
  style: CircularIndicatorStyle.segmented,
  segmentCount: 20,
  isAnimated: true, // set as animated
),

AdvancedCircularProgress(
  value: 0.85,
  color: kErrorColor,
  style: CircularIndicatorStyle.segmented,
  segmentCount: 30,
  isAnimated: true, // set as animated
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Circular Progress Indicator with Label',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, and add <code> showPercentage: true</code> argument to set a circular progress indicator with label.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: 0.15,
                              showPercentage: true, // show label
                              color: kPrimaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.25,
                              showPercentage: true, // show label
                              color: kSecondaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.35,
                              showPercentage: true, // show label
                              color: kInfoColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.45,
                              showPercentage: true, // show label
                              color: kSuccessColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.65,
                              showPercentage: true, // show label
                              color: kWarningColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.85,
                              showPercentage: true, // show label
                              color: kErrorColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: 0.15,
  showPercentage: true, // show label
  color: kPrimaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.25,
  showPercentage: true, // show label
  color: kSecondaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.35,
  showPercentage: true, // show label
  color: kInfoColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.45,
  showPercentage: true, // show label
  color: kSuccessColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.65,
  showPercentage: true, // show label
  color: kWarningColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.85,
  showPercentage: true, // show label
  color: kErrorColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Circular Progress Indicator with Custom Radius',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, and add <code>radius</code> argument to set a circular progress indicator with custom radius.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: 0.15,
                              radius: 16, // set radius
                              showPercentage: true,
                              color: kPrimaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.25,
                              radius: 18, // set radius
                              showPercentage: true,
                              color: kSecondaryColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.35,
                              radius: 20, // set radius
                              showPercentage: true,
                              color: kInfoColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.45,
                              radius: 22, // set radius
                              showPercentage: true,
                              color: kSuccessColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.65,
                              radius: 24, // set radius
                              showPercentage: true,
                              color: kWarningColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.85,
                              radius: 26, // set radius
                              showPercentage: true,
                              color: kErrorColor,
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: 0.15,
  radius: 16, // set radius
  showPercentage: true,
  color: kPrimaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.25,
  radius: 18, // set radius
  showPercentage: true,
  color: kSecondaryColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.35,
  radius: 20, // set radius
  showPercentage: true,
  color: kInfoColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.45,
  radius: 22, // set radius
  showPercentage: true,
  color: kSuccessColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.65,
  radius: 24, // set radius
  showPercentage: true,
  color: kWarningColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.85,
  radius: 26, // set radius
  showPercentage: true,
  color: kErrorColor,
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),
''',
                      ),
                    ),

                    // circular progress indicator with label
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle:
                            'Circular Progress Indicator with Custom Label Style',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, and add <code> percentageTextStyle</code> argument to set a circular progress indicator with custom label style.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: 0.15,
                              radius: 16,
                              showPercentage: true,
                              color: kPrimaryColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.25,
                              radius: 18,
                              showPercentage: true,
                              color: kSecondaryColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.35,
                              radius: 20, // set radius
                              showPercentage: true,
                              color: kInfoColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.45,
                              radius: 22, // set radius
                              showPercentage: true,
                              color: kSuccessColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.65,
                              radius: 24, // set radius
                              showPercentage: true,
                              color: kWarningColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: 0.85,
                              radius: 26, // set radius
                              showPercentage: true,
                              color: kErrorColor,
                              percentageTextStyle: TextStyle(
                                color: kTextColor,
                                fontSize: kBodySmall,
                                fontWeight: FontWeight.w600,
                              ), // set percentage Text Style
                              isAnimated: true,
                              animationDuration: const Duration(seconds: 5),
                              curve: Curves.easeInOut,
                              style: CircularIndicatorStyle.segmented,
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: 0.15,
  radius: 16,
  showPercentage: true,
  color: kPrimaryColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.25,
  radius: 18,
  showPercentage: true,
  color: kSecondaryColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.35,
  radius: 20, // set radius
  showPercentage: true,
  color: kInfoColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.45,
  radius: 22, // set radius
  showPercentage: true,
  color: kSuccessColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.65,
  radius: 24, // set radius
  showPercentage: true,
  color: kWarningColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),

AdvancedCircularProgress(
  value: 0.85,
  radius: 26, // set radius
  showPercentage: true,
  color: kErrorColor,
  percentageTextStyle: TextStyle(
    color: kTextColor,
    fontSize: kBodySmall,
    fontWeight: FontWeight.w600,
  ), // set percentage Text Style
  isAnimated: true,
  animationDuration: const Duration(seconds: 5),
  curve: Curves.easeInOut,
  style: CircularIndicatorStyle.segmented,
),
''',
                      ),
                    ),

                    // Indeterminate circular progress indicator
                    SizedBox(
                      width: mediaQueryData.size.width > kScreenWidthXxl
                          ? availableWidth * 0.5
                          : constraints.maxWidth * 1,
                      child: ShowCodeCard(
                        cardTitle: 'Indeterminate Circular Progress Indicator',
                        description:
                            'Use <code>AdvancedCircularProgress()</code>, and set value as <code>null</code> to set an indeterminate circular progress indicator. You can use this as loading indicator.',
                        uiView: Wrap(
                          spacing: kDefaultPadding,
                          children: [
                            AdvancedCircularProgress(
                              value: null, // set null
                              color: kPrimaryColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: null,
                              radius: 18,
                              color: kSecondaryColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: null,
                              radius: 20,
                              color: kInfoColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: null,
                              radius: 22,
                              color: kSuccessColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: null,
                              radius: 24,
                              color: kWarningColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                            AdvancedCircularProgress(
                              value: null,
                              radius: 26,
                              color: kErrorColor,
                              style: CircularIndicatorStyle.segmented,
                            ),
                          ],
                        ),
                        codeView: '''
AdvancedCircularProgress(
  value: null, // set null
  color: kPrimaryColor,
  style: CircularIndicatorStyle.segmented,
),
AdvancedCircularProgress(
  value: null,
  radius: 18,
  color: kSecondaryColor,
  style: CircularIndicatorStyle.segmented,
),
AdvancedCircularProgress(
  value: null,
  radius: 20,
  color: kInfoColor,
  style: CircularIndicatorStyle.segmented,
),
AdvancedCircularProgress(
  value: null,
  radius: 22,
  color: kSuccessColor,
  style: CircularIndicatorStyle.segmented,
),
AdvancedCircularProgress(
  value: null,
  radius: 24,
  color: kWarningColor,
  style: CircularIndicatorStyle.segmented,
),
AdvancedCircularProgress(
  value: null,
  radius: 26,
  color: kErrorColor,
  style: CircularIndicatorStyle.segmented,
),
''',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

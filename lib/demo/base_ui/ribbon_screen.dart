import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/widgets/base_ui/ribbon.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class RibbonScreen extends StatefulWidget {
  const RibbonScreen({super.key});

  @override
  State<RibbonScreen> createState() => _RibbonScreenState();
}

class _RibbonScreenState extends State<RibbonScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).ribbon; //update your page tittle here
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
                      lang.ribbon.toUpperCase(),
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
                        BreadcrumbItem(
                          label: lang.ribbon,
                          uri: RouteUri.ribbon,
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
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ShowCodeCard(
                  cardTitle: 'Rounded Ribbon',
                  height: 320,
                  description:
                      'Use <code>RoundedRibbonCard()</code> to show round-shaped ribbon card.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: RoundedRibbonCard(
                              ribbonText: 'Primary',
                              ribbonColor: kPrimaryColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: RoundedRibbonCard(
                              ribbonText: 'Success',
                              ribbonColor: kSuccessColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: RoundedRibbonCard(
                              ribbonText: 'Info',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.right,
                              child: ExampleContent(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
RoundedRibbonCard(
  ribbonText: 'Primary',
  ribbonColor: kPrimaryColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

RoundedRibbonCard(
  ribbonText: 'Success',
  ribbonColor: kSuccessColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

RoundedRibbonCard(
  ribbonText: 'Info',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.right,
  child: ExampleContent(),
),

''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Triangle Ribbon',
                  height: 640,
                  description:
                      'Use <code>TriangleRibbonCard()</code> and <code>ReverseTriangleRibbonCard()</code> to show round-shaped ribbon card.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: TriangleRibbonCard(
                              ribbonText: 'Primary',
                              ribbonColor: kPrimaryColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: TriangleRibbonCard(
                              ribbonText: 'Success',
                              ribbonColor: kSuccessColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: TriangleRibbonCard(
                              ribbonText: 'Info',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.right,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: ReverseTriangleRibbonCard(
                              ribbonText: 'Primary',
                              ribbonColor: kPrimaryColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: ReverseTriangleRibbonCard(
                              ribbonText: 'Success',
                              ribbonColor: kSuccessColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: ReverseTriangleRibbonCard(
                              ribbonText: 'Info',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.right,
                              child: ExampleContent(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
TriangleRibbonCard(
  ribbonText: 'Primary',
  ribbonColor: kPrimaryColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

TriangleRibbonCard(
  ribbonText: 'Success',
  ribbonColor: kSuccessColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

TriangleRibbonCard(
  ribbonText: 'Info',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.right,
  child: ExampleContent(),
),

ReverseTriangleRibbonCard(
  ribbonText: 'Primary',
  ribbonColor: kPrimaryColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

ReverseTriangleRibbonCard(
  ribbonText: 'Success',
  ribbonColor: kSuccessColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

ReverseTriangleRibbonCard(
  ribbonText: 'Info',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.right,
  child: ExampleContent(),
),
''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Sloped Ribbon',
                  height: 320,
                  description:
                      'Use <code>SlopedRibbonCard()</code> to show sloped ribbon card.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SlopedRibbonCard(
                              ribbonText: 'Primary',
                              ribbonColor: kPrimaryColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SlopedRibbonCard(
                              ribbonText: 'Success',
                              ribbonColor: kSuccessColor,
                              ribbonPosition: RibbonPosition.left,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SlopedRibbonCard(
                              ribbonText: 'Info',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.right,
                              child: ExampleContent(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
SlopedRibbonCard(
  ribbonText: 'Primary',
  ribbonColor: kPrimaryColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

SlopedRibbonCard(
  ribbonText: 'Success',
  ribbonColor: kSuccessColor,
  ribbonPosition: RibbonPosition.left,
  child: ExampleContent(),
),

SlopedRibbonCard(
  ribbonText: 'Info',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.right,
  child: ExampleContent(),
),
''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Hover Ribbon',
                  height: 360,
                  description:
                      'Use <code>HoverRibbonCard()</code>to show ribbon card with hover effect.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HoverRibbonCard(
                              ribbonText: 'Trending',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.left,
                              ribbonIcon: Icons.bolt_outlined,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HoverRibbonCard(
                              ribbonText: 'Trending',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.left,
                              ribbonIcon: Icons.bolt_outlined,
                              child: ExampleContent(),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HoverRibbonCard(
                              ribbonText: 'Trending',
                              ribbonColor: kInfoColor,
                              ribbonPosition: RibbonPosition.right,
                              ribbonIcon: Icons.bolt_outlined,
                              child: ExampleContent(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
HoverRibbonCard(
  ribbonText: 'Trending',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.left,
  ribbonIcon: Icons.bolt_outlined,
  child: ExampleContent(),
),

HoverRibbonCard(
  ribbonText: 'Trending',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.left,
  ribbonIcon: Icons.bolt_outlined,
  child: ExampleContent(),
),

HoverRibbonCard(
  ribbonText: 'Trending',
  ribbonColor: kInfoColor,
  ribbonPosition: RibbonPosition.right,
  ribbonIcon: Icons.bolt_outlined,
  child: ExampleContent(),
),
''',
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

//Card content

class ExampleContent extends StatelessWidget {
  const ExampleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    );
  }
}

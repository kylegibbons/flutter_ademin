import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/helper/show_code_container.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pageTitle = Lang.of(context).layout; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });

    // scroll controller
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          // show back to ti=op button, if user scroll <= 400 px
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        controller: _scrollController,
        children: [
          //page title and breadcrumb
          Container(
            width: double.infinity,
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
                      lang.layout.toUpperCase(),
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
                          label: lang.layout,
                          uri: RouteUri.layoutBaseUi,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Demo 2 Columns (70% - 30%) ===
                ShowCodeContainer(
                  title: '2 Columns Demo (70% - 30%)',
                  description:
                      'Use <code>AdaptiveWrap()</code> to set an adaptive wrap layout, in this demo there are 2 columns, Column A (70% width) and Column B (30% width). Please resize your browser to see adaptive wrap in action.',
                  uiView: AdaptiveWrap(
                    breakpoints: {
                      576: 1,
                      // set breakpoint for 1 column layout, will be triggered when width constraint less than 576 px
                      768: 2, // set breakpoint for 2 column layout
                    },
                    columnRatios: const [
                      0.7, // set column A as 70% width
                      0.3, // set column B as 30% width
                    ],
                    spacing: kDefaultPadding, // spacing
                    runSpacing: kDefaultPadding, // run spacing
                    children: [
                      // put your widgets children here
                      _demoCard('Column A', kSecondaryColor), // column A widget
                      _demoCard('Column B', kInfoColor), // column B widget
                    ],
                  ),
                  codeView: '''
AdaptiveWrap(
  breakpoints: {
    576: 1, // set breakpoint for 1 column layout, will be triggered when width constraint less than 576 px
    768: 2, // set breakpoint for 2 column layout
  },
  columnRatios: const [
    0.7, // set column A as 70% width
    0.3, // set column B as 30% width
  ],
  spacing: kDefaultPadding, // spacing
  runSpacing: kDefaultPadding, // run spacing
  children: [
    // put your widgets children here
    _demoCard('Column A', kSecondaryColor), // column A widget
    _demoCard('Column B', kInfoColor), // column B widget
  ],
),
''',
                  height: 420,
                ),

                SizedBox(height: kDefaultPadding),

                // === Demo 2 Columns (70% - 30%) ===
                ShowCodeContainer(
                  title: '2 Columns Demo (70% - 30%) - ScreenWidth Breakpoint',
                  description:
                      'Use <code>AdaptiveWrap()</code> to set an adaptive wrap layout, and <code>useScreenWidth: true</code> to use screen width as breakpoints.',
                  uiView: AdaptiveWrap(
                    useScreenWidth: true, // use screen width (MediaQuery)
                    breakpoints: {
                      576: 1,
                      // set breakpoint for 1 column layout, will be triggered when width constraint less than 576 px
                      768: 2, // set breakpoint for 2 column layout
                    },
                    columnRatios: const [
                      0.7, // set column A as 70% width
                      0.3, // set column B as 30% width
                    ],
                    spacing: kDefaultPadding, // spacing
                    runSpacing: kDefaultPadding, // run spacing
                    children: [
                      // put your widgets children here
                      _demoCard('Column A', kSecondaryColor), // column A widget
                      _demoCard('Column B', kInfoColor), // column B widget
                    ],
                  ),
                  codeView: '''
AdaptiveWrap(
  useScreenWidth: true, // use screen width (MediaQuery)
  breakpoints: {
    576: 1, // set breakpoint for 1 column layout, will be triggered when width constraint less than 576 px
    768: 2, // set breakpoint for 2 column layout
  },
  columnRatios: const [
    0.7, // set column A as 70% width
    0.3, // set column B as 30% width
  ],
  spacing: kDefaultPadding, // spacing
  runSpacing: kDefaultPadding, // run spacing
  children: [
    // put your widgets children here
    _demoCard('Column A', kSecondaryColor), // column A widget
    _demoCard('Column B', kInfoColor), // column B widget
  ],
),
''',
                  height: 420,
                ),

                SizedBox(height: kDefaultPadding),

                // === Demo 3 Columns (50% - 25% - 25%) ===
                ShowCodeContainer(
                  title: '3 Columns Demo (50% - 25% - 25%)',
                  description:
                      'Use <code>AdaptiveWrap()</code> to set an adaptive wrap layout, in this demo there are 3 columns, Column A (50% width), Column B (25% width), and Column C (25% width). Please resize your browser to see adaptive wrap in action.',
                  uiView: AdaptiveWrap(
                    breakpoints: {
                      kScreenWidthSm: 1, // set breakpoint for 1 column layout,
                      kScreenWidthMd: 2, // set breakpoint for 2 column layout
                      kScreenWidthLg: 3, // set breakpoint for 3 column layout
                    },
                    columnRatios: const [
                      0.5, // set column A as 50% width
                      0.25, // set column B as 25% width
                      0.25, // set column C as 25% width
                    ],
                    spacing: kDefaultPadding, // spacing
                    runSpacing: kDefaultPadding, // run spacing
                    children: [
                      // put your widgets children here
                      _demoCard('Column A', kSecondaryColor), // column A widget
                      _demoCard('Column B', kInfoColor), // column B widget
                      _demoCard('Column C', kSuccessColor), // column C widget
                    ],
                  ),
                  codeView: '''
AdaptiveWrap(
  breakpoints: {
    kScreenWidthSm: 1, // set breakpoint for 1 column layout,
    kScreenWidthMd: 2, // set breakpoint for 2 column layout
    kScreenWidthLg: 3, // set breakpoint for 3 column layout
  },
  columnRatios: const [
    0.5, // set column A as 50% width
    0.25, // set column B as 25% width
    0.25, // set column C as 25% width
  ],
  spacing: kDefaultPadding, // spacing
  runSpacing: kDefaultPadding, // run spacing
  children: [
    // put your widgets children here
    _demoCard('Column A', kSecondaryColor), // column A widget
    _demoCard('Column B', kInfoColor), // column B widget
    _demoCard('Column C', kSuccessColor), // column C widget
  ],
)

/* You can use any number to set the breakpoint, but we follow the BootStrap standard. Here's a note:
const double kScreenWidthSm = 576.0;
const double kScreenWidthMd = 768.0;
const double kScreenWidthLg = 992.0;
const double kScreenWidthXl = 1200.0;
const double kScreenWidthXxl = 1400.0;
const double kScreenWidthXxxl = 2000.0; */
''',
                  height: 420,
                ),

                SizedBox(height: kDefaultPadding),

                // === Demo 4 Columns (25% - 25% - 25% - 25%) ===
                ShowCodeContainer(
                  title: '4 Columns Demo (25% - 25% - 25% - 25%)',
                  description:
                      'Use <code>AdaptiveWrap()</code> to set an adaptive wrap layout, in this demo there are 4 columns, Column A (25% width), Column B (25% width), Column C (25% width), and Column D (25% width). Please resize your browser to see adaptive wrap in action.',
                  uiView: AdaptiveWrap(
                    breakpoints: {
                      kScreenWidthSm: 1, // set breakpoint for 1 column layout,
                      kScreenWidthLg: 2, // set breakpoint for 2 column layout
                      kScreenWidthXl: 4, // set breakpoint for 4 column layout
                    },
                    columnRatios: const [
                      0.25, // set column A as 25% width
                      0.25, // set column B as 25% width
                      0.25, // set column C as 25% width
                      0.25, // set column D as 25% width
                    ],
                    spacing: kDefaultPadding, // spacing
                    runSpacing: kDefaultPadding, // run spacing
                    children: [
                      // put your widgets children here
                      _demoCard('Column A', kSecondaryColor), // column A widget
                      _demoCard('Column B', kInfoColor), // column B widget
                      _demoCard('Column C', kSuccessColor), // column C widget
                      _demoCard('Column D', kErrorColor), // column D widget
                    ],
                  ),
                  codeView: '''
AdaptiveWrap(
  breakpoints: {
    kScreenWidthSm: 1, // set breakpoint for 1 column layout,
    kScreenWidthLg: 2, // set breakpoint for 2 column layout
    kScreenWidthXl: 4, // set breakpoint for 4 column layout
  },
  columnRatios: const [
    0.25, // set column A as 25% width
    0.25, // set column B as 25% width
    0.25, // set column C as 25% width
    0.25, // set column D as 25% width
  ],
  spacing: kDefaultPadding, // spacing
  runSpacing: kDefaultPadding, // run spacing
  children: [
    // put your widgets children here
    _demoCard('Column A', kSecondaryColor), // column A widget
    _demoCard('Column B', kInfoColor), // column B widget
    _demoCard('Column C', kSuccessColor), // column C widget
    _demoCard('Column D', kErrorColor), // column D widget
  ],
),

/* You can use any number to set the breakpoint, but we follow the BootStrap standard. Here's a note:
const double kScreenWidthSm = 576.0;
const double kScreenWidthMd = 768.0;
const double kScreenWidthLg = 992.0;
const double kScreenWidthXl = 1200.0;
const double kScreenWidthXxl = 1400.0;
const double kScreenWidthXxxl = 2000.0; */
''',
                  height: 420,
                ),

                SizedBox(height: kDefaultPadding),

                // === Complex 3 Columns Demo (50% - 30% - 20%) ===
                ShowCodeContainer(
                  title: 'Complex 3 Columns Demo (50% - 30% - 20%)',
                  description:
                      'You can make <code>AdaptiveWrap()</code> a child of another <code>AdaptiveWrap()</code> to create complex responsive layouts. In this demo, Columns B and C are always in the same row. Please resize your browser to see adaptive wrap in action.',
                  uiView: AdaptiveWrap(
                    breakpoints: {
                      kScreenWidthMd: 1, // set breakpoint for 1 column layout,
                      kScreenWidthLg: 2, // set breakpoint for 2 column layout
                    },
                    columnRatios: const [
                      0.5, // set column A as 50% width
                      0.5, // set column B as 30%  + Column C as 20% width
                    ],
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // column A widget
                      _demoCard('Column A', kSecondaryColor),

                      // Column B & C
                      AdaptiveWrap(
                        breakpoints: {kScreenWidthSm: 2},
                        columnRatios: const [
                          0.3, // set column B as 30%
                          0.2, // set column C as 20%
                        ],
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          _demoCard('Column B', kInfoColor),
                          _demoCard('Column C', kErrorColor),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
AdaptiveWrap(
  breakpoints: {
    kScreenWidthMd: 1, // set breakpoint for 1 column layout,
    kScreenWidthLg: 2, // set breakpoint for 2 column layout
  },
  columnRatios: const [
    0.5, // set column A as 50% width
    0.5, // set column B as 30%  + Column C as 20% width
  ],
  spacing: kDefaultPadding,
  runSpacing: kDefaultPadding,
  children: [
    // column A widget
    _demoCard('Column A', kSecondaryColor),

    // Column B & C
    AdaptiveWrap(
      breakpoints: {
        kScreenWidthSm: 2,
      },
      columnRatios: const [
        0.3, // set column B as 30%
        0.2, // set column C as 20%
      ],
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      children: [
        _demoCard('Column B', kInfoColor),
        _demoCard('Column C', kErrorColor),
      ],
    ),
  ],
),
''',
                  height: 420,
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

  static Widget _demoCard(String text, Color color) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: outlineWidth),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: kBodyLarge,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

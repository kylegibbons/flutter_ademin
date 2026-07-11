import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/card_example.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class StarterPageScreen extends StatefulWidget {
  const StarterPageScreen({super.key});

  @override
  State<StarterPageScreen> createState() => _StarterPageScreenState();
}

class _StarterPageScreenState extends State<StarterPageScreen> {
  late ScrollController _scrollController;
  bool _showButton = false;
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).starterPage;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });

    // scroll controller
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          // show back to top button, if user scroll <= 400 px
          _showButton = _scrollController.offset >= 400;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: ListView(
        controller: _scrollController,
        children: [
          //header
          PageHeader(
            title: lang.starterPage.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(
                label: lang.starterPage,
                uri: RouteUri.starterpage,
              ),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // Demo Content - replace this with your content
                AdaptiveWrap(
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
                    CardExample(), // column A widget
                    CardExample(), // column B widget
                  ],
                ),

                SizedBox(height: kDefaultPadding),

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
                    CardExample(), // column A widget
                    CardExample(), // column B widget
                    CardExample(), // column C widget
                  ],
                ),

                SizedBox(height: kDefaultPadding),

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
                    CardExample(), // column A widget
                    CardExample(), // column B widget
                    CardExample(), // column C widget
                    CardExample(), // column D widget
                  ],
                ),
                SizedBox(height: kDefaultPadding),

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
                    CardExample(),

                    // Column B & C
                    AdaptiveWrap(
                      breakpoints: {kScreenWidthSm: 2},
                      columnRatios: const [
                        0.3, // set column B as 30%
                        0.2, // set column C as 20%
                      ],
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [CardExample(), CardExample()],
                    ),
                  ],
                ),
                // End of Demo Content
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
      floatingActionButton: _showButton
          ? SizedBox(
              height: mediumHeight,
              width: mediumHeight,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: kErrorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )
          : null,
    );
  }
}

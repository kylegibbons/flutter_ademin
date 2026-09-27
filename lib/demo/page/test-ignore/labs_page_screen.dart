import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class LabsPageScreen extends StatefulWidget {
  const LabsPageScreen({super.key});

  @override
  State<LabsPageScreen> createState() => _LabsPageScreenState();
}

class _LabsPageScreenState extends State<LabsPageScreen> {
  late ScrollController _scrollController;
  bool _showButton = false;
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).labs;
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
                      lang.labs.toUpperCase(),
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
                        BreadcrumbItem(label: lang.pages(2), uri: ''),
                        BreadcrumbItem(
                          label: lang.labs,
                          uri: RouteUri.labsPage,
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
            child: ShowCodeCard(
              cardTitle: 'Testing Card',
              description:
                  'We provide dedicated testing cards that allow developers to quickly experiment with FlutKit widgets. These cards are isolated, easy to reset, and ideal for validating UI behavior, styling, and layout responsiveness before integrating components into production pages.',
              uiView: Column(
                children: [
                  // Primary button
                  CustomElevatedButton(
                    kText: 'Primary',
                    bgColor: kPrimaryColor,
                    kTextColor: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          //footer

          // const PortalFooter(),
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

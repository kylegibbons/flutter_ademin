import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/notifications/widgets/notifications_list.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late ScrollController _scrollController;
  bool _showButton = false;
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).notifications;
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
            title: lang.gallery.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.gallery, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: NotificationList(),
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

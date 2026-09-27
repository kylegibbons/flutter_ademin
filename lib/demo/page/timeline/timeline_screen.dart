import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/timeline/timeline_data.dart';
import 'package:flutkit_ademin/demo/page/timeline/widgets/timeline_centered.dart';
import 'package:flutkit_ademin/demo/page/timeline/widgets/timeline_leading.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).timeline; //update your page tittle here
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
          //header
          PageHeader(
            title: lang.timeline.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.timeline, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // Center Timeline
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Center Timeline",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: kBodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                CenteredTimeline(events: timelineEvents),

                // Left Timeline
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Leading Timeline",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: kBodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                const LeadingTimeline(),
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

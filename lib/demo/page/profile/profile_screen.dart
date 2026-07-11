import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_activities.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_documents.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_header.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_overview.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_projects.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/base_ui/tab.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).profile; //update your page tittle here
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
          //header
          PageHeader(
            title: lang.profile.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.profile, uri: ''),
            ],
          ),

          //content
          Stack(
            children: [
              // header background
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile_bg.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: 2 * kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: Column(
                  children: [
                    // Profile Header
                    ProfileHeader(),

                    SizedBox(height: 2 * kDefaultPadding),

                    // tabs
                    HorizontalTabBar(
                      indicatorColor: Colors.white.withValues(alpha: 0.1),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      headerColor: Colors.transparent,
                      labelStyle: TextStyle(
                        fontSize: kBodyLarge,
                        fontWeight: FontWeight.w500,
                      ),
                      sideWidget: FancyIconButton(
                        kText: 'Edit Profile',
                        kTextColor: Colors.white,
                        bgColor: kSuccessColor,
                        kLeadingIcon: Icons.edit_outlined,
                        onPressed: () {},
                      ),
                      isPill: true,
                      tabs: [
                        // overview tab
                        TabBarItem(
                          label: 'Overview',
                          icon: Icons.dashboard_outlined,
                          content: OverviewContent(
                            mediaQueryData: mediaQueryData,
                            themeData: themeData,
                          ),
                        ),
                        TabBarItem(
                          label: 'Activities',
                          icon: Icons.query_stats_outlined,
                          content: ActivitiesContent(themeData: themeData),
                        ),
                        TabBarItem(
                          label: 'Projects',
                          icon: Icons.view_kanban_outlined,
                          content: ProjectContent(),
                        ),
                        TabBarItem(
                          label: 'Documents',
                          icon: Icons.document_scanner_outlined,
                          content: DocumentsContent(themeData: themeData),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

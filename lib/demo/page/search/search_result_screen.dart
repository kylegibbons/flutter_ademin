import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_documents_table.dart';
import 'package:flutkit_ademin/demo/page/search/widgets/search_result_all.dart';
import 'package:flutkit_ademin/demo/page/search/widgets/search_result_header.dart';
import 'package:flutkit_ademin/demo/page/search/widgets/search_result_image.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/base_ui/tab.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).searchResult; //update your page tittle here
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
            title: lang.searchResult.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.searchResult, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      // search header
                      SearchResultHeader(),

                      SizedBox(height: kDefaultPadding),

                      // search result tab bar
                      HorizontalTabBar(
                        indicatorColor: themeData.colorScheme.primary,
                        labelColor: themeData.colorScheme.primary,
                        unselectedLabelColor: themeData.colorScheme.onSurface,
                        labelStyle: TextStyle(
                          fontSize: kBodyMedium,
                          fontWeight: FontWeight.w500,
                        ),
                        sideWidget: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2,
                              horizontal: kDefaultPadding,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: themeData.colorScheme.onSurface,
                                ),
                                if (MediaQuery.of(context).size.width >
                                    kScreenWidthSm)
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: kDefaultPadding / 2,
                                    ),
                                    child: Text(
                                      'Settings',
                                      style: TextStyle(
                                        color: themeData.colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        pillBorderRadius: 0,
                        headerBorder: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                        indicatorTabbar: BoxDecoration(
                          color: kPrimaryColor.withValues(alpha: 0.1),
                          border: Border(
                            bottom: BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        tabs: [
                          TabBarItem(
                            label: 'All results',
                            icon: Icons.search_sharp,
                            content: AllSearchResults(),
                          ),
                          TabBarItem(
                            label: 'Images',
                            icon: Icons.image_outlined,
                            content: ImageSearchResults(),
                          ),
                          TabBarItem(
                            label: 'Files',
                            icon: Icons.list,
                            content: DocumentsTable(),
                          ),
                          // TabBarItem(
                          //   label: 'Videos',
                          //   icon: Icons.video_settings,
                          //   content: VideoSearchResults(),
                          // ),
                        ],
                      ),
                    ],
                  ),
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

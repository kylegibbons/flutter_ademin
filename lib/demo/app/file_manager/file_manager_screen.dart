import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/file_manager/widgets/all_media_section.dart';
import 'package:flutkit_ademin/demo/app/file_manager/widgets/folder_section.dart';
import 'package:flutkit_ademin/demo/app/file_manager/widgets/recent_files_table.dart';
import 'package:flutkit_ademin/demo/app/file_manager/widgets/storage_details.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).fileManager;
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

    return PortalMasterLayout(
      body: ListView(
        children: [
          // page header
          PageHeader(
            title: lang.fileManager.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.fileManager, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // All Media
                AllMedia(),
                SizedBox(height: kDefaultPadding),

                ResponsiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: const [
                    0.7, // set column A as 70% width
                    0.3, // set column B as 30% width
                  ],
                  spacing: kDefaultPadding, // spacing
                  runSpacing: kDefaultPadding, // run spacing
                  children: [
                    // all folders
                    FolderSection(),

                    // storage details pie chart
                    StorageDetails(),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                // recent files
                RecentFilesTable(),
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

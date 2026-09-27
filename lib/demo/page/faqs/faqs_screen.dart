import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/faqs/faqs_data.dart';
import 'package:flutkit_ademin/demo/page/faqs/widgets/faqs_section.dart';
import 'package:flutkit_ademin/demo/page/faqs/widgets/faqs_header.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).faqs; //update your page tittle here
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
          //header
          PageHeader(
            title: lang.faqs.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.faqs, uri: ''),
            ],
          ),

          //content
          Column(
            children: [
              // faqs header
              FaqsHeader(),

              SizedBox(height: kDefaultPadding),

              // faqs grid view
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: ResponsiveWrap(
                  columnRatios: [1 / 3, 1 / 3, 1 / 3],
                  breakpoints: {
                    kScreenWidthSm: 1,
                    kScreenWidthMd: 2,
                    kScreenWidthLg: 3,
                  },
                  children: mockFaqCategories.map((category) {
                    return FaqSection(category: category);
                  }).toList(),
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

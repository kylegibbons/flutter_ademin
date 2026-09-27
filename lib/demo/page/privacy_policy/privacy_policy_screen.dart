import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/privacy_policy/widgets/privacy_policy_header.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

import 'widgets/privacy_policy_content.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _StarterPageScreenState();
}

class _StarterPageScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).privacyPolicy; //update your page tittle here
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
    final screenWidth = MediaQuery.of(context).size.width;
    // Last updated date
    final String lastUpdatedDate = "April 28, 2025";

    return PortalMasterLayout(
      body: ListView(
        children: [
          //header
          PageHeader(
            title: lang.privacyPolicy.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.privacyPolicy, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth >= kScreenWidthXl
                  ? 4 * kDefaultPadding
                  : kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: Card(
              child: Column(
                children: [
                  // header
                  PrivacyPolicyHeader(lastUpdatedDate: lastUpdatedDate),

                  // content
                  const PrivacyPolicyContent(),

                  // approve button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2 * kDefaultPadding,
                        right: 2 * kDefaultPadding,
                        bottom: 2 * kDefaultPadding,
                      ),
                      child: FlatButton(
                        kText: 'I Approve',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

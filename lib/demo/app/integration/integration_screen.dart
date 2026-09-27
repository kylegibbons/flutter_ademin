import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/integration/dialogs/new_integration_form.dart';
import 'package:flutkit_ademin/demo/app/integration/integration_data.dart';
import 'package:flutkit_ademin/demo/app/integration/widgets/integration_card.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class IntegrationScreen extends StatefulWidget {
  const IntegrationScreen({super.key});

  @override
  State<IntegrationScreen> createState() => _IntegrationScreenState();
}

class _IntegrationScreenState extends State<IntegrationScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).integration;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  void _showNewIntegrationDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "New integration",
      showCloseButton: true, // show close button
      content: NewIntegrationForm(apps: mockupIntegrations),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return PortalMasterLayout(
      body: ListView(
        children: [
          // page header
          PageHeader(
            title: lang.integration.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.integration, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // header
                Row(
                  children: [
                    // search bar
                    SizedBox(
                      width: 280,
                      child: OutlineSearchBar(hintText: 'Search...'),
                    ),

                    Spacer(),
                    // upload button
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kSecondaryColor,
                            tooltipMessage: 'New Integration',
                            onTap: () => _showNewIntegrationDialog(context),
                          )
                        : FlatButton(
                            kText: 'New Integration',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () => _showNewIntegrationDialog(context),
                            kLeadingIcon: Icons.add_outlined,
                          ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                IntegrationCardGrid(),
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

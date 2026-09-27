import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/settings/settings_data.dart';
import 'package:flutkit_ademin/demo/page/settings/widgets/settings_appearance.dart';
import 'package:flutkit_ademin/demo/page/settings/widgets/settings_preference.dart';
import 'package:flutkit_ademin/demo/page/settings/widgets/settings_profile.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/tab.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).settings;
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
            title: lang.settings.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.settings, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(defaultRadius),
                child: VerticalTabBar(
                  color: kSecondaryColor,
                  tabs: const [
                    VerticalTabItem(
                      title: "Profile",
                      subtitle: "Personal information",
                      icon: Icons.person_outline,
                    ),
                    VerticalTabItem(
                      title: "Preferences",
                      subtitle: "Notifications & alerts",
                      icon: Icons.notifications_none,
                    ),
                    VerticalTabItem(
                      title: "Appearance",
                      subtitle: "Look & feel",
                      icon: Icons.palette_outlined,
                    ),
                  ],
                  children: [
                    ProfileSettings(
                      initialData: user,
                      onSubmit: (updatedUser) {
                        debugPrint('Name: ${updatedUser.name}');
                        debugPrint('Email: ${updatedUser.email}');
                        debugPrint('Phone: ${updatedUser.phone}');
                        debugPrint('Phone: ${updatedUser.phone}');
                        debugPrint('Bio: ${updatedUser.bio}');
                      },
                    ),
                    PreferencesSettings(),
                    AppearanceSettings(),
                  ],
                ),
              ),
            ),
          ),

          //footer
          // const PortalFooter(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/app_selector.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/full_screen_toggle.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/language_selector.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/notifications_bell.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/profile_button.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/rtl_switch.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/search_bar.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/theme_selector.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/theme_toggle.dart';

class TopNavBarConfig {
  // List of widgets displayed in the desktop top navigation bar
  static List<Widget> desktopActions(BuildContext context) {
    final lang = Lang.of(context);

    return [
      // Search bar with fixed width
      SizedBox(width: 274, child: SoftSearchBar(hintText: lang.search)),
      Spacer(), // Pushes utility widgets to the right.
      RTLSwitch(), // Toggles UI direction (Right-to-Left).
      AppSelectorButton(), // Button to switch applications/modules.
      FullScreenButton(), // Toggles application fullscreen mode.
      ToggleThemeButton(), // Switches between light and dark themes.
      ChangeLanguageButton(), // Changes the application's displayed language.
      ThemeSelectorButton(), // Selects a specific color theme/palette.
      NotificationBell(), // Displays notifications count and list.
      SizedBox(width: kDefaultPadding / 8),
      ProfileButton(), // Accesses user profile, settings, and logout.
    ];
  }

  // List of widgets displayed in the mobile top navigation bar
  static List<Widget> mobileActions(BuildContext context) {
    return [
      SmallSearchBarButton(), // Button that opens/expands the search interface.
      RTLSwitch(), // Toggles UI direction (Right-to-Left).
      AppSelectorButton(), // Button to switch applications/modules.
      ToggleThemeButton(), // Switches between light and dark themes.
      ChangeLanguageButton(), // Changes the application's displayed language.
      ThemeSelectorButton(), // Selects a specific color theme/palette.
      NotificationBell(), // Displays notifications count and list.
      ProfileButton(), // Accesses user profile, settings, and logout.
    ];
  }
}

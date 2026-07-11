import 'package:flutter/material.dart';

/// =======================
/// Global App Settings
/// =======================
class AppSettings {
  /// Identity
  static const String appName = "Ademin Flutter Dashboard";
  static const String appShortName = "Ademin";
  static const String appVersion = "1.0.0";
  static const String appDescription =
      "Flutter Dashboard UI Kits for Modern Web, Dekstop & Mobile Apps";
  static const String companyName = "FlutKit";
  static const String companyWebsite = "flutkit.com";

  /// Assets
  // logo path must be in assets/images/ folder
  static const String logoPath = "assets/images/logo.png";
  static const String logoMinPath = "assets/images/logo_min.png";

  /// Theme
  // set initial ThemeMode, ThemeMode.system to follow system brightness
  static const ThemeMode initialThemeMode = ThemeMode.light;

  // index of default palette (0 = primary/default, 1 = Deep Blue, 2 = Purple, etc. Check lib\data\top_nav_bar_data.dart)
  static const int defaultThemeIndex = 0;

  // enable or disable theme selector
  static const bool enableThemeSelector = true;

  // set as true to initialize as RTL app
  static const bool isRTL = false;

  /// Authentication
  // set true for production, go to app_router.dart for advanced setup
  static const bool enableAuth = false;

  /// API / Backend
  static const String apiBaseUrl = "https://api.example.com";
  static const Duration apiTimeout = Duration(seconds: 15);

  /// Localization
  // replace with your default language code, check localeMenuConfigs in lib\data\top_nav_bar_data.dart and /lib/l10n folder
  static const String defaultLocale = "en";
}

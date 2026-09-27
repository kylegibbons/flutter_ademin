import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/constants/values.dart';
import 'package:flutkit_ademin/environment.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appPreferencesProvider =
    NotifierProvider<AppPreferencesController, AppPreferencesState>(
      AppPreferencesController.new,
    );

@immutable
class AppPreferencesState {
  const AppPreferencesState({
    required this.appThemeIndex,
    required this.locale,
    required this.themeMode,
    required this.isRTL,
    required this.useLightSidebar,
  });

  factory AppPreferencesState.initial() {
    return AppPreferencesState(
      appThemeIndex: AppSettings.defaultThemeIndex,
      locale: Locale(env.defaultAppLanguageCode),
      themeMode: AppSettings.initialThemeMode,
      isRTL: AppSettings.isRTL,
      useLightSidebar: AppSettings.defaultUseLightSidebar,
    );
  }

  final int appThemeIndex;
  final Locale locale;
  final ThemeMode themeMode;
  final bool isRTL;
  final bool useLightSidebar;

  AppPreferencesState copyWith({
    int? appThemeIndex,
    Locale? locale,
    ThemeMode? themeMode,
    bool? isRTL,
    bool? useLightSidebar,
  }) {
    return AppPreferencesState(
      appThemeIndex: appThemeIndex ?? this.appThemeIndex,
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      isRTL: isRTL ?? this.isRTL,
      useLightSidebar: useLightSidebar ?? this.useLightSidebar,
    );
  }
}

class AppPreferencesController extends Notifier<AppPreferencesState> {
  @override
  AppPreferencesState build() {
    final initialState = AppPreferencesState.initial();
    ThemePalette.instance.setPalette(initialState.appThemeIndex);
    return initialState;
  }

  Future<void> loadAsync() async {
    final sharedPref = await SharedPreferences.getInstance();
    final langCode =
        sharedPref.getString(StorageKeys.appLanguageCode) ??
        env.defaultAppLanguageCode;
    final savedThemeIndex =
        sharedPref.getInt(StorageKeys.appThemeIndex) ??
        AppSettings.defaultThemeIndex;

    final locale = _parseLocale(langCode);
    final savedThemeMode = sharedPref.getString(StorageKeys.appThemeMode);
    final savedUseLightSidebar = sharedPref.getBool(
      StorageKeys.appUseLightSidebar,
    );
    final themeMode = ThemeMode.values.byName(
      savedThemeMode ?? AppSettings.initialThemeMode.name,
    );
    ThemePalette.instance.setPalette(savedThemeIndex);

    state = state.copyWith(
      appThemeIndex: savedThemeIndex,
      locale: locale,
      themeMode: themeMode,
      isRTL: _isLocaleRtl(locale),
      useLightSidebar:
          savedUseLightSidebar ?? AppSettings.defaultUseLightSidebar,
    );
  }

  Future<void> setLocaleAsync({
    required Locale locale,
    bool save = true,
  }) async {
    final shouldBeRTL = _isLocaleRtl(locale);
    if (locale == state.locale && shouldBeRTL == state.isRTL) return;

    if (save) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(
        StorageKeys.appLanguageCode,
        _serializeLocale(locale),
      );
    }

    state = state.copyWith(locale: locale, isRTL: shouldBeRTL);
  }

  Future<void> setThemeModeAsync({
    required ThemeMode themeMode,
    bool save = true,
  }) async {
    if (themeMode == state.themeMode) return;

    if (save) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(StorageKeys.appThemeMode, themeMode.name);
    }

    state = state.copyWith(themeMode: themeMode);
  }

  void toggleRTL() {
    state = state.copyWith(isRTL: !state.isRTL);
  }

  Future<void> loadPreferences() async {
    ThemePalette.instance.setPalette(state.appThemeIndex);
  }

  Future<void> setAppThemeIndex(int index) async {
    if (index == state.appThemeIndex) return;

    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(StorageKeys.appThemeIndex, index);
    ThemePalette.instance.setPalette(index);
    state = state.copyWith(appThemeIndex: index);
  }

  Future<void> setUseLightSidebarAsync({
    required bool useLightSidebar,
    bool save = true,
  }) async {
    if (useLightSidebar == state.useLightSidebar) return;

    if (save) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool(StorageKeys.appUseLightSidebar, useLightSidebar);
    }

    state = state.copyWith(useLightSidebar: useLightSidebar);
  }

  Locale _parseLocale(String langCode) {
    if (!langCode.contains('_')) {
      return Locale(langCode);
    }

    final values = langCode.split('_');
    return Locale.fromSubtags(languageCode: values[0], scriptCode: values[1]);
  }

  String _serializeLocale(Locale locale) {
    if (locale.scriptCode == null || locale.scriptCode!.isEmpty) {
      return locale.languageCode;
    }

    return '${locale.languageCode}_${locale.scriptCode}';
  }

  bool _isLocaleRtl(Locale locale) {
    return const [
      'ar',
      'he',
      'fa',
      'ur',
    ].contains(locale.languageCode.toLowerCase());
  }
}

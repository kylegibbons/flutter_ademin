import 'package:flutter/material.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/constants/values.dart';
import 'package:flutter_ademin/environment.dart';
import 'package:flutter_ademin/theme/themes.dart';
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
  });

  factory AppPreferencesState.initial() {
    return AppPreferencesState(
      appThemeIndex: AppSettings.defaultThemeIndex,
      locale: Locale(env.defaultAppLanguageCode),
      themeMode: AppSettings.initialThemeMode,
      isRTL: AppSettings.isRTL,
    );
  }

  final int appThemeIndex;
  final Locale locale;
  final ThemeMode themeMode;
  final bool isRTL;

  AppPreferencesState copyWith({
    int? appThemeIndex,
    Locale? locale,
    ThemeMode? themeMode,
    bool? isRTL,
  }) {
    return AppPreferencesState(
      appThemeIndex: appThemeIndex ?? this.appThemeIndex,
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      isRTL: isRTL ?? this.isRTL,
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
    final themeMode = ThemeMode.values.byName(
      savedThemeMode ?? AppSettings.initialThemeMode.name,
    );
    ThemePalette.instance.setPalette(savedThemeIndex);

    state = state.copyWith(
      appThemeIndex: savedThemeIndex,
      locale: locale,
      themeMode: themeMode,
    );
  }

  Future<void> setLocaleAsync({required Locale locale, bool save = true}) async {
    if (locale == state.locale) return;

    if (save) {
      final sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setString(
        StorageKeys.appLanguageCode,
        _serializeLocale(locale),
      );
    }

    state = state.copyWith(locale: locale);
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

  Locale _parseLocale(String langCode) {
    if (!langCode.contains('_')) {
      return Locale(langCode);
    }

    final values = langCode.split('_');
    return Locale.fromSubtags(
      languageCode: values[0],
      scriptCode: values[1],
    );
  }

  String _serializeLocale(Locale locale) {
    if (locale.scriptCode == null || locale.scriptCode!.isEmpty) {
      return locale.languageCode;
    }

    return '${locale.languageCode}_${locale.scriptCode}';
  }
}

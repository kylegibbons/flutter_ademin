import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/providers/user_data_provider.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/app_focus_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';

class RootApp extends ConsumerStatefulWidget {
  const RootApp({super.key});

  @override
  ConsumerState<RootApp> createState() => _RootAppState();
}

class _RootAppState extends ConsumerState<RootApp> {
  GoRouter? _appRouter;
  late final Future<bool> _future;

  Future<bool> _getScreenDataAsync(
    AppPreferencesController appPreferencesController,
    UserDataController userDataController,
  ) async {
    await appPreferencesController.loadAsync();
    await userDataController.loadAsync();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _future = _getScreenDataAsync(
      ref.read(appPreferencesProvider.notifier),
      ref.read(userDataProvider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(appPreferencesProvider);

    return GestureDetector(
      onTap: () {
        // Tap anywhere to dismiss soft keyboard.
        AppFocusHelper.instance.requestUnfocus();
      },
      child: FutureBuilder<bool>(
        initialData: null,
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            _appRouter ??= appRouter(ref.read(userDataProvider.notifier));

            return MaterialApp.router(
              key: ValueKey(
                'app-${preferences.appThemeIndex}-${preferences.themeMode.name}-${preferences.useLightSidebar}-${preferences.isRTL}-${preferences.locale.toLanguageTag()}',
              ),
              title: AppSettings.appName,
              debugShowCheckedModeBanner: false,
              routeInformationProvider: _appRouter!.routeInformationProvider,
              routeInformationParser: _appRouter!.routeInformationParser,
              routerDelegate: _appRouter!.routerDelegate,
              supportedLocales: Lang.delegate.supportedLocales,
              localizationsDelegates: const [
                Lang.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FormBuilderLocalizations.delegate,
                FlutterQuillLocalizations.delegate,
              ],
              locale: preferences.locale,
              onGenerateTitle: (context) => AppSettings.appName,
              theme: AppThemeData.instance.light(
                useLightSidebar: preferences.useLightSidebar,
              ),
              darkTheme: AppThemeData.instance.dark(
                useLightSidebar: preferences.useLightSidebar,
              ),
              themeMode: preferences.themeMode,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: Directionality(
                    textDirection: preferences.isRTL
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: child!,
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: kSuccessColor,
            ), // show loading indicator
          );
        },
      ),
    );
  }
}

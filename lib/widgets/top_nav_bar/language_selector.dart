import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/top_nav_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Language Selector ///

// language selector data model

class LocaleMenuConfig {
  final String languageCode;
  final String? scriptCode;
  final String name;

  const LocaleMenuConfig({
    required this.languageCode,
    this.scriptCode,
    required this.name,
  });
}

// Local menu configs, this is language selection menu, at default will be showed at top nav bar
const localeMenuConfigs = [
  LocaleMenuConfig(languageCode: 'en', name: 'English'),
  LocaleMenuConfig(languageCode: 'id', name: 'Indonesia'),
  LocaleMenuConfig(languageCode: 'ar', name: 'العربية'),

  // add new translation config here
];

//language selector button

class ChangeLanguageButton extends ConsumerWidget {
  ChangeLanguageButton({super.key});

  final GlobalKey<PopupMenuButtonState> popupLangSelector =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return PopupMenuButton(
      key: popupLangSelector,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      popUpAnimationStyle: AnimationStyle.noAnimation,
      itemBuilder: (context) {
        return localeMenuConfigs
            .map<PopupMenuItem>((e) {
              return PopupMenuItem(
                onTap: () async {
                  final controller = ref.read(appPreferencesProvider.notifier);

                  await controller.setLocaleAsync(
                    locale: Locale.fromSubtags(
                      languageCode: e.languageCode,
                      scriptCode: e.scriptCode,
                    ),
                  );
                },
                child: Text(
                  e.name,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontSize: kBodyMedium,
                  ),
                ),
              );
            })
            .toList(growable: false);
      },
      child: TopNavButton(
        tooltipMessage: 'Select Language',
        onTap: () {
          popupLangSelector.currentState?.showButtonMenu();
        },
        icon: Icons.translate_outlined,
      ),
    );
  }
}

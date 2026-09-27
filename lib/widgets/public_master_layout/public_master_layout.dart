import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/language_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublicMasterLayout extends ConsumerWidget {
  final Widget body;

  const PublicMasterLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: kToolbarHeight,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _toggleThemeButton(context, ref),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: VerticalDivider(
                    width: 1.0,
                    thickness: 1.0,
                    color: themeData.colorScheme.onSurface.withValues(
                      alpha: 0.3,
                    ),
                    indent: 14.0,
                    endIndent: 14.0,
                  ),
                ),
                _changeLanguageButton(context, ref),
                const SizedBox(width: kDefaultPadding * 0.5),
              ],
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }

  Widget _toggleThemeButton(BuildContext context, WidgetRef ref) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final isFullWidthButton =
        (MediaQuery.of(context).size.width > kScreenWidthMd);
    final themeMode = ref.watch(
      appPreferencesProvider.select((state) => state.themeMode),
    );

    return SizedBox(
      height: kToolbarHeight,
      width: (isFullWidthButton ? null : 48.0),
      child: TextButton(
        onPressed: () async {
          final controller = ref.read(appPreferencesProvider.notifier);
          final currentThemeMode = ref.read(
            appPreferencesProvider.select((state) => state.themeMode),
          );
          final themeMode = (currentThemeMode != ThemeMode.dark
              ? ThemeMode.dark
              : ThemeMode.light);

          controller.setThemeModeAsync(themeMode: themeMode);
        },
        style: TextButton.styleFrom(
          foregroundColor: themeData.colorScheme.onSurface,
          disabledForegroundColor: themeData.colorScheme.primary.withValues(
            alpha: 0.38,
          ),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Builder(
          builder: (context) {
            var icon = Icons.dark_mode_rounded;
            var text = lang.darkTheme;

            if (themeMode == ThemeMode.dark) {
              icon = Icons.light_mode_rounded;
              text = lang.lightTheme;
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: (themeData.textTheme.labelLarge!.fontSize! + 4.0),
                ),
                Visibility(
                  visible: isFullWidthButton,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding * 0.5),
                    child: Text(text),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _changeLanguageButton(BuildContext context, WidgetRef ref) {
    Lang.of(context);
    final themeData = Theme.of(context);
    return PopupMenuButton(
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
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
                child: Text(e.name),
              );
            })
            .toList(growable: false);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
        constraints: const BoxConstraints(minWidth: 48.0),
        child: Row(
          children: [
            Icon(
              Icons.translate_rounded,
              size: (Theme.of(context).textTheme.labelLarge!.fontSize! + 4.0),
              color: themeData.colorScheme.onSurface,
            ),
            Visibility(
              visible: (MediaQuery.of(context).size.width > kScreenWidthMd),
              child: Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding * 0.5),
                child: Text(
                  Lang.of(context).language,
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

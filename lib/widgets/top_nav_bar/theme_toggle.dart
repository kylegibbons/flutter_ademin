import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//theme toggle widget

class ToggleThemeButton extends ConsumerWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final themeMode = ref.watch(
      appPreferencesProvider.select((state) => state.themeMode),
    );
    final controller = ref.read(appPreferencesProvider.notifier);
    final currentThemeMode = themeMode;
    ThemeMode newThemeMode;
    final isDarkMode =
        (themeMode == ThemeMode.dark) ||
        (themeMode == ThemeMode.system && systemBrightness == Brightness.dark);

    return Material(
      type: MaterialType.transparency,
      child: Tooltip(
        message: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        child: InkWell(
          onTap: () {
            if (currentThemeMode == ThemeMode.light) {
              // If current mode is light, switch to dark
              newThemeMode = ThemeMode.dark;
            } else if (currentThemeMode == ThemeMode.dark) {
              // If current mode is dark, switch to light
              newThemeMode = ThemeMode.light;
            } else {
              // If the current mode is 'system', switch to the opposite mode of systemBrightness
              final systemBrightness = MediaQuery.of(
                context,
              ).platformBrightness;
              newThemeMode = systemBrightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
            }

            controller.setThemeModeAsync(themeMode: newThemeMode);
          },
          hoverColor: kSecondaryColor.withValues(alpha: 0.1),
          splashColor: kSecondaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(50),
          child: Builder(
            builder: (context) {
              final systemBrightness = MediaQuery.of(
                context,
              ).platformBrightness;
              final isDarkMode =
                  (themeMode == ThemeMode.dark) ||
                  (themeMode == ThemeMode.system &&
                      systemBrightness == Brightness.dark);
              final icon = isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined;

              return CircleAvatar(
                radius: mediumHeight / 2,
                backgroundColor: Colors.transparent,
                child: Icon(icon, color: kTextColor),
              );
            },
          ),
        ),
      ),
    );
  }
}

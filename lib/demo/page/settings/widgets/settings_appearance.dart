// Appearance Settings

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/language_selector.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/theme_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppearanceSettings extends ConsumerWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final preferences = ref.watch(appPreferencesProvider);
    final controller = ref.read(appPreferencesProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appearance'.toUpperCase(),
            style: TextStyle(
              fontSize: kBodyMedium,
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          Text(
            'Customize the look and feel of the dashboard',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),

          const SizedBox(height: 2 * kDefaultPadding),

          // dark light mode
          Text(
            'Theme Mode',
            style: TextStyle(
              // fontSize: kBodyLarge,
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            'Choose how the app should render light and dark surfaces.',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),

          const SizedBox(height: kDefaultPadding),

          Wrap(
            spacing: kDefaultPadding / 2,
            runSpacing: kDefaultPadding / 2,
            children: [
              _ChoiceChipTile(
                label: 'Light',
                icon: Icons.light_mode_outlined,
                selected: preferences.themeMode == ThemeMode.light,
                onTap: () =>
                    controller.setThemeModeAsync(themeMode: ThemeMode.light),
              ),
              _ChoiceChipTile(
                label: 'Dark',
                icon: Icons.dark_mode_outlined,
                selected: preferences.themeMode == ThemeMode.dark,
                onTap: () =>
                    controller.setThemeModeAsync(themeMode: ThemeMode.dark),
              ),
              _ChoiceChipTile(
                label: 'System',
                icon: Icons.desktop_mac_outlined,
                selected: preferences.themeMode == ThemeMode.system,
                onTap: () =>
                    controller.setThemeModeAsync(themeMode: ThemeMode.system),
              ),
            ],
          ),

          const SizedBox(height: 2 * kDefaultPadding),

          // Color Scheme
          Text(
            'Color Scheme',
            style: TextStyle(
              // fontSize: kBodyLarge,
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            'Pick the primary palette used across the dashboard.',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),

          const SizedBox(height: kDefaultPadding),

          ResponsiveWrap(
            breakpoints: {
              kScreenWidthMd / 2: 1,
              kScreenWidthLg: 2,
              kScreenWidthXl: 3,
            },
            columnRatios: const [1, 1, 1],
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding,
            children: List.generate(palettes.length, (index) {
              final palette = palettes[index];
              final isSelected = preferences.appThemeIndex == index;

              return InkWell(
                onTap: () => controller.setAppThemeIndex(index),
                borderRadius: BorderRadius.circular(defaultRadius),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    border: Border.all(
                      color: isSelected
                          ? palette.color
                          : themeData.colorScheme.outline,
                      width: isSelected ? 1.4 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: palette.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: Text(
                              palette.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_circle, color: palette.color),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Row(
                        children: [
                          _PalettePreview(color: palette.color),
                          const SizedBox(width: kDefaultPadding / 2),
                          _PalettePreview(
                            color: palette.color.withValues(alpha: 0.7),
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          _PalettePreview(
                            color: palette.color.withValues(alpha: 0.35),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 2 * kDefaultPadding),

          // sidebar style
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // language
                  Text(
                    'Use lighter sidebar background',
                    style: TextStyle(
                      // fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    'Use the surface color for sidebar background instead of the drawer accent color.',
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ],
              ),
              CustomSwitch(
                activeColor: kSecondaryColor,
                value: preferences.useLightSidebar,
                onChanged: (value) =>
                    controller.setUseLightSidebarAsync(useLightSidebar: value),
              ),
            ],
          ),

          const SizedBox(height: 2 * kDefaultPadding),

          // language
          Text(
            'Language',
            style: TextStyle(
              // fontSize: kBodyLarge,
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          Text(
            'Change the display language used by the interface.',
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
          const SizedBox(height: kDefaultPadding),

          Wrap(
            spacing: kDefaultPadding / 2,
            runSpacing: kDefaultPadding / 2,
            children: localeMenuConfigs
                .map((localeConfig) {
                  final locale = Locale.fromSubtags(
                    languageCode: localeConfig.languageCode,
                    scriptCode: localeConfig.scriptCode,
                  );
                  final isSelected =
                      preferences.locale.languageCode == locale.languageCode &&
                      preferences.locale.scriptCode == locale.scriptCode;

                  return _ChoiceChipTile(
                    label: localeConfig.name,
                    icon: Icons.translate_outlined,
                    selected: isSelected,
                    onTap: () => controller.setLocaleAsync(locale: locale),
                  );
                })
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _ChoiceChipTile extends StatelessWidget {
  const _ChoiceChipTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding * 0.5,
        ),
        height: mediumHeight,
        decoration: BoxDecoration(
          color: selected
              ? kSecondaryColor.withValues(alpha: 0.12)
              : themeData.colorScheme.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? kSecondaryColor : themeData.colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? kSecondaryColor
                  : themeData.colorScheme.onSurface,
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected
                    ? kSecondaryColor
                    : themeData.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PalettePreview extends StatelessWidget {
  const _PalettePreview({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

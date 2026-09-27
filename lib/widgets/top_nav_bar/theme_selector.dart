import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// THEME SELECTOR BUTTON ///

// Theme pallete data model

class Palette {
  final String name;
  final Color color;
  const Palette(this.name, this.color);
}

// Theme pallete mockup data
const List<Palette> palettes = [
  Palette('Navy Slate', Color(0xFF313F6C)),
  Palette('Dark Indigo', Color(0xFF303e8a)),
  Palette('Dark Violet', Color(0xFF463171)),
  Palette('Electric Violet', Color(0xFF520DC2)),
  Palette('Ocean Blue', Color(0xFF087990)),
  Palette('Navy Blue', Color(0xFF13509B)),
];

// Theme Selector Button UI View

class ThemeSelectorButton extends ConsumerWidget {
  ThemeSelectorButton({super.key});

  final GlobalKey<PopupMenuButtonState> popupThemeSelector =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = ref.read(appPreferencesProvider.notifier);
    final currentIndex = ref.watch(
      appPreferencesProvider.select((state) => state.appThemeIndex),
    );

    return PopupMenuButton<int>(
      key: popupThemeSelector,
      tooltip: 'Select theme',
      splashRadius: 0.0,
      position: PopupMenuPosition.under,
      color: theme.colorScheme.surface,
      popUpAnimationStyle: AnimationStyle.noAnimation,
      onSelected: (idx) {
        if (idx >= 0) {
          controller.setAppThemeIndex(idx);
        }
      },
      itemBuilder: (context) {
        final items = List<PopupMenuEntry<int>>.generate(
          palettes.length,
          (i) => PopupMenuItem(
            value: i,
            child: Row(
              children: [
                _swatch(palettes[i].color),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(child: Text(palettes[i].name)),
                if (currentIndex == i) Icon(Icons.check),
              ],
            ),
          ),
        );

        items.add(
          PopupMenuItem<int>(
            enabled: false,
            child: Consumer(
              builder: (context, ref, _) {
                final useLightSidebarInMenu = ref.watch(
                  appPreferencesProvider.select((s) => s.useLightSidebar),
                );
                final controllerInMenu = ref.read(
                  appPreferencesProvider.notifier,
                );

                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Use light sidebar',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                    CustomSwitch(
                      activeColor: kSecondaryColor,
                      value: useLightSidebarInMenu,
                      onChanged: (value) {
                        controllerInMenu.setUseLightSidebarAsync(
                          useLightSidebar: value,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );

        return items;
      },
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => popupThemeSelector.currentState?.showButtonMenu(),
          hoverColor: ThemePalette.instance.secondary.withValues(alpha: 0.1),
          splashColor: ThemePalette.instance.secondary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(50),
          child: CircleAvatar(
            radius: mediumHeight / 2,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.color_lens_outlined,
              color: ThemePalette.instance.text,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _swatch(Color color) {
    return Container(
      width: mediumHeight,
      height: mediumHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    );
  }
}

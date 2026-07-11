// Search bar

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/top_nav_button.dart';

class ResponsiveSearchBar extends StatelessWidget {
  const ResponsiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 280, // Batas maksimal lebar
      ),
      child: SizedBox(
        width: double.infinity, // Mencoba memenuhi ruang yang tersedia
        child: SoftSearchBar(hintText: lang.search),
      ),
    );
  }
}

//Small Search button

class SmallSearchBarButton extends StatelessWidget {
  SmallSearchBarButton({super.key, this.hintText});

  final GlobalKey<PopupMenuButtonState> popupSearchbar =
      GlobalKey<PopupMenuButtonState>();
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final lang = Lang.of(context);
    return PopupMenuButton(
      key: popupSearchbar,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: double.maxFinite,
            child: OutlineSearchBar(
              hintText: hintText ?? lang.search,
              autofocus: true,
            ),
          ),
        ),
      ],
      child: TopNavButton(
        tooltipMessage: 'Search',
        onTap: () {
          popupSearchbar.currentState?.showButtonMenu();
        },
        icon: Icons.search_outlined,
      ),
    );
  }
}

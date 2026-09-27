import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/providers/sidebar_provider.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// buy ademin button

class BuyAdeminButton extends ConsumerStatefulWidget {
  const BuyAdeminButton({super.key});

  @override
  ConsumerState<BuyAdeminButton> createState() => _BuyAdeminButtonState();
}

class _BuyAdeminButtonState extends ConsumerState<BuyAdeminButton> {
  // State to track whether the full content is allowed to be displayed
  bool _showFullContent = true;

  Future<void> _openAdemin() async {
    final Uri url = Uri.parse('https://flutkit.com/ademin');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sidebarState = ref.watch(sidebarProvider);
    final isSidebarHovered = ref.watch(sidebarHoverProvider);
    final bool shouldExpand =
        !sidebarState.isSidebarMinimized || isSidebarHovered;
    final useLightSidebar = ref.watch(
      appPreferencesProvider.select((state) => state.useLightSidebar),
    );

    final themeData = Theme.of(context);

    // KEY logic: Delay content swapping until width is appropriate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (shouldExpand && !_showFullContent) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() => _showFullContent = true);
          }
        });
      } else if (!shouldExpand && _showFullContent) {
        // If it must be minimized, immediately hide the full content
        setState(() => _showFullContent = false);
      }
    });
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: _showFullContent
          ? FancyIconButton(
              kText: 'Buy Ademin',
              kTextColor: useLightSidebar
                  ? themeData.colorScheme.onSurface
                  : Colors.white,
              bgColor: useLightSidebar
                  ? themeData.colorScheme.onSurface.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.1),
              kLeadingIcon: Icons.workspace_premium_outlined,
              isFullWidth: true,
              onPressed: _openAdemin,
            )
          : CustomIconButton(
              icon: Icons.workspace_premium_outlined,
              iconColor: useLightSidebar
                  ? themeData.colorScheme.onSurface
                  : Colors.white,
              buttonColor: useLightSidebar
                  ? themeData.colorScheme.onSurface.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.1),
              onTap: _openAdemin,
            ),
    );
  }
}

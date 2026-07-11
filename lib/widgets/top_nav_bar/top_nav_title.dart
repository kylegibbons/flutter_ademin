//title /logo widget

import 'package:flutter/material.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/providers/sidebar_provider.dart';
import 'package:flutter_ademin/theme/theme_extensions/app_sidebar_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsiveAppBarTitle extends ConsumerStatefulWidget {
  final void Function() onAppBarTitlePressed;

  const ResponsiveAppBarTitle({super.key, required this.onAppBarTitlePressed});

  @override
  ConsumerState<ResponsiveAppBarTitle> createState() =>
      _ResponsiveAppBarTitleState();
}

class _ResponsiveAppBarTitleState
    extends ConsumerState<ResponsiveAppBarTitle> {
  bool _showFullLogo = true;
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final sidebarTheme = themeData.extension<AppSidebarTheme>()!;
    final sidebarState = ref.watch(sidebarProvider);
    final isSidebarHovered = ref.watch(sidebarHoverProvider);

    // Calculates the state of whether the sidebar should expand/fill
    final bool shouldExpand =
        !sidebarState.isSidebarMinimized || isSidebarHovered;
    final double sidebarWidth = shouldExpand ? kSidebarWidth : kSidebarWidthMin;

    // We use WidgetsBinding.instance.addPostFrameCallback
    // to intervene with the state after the AnimatedContainer starts changing.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Expansion Case (Minimized to Full/Hover)
      if (shouldExpand && !_showFullLogo) {
        // Delay the display of the full logo (logo.png)
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _showFullLogo = true;
            });
          }
        });
      }
      // 2. Minimized Case (Full/Hover to Minimized)
      else if (!shouldExpand && _showFullLogo) {
        setState(() {
          _showFullLogo = false;
        });
      }
    });

    // Determine the correct logo path based on the local state (_showFullLogo)
    final String logoPath;

    logoPath = _showFullLogo ? AppSettings.logoPath : AppSettings.logoMinPath;

    return MouseRegion(
      onEnter: (_) {
        if (sidebarState.isSidebarMinimized) {
          ref.read(sidebarHoverProvider.notifier).setHoverState(true);
        }
      },
      onExit: (_) {
        if (sidebarState.isSidebarMinimized) {
          ref.read(sidebarHoverProvider.notifier).setHoverState(false);
        }
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onAppBarTitlePressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: sidebarWidth,
          height: kTopNavHeight,
          decoration: BoxDecoration(
            color: mediaQueryData.size.width >= kScreenWidthLg
                ? sidebarTheme.backgroundColor
                : Colors.transparent,
          ),
          child: ClipRect(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: mediaQueryData.size.width > kScreenWidthLg,
                  child: SizedBox(
                    height: 24,
                    child: Image.asset(logoPath, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

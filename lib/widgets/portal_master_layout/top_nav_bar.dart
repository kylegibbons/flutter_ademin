import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/configs/top_nav_bar_config.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/providers/sidebar_provider.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/top_nav_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TopNavBar extends ConsumerStatefulWidget {
  const TopNavBar({
    super.key,
    required this.drawer,
    required this.onTunePressed,
    required this.isSecondaryBarVisible,
  });

  final Widget? drawer;
  final VoidCallback onTunePressed;
  final bool isSecondaryBarVisible;

  @override
  ConsumerState<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends ConsumerState<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final sidebarState = ref.watch(sidebarProvider);
    final bool isDesktop = mediaQueryData.size.width > kScreenWidthMd;
    final bool isMobile = mediaQueryData.size.width <= kScreenWidthMd;
    return Container(
      decoration: BoxDecoration(color: themeData.colorScheme.surfaceBright),
      child: Row(
        children: [
          //drawer
          if (widget.drawer != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: kDefaultPadding / 2,
              ),
              child: IconButton(
                icon: Icon(Icons.menu, color: kTextColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),

          //title /logo
          if (mediaQueryData.size.width > kScreenWidthLg)
            ResponsiveAppBarTitle(
              onAppBarTitlePressed: () =>
                  GoRouter.of(context).go(RouteUri.home),
            ),

          Expanded(
            child: Container(
              height: kTopNavHeight,
              decoration: BoxDecoration(
                color: themeData.colorScheme.surfaceBright,
                boxShadow: mediaQueryData.size.width > kScreenWidthLg
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  //sidebar minimize button
                  if (mediaQueryData.size.width > kScreenWidthLg)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      child: InkWell(
                        onTap: () {
                          ref.read(sidebarProvider.notifier).toggleSidebar();
                        },
                        child: Icon(
                          sidebarState.isSidebarMinimized
                              ? Icons.arrow_forward
                              : Icons.menu,
                          color: kTextColor,
                        ),
                      ),
                    ),

                  /// DESKTOP actions menu
                  if (isDesktop)
                    ...TopNavBarConfig.desktopActions(context).map(
                      (e) => e is Spacer
                          ? e
                          : Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: kDefaultPadding / 2,
                              ),
                              child: e,
                            ),
                    ),
                  if (isDesktop) SizedBox(width: kDefaultPadding),

                  /// MOBILE actions menu
                  if (isMobile) Spacer(),
                  if (isMobile)
                    // Show mobile top nav bar widget button
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: kDefaultPadding,
                      ),
                      child: CustomIconButton(
                        icon: widget.isSecondaryBarVisible
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        onTap: widget.onTunePressed,
                        buttonColor: kTableHeaderColor,
                        shape: ButtonShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Secondary top nav bar, slide down under main top nav bar in mobile.

class SecondaryTopNavBar extends StatelessWidget {
  const SecondaryTopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Divider(height: 0),
        Container(
          width: double.infinity,
          height: kTopNavHeight,
          decoration: BoxDecoration(color: themeData.colorScheme.surfaceBright),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ...TopNavBarConfig.mobileActions(
                context,
              ).map((e) => e is Spacer ? e : e),
            ],
          ),
        ),
      ],
    );
  }
}

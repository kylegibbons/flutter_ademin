import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/configs/sidebar_menu_config.dart';
import 'package:flutter_ademin/providers/sidebar_provider.dart';
import 'package:flutter_ademin/theme/theme_extensions/app_sidebar_theme.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/sidebar.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/top_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalMasterLayout extends ConsumerStatefulWidget {
  // final GlobalKey<ScaffoldState>? key;
  final Widget body;
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final void Function(bool isOpened)? onDrawerChanged;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Drawer? endDrawer;

  const PortalMasterLayout({
    // this.key,
    super.key,
    required this.body,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    this.onDrawerChanged,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
  });

  @override
  ConsumerState<PortalMasterLayout> createState() =>
      _PortalMasterLayoutState();
}

class _PortalMasterLayoutState extends ConsumerState<PortalMasterLayout> {
  // State to control the visibility of the additional bar
  bool _isBarVisible = false;

  // Function to toggle (flip) the visibility of the bar
  void _toggleBarVisibility() {
    setState(() {
      _isBarVisible = !_isBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final drawer = (mediaQueryData.size.width <= kScreenWidthLg
        ? _sidebar(context)
        : null);
    final sidebarState = ref.watch(sidebarProvider);
    final isSidebarHovered = ref.watch(sidebarHoverProvider);

    return Scaffold(
      appBar: _DynamicAppBar(
        isBarVisible: _isBarVisible,
        onTunePressed: _toggleBarVisibility,
        mediaQueryData: mediaQueryData,
        themeData: themeData,
        drawer: drawer,
      ),
      key: widget.key,
      drawer: drawer,
      endDrawer: widget.endDrawer,
      drawerEnableOpenDragGesture: false,
      onDrawerChanged: widget.onDrawerChanged,
      body: _responsiveBody(context, sidebarState, isSidebarHovered),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
    );
  }

  Widget _responsiveBody(
    BuildContext context,
    SidebarState sidebarState,
    bool isSidebarHovered,
  ) {
    if (MediaQuery.of(context).size.width <= kScreenWidthLg) {
      return widget.body;
    } else {
      return Row(
        children: [
          MouseRegion(
            onEnter: (_) {
              ref.read(sidebarHoverProvider.notifier).setHoverState(true);
            },
            onExit: (_) {
              ref.read(sidebarHoverProvider.notifier).setHoverState(false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width:
                  isSidebarHovered || !sidebarState.isSidebarMinimized
                  ? Theme.of(context).extension<AppSidebarTheme>()!.sidebarWidth
                  : kSidebarWidthMin,
              child: _sidebar(context),
            ),
          ),

          //content body
          Expanded(child: widget.body),
        ],
      );
    }
  }

  //sidebar widget
  Widget _sidebar(BuildContext context) {
    return Sidebar(
      autoSelectMenu: widget.autoSelectMenu,
      selectedMenuUri: widget.selectedMenuUri,
      sidebarConfigs: sidebarMenuConfigs,
    );
  }
}

// --- DYNAMIC APPBAR WIDGET (PreferredSizeWidget Implementation) ---
class _DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBarVisible;
  final VoidCallback onTunePressed;
  final MediaQueryData mediaQueryData;
  final ThemeData themeData;
  final Widget? drawer;

  const _DynamicAppBar({
    required this.isBarVisible,
    required this.onTunePressed,
    required this.mediaQueryData,
    required this.themeData,
    required this.drawer,
  });

  // DYNAMIC HIGH LOGIC: This is the key to making Scaffold respond to state changes
  @override
  Size get preferredSize {
    final bool isMobile = mediaQueryData.size.width <= kScreenWidthMd;
    final double addedHeight = (isMobile && isBarVisible) ? kTopNavHeight : 0.0;
    // Total height = TopNav height + Visible Additional Bar height
    return Size.fromHeight(kTopNavHeight + addedHeight);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = mediaQueryData.size.width <= kScreenWidthMd;
    final double topPadding = mediaQueryData.padding.top;
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Column(
          children: [
            Builder(
              builder: (BuildContext context) {
                return TopNavBar(
                  drawer: drawer,
                  onTunePressed: onTunePressed,
                  isSecondaryBarVisible: isBarVisible,
                );
              },
            ),

            // SECONDARY TOP NAV BAR (Conditionally rendered)
            if (isMobile && isBarVisible) SecondaryTopNavBar(),
          ],
        ),
      ),
    );
  }
}

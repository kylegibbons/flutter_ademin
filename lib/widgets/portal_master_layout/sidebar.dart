import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/configs/sidebar_footer_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutkit_ademin/widgets/base_ui/custom_expansion_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/providers/sidebar_provider.dart';
import 'package:flutkit_ademin/theme/theme_extensions/app_sidebar_theme.dart';

const String _kSidebarRootGroupKey = 'root';

typedef _SidebarExpansionChanged =
    void Function(String groupKey, String itemKey, bool isExpanded);

String _sidebarMenuItemKey(String groupKey, int index) => '$groupKey/$index';

// Recursive Model
class SidebarMenuConfig {
  final String uri;
  final String Function(BuildContext context) title;
  final double fontSize;
  final IconData icon;
  final double iconSize;
  final List<SidebarMenuConfig> children;

  const SidebarMenuConfig({
    required this.uri,
    required this.title,
    this.fontSize = kBodyMedium,
    this.icon = Icons.fiber_manual_record_outlined,
    this.iconSize = 16,
    this.children = const [],
  });
}

class Sidebar extends ConsumerStatefulWidget {
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final List<SidebarMenuConfig> sidebarConfigs;

  const Sidebar({
    super.key,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    required this.sidebarConfigs,
  });

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _selectedItemKey =
      GlobalKey(); // auto scroll to active menu key
  bool _hasScrolledToSelected = false;
  String? _lastSelectedLocation;
  String? _lastSyncedExpansionLocation;
  final Map<String, String> _expandedItemKeyByGroup = <String, String>{};
  // State to track whether the full content is allowed to be displayed
  bool _showFullContent = true;

  // Controller for Width Animation
  late AnimationController _widthController;

  // Variable to track the expansion status from the previous build
  bool _wasExpandedLastBuild = true;

  @override
  void initState() {
    super.initState();

    _widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset scroll flag if URI change
    if (widget.selectedMenuUri != oldWidget.selectedMenuUri) {
      _hasScrolledToSelected = false;
    }
    if (widget.sidebarConfigs != oldWidget.sidebarConfigs) {
      _lastSyncedExpansionLocation = null;
    }
  }

  // Auto Scroll function
  void _scrollToSelected() {
    if (_hasScrolledToSelected) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedItemKey.currentContext != null) {
        Scrollable.ensureVisible(
          _selectedItemKey.currentContext!,
          alignment: 0.5, // Center to viewport
          duration: Duration.zero,
          curve: Curves.easeInOut,
        );
        _hasScrolledToSelected = true;
      }
    });
  }

  void _syncExpandedItemsForLocation(String currentLocation) {
    if (_lastSyncedExpansionLocation == currentLocation) return;

    final expandedItemKeyByGroup = <String, String>{};
    _collectExpandedItemsForLocation(
      widget.sidebarConfigs,
      _kSidebarRootGroupKey,
      currentLocation,
      expandedItemKeyByGroup,
    );

    _expandedItemKeyByGroup
      ..clear()
      ..addAll(expandedItemKeyByGroup);
    _lastSyncedExpansionLocation = currentLocation;
  }

  bool _collectExpandedItemsForLocation(
    List<SidebarMenuConfig> configs,
    String groupKey,
    String currentLocation,
    Map<String, String> expandedItemKeyByGroup,
  ) {
    if (currentLocation.isEmpty) return false;

    for (final entry in configs.asMap().entries) {
      final config = entry.value;
      final itemKey = _sidebarMenuItemKey(groupKey, entry.key);

      if (config.uri == currentLocation) {
        return true;
      }

      final hasSelectedChild = _hasSelectedDescendant(
        config,
        currentLocation,
      );
      if (hasSelectedChild) {
        expandedItemKeyByGroup[groupKey] = itemKey;
        _collectExpandedItemsForLocation(
          config.children,
          itemKey,
          currentLocation,
          expandedItemKeyByGroup,
        );
        return true;
      }
    }

    return false;
  }

  bool _hasSelectedDescendant(SidebarMenuConfig config, String currentLocation) {
    for (final child in config.children) {
      if (child.uri == currentLocation) return true;
      if (_hasSelectedDescendant(child, currentLocation)) return true;
    }
    return false;
  }

  void _handleExpansionChanged(
    String groupKey,
    String itemKey,
    bool isExpanded,
  ) {
    setState(() {
      if (isExpanded) {
        _expandedItemKeyByGroup[groupKey] = itemKey;
      } else if (_expandedItemKeyByGroup[groupKey] == itemKey) {
        _expandedItemKeyByGroup.remove(groupKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final sidebarTheme = themeData.extension<AppSidebarTheme>()!;
    final useLightSidebar = ref.watch(
      appPreferencesProvider.select((state) => state.useLightSidebar),
    );
    final bool isDarkMode = themeData.brightness == Brightness.dark;

    // current location
    var currentLocation = widget.selectedMenuUri ?? '';
    if (currentLocation.isEmpty && widget.autoSelectMenu) {
      currentLocation = GoRouter.of(
        context,
      ).routerDelegate.currentConfiguration.uri.toString();
    }

    if (_lastSelectedLocation != currentLocation) {
      _hasScrolledToSelected = false;
      _lastSelectedLocation = currentLocation;
    }
    _syncExpandedItemsForLocation(currentLocation);

    // Trigger auto scroll every time build is finished if item is found
    _scrollToSelected();

    final sidebarState = ref.watch(sidebarProvider);
    final isSidebarHovered = ref.watch(sidebarHoverProvider);
    final bool shouldExpand =
        !sidebarState.isSidebarMinimized || isSidebarHovered;
    final double sidebarWidth = shouldExpand ? kSidebarWidth : kSidebarWidthMin;

    // ********** SCROLL LOGIC RESET & NEW TRIGGER **********

    // 1. Check Transitions
    final bool isTransitioningToExpanded =
        shouldExpand && !_wasExpandedLastBuild;
    final bool isTransitioningToMinimized =
        !shouldExpand && _wasExpandedLastBuild;

    // 2. Scroll Reset Logic: Reset when switching to minimalist mode
    if (isTransitioningToMinimized) {
      _hasScrolledToSelected = false;
    }

    // 3. Scroll Trigger Logic: Scroll when switching to full mode
    // This ensures autoscroll is triggered when HOVER ON or MAXIMIZE BUTTON is pressed.
    if (isTransitioningToExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected();
      });
    }

    // 4. Update status for next build
    _wasExpandedLastBuild = shouldExpand;

    // KEY logic: Delay content swapping until width is appropriate
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (shouldExpand && !_showFullContent) {
        Future.delayed(const Duration(milliseconds: 5), () {
          if (mounted) {
            setState(() => _showFullContent = true);
          }
        });
      } else if (!shouldExpand && _showFullContent) {
        // If it must be minimized, immediately hide the full content
        setState(() => _showFullContent = false);
      }
    });

    final Widget menuContent = _showFullContent
        ? Scrollbar(
            controller: _scrollController,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                sidebarTheme.sidebarLeftPadding,
                0,
                sidebarTheme.sidebarRightPadding,
                sidebarTheme.sidebarBottomPadding,
              ),
              children: widget.sidebarConfigs.asMap().entries.map((entry) {
                final menuItemKey = _sidebarMenuItemKey(
                  _kSidebarRootGroupKey,
                  entry.key,
                );
                return _SidebarItem(
                  config: entry.value,
                  currentLocation: currentLocation,
                  sidebarTheme: sidebarTheme,
                  themeData: themeData,
                  selectedItemKey: _selectedItemKey,
                  useLightSidebar: useLightSidebar,
                  groupKey: _kSidebarRootGroupKey,
                  menuItemKey: menuItemKey,
                  expandedItemKeyByGroup: _expandedItemKeyByGroup,
                  onExpansionChanged: _handleExpansionChanged,
                  level: 0,
                );
              }).toList(),
            ),
          )
        : MinimizedSidebar(
            menuConfigs: widget.sidebarConfigs,
            currentLocation: currentLocation,
            sidebarTheme: sidebarTheme,
            useLightSidebar: useLightSidebar,
          );

    final double topPadding = mediaQueryData.padding.top;
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
      child: Drawer(
        elevation: 0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: sidebarWidth,
          child: Column(
            children: [
              // Sidebar Header for drawer
              Visibility(
                visible: (mediaQueryData.size.width <= kScreenWidthLg),
                child: Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: Container(
                    alignment: Alignment.center,
                    height: kToolbarHeight,
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Image.asset(
                      isDarkMode
                          ? AppSettings.logoPath
                          : (useLightSidebar
                                ? AppSettings.logoDarkPath
                                : AppSettings.logoPath),
                    ),
                  ),
                ),
              ),

              // List Menu
              Expanded(
                child: Theme(
                  data: themeData.copyWith(
                    scrollbarTheme: themeData.scrollbarTheme.copyWith(
                      thumbColor: WidgetStateProperty.all(
                        sidebarTheme.foregroundColor.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: menuContent,
                ),
              ),

              // Sidebar footer
              ...SidebarFooter.sidebarFooter(context).map((e) => e),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SIDEBAR ITEM WIDGET---

class _SidebarItem extends StatefulWidget {
  final SidebarMenuConfig config;
  final String currentLocation;
  final AppSidebarTheme sidebarTheme;
  final ThemeData themeData;
  final GlobalKey selectedItemKey;
  final bool useLightSidebar;
  final int level;
  final String groupKey;
  final String menuItemKey;
  final Map<String, String> expandedItemKeyByGroup;
  final _SidebarExpansionChanged onExpansionChanged;

  const _SidebarItem({
    required this.config,
    required this.currentLocation,
    required this.sidebarTheme,
    required this.themeData,
    required this.selectedItemKey,
    required this.useLightSidebar,
    required this.groupKey,
    required this.menuItemKey,
    required this.expandedItemKeyByGroup,
    required this.onExpansionChanged,
    this.level = 0,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    // Check if this item is active (exact match)
    final bool isSelected = widget.currentLocation == widget.config.uri;

    // Check if this item is a parent of the active item (for auto-expand)
    // startsWith can be dangerous if the URIs are similar, so it's best to use a logical exact match on children.
    // But for simplicity, we'll use a recursive check here:
    final bool hasSelectedChild = _checkIfHasSelectedChild(
      widget.config,
      widget.currentLocation,
    );

    // final padding = EdgeInsets.fromLTRB(leftPadding, 0, 0, 0);

    // final padding = EdgeInsets.fromLTRB(0, 0, 0, 0);

    // If NO children -> Render Leaf
    if (widget.config.children.isEmpty) {
      return _buildLeafNode(context, isSelected);
    }

    // If it HAS children -> Render ExpansionTile
    final parentTextColor = (hasSelectedChild || isSelected || _isHovering
        ? widget.sidebarTheme.menuSelectedFontColor
        : widget.sidebarTheme.foregroundColor);

    final double startPadding =
        widget.sidebarTheme.menuLeftPadding +
        (widget.level * (kDefaultPadding / 2));
    final bool isExpanded =
        widget.expandedItemKeyByGroup[widget.groupKey] == widget.menuItemKey;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: CustomExpansionTile(
        // key: PageStorageKey<String>(widget.config.uri),
        key: PageStorageKey<String>(widget.menuItemKey),
        expanded: isExpanded,
        initiallyExpanded: hasSelectedChild,
        onExpansionChanged: (expanded) {
          widget.onExpansionChanged(
            widget.groupKey,
            widget.menuItemKey,
            expanded,
          );
        },
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            widget.sidebarTheme.menuBorderRadius,
          ),
        ),
        headerBuilder: (context, isExpanded, animation) {
          return Container(
            padding: EdgeInsetsDirectional.only(
              start: startPadding,
              end: kDefaultPadding / 2,
              top: 10,
              bottom: 10,
            ),
            margin: EdgeInsets.only(top: 4, bottom: 4),
            child: Row(
              children: [
                Icon(
                  widget.config.icon,
                  size: widget.config.iconSize,
                  color: parentTextColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  child: Text(
                    widget.config.title(context),
                    style: TextStyle(
                      fontSize: widget.config.fontSize,
                      fontWeight: FontWeight.w500,
                      color: parentTextColor,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeIn),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: parentTextColor,
                  ),
                ),
              ],
            ),
          );
        },

        // Render children
        children: widget.config.children.asMap().entries.map((entry) {
          final childMenuItemKey = _sidebarMenuItemKey(
            widget.menuItemKey,
            entry.key,
          );
          return _SidebarItem(
            config: entry.value,
            currentLocation: widget.currentLocation,
            sidebarTheme: widget.sidebarTheme,
            themeData: widget.themeData,
            selectedItemKey: widget.selectedItemKey,
            useLightSidebar: widget.useLightSidebar,
            groupKey: widget.menuItemKey,
            menuItemKey: childMenuItemKey,
            expandedItemKeyByGroup: widget.expandedItemKeyByGroup,
            onExpansionChanged: widget.onExpansionChanged,
            level: widget.level + 1, // Add level
          );
        }).toList(),
      ),
    );
  }

  // Helper to check active child recursively
  bool _checkIfHasSelectedChild(SidebarMenuConfig item, String uri) {
    if (item.children.isEmpty) return false;
    for (var child in item.children) {
      if (child.uri == uri) return true;
      if (_checkIfHasSelectedChild(child, uri)) return true;
    }
    return false;
  }

  Widget _buildLeafNode(BuildContext context, bool isSelected) {
    final textColor = isSelected
        ? widget.useLightSidebar
              ? Colors.white
              : widget.sidebarTheme.menuSelectedFontColor
        : widget.sidebarTheme.foregroundColor;

    // Calculate Padding based on level (indentation)
    final double startPadding =
        widget.sidebarTheme.menuLeftPadding +
        (widget.level * (kDefaultPadding / 2));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).go(widget.config.uri);
        },
        hoverColor: Colors.transparent,
        child: Container(
          key: isSelected ? widget.selectedItemKey : null,
          decoration: BoxDecoration(
            color: isSelected
                ? widget.sidebarTheme.menuSelectedBackgroundColor
                : _isHovering
                ? widget.sidebarTheme.menuSelectedBackgroundColor.withValues(
                    alpha: 0.1,
                  )
                : null,
            borderRadius: BorderRadius.circular(
              widget.sidebarTheme.menuBorderRadius,
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: startPadding,
            end: kDefaultPadding / 2,
            top: 10,
            bottom: 10,
          ),
          margin: EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            children: [
              Icon(
                widget.config.icon,
                size: widget.config.iconSize,
                color: textColor,
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Expanded(
                child: Text(
                  widget.config.title(context),
                  style: TextStyle(
                    fontSize: widget.config.fontSize,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Minimized sidebar menu

class MinimizedSidebar extends StatelessWidget {
  final List<SidebarMenuConfig> menuConfigs;
  final String currentLocation; // The current active URI
  final AppSidebarTheme sidebarTheme;
  final bool useLightSidebar;

  const MinimizedSidebar({
    super.key,
    required this.menuConfigs,
    required this.currentLocation,
    required this.sidebarTheme,
    required this.useLightSidebar,
  });

  // This function will return true if the uri matches this config or one of its children.
  bool isConfigActive(SidebarMenuConfig menuConfigs, String currentLocation) {
    // 1. Check if the current URI matches this menu's URI
    if (menuConfigs.uri == currentLocation) {
      return true;
    }

    // 2. Check recursively in all children
    for (final child in menuConfigs.children) {
      if (isConfigActive(child, currentLocation)) {
        return true;
      }
    }
    // If not found at this level or below
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Only iterate through Level 1 menus (top-level parents)
    return Column(
      children: menuConfigs.map((menu) {
        // Determine whether this Level 1 menu is active (or has active children)
        // Note: For simplicity, we only check the Level 1 URI.
        // final isSelected = currentLocation == menu.uri;
        final isSelected = isConfigActive(menu, currentLocation);

        // icon color for selected menu
        final iconColor = isSelected
            ? (useLightSidebar
                  ? Colors.white
                  : sidebarTheme.menuSelectedFontColor)
            : sidebarTheme.foregroundColor;

        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 4,
            horizontal: kDefaultPadding / 4,
          ),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: isSelected
                  ? sidebarTheme.menuSelectedBackgroundColor
                  : null,
              borderRadius: BorderRadius.circular(
                sidebarTheme.menuBorderRadius,
              ),
            ),

            // child: Icon(menu.icon, size: menu.iconSize, color: iconColor),
            child: Icon(menu.icon, size: 24, color: iconColor),
          ),
        );
      }).toList(),
    );
  }
}

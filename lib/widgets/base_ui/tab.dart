import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';

// horizontal tab bar
class HorizontalTabBar extends StatefulWidget {
  final List<TabBarItem> tabs;
  final int initialIndex;
  final Color? headerColor;
  final bool isScrollable;
  final Color? labelColor;
  final Color? indicatorColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final Widget? sideWidget;
  final double? pillBorderRadius;
  final BoxBorder? headerBorder;
  final Decoration? indicatorTabbar;
  final bool isPill;
  final double? indicatorWeight;
  final bool isTopIndicator;
  final bool isTabAtStart;
  final double? tabBarHeight;

  const HorizontalTabBar({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.headerColor,
    this.isScrollable = true,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: kBodyMedium,
    ),
    this.sideWidget,
    this.pillBorderRadius,
    this.headerBorder,
    this.indicatorTabbar,
    this.isPill = false,
    this.indicatorColor,
    this.indicatorWeight,
    this.isTopIndicator = false,
    this.isTabAtStart = true,
    this.tabBarHeight,
  });

  @override
  State<HorizontalTabBar> createState() => _HorizontalTabBarState();
}

class _HorizontalTabBarState extends State<HorizontalTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      setState(() {}); // Update the UI when the tab changes
    });

    _previousIndex = widget.initialIndex;
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Saat tab akan berubah, simpan indeks saat ini sebagai indeks "sebelumnya"
        _previousIndex = _tabController.previousIndex;
      }
      setState(() {}); // Update the UI when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TabBar Header
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // side widget
              if (widget.sideWidget != null && widget.isTabAtStart == false)
                Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: widget.sideWidget!,
                ),

              // tabbar
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: widget.isTopIndicator
                          ? BorderSide(
                              color: themeData.colorScheme.outline,
                              width: 0.2,
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: Align(
                    alignment: widget.isTabAtStart
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: widget.isScrollable,
                      labelColor:
                          widget.labelColor ?? themeData.colorScheme.onSurface,
                      unselectedLabelColor:
                          widget.unselectedLabelColor ?? kTextColor,
                      labelStyle: widget.labelStyle,
                      labelPadding: EdgeInsets.zero,
                      indicator: widget.isTopIndicator
                          ? BoxDecoration(
                              color: widget.indicatorColor!.withValues(
                                alpha: 0.1,
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: widget.indicatorColor!,
                                  width: widget.indicatorWeight ?? 2,
                                ),
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(defaultRadius),
                                topRight: Radius.circular(defaultRadius),
                              ),
                            )
                          : widget.isPill
                          ? BoxDecoration(
                              color: widget.indicatorColor,
                              borderRadius: BorderRadius.circular(
                                widget.pillBorderRadius ?? defaultRadius,
                              ),
                            )
                          : null,
                      indicatorColor:
                          widget.indicatorColor ??
                          themeData.colorScheme.primary,
                      indicatorWeight: widget.indicatorWeight ?? 1.6,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: widget.tabs
                          .map(
                            (tab) => Container(
                              height: widget.tabBarHeight ?? mediumHeight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                              ),
                              child: Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (tab.icon != null)
                                      Icon(tab.icon, size: 16),
                                    if (tab.icon != null &&
                                        MediaQuery.of(context).size.width >
                                            kScreenWidthMd)
                                      const SizedBox(
                                        width: kDefaultPadding / 2,
                                      ),
                                    if (tab.icon == null ||
                                        MediaQuery.of(context).size.width >
                                            kScreenWidthMd)
                                      Text(tab.label),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),

              // side widget
              if (widget.sideWidget != null && widget.isTabAtStart == true)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: kDefaultPadding,
                  ),
                  child: widget.sideWidget!,
                ),
            ],
          ),
        ),

        // Dynamic Height Content with Sliding Animation
        Container(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                children: <Widget>[...previousChildren, ?currentChild],
              );
            },
            child: Container(
              key: ValueKey<int>(_tabController.index),
              child: widget.tabs[_tabController.index].content,
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final bool isSlidingRight = _tabController.index > _previousIndex;

              final inAnimation = Tween<Offset>(
                begin: Offset(isSlidingRight ? 1.0 : -1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);

              final outAnimation = Tween<Offset>(
                begin: Offset(isSlidingRight ? -1.0 : 1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);

              if (child.key == ValueKey<int>(_tabController.index)) {
                // new widget in
                return ClipRect(
                  child: SlideTransition(position: inAnimation, child: child),
                );
              } else {
                // old widget out
                return ClipRect(
                  child: SlideTransition(position: outAnimation, child: child),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

/// Model for each Horizontal Tab Item
class TabBarItem {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Widget content;

  TabBarItem({
    required this.label,
    this.icon,
    this.iconColor,
    required this.content,
  });
}

// Vertical tab bar

class VerticalTabItem {
  final String title;
  final String? subtitle;
  final IconData icon;

  const VerticalTabItem({
    required this.title,
    this.subtitle,
    required this.icon,
  });
}

class VerticalTabBar extends StatefulWidget {
  final List<VerticalTabItem> tabs;
  final List<Widget> children;
  final double tabWidth;
  final int initialIndex;
  final Color? color;

  const VerticalTabBar({
    super.key,
    required this.tabs,
    required this.children,
    this.tabWidth = 260,
    this.initialIndex = 0,
    this.color,
  }) : assert(
         tabs.length == children.length,
         "tabs and children length must match",
       );

  @override
  State<VerticalTabBar> createState() => _VerticalTabBarState();
}

class _VerticalTabBarState extends State<VerticalTabBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onSelect(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(color: widget.color!.withValues(alpha: 0.1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebar(context, widget.color ?? kPrimaryColor),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(_currentIndex),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                  ),
                  child: widget.children[_currentIndex],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, Color color) {
    // final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return SizedBox(
      width: isMobile ? null : widget.tabWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(widget.tabs.length, (index) {
          final tab = widget.tabs[index];
          final isSelected = index == _currentIndex;

          return _VerticalTabTile(
            item: tab,
            color: color,
            isSelected: isSelected,
            onTap: () => _onSelect(index),
          );
        }),
      ),
    );
  }
}

class _VerticalTabTile extends StatelessWidget {
  final VerticalTabItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _VerticalTabTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(4 + kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: isSelected
              ? themeData.colorScheme.surface
              : Colors.transparent,
        ),
        child: isMobile
            ? Icon(
                item.icon,
                color: isSelected ? color : themeData.colorScheme.onSurface,
              )
            : Row(
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? color : themeData.colorScheme.onSurface,
                  ),
                  const SizedBox(width: kDefaultPadding),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            color: isSelected
                                ? color
                                : themeData.colorScheme.onSurface,
                            fontSize: kBodyMedium,

                            // fontWeight: isSelected
                            //     ? FontWeight.w600
                            //     : FontWeight.w500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.subtitle != null) Text(item.subtitle!),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

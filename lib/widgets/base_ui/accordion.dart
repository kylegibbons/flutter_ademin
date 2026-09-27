import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

/// Accordion Item Data Model
class AccordionItemData {
  final String title;
  final Widget content;
  final IconData? prefixIcon;
  final IconData? suffixIcon; // Optional, falls back to Accordion's icons
  final Color? headerColor;
  final Color? headerTextColor;

  AccordionItemData({
    required this.title,
    required this.content,
    this.prefixIcon,
    this.suffixIcon,
    this.headerColor,
    this.headerTextColor,
  });
}

/// Accordion Widget
class Accordion extends StatefulWidget {
  final List<AccordionItemData> items;
  final bool singleCollapse; // true for single, false for multiple
  final IconData? prefixIcon; // Global prefix icon for all items
  final IconData? suffixIcon; // Global suffix icon for all items
  final Color? headerColor;
  final Color? headerTextColor;

  const Accordion({
    super.key,
    required this.items,
    this.singleCollapse = false, // Default to multiple collapse
    this.prefixIcon,
    this.suffixIcon,
    this.headerColor,
    this.headerTextColor,
  });

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  List<int> expandedIndexes = [];

  void toggleExpansion(int index) {
    setState(() {
      if (widget.singleCollapse) {
        // Single Collapse Mode: Only one item can be expanded
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes = [index];
        }
      } else {
        // Multiple Collapse Mode: Toggle the item
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.outline,
          width: outlineWidth,
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Column(
          children: widget.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Column(
              children: [
                AccordionItem(
                  title: item.title,
                  content: item.content,
                  headerColor:
                      item.headerColor ??
                      widget.headerColor ??
                      kTableHeaderColor,
                  headerTextColor:
                      item.headerTextColor ??
                      widget.headerTextColor ??
                      themeData.colorScheme.onSurface,
                  prefixIcon: item.prefixIcon ?? widget.prefixIcon,
                  suffixIcon:
                      item.suffixIcon ?? widget.suffixIcon ?? Icons.expand_more,
                  isExpanded: expandedIndexes.contains(index),
                  onHeaderTapped: () => toggleExpansion(index),
                ),
                if (index < widget.items.length - 1)
                  Divider(
                    height: 0,
                    thickness: outlineWidth,
                    color: themeData.colorScheme.outline,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Accordion Item Widget
class AccordionItem extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isExpanded;
  final VoidCallback onHeaderTapped;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? headerColor;
  final Color? headerTextColor;

  const AccordionItem({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onHeaderTapped,
    this.prefixIcon,
    this.suffixIcon,
    this.headerColor,
    this.headerTextColor,
  });

  @override
  State<AccordionItem> createState() => _AccordionItemState();
}

class _AccordionItemState extends State<AccordionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AccordionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: widget.onHeaderTapped,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: widget.isExpanded
                  ? widget.headerColor
                  : themeData.colorScheme.surface,
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null)
                  Icon(
                    widget.prefixIcon,
                    color: widget.isExpanded
                        ? widget.headerTextColor
                        : themeData.colorScheme.onSurface,
                  )
                else
                  const SizedBox.shrink(),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.isExpanded
                          ? widget.headerTextColor
                          : themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.suffixIcon != null)
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(
                      widget.suffixIcon,
                      color: widget.isExpanded
                          ? widget.headerTextColor
                          : themeData.colorScheme.onSurface,
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
          axis: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(color: themeData.colorScheme.surface),
            child: widget.content,
          ),
        ),
      ],
    );
  }
}

/// BorderArcodion Item Data Model
class BorderArcodionItemData {
  final String title;
  final Widget content;
  final IconData? prefixIcon;
  final IconData? suffixIcon; // Optional, falls back to BorderArcodion's icons

  BorderArcodionItemData({
    required this.title,
    required this.content,
    this.prefixIcon,
    this.suffixIcon,
  });
}

/// BorderArcodion Widget
class BorderArcodion extends StatefulWidget {
  final List<BorderArcodionItemData> items;
  final bool singleCollapse; // true for single, false for multiple
  final IconData? prefixIcon; // Global prefix icon for all items
  final IconData? suffixIcon; // Global suffix icon for all items
  final Color? borderColor;

  const BorderArcodion({
    super.key,
    required this.items,
    this.singleCollapse = false, // Default to multiple collapse
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
  });

  @override
  State<BorderArcodion> createState() => _BorderArcodionState();
}

class _BorderArcodionState extends State<BorderArcodion> {
  List<int> expandedIndexes = [];

  void toggleExpansion(int index) {
    setState(() {
      if (widget.singleCollapse) {
        // Single Collapse Mode: Only one item can be expanded
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes = [index];
        }
      } else {
        // Multiple Collapse Mode: Toggle the item
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Column(
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Column(
            children: [
              BorderArcodionItem(
                title: item.title,
                content: item.content,
                prefixIcon: item.prefixIcon ?? widget.prefixIcon,
                suffixIcon: item.suffixIcon ?? widget.suffixIcon,
                isExpanded: expandedIndexes.contains(index),
                onHeaderTapped: () => toggleExpansion(index),
                borderColor: widget.borderColor!,
              ),
              if (index < widget.items.length - 1)
                const SizedBox(height: 0.5 * kDefaultPadding),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// BorderArcodion Item Widget
class BorderArcodionItem extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isExpanded;
  final VoidCallback onHeaderTapped;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color borderColor;

  const BorderArcodionItem({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onHeaderTapped,
    this.prefixIcon,
    this.suffixIcon,
    required this.borderColor,
  });

  @override
  State<BorderArcodionItem> createState() => _BorderArcodionItemState();
}

class _BorderArcodionItemState extends State<BorderArcodionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(BorderArcodionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: widget.borderColor, width: outlineWidth),
          bottom: BorderSide(color: widget.borderColor, width: outlineWidth),
          right: BorderSide(color: widget.borderColor, width: outlineWidth),
          left: BorderSide(color: widget.borderColor, width: 2),
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Column(
          children: [
            InkWell(
              onTap: widget.onHeaderTapped,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: widget.isExpanded
                      ? widget.borderColor.withValues(alpha: 0.1)
                      : themeData.colorScheme.surface,
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null)
                      Icon(
                        widget.prefixIcon,
                        color: widget.isExpanded
                            ? widget.borderColor
                            : themeData.colorScheme.onSurface,
                      )
                    else
                      const SizedBox.shrink(),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.isExpanded
                              ? widget.borderColor
                              : themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (widget.suffixIcon != null)
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Icon(
                          widget.suffixIcon,
                          // color: widget.isExpanded
                          //     ? kSuccessColor
                          //     : themeData.colorScheme.onSurface,
                          color: widget.borderColor,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
              ),
              axis: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: widget.content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// FilledAccordion Item Data Model
class FilledAccordionItemData {
  final String title;
  final Widget content;
  final IconData? prefixIcon;
  final IconData? suffixIcon; // Optional, falls back to FilledAccordion's icons

  FilledAccordionItemData({
    required this.title,
    required this.content,
    this.prefixIcon,
    this.suffixIcon,
  });
}

/// NoBorderAccordion Item Data Model
class NoBorderAccordionItemData {
  final String title;
  final Widget content;
  final IconData? prefixIcon;
  final IconData?
  suffixIcon; // Optional, falls back to NoBorderAccordion's icons

  NoBorderAccordionItemData({
    required this.title,
    required this.content,
    this.prefixIcon,
    this.suffixIcon,
  });
}

/// NoBorderAccordion Widget
class NoBorderAccordion extends StatefulWidget {
  final List<NoBorderAccordionItemData> items;
  final bool singleCollapse; // true for single, false for multiple
  final IconData? prefixIcon; // Global prefix icon for all items
  final IconData? suffixIcon; // Global suffix icon for all items
  final Color fillColor;

  const NoBorderAccordion({
    super.key,
    required this.items,
    this.singleCollapse = false, // Default to multiple collapse
    this.prefixIcon,
    this.suffixIcon,
    required this.fillColor,
  });

  @override
  State<NoBorderAccordion> createState() => _NoBorderAccordionState();
}

class _NoBorderAccordionState extends State<NoBorderAccordion> {
  List<int> expandedIndexes = [];

  void toggleExpansion(int index) {
    setState(() {
      if (widget.singleCollapse) {
        // Single Collapse Mode: Only one item can be expanded
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes = [index];
        }
      } else {
        // Multiple Collapse Mode: Toggle the item
        if (expandedIndexes.contains(index)) {
          expandedIndexes.remove(index);
        } else {
          expandedIndexes.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return Column(
          children: [
            NoBorderAccordionItem(
              title: item.title,
              content: item.content,
              prefixIcon: item.prefixIcon ?? widget.prefixIcon,
              suffixIcon: item.suffixIcon ?? widget.suffixIcon,
              isExpanded: expandedIndexes.contains(index),
              onHeaderTapped: () => toggleExpansion(index),
              fillColor: widget.fillColor,
            ),
            if (index < widget.items.length - 1)
              Divider(
                height: 0,
                thickness: outlineWidth,
                color: Theme.of(context).colorScheme.outline,
              ),
          ],
        );
      }).toList(),
    );
  }
}

/// NoBorderAccordion Item Widget
class NoBorderAccordionItem extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isExpanded;
  final VoidCallback onHeaderTapped;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color fillColor;

  const NoBorderAccordionItem({
    super.key,
    required this.title,
    required this.content,
    required this.isExpanded,
    required this.onHeaderTapped,
    this.prefixIcon,
    this.suffixIcon,
    required this.fillColor,
  });

  @override
  State<NoBorderAccordionItem> createState() => _NoBorderAccordionItemState();
}

class _NoBorderAccordionItemState extends State<NoBorderAccordionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(NoBorderAccordionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: widget.onHeaderTapped,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              color: widget.isExpanded
                  ? widget.fillColor
                  : themeData.colorScheme.surface,
            ),
            child: Row(
              children: [
                if (widget.prefixIcon != null)
                  Icon(
                    widget.prefixIcon,
                    color: widget.isExpanded
                        ? Colors.white
                        : themeData.colorScheme.onSurface,
                  )
                else
                  const SizedBox.shrink(),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.isExpanded
                          ? Colors.white
                          : themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.suffixIcon != null)
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(
                      widget.suffixIcon,
                      color: widget.isExpanded
                          ? Colors.white
                          : themeData.colorScheme.onSurface,
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
          axis: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: widget.content,
          ),
        ),
      ],
    );
  }
}

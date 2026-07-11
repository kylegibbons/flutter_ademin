import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

/// A responsive, flexible wrap-based layout widget that adapts to screen width.
class AdaptiveWrap extends StatelessWidget {
  /// Widgets to display in the layout
  final List<Widget> children;

  /// Spacing between items horizontally
  final double spacing;

  /// Spacing between items vertically
  final double runSpacing;

  /// Maximum column count (if not using breakpoints)
  final int? maxColumns;

  /// Minimum column count
  final int? minColumns;

  /// Custom column ratios (e.g., [0.5, 0.3, 0.2])
  final List<double>? columnRatios;

  /// Breakpoints mapping (e.g. `{600: 1, 1000: 2, 1400: 3}`)
  final Map<double, int>? breakpoints;

  /// Main axis alignment of items
  final WrapAlignment alignment;

  /// Cross axis alignment of items
  final WrapCrossAlignment crossAlignment;

  /// Callback triggered when column count changes
  final void Function(int columnCount)? onLayoutChanged;

  // Use screen width as breakpoint
  final bool useScreenWidth;

  const AdaptiveWrap({
    super.key,
    required this.children,
    this.spacing = kDefaultPadding,
    this.runSpacing = kDefaultPadding,
    this.maxColumns,
    this.minColumns,
    this.columnRatios,
    this.breakpoints,
    this.alignment = WrapAlignment.start,
    this.crossAlignment = WrapCrossAlignment.start,
    this.onLayoutChanged,
    this.useScreenWidth = false,
  });

  int _getColumnCount(double width) {
    if (breakpoints != null && breakpoints!.isNotEmpty) {
      final sorted = breakpoints!.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      for (final bp in sorted) {
        if (width <= bp.key) return bp.value;
      }
      return sorted.last.value;
    }
    return maxColumns ?? columnRatios?.length ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 1. Tentukan lebar referensi HANYA untuk menghitung jumlah kolom (Breakpoint Logic)
        final breakpointWidth = useScreenWidth
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth;

        int columnCount = _getColumnCount(breakpointWidth);

        if (minColumns != null && columnCount < minColumns!) {
          columnCount = minColumns!;
        }

        // Panggil callback jika ada perubahan layout
        onLayoutChanged?.call(columnCount);

        // 2. Tentukan lebar fisik yang tersedia berdasarkan parent constraint (Layout Logic)
        // KOREKSI: Selalu gunakan constraints.maxWidth untuk menggambar widget,
        // terlepas dari breakpoint mana yang dipakai.
        final layoutWidth = constraints.maxWidth;

        final totalSpacing = spacing * (columnCount - 1);
        final availableWidth = layoutWidth - totalSpacing;

        // --- Perhitungan Rasio (Sama seperti sebelumnya) ---
        List<double> effectiveRatios;
        if (columnRatios != null && columnRatios!.isNotEmpty) {
          effectiveRatios = List.generate(
            columnCount,
            (i) => columnRatios![i % columnRatios!.length],
          );
          final sum = effectiveRatios.reduce((a, b) => a + b);
          if (sum > 0) {
            effectiveRatios = effectiveRatios.map((r) => r / sum).toList();
          } else {
            effectiveRatios = List<double>.filled(columnCount, 1 / columnCount);
          }
        } else {
          effectiveRatios = List<double>.filled(columnCount, 1 / columnCount);
        }

        Widget buildChild(int index) {
          final ratio = effectiveRatios[index % effectiveRatios.length];
          // availableWidth sekarang sudah benar (berdasarkan parent constraint)
          final itemWidth = availableWidth * ratio;

          return SizedBox(width: itemWidth, child: children[index]);
        }

        return Wrap(
          alignment: alignment,
          crossAxisAlignment: crossAlignment,
          spacing: spacing,
          runSpacing: runSpacing,
          children: List.generate(children.length, buildChild),
        );
      },
    );
  }
}

//
// ──────────────────────────────────────────────────────────────
//   EXTENSION: Enables List<Widget>.AdaptiveWrap()
// ──────────────────────────────────────────────────────────────
//

extension ResponsiveWrapExtension on List<Widget> {
  /// Turns a list of widgets into a responsive wrap layout.
  ///
  /// Example:
  /// ```dart
  /// [
  ///   Card(...),
  ///   Card(...),
  /// ].AdaptiveWrap(
  ///   breakpoint: 1200,
  ///   ratios: [0.7, 0.3],
  /// );
  /// ```
  Widget adaptiveWrap({
    double breakpoint = 1200,
    List<double>? ratios,
    double spacing = kDefaultPadding,
    double runSpacing = kDefaultPadding,
    bool useIntrinsicHeight = false,
    bool scrollable = false,
    Axis scrollDirection = Axis.vertical,
    Map<double, int>? responsiveBreakpoints,
    WrapAlignment alignment = WrapAlignment.start,
    WrapCrossAlignment crossAlignment = WrapCrossAlignment.start,
    // bool debugColor = false,
    void Function(int columnCount)? onLayoutChanged,
  }) {
    return AdaptiveWrap(
      spacing: spacing,
      runSpacing: runSpacing,
      columnRatios: ratios,
      breakpoints: responsiveBreakpoints ?? {breakpoint: ratios?.length ?? 1},
      // useIntrinsicHeight: useIntrinsicHeight,
      // scrollable: scrollable,
      // scrollDirection: scrollDirection,
      alignment: alignment,
      crossAlignment: crossAlignment,
      // debugColor: debugColor,
      onLayoutChanged: onLayoutChanged,
      children: this,
    );
  }
}

class ResponsiveHelper {
  static int calculateCrossAxisCount(double width, {int maxColumns = 6}) {
    if (maxColumns >= 6 && width >= kScreenWidthXxl) {
      return 6; // Extra large screens: 6 cards per row if allowed
    } else if (maxColumns >= 5 && width >= kScreenWidthXl) {
      return 5; // Large screens: 5 cards per row if allowed
    } else if (maxColumns >= 3 && width >= kScreenWidthLg) {
      return 3; // Medium-large screens: 3 cards per row
    } else if (maxColumns >= 2 && width >= kScreenWidthMd) {
      return 2; // Medium screens: 2 cards per row
    } else {
      return 1; // Small screens: 1 card per row
    }
  }
}

//Responsive helper to calculate card width for 2 cards per row

double calculateCardWidth_2(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getNumberOfCardsPerRow_2(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthXl) {
    return 2;
  } else {
    return 1;
  }
}

//Responsive helper to calculate card width for 3 cards per row

double calculateCardWidth_3(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getNumberOfCardsPerRow_3(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthXxl) {
    return 3;
  } else if (mediaQueryData.size.width >= kScreenWidthXl) {
    return 2;
  } else if (mediaQueryData.size.width >= kScreenWidthLg) {
    return 2;
  } else if (mediaQueryData.size.width >= kScreenWidthMd) {
    return 2;
  } else {
    return 1;
  }
}

//Responsive helper to calculate card width for 4 cards per row

double calculateCardWidth_4(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getNumberOfCardsPerRow_4(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthXxl) {
    return 4;
  } else if (mediaQueryData.size.width >= kScreenWidthXl) {
    return 2;
  } else if (mediaQueryData.size.width >= kScreenWidthLg) {
    return 2;
  } else if (mediaQueryData.size.width >= kScreenWidthMd) {
    return 2;
  } else {
    return 1;
  }
}

//Responsive helper to calculate card width for 5 cards per row

double calculateCardWidth_5(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getNumberOfCardsPerRow_5(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthXxl) {
    return 5;
  } else if (mediaQueryData.size.width >= kScreenWidthXl) {
    return 4;
  } else if (mediaQueryData.size.width >= kScreenWidthLg) {
    return 3;
  } else if (mediaQueryData.size.width >= kScreenWidthMd) {
    return 2;
  } else {
    return 1;
  }
}

//Responsive helper to calculate card width for 5 cards per row

double calculateCardWidth_6(
  BuildContext context,
  BoxConstraints constraints,
  int numberOfCardsPerRow,
) {
  double availableWidth =
      constraints.maxWidth - (numberOfCardsPerRow - 1) * kDefaultPadding;

  return availableWidth / numberOfCardsPerRow;
}

int getNumberOfCardsPerRow_6(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);

  if (mediaQueryData.size.width >= kScreenWidthXxl) {
    return 6;
  } else if (mediaQueryData.size.width >= kScreenWidthXl) {
    return 5;
  } else if (mediaQueryData.size.width >= kScreenWidthLg) {
    return 4;
  } else if (mediaQueryData.size.width >= kScreenWidthMd) {
    return 3;
  } else {
    return 1;
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TableStyle {
  // Style for the table header

  static TextStyle tableHeaderTextStyle(BuildContext context) {
    return TextStyle(
      // fontSize: kBodyMedium,
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );
  }

  // Style for the table cell
  static TextStyle cellTextStyle(BuildContext context) {
    return const TextStyle(
      // fontSize: kBodyMedium,
      // color: Theme.of(context).colorScheme.onSurface,
    );
  }

  // Style for SfDataGridThemeData
  static SfDataGridThemeData dataGridTheme = SfDataGridThemeData(
    headerColor: kTableHeaderColor,
    currentCellStyle: DataGridCurrentCellStyle(
      borderColor: Colors.transparent,
      borderWidth: 0,
    ),
  );
}

// Height of the DataPager widget.
final double dataPagerHeight = 60.0;

//custom clipper for

class CustomLeftClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(1, 1, size.width - 1, size.height - 1);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

// table constant

const double tableRowHeight = 44;
const double tableHeaderRowHeight = 44;

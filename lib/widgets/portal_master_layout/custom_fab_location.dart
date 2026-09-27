import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final double paddingRight;
  final double paddingBottom;

  CustomFabLocation({this.paddingRight = 16.0, this.paddingBottom = 16.0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double scaffoldWidth = scaffoldGeometry.scaffoldSize.width;
    final double scaffoldHeight = scaffoldGeometry.scaffoldSize.height;

    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final double calculatedX = scaffoldWidth - fabWidth - paddingRight;

    final double calculatedY = scaffoldHeight - fabHeight - paddingBottom;

    return Offset(calculatedX, calculatedY);
  }
}

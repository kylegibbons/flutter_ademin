import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';

// Global chart title style
TextStyle chartTitleStyle = TextStyle(
  fontSize: kBodyMedium, // Adjust font size as needed
  fontWeight: FontWeight.w500, // Adjust font weight
);

// global axis label style
TextStyle chartAxisLabelStyle = TextStyle(
  fontSize: kBodyMedium,
  fontWeight: FontWeight.w500,
);

// column top border radius

final BorderRadius chartTopRadius = BorderRadius.only(
  topLeft: Radius.circular(secondaryRadius / 2),
  topRight: Radius.circular(secondaryRadius / 2),
);

// column bottom border radius

final BorderRadius chartBottomRadius = BorderRadius.only(
  bottomLeft: Radius.circular(secondaryRadius / 2),
  bottomRight: Radius.circular(secondaryRadius / 2),
);

// bar border radius

final BorderRadius chartBarRadius = BorderRadius.only(
  topRight: Radius.circular(secondaryRadius / 2),
  bottomRight: Radius.circular(secondaryRadius / 2),
);

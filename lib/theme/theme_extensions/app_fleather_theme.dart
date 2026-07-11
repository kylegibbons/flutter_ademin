import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';

// Theme extension for Fleather Editor

extension FleatherThemeContextExt on BuildContext {
  FleatherThemeData get fleatherTheme {
    final themeData = Theme.of(this);
    return FleatherThemeData(
      paragraph: TextBlockTheme(
        style: TextStyle(color: kTextColor),
        spacing: VerticalSpacing(bottom: 8.0),
      ),
      bold: const TextStyle(fontWeight: FontWeight.w600),
      italic: const TextStyle(fontStyle: FontStyle.italic),
      underline: const TextStyle(decoration: TextDecoration.underline),
      heading1: TextBlockTheme(
        style: TextStyle(
          fontSize: kHeadlineLarge,
          fontWeight: FontWeight.w600,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 12.0),
      ),
      heading2: TextBlockTheme(
        style: TextStyle(
          fontSize: kHeadlineMedium,
          fontWeight: FontWeight.w600,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 10.0),
      ),
      heading3: TextBlockTheme(
        style: TextStyle(
          fontSize: kHeadlineSmall,
          fontWeight: FontWeight.w600,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 8.0),
      ),
      heading4: TextBlockTheme(
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 6.0),
      ),
      heading5: TextBlockTheme(
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 4.0),
      ),
      heading6: TextBlockTheme(
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 2.0),
      ),
      code: TextBlockTheme(
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: kBodySmall,
          color: kTextColor,
        ),
        spacing: VerticalSpacing(bottom: 8.0),
      ),
      strikethrough: TextStyle(decoration: TextDecoration.lineThrough),
      inlineCode: InlineCodeThemeData(
        backgroundColor: Colors.white,
        radius: Radius.circular(defaultRadius),
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: 12,
          color: themeData.colorScheme.onSurface,
        ),
      ),
      link: TextStyle(
        color: kSecondaryColor,
        decoration: TextDecoration.underline,
      ),
      lists: TextBlockTheme(
        style: TextStyle(),
        spacing: VerticalSpacing(bottom: 8.0),
      ),
      quote: TextBlockTheme(
        style: TextStyle(fontStyle: FontStyle.italic),
        spacing: VerticalSpacing(bottom: 8.0),
      ),
      horizontalRule: HorizontalRuleThemeData(
        height: 12,
        thickness: 1.5,
        color: themeData.colorScheme.outline,
      ),
    );
  }
}

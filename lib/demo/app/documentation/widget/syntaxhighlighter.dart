import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_highlighting/themes/github-dark.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:google_fonts/google_fonts.dart';

class InlineCodeBuilder extends MarkdownElementBuilder {
  final bool isDark;

  InlineCodeBuilder(this.isDark);

  @override
  Widget? visitElementAfter(element, TextStyle? preferredStyle) {
    final code = element.textContent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: inlineCode.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: GoogleFonts.robotoMono().fontFamily,
          fontSize: kBodySmall,
          color: inlineCode,
        ),
      ),
    );
  }
}

class HighlightBuilder extends MarkdownElementBuilder {
  final bool isDark;

  HighlightBuilder({required this.isDark});

  String detectLanguage(String code) {
    code = code.trim();

    if (code.startsWith('{') && code.endsWith('}')) {
      return 'json';
    }

    if (code.contains('<html') || code.contains('</')) {
      return 'html';
    }

    if (code.contains('import ') && code.contains('class ')) {
      return 'dart';
    }

    if (code.contains('function ') || code.contains('console.log')) {
      return 'javascript';
    }

    if (code.contains(':') && code.contains('-')) {
      return 'yaml';
    }

    return 'plaintext';
  }

  @override
  Widget? visitElementAfter(element, TextStyle? preferredStyle) {
    final classAttr = element.attributes['class'] ?? '';
    final code = element.textContent;

    String language = classAttr.replaceFirst('language-', '');

    if (language.isEmpty) {
      language = detectLanguage(code);
    }

    final theme = isDark ? githubDarkTheme : githubTheme;

    return Builder(
      builder: (BuildContext context) {
        final themeData = Theme.of(context);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? kSurfaceContainerHighDark : kTableHeaderColor,
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border.all(color: themeData.colorScheme.outline),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultRadius),
            child: HighlightView(
              code,
              language: language.isEmpty ? 'dart' : language,
              theme: theme,
              padding: const EdgeInsetsDirectional.only(
                top: kDefaultPadding,
                start: kDefaultPadding,
                end: kDefaultPadding,
              ),
              textStyle: TextStyle(
                fontFamily: GoogleFonts.robotoMono().fontFamily,
                fontSize: kBodyMedium,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class DocMarkdownStyle {
  static MarkdownStyleSheet sheet(BuildContext context) {
    final themeData = Theme.of(context);

    return MarkdownStyleSheet.fromTheme(themeData).copyWith(
      // =========================
      // HEADINGS
      // =========================
      h1: TextStyle(
        fontSize: kHeadlineLarge,
        fontWeight: FontWeight.bold,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),
      h2: TextStyle(
        fontSize: kHeadlineMedium,
        fontWeight: FontWeight.bold,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),
      h3: TextStyle(
        fontSize: kHeadlineSmall,
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),
      h4: TextStyle(
        fontSize: kTitleLarge,
        fontWeight: FontWeight.w500,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),
      h5: TextStyle(
        fontSize: kTitleMedium,
        fontWeight: FontWeight.w500,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),
      h6: TextStyle(
        fontSize: kTitleSmall,
        fontWeight: FontWeight.w500,
        color: themeData.colorScheme.onSurface,
        height: 1.1,
      ),

      // =========================
      // BODY TEXT
      // =========================
      p: TextStyle(fontSize: kBodyMedium, height: 1.7),
      strong: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
      em: const TextStyle(fontStyle: FontStyle.italic),
      del: const TextStyle(decoration: TextDecoration.lineThrough),

      // =========================
      // LINKS
      // =========================
      a: TextStyle(
        fontSize: kBodyLarge,
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
      ),

      // =========================
      // LISTS
      // =========================
      listBullet: TextStyle(fontSize: kBodyLarge, height: 1.7),
      // listIndent: 1.6 * kDefaultPadding,
      // listBulletPadding: const EdgeInsets.only(right: kDefaultPadding),

      // =========================
      // BLOCKQUOTE
      // =========================
      blockquote: TextStyle(fontSize: kBodyLarge, fontStyle: FontStyle.italic),
      blockquotePadding: const EdgeInsets.all(kDefaultPadding),
      blockquoteDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 4,
          ),
        ),
      ),

      // =========================
      // INLINE CODE
      // =========================
      // code: TextStyle(
      //   fontSize: kBodyMedium,
      //   fontFamily: 'monospace',
      //   color: kErrorColor,
      //   backgroundColor: Colors.transparent,
      // ),

      // =========================
      // CODE BLOCK
      // =========================
      // codeblockPadding: const EdgeInsets.all(kDefaultPadding),
      // codeblockDecoration: BoxDecoration(
      //   color: Colors.grey.shade900,
      //   borderRadius: BorderRadius.circular(defaultRadius),
      // ),

      // =========================
      // TABLE
      // =========================
      tableHead: TextStyle(fontSize: kBodyMedium, fontWeight: FontWeight.w600),
      tableBody: TextStyle(fontSize: kBodyMedium),
      tableBorder: TableBorder.all(
        color: themeData.colorScheme.outline,
        width: outlineWidth,
      ),
      tableCellsPadding: const EdgeInsets.all(kDefaultPadding / 2),

      // =========================
      // HORIZONTAL RULE
      // =========================
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
        ),
      ),

      // =========================
      // SPACING SYSTEM
      // =========================
      h1Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),
      h2Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),
      h3Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),
      h4Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),
      h5Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),
      h6Padding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 4,
      ),

      pPadding: const EdgeInsets.only(
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 6,
      ),
      blockSpacing: kDefaultPadding / 2,
    );
  }
}

//blockquote

class BlockQuote extends StatelessWidget {
  final String quote;
  final String author;
  final String source;
  final bool isLeftAligned;

  const BlockQuote({
    super.key,
    required this.quote,
    required this.author,
    required this.source,
    required this.isLeftAligned,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        left: isLeftAligned ? kDefaultPadding : 0,
        right: !isLeftAligned ? kDefaultPadding : 0,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: isLeftAligned
              ? BorderSide(color: Colors.grey.shade300, width: 4)
              : BorderSide.none,
          right: !isLeftAligned
              ? BorderSide(color: Colors.grey.shade300, width: 4)
              : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isLeftAligned
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: isLeftAligned
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: themeData.colorScheme.onSurface,
                  ),
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                ),
                const SizedBox(height: kDefaultPadding),
                RichText(
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                  text: TextSpan(
                    text: '— $author in ',
                    style: TextStyle(color: kTextColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: source,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//blockquote background color

class BlockQuoteBgColor extends StatelessWidget {
  final String quote;
  final String author;
  final String source;
  final bool isLeftAligned;
  final Color kColor;

  const BlockQuoteBgColor({
    super.key,
    required this.quote,
    required this.author,
    required this.source,
    required this.isLeftAligned,
    required this.kColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kColor.withValues(alpha: 0.1),
        border: Border(
          left: isLeftAligned
              ? BorderSide(color: kColor, width: 4)
              : BorderSide.none,
          right: !isLeftAligned
              ? BorderSide(color: kColor, width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isLeftAligned
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: isLeftAligned
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: themeData.colorScheme.onSurface,
                  ),
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                ),
                const SizedBox(height: kDefaultPadding),
                RichText(
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                  text: TextSpan(
                    text: '— $author in ',
                    style: TextStyle(color: kColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: source,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: kColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//blockquote border color

class BlockQuoteBorderColor extends StatelessWidget {
  final String quote;
  final String author;
  final String source;
  final bool isLeftAligned;
  final Color kColor;

  const BlockQuoteBorderColor({
    super.key,
    required this.quote,
    required this.author,
    required this.source,
    required this.isLeftAligned,
    required this.kColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        border: Border(
          left: isLeftAligned
              ? BorderSide(color: kColor, width: 4)
              : BorderSide(color: kColor, width: 0.5),
          right: !isLeftAligned
              ? BorderSide(color: kColor, width: 4)
              : BorderSide(color: kColor, width: 0.5),
          top: BorderSide(color: kColor, width: 0.5),
          bottom: BorderSide(color: kColor, width: 0.5),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isLeftAligned
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: isLeftAligned
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: themeData.colorScheme.onSurface,
                  ),
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                ),
                const SizedBox(height: kDefaultPadding),
                RichText(
                  textAlign: isLeftAligned ? TextAlign.left : TextAlign.right,
                  text: TextSpan(
                    text: '— $author in ',
                    style: TextStyle(color: kColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: source,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: kColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

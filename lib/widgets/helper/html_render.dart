import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// html renderer

class HtmlRender extends StatelessWidget {
  const HtmlRender({
    super.key,
    required this.data,
    this.bodyTextColor,
    this.shrinkWrap = true,
  });

  final String data;
  final Color? bodyTextColor;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Html(
      data: data,
      shrinkWrap: shrinkWrap,
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        }
      },
      style: {
        "h1": Style(
          fontSize: FontSize(kBodyLarge),
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.onSurface,
        ),
        "h2": Style(
          fontSize: FontSize(kBodyLarge),
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.onSurface,
        ),
        "h3": Style(
          fontSize: FontSize(14),
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.onSurface,
        ),

        "ul": Style(
          margin: Margins.only(
            bottom: kDefaultPadding / 3,
            // left: kDefaultPadding,
            // inlineStart: kDefaultPadding,
            // blockStart: kDefaultPadding,
          ),
        ),
        "li": Style(
          margin: Margins.only(
            // left: kDefaultPadding,
            // inlineStart: kDefaultPadding,
            // blockStart: kDefaultPadding,
            bottom: kDefaultPadding / 3,
          ),
        ),
        ".text-bold": Style(fontWeight: FontWeight.w600),
        // Style for <code>
        "code": Style(
          color: inlineCode,
          fontFamily: GoogleFonts.robotoMono().fontFamily,
          fontSize: FontSize(kBodySmall),
        ),
        // Style for other tags if needed (like <span> or default body text)
        // Remove padding around the body and other tags
        "body": Style(
          color: bodyTextColor ?? kTextColor,
          margin: Margins.all(0),
        ),
        // Optionally apply the same padding removal to <p> tags
        "p": Style(margin: Margins.all(0)),
        "b": Style(
          fontWeight: FontWeight.w600,
          color: bodyTextColor ?? kTextColor,
        ),
      },
    );
  }
}

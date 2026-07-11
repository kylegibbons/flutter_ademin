import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'package:web/web.dart' as html;

class HtmlEmbed extends StatelessWidget {
  final String url;
  final double aspectRatio;
  final bool fullScreen;

  const HtmlEmbed({
    super.key,
    required this.url,
    required this.aspectRatio,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we're running on web platform using conditional imports
    // This file should only be compiled for web platform

    final iframe = html.HTMLIFrameElement()
      ..src = url
      ..style.border = 'none'
      ..allowFullscreen = fullScreen
      ..style.pointerEvents = 'auto';

    final viewType = 'iframeElement_$url';

    // This code is web-specific and should only run on web platform

    ui.platformViewRegistry
        .registerViewFactory(viewType, (int viewId) => iframe);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: HtmlElementView(
        key: ValueKey(viewType),
        viewType: viewType,
      ),
    );
  }
}

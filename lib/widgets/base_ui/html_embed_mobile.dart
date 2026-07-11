import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlEmbed extends StatelessWidget {
  final String url;
  final double? aspectRatio;
  final bool fullScreen;

  const HtmlEmbed({
    super.key,
    required this.url,
    this.aspectRatio,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    final webView = WebViewWidget(controller: controller);

    if (aspectRatio != null) {
      return AspectRatio(
        aspectRatio: aspectRatio!,
        child: webView,
      );
    }

    return SizedBox.expand(child: webView);
  }
}

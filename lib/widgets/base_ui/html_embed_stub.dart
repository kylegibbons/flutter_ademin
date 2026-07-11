import 'package:flutter/material.dart';

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
    return const Center(
      child: Text("Embed not supported on this platform."),
    );
  }
}

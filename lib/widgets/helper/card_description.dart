import 'package:flutter/material.dart';

import 'package:flutter_ademin/widgets/helper/html_render.dart';

//Widget for showing card description.

class CardDescription extends StatelessWidget {
  const CardDescription({super.key, required this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return HtmlRender(data: content ?? '');
  }
}

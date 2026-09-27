import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/footer_config.dart';

class PublicFooter extends StatelessWidget {
  final Color textColor;
  const PublicFooter({super.key, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          ...PublicFooterConfig.widgets(context, textColor: textColor),
        ],
      ),
    );
  }
}

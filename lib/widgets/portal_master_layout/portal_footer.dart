import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/footer_config.dart';
import 'package:flutkit_ademin/constants/dimens.dart';

class PortalFooter extends StatelessWidget {
  const PortalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      decoration: BoxDecoration(color: themeData.colorScheme.surface),
      child: Row(children: [...PortalFooterConfig.widgets(context)]),
    );
  }
}

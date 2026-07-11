import 'package:flutter/material.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:intl/intl.dart';

class PortalFooterConfig {
  static List<Widget> widgets(BuildContext context) {
    final lang = Lang.of(context);
    final year = DateFormat('yyyy').format(DateTime.now());

    return [
      Text("$year © ${AppSettings.appShortName}"), // year & app name
      const Spacer(),
      Text("${lang.designedBy} ${AppSettings.companyName}"), // company name
    ];
  }
}

class PublicFooterConfig {
  static List<Widget> widgets(BuildContext context, {Color? textColor}) {
    final lang = Lang.of(context);
    final year = DateFormat('yyyy').format(DateTime.now());

    return [
      const Spacer(),
      // year & app name
      Text(
        "$year © ${AppSettings.appShortName} - ${lang.designedBy} ${AppSettings.companyName}",
        style: TextStyle(color: textColor),
      ),
      const Spacer(),
    ];
  }
}

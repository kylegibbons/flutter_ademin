import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

void _openFlutkit() async {
  final Uri url = Uri.parse('https://flutkit.com');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

class PortalFooterConfig {


  static List<Widget> widgets(BuildContext context) {
    final lang = Lang.of(context);
    final year = DateFormat('yyyy').format(DateTime.now());

    return [
      Text("$year © ${AppSettings.appShortName}"), // year & app name
      const Spacer(),
      Text("${lang.designedBy} "), 
      GestureDetector(
        onTap: _openFlutkit,
        child: Text(
          AppSettings.companyName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline),
        ),
      ),
      // company name
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
        "$year © ${AppSettings.appShortName} - ${lang.designedBy} ",
        style: TextStyle(color: textColor),
      ),

      GestureDetector(
        onTap: _openFlutkit,
        child: Text(
          AppSettings.companyName,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
        ),
      ),
      const Spacer(),
    ];
  }
}

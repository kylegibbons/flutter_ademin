import 'package:flutter/material.dart';
import 'package:flutter_ademin/widgets/sidebar/buy_button.dart';

// sidebar footer config
// these widgets will be place below sidebar menu.

class SidebarFooter {
  static List<Widget> sidebarFooter(BuildContext context) {
    return [
      // buy ademin button
      BuyAdeminButton(),
    ];
  }
}

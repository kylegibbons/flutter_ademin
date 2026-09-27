// pop up menu

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';

// pop up menu

class TeamCardPopUpMenu extends StatelessWidget {
  const TeamCardPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      onSelected: (value) => debugPrint('Selected: $value'),
      items: [
        PopupMenuItemData(value: 'edit', icon: Icons.edit, text: 'Edit'),
        PopupMenuItemData(
          value: 'disabled',
          icon: Icons.disabled_by_default_outlined,
          text: 'Disabled',
        ),
        PopupMenuItemData(
          value: 'remove',
          icon: Icons.block_outlined,
          iconColor: kErrorColor,
          text: 'Remove',
          textStyle: TextStyle(color: kErrorColor),
        ),
      ],
      // icon button
      icon: Icons.more_vert,
      iconColor: Colors.white,
    );
  }
}

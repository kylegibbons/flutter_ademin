// pop up menu

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/dropdown.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';

class PeriodPopUpMenu extends StatelessWidget {
  const PeriodPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      onSelected: (value) => debugPrint('Selected: $value'),
      items: [
        PopupMenuItemData(
          value: '7days',
          icon: Icons.calendar_view_week,
          text: 'Last 7 days',
        ),
        PopupMenuItemData(
          value: '30days',
          icon: Icons.calendar_today,
          text: 'Last 30 days',
        ),
        PopupMenuItemData(
          value: 'compare',
          icon: Icons.compare,
          text: 'Compare period',
        ),
        PopupMenuItemData(
          value: 'custom',
          icon: Icons.date_range,
          text: 'Custom range',
        ),
      ],
      // icon button
      icon: Icons.more_vert,
    );
  }
}

// time filter dropdown

class TimeFilterDropdown extends StatefulWidget {
  const TimeFilterDropdown({super.key});

  @override
  State<TimeFilterDropdown> createState() => _TimeFilterDropdownState();
}

class _TimeFilterDropdownState extends State<TimeFilterDropdown> {
  String? selectedValue = 'all_time';
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
      child: CustomDropdownButton<String>(
        label: 'Time Selector',
        color: themeData.colorScheme.surface,
        labelColor: themeData.colorScheme.onSurface,
        alignment: AlignmentDirectional.centerEnd,
        items: [
          DropdownMenuItem(value: 'all_time', child: Text('All Time')),
          DropdownMenuItem(value: '7days', child: Text('Last 7 Days')),
          DropdownMenuItem(value: '30days', child: Text('Last 30 Days')),
          DropdownMenuItem(value: '90days', child: Text('Last 90 Days')),
        ],
        value: selectedValue,
        isExpanded: false,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }
}

// pop up menu

class MorePopUpMenu extends StatelessWidget {
  const MorePopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      onSelected: (value) => debugPrint('Selected: $value'),
      items: [
        PopupMenuItemData(
          value: 'export',
          icon: Icons.download_outlined,
          text: 'Export',
          showDividerAfter: true,
        ),
        PopupMenuItemData(value: 'share', icon: Icons.share, text: 'Share'),
        PopupMenuItemData(
          value: 'rename',
          icon: Icons.edit_outlined,
          text: 'Rename',
        ),
        PopupMenuItemData(
          value: 'delete',
          icon: Icons.delete_outline,
          iconColor: kErrorColor,
          text: 'Delete',
          textStyle: TextStyle(color: kErrorColor),
        ),
      ],
      // icon button
      icon: Icons.more_vert,
    );
  }
}

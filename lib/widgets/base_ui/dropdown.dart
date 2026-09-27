import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

enum DropdownType { solid, soft, outline }

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String label;
  final Color color;
  final Color? labelColor;
  final Color? bgColor;
  final Color? outlineColor;
  final ValueChanged<T?> onChanged;
  final VoidCallback? onTap;
  final bool isExpanded;
  final AlignmentDirectional alignment;
  final DropdownType type;

  const CustomDropdownButton({
    super.key,
    required this.label,
    required this.color,
    required this.items,
    required this.value,
    required this.onChanged,
    this.labelColor = Colors.white,
    this.bgColor,
    this.outlineColor,
    this.onTap,
    this.isExpanded = false,
    this.alignment = AlignmentDirectional.center,
    this.type = DropdownType.solid,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // --- Colors logic ---
    Color backgroundColor;
    Color contentColor;
    BoxBorder? border;

    switch (type) {
      case DropdownType.outline:
        backgroundColor = themeData.colorScheme.surface;
        contentColor = color;
        border = Border.all(color: outlineColor ?? color, width: outlineWidth);
        break;
      case DropdownType.soft:
        backgroundColor = color.withValues(alpha: 0.12);
        contentColor = color;
        border = null;
        break;
      case DropdownType.solid:
        backgroundColor = color;
        contentColor = labelColor ?? Colors.white;
        border = null;
        break;
    }

    return Container(
      height: mediumHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: border,
      ),
      padding: const EdgeInsetsDirectional.only(
        start: kDefaultPadding,
        end: kDefaultPadding / 2,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          dropdownColor:
              bgColor ??
              (type == DropdownType.solid
                  ? color
                  : themeData.colorScheme.surface),
          style: TextStyle(
            color: contentColor,
            // fontSize: kBodyMedium,
          ),
          focusColor: Colors.transparent,
          onChanged: onChanged,
          onTap: onTap,
          elevation: 2,
          isDense: true,
          iconSize: 20,
          borderRadius: BorderRadius.circular(defaultRadius),
          isExpanded: isExpanded,
          items: items,
          icon: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: kDefaultPadding / 2,
            ),
            child: Icon(Icons.keyboard_arrow_down, color: contentColor),
          ),
          alignment: alignment,
          hint: Text(label, style: TextStyle(color: contentColor)),
        ),
      ),
    );
  }
}

//nested pop up menu button

class NestedPopupMenuButton extends StatelessWidget {
  final GlobalKey moreActionsKey = GlobalKey();

  NestedPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PopupMenuButton<String>(
      onSelected: (value) {
        debugPrint('$value selected');
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'View',
          child: Row(
            children: [
              Icon(Icons.visibility, color: themeData.colorScheme.onSurface),
              SizedBox(width: 1.5 * kDefaultPadding),
              Text(
                'View',
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: themeData.colorScheme.onSurface),
              SizedBox(width: 1.5 * kDefaultPadding),
              Text(
                'Edit',
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            key: moreActionsKey, // Assign the key to "More Actions"
            title: Text(
              'More Actions',
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            trailing: Icon(
              Icons.arrow_right,
              color: themeData.colorScheme.onSurface,
            ),
            onTap: () {
              // Navigator.pop(context); // Close the first popup
              _showSubMenu(context); // Show the submenu near "More Actions"
            },
          ),
        ),
      ],
      icon: Icon(Icons.more_vert, size: 22, color: kTextColor),
      splashRadius: 20,
      padding: EdgeInsets.zero,
      color: themeData.colorScheme.surface,
      tooltip: 'Show action',
    );
  }

  void _showSubMenu(BuildContext context) {
    final themeData = Theme.of(context);
    // Get the RenderBox of "More Actions"
    final RenderBox moreActionsBox =
        moreActionsKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Calculate the position of the "More Actions" button
    final Offset position = moreActionsBox.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    // Adjust position to appear next to "More Actions"
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx, // Right of "More Actions"
        position.dy, // Align vertically with "More Actions"
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'Share',
          child: ListTile(
            leading: Icon(Icons.share, color: themeData.colorScheme.onSurface),
            title: Text(
              'Share',
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Download',
          child: ListTile(
            leading: Icon(
              Icons.download,
              color: themeData.colorScheme.onSurface,
            ),
            title: Text(
              'Download',
              style: TextStyle(
                fontSize: kBodyMedium,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        debugPrint('$value selected from submenu');
      }
    });
  }
}

//action pop up menu button

class IconPopupMenuButton extends StatelessWidget {
  const IconPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'View':
            debugPrint('View selected');
            break;
          case 'Edit':
            debugPrint('Edit selected');
            break;
          case 'Delete':
            debugPrint('Delete selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'View',
          child: Row(
            children: [
              Icon(Icons.visibility, color: kInfoColor),
              SizedBox(width: 1.5 * kDefaultPadding),
              Text(
                'View',
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: kWarningColor),
              SizedBox(width: 1.5 * kDefaultPadding),
              Text(
                'Edit',
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: kErrorColor),
              SizedBox(width: 1.5 * kDefaultPadding),
              Text(
                'Delete',
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
      icon: Icon(
        Icons.more_vert,
        size: 22,
        color: kTextColor,
      ), // Icon to show for the popup menu
      splashRadius: 20,
      padding: EdgeInsets.zero,
      color: themeData.colorScheme.surface,
      tooltip: 'Show action',
    );
  }
}

//list pop up menu button

class ListPopupMenuButton extends StatelessWidget {
  const ListPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final popupMenuNotif = GlobalKey<PopupMenuButtonState>();
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return PopupMenuButton(
      key: popupMenuNotif,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      itemBuilder: (context) {
        // Adding the header
        final header = PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeData.colorScheme.onSurface,
                  fontSize: kBodyMedium,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "4 New",
                  style: TextStyle(
                    color: themeData.colorScheme.onPrimary,
                    fontSize: kBodySmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

        // Adding the footer
        final footer = PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kSuccessColor.withValues(alpha: 0.2),
                  foregroundColor: kSuccessColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View All Notifications'),
                    Icon(Icons.arrow_forward, color: kSuccessColor),
                  ],
                ),
              ),
            ),
          ),
        );

        // Generating the notification items
        final menuItems = notificationItems
            .map<PopupMenuItem>((e) {
              return PopupMenuItem(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.5 * kDefaultPadding,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(e.kIcon, color: themeData.colorScheme.onSurface),
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.notificationContent,
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontSize: kBodyMedium,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule_outlined,
                                  color: kTextColor,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  e.time,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList(growable: false);

        // Returning the complete list with header and footer
        return [header, ...menuItems, footer];
      },
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            popupMenuNotif.currentState?.showButtonMenu();
          },
          hoverColor: kSecondaryColor.withValues(alpha: 0.1),
          splashColor: kSecondaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.list, size: 22, color: kTextColor),
          ),
        ),
      ),
    );
  }
}

List<NotificationItem> notificationItems = [
  NotificationItem(
    kIcon: Icons.message_outlined,
    time: '2m ago',
    notificationContent: 'You have a new message from John.',
  ),
  NotificationItem(
    kIcon: Icons.error_outline,
    time: '10m ago',
    notificationContent: 'System alert: Your account needs attention.',
  ),
  NotificationItem(
    kIcon: Icons.person_outline,
    time: '30m ago',
    notificationContent: 'New friend request from Alice.',
  ),
  NotificationItem(
    kIcon: Icons.update_outlined,
    time: '1h ago',
    notificationContent:
        'App update available. Please update to the latest version.',
  ),
];

class NotificationItem {
  final IconData kIcon;
  final String time;
  final String notificationContent;

  NotificationItem({
    required this.kIcon,
    required this.time,
    required this.notificationContent,
  });
}

//Grid Popup Menu Button

class GridPopupMenuButton extends StatelessWidget {
  const GridPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final popupAppSelector = GlobalKey<PopupMenuButtonState>();
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return PopupMenuButton(
      key: popupAppSelector,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      itemBuilder: (context) {
        // Adding the header
        final header = PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Header Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeData.colorScheme.onSurface,
                  fontSize: kBodyMedium,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kInfoColor.withValues(alpha: 0.2),
                  foregroundColor: kInfoColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                child: Row(
                  children: [
                    Text('View All', style: TextStyle(fontSize: kBodySmall)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
              ),
            ],
          ),
        );

        // Generating the grid items
        final gridItems = PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 520,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3, // 3 items per row
              shrinkWrap: true,

              children: appItems.map((e) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  hoverColor: kSecondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(e.appImg),
                      SizedBox(height: 8),
                      Text(
                        e.appTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );

        // Returning the complete list with header, grid, and footer
        return [header, gridItems];
      },
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            popupAppSelector.currentState?.showButtonMenu();
          },
          hoverColor: kSecondaryColor.withValues(alpha: 0.1),
          splashColor: kSecondaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.apps, size: 22, color: kTextColor),
          ),
        ),
      ),
    );
  }
}

List<AppItem> appItems = [
  AppItem(appImg: 'assets/images/mail_chimp.png', appTitle: 'Mail Chimp'),
  AppItem(appImg: 'assets/images/slack.png', appTitle: 'Slack'),
  AppItem(appImg: 'assets/images/dribbble.png', appTitle: 'Dribbble'),
  AppItem(appImg: 'assets/images/dropbox.png', appTitle: 'Dropbox'),
  AppItem(appImg: 'assets/images/github.png', appTitle: 'GitHub'),
  AppItem(appImg: 'assets/images/bitbucket.png', appTitle: 'Bitbucket'),
];

class AppItem {
  final String appImg, appTitle;

  AppItem({required this.appImg, required this.appTitle});
}

//Icon dropdown button
class IconDropdownButton extends StatelessWidget {
  final String label;
  final Color color;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const IconDropdownButton({
    super.key,
    required this.label,
    required this.color,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: themeData.colorScheme.surface,
        style: TextStyle(),
        iconEnabledColor: color,
        onChanged: onChanged,
        elevation: 0,
        isDense: true,
        padding: EdgeInsets.only(left: 16, right: 12, top: 4, bottom: 4),
        iconSize: 20,
        borderRadius: BorderRadius.circular(5),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(Icons.radio_button_unchecked, color: color, size: 10),
                SizedBox(width: 0.5 * kDefaultPadding),
                Text(
                  value,
                  style: TextStyle(color: color, fontSize: kBodyMedium),
                ),
              ],
            ),
          );
        }).toList(),
        underline: Container(),
        icon: Icon(Icons.keyboard_arrow_down, color: color),
        isExpanded: false,
        hint: Text(
          value ?? label, // Show label if no value is selected
          style: TextStyle(color: color, fontSize: kBodyMedium),
        ),
        focusColor: themeData.colorScheme.surface,
      ),
    );
  }
}

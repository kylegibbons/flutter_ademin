import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:go_router/go_router.dart';

// PROFILE BUTTON

// Profile Item Data Model

class ProfileItem {
  final IconData kIcon;
  final String profileMenu;
  final String? route;

  ProfileItem({
    required this.kIcon,
    required this.profileMenu,
    required this.route,
  });
}

// profile item mockup data
List<ProfileItem> profileItems = [
  ProfileItem(
    kIcon: Icons.person_outline,
    profileMenu: 'Profile',
    route: RouteUri.profile,
  ),
  ProfileItem(
    kIcon: Icons.message_outlined,
    profileMenu: 'Messages',
    route: RouteUri.chat,
  ),
  ProfileItem(
    kIcon: Icons.view_kanban_outlined,
    profileMenu: 'Taskboard',
    route: RouteUri.kanbanBoard,
  ),
  ProfileItem(
    kIcon: Icons.help_outline,
    profileMenu: 'Help',
    route: RouteUri.faqs,
  ),
  ProfileItem(
    kIcon: Icons.settings_outlined,
    profileMenu: 'Settings',
    route: RouteUri.settings,
  ),
  ProfileItem(
    kIcon: Icons.logout_outlined,
    profileMenu: 'Logout',
    route: RouteUri.sliderSignIn,
  ),
];

//Profile button ui view

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key});

  final GlobalKey<PopupMenuButtonState> popupAppSelector =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return PopupMenuButton<ProfileItem>(
      key: popupAppSelector,
      onSelected: (item) {
        if (item.route != null) {
          context.go(item.route!);
        }
      },
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      // padding: EdgeInsets.zero,
      popUpAnimationStyle: AnimationStyle.noAnimation,
      itemBuilder: (context) {
        return [
          //HEADER
          PopupMenuItem<ProfileItem>(
            enabled: false,
            child: Text(
              'Welcome Umar!',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: kBodyMedium,
                color: kTextColor,
              ),
            ),
          ),

          const PopupMenuDivider(thickness: 0, height: 0),

          //MENU ITEMS
          ...profileItems.map((e) {
            return PopupMenuItem<ProfileItem>(
              value: e, // ✅ WAJIB
              child: Row(
                children: [
                  Icon(e.kIcon, color: themeData.colorScheme.onSurface),
                  const SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Text(
                      e.profileMenu,
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ];
      },
      child: MediaQuery.of(context).size.width > kScreenWidthXl
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(color: kTableHeaderColor),
              child: Row(
                children: [
                  userAvatar(),
                  SizedBox(width: kDefaultPadding / 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Umar Hamzah",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontSize: kBodyMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 4),
                      Text(
                        "Admin",
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: kBodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : userAvatar(),
    );
  }

  CircleAvatar userAvatar() {
    return CircleAvatar(
      radius: mediumHeight / 2,
      backgroundImage: AssetImage('assets/images/avatar_2.jpg'),
    );
  }
}

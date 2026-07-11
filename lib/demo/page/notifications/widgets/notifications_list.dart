import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/notifications/widgets/notifications_filter_tab.dart';
import 'package:flutter_ademin/demo/page/notifications/widgets/notifications_item.dart';
import 'package:flutter_ademin/providers/notification_provider.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationList extends ConsumerWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(notificationProvider.notifier);
    final _ = ref.watch(notificationProvider);

    final notifications = controller.filteredNotifications;
    final unreadCount = controller.unreadCount;
    final themeData = Theme.of(context);

    return Column(
      children: [
        // header
        Row(
          children: [
            Text(
              "All Notifications",
              style: TextStyle(
                fontSize: kBodyLarge,
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: kDefaultPadding),

            // unread counter
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "$unreadCount unread",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: kBodySmall,
                  ),
                ),
              ),

            Spacer(),

            // filter tabs
            NotificationsFilterTab(),

            SizedBox(width: kDefaultPadding),

            // more button
            CustomPopupMenu<String>(
              onSelected: (value) {
                switch (value) {
                  case 'markRead':
                    controller.markAllAsRead();
                    break;
                  case 'settings':
                    GoRouter.of(context).go(RouteUri.settings);
                    break;
                }
              },
              items: [
                // mark all read
                PopupMenuItemData(
                  value: 'markRead',
                  text: 'Mark all as read',
                  icon: Icons.done_all,
                ),

                // settings
                PopupMenuItemData(
                  value: 'settings',
                  text: 'Notification Settings',
                  icon: Icons.settings_outlined,
                ),
              ],

              // icon
              icon: Icons.more_horiz,
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding / 2),

        ListView.separated(
          itemCount: notifications.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (_, _) =>
              const SizedBox(height: kDefaultPadding / 4),
          itemBuilder: (context, index) {
            final item = notifications[index];
            return NotificationItem(notification: item);
          },
        ),
      ],
    );
  }
}

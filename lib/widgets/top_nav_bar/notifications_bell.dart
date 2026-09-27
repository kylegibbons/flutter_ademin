import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/notifications/notifications_models.dart';
import 'package:flutkit_ademin/demo/page/notifications/widgets/notifications_item.dart';
import 'package:flutkit_ademin/providers/notification_provider.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// notification bell

class NotificationBell extends ConsumerWidget {
  NotificationBell({super.key});

  final GlobalKey<PopupMenuButtonState> popupMenuNotif =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final state = ref.watch(notificationProvider);
    final notifications = [...state.notifications]
      ..sort((a, b) => b.time.compareTo(a.time));
    final latestNotifications = notifications.take(4).toList();
    final unreadCount = state.notifications
        .where((n) => n.status == NotificationStatus.unread)
        .length;
    return PopupMenuButton(
      key: popupMenuNotif,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 380,
      ),
      popUpAnimationStyle: AnimationStyle.noAnimation,
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        // Adding the header
        final header = PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Consumer(
            builder: (context, ref, _) {
              final unreadCount = ref.watch(
                notificationProvider.select(
                  (state) => state.notifications
                      .where((n) => n.status == NotificationStatus.unread)
                      .length,
                ),
              );

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                      fontSize: kBodyLarge,
                    ),
                  ),

                  if (unreadCount > 0)
                    CustomBadge(
                      kText: '$unreadCount New',
                      kColor: kSecondaryColor,
                    ),
                ],
              );
            },
          ),
        );

        // Adding the footer
        final footer = PopupMenuItem(
          enabled: false,
          child: Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              bottom: kDefaultPadding / 2,
            ),
            child: Center(
              child: SoftButton(
                kText: 'View all notifications',
                bgColor: themeData.colorScheme.primary,
                kTrailingIcon: Icons.arrow_forward,
                isFullWidth: true,
                onPressed: () {
                  GoRouter.of(context).go(RouteUri.notifications);
                },
              ),
            ),
          ),
        );

        // Generating the notification items
        final List<PopupMenuEntry<String>> menuItems = latestNotifications
            .map<PopupMenuEntry<String>>(
              (n) => PopupMenuItem<String>(
                value: n.id, // or any identifier
                onTap: () {
                  ref.read(notificationProvider.notifier).markAsRead(n.id);

                  // just for demo purpose, replace with activities route
                  GoRouter.of(context).go(RouteUri.notifications);
                },
                padding: EdgeInsets.zero,
                child: _PopupItem(notification: n),
              ),
            )
            .toList();

        // Returning the complete list with header and footer
        return <PopupMenuEntry<dynamic>>[header, ...menuItems, footer];
      },
      child: Material(
        type: MaterialType.transparency,
        child: Tooltip(
          message: 'Notifications',
          child: InkWell(
            onTap: () {
              popupMenuNotif.currentState?.showButtonMenu();
            },

            hoverColor: kSecondaryColor.withValues(alpha: 0.1),
            splashColor: kSecondaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              radius: mediumHeight / 2,
              backgroundColor: Colors.transparent,
              child: Badge(
                label: Text(unreadCount.toString()),
                isLabelVisible: unreadCount > 0,
                offset: Offset(8, -10),
                child: Icon(Icons.notifications_outlined, color: kTextColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PopupItem extends ConsumerWidget {
  final AppNotification notification;

  const _PopupItem({required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentNotification = ref.watch(
      notificationProvider.select(
        (state) =>
            state.notifications.firstWhere((n) => n.id == notification.id),
      ),
    );
    final isUnread = currentNotification.status == NotificationStatus.unread;
    final color = NotificationHelper.getColor(currentNotification.type);
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            radius: 20,
            child: Icon(
              NotificationHelper.getIcon(currentNotification.type),
              size: 18,
              color: color,
            ),
          ),
          const SizedBox(width: kDefaultPadding),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // notification description
                Text(
                  currentNotification.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // time
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      _timeAgo(currentNotification.time),
                      style: TextStyle(fontSize: kBodySmall, color: kTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (isUnread)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }
}

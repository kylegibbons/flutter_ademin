import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/notifications/notifications_models.dart';
import 'package:flutter_ademin/providers/notification_provider.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationItem extends ConsumerWidget {
  final AppNotification notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(notificationProvider.notifier);

    final isUnread = notification.status == NotificationStatus.unread;
    final color = NotificationHelper.getColor(notification.type);
    final themeData = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(defaultRadius),
      onTap: () {
        controller.markAsRead(notification.id);
      },
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: isUnread
              ? themeData.colorScheme.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: NotificationHelper.getBackgroundColor(notification.type),
                shape: BoxShape.circle,
              ),
              child: Icon(
                NotificationHelper.getIcon(notification.type),
                color: color,
              ),
            ),

            const SizedBox(width: kDefaultPadding),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),

                      // Unread Dot
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 4),

                  // description
                  Text(
                    notification.description,
                    style: TextStyle(fontSize: kBodySmall),
                  ),
                  const SizedBox(height: kDefaultPadding / 4),

                  // time
                  Text(
                    _timeAgo(notification.time),
                    style: TextStyle(fontSize: kBodySmall),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else {
      return "${diff.inDays} days ago";
    }
  }
}

class NotificationHelper {
  static IconData getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_cart_outlined;
      case NotificationType.payment:
        return Icons.payment_outlined;
      case NotificationType.user:
        return Icons.person_add_alt_1_outlined;
      case NotificationType.system:
        return Icons.settings_outlined;
    }
  }

  static Color getColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return kSecondaryColor;
      case NotificationType.payment:
        return kInfoColor;
      case NotificationType.user:
        return kSuccessColor;
      case NotificationType.system:
        return kErrorColor;
    }
  }

  static Color getBackgroundColor(NotificationType type) {
    return getColor(type).withValues(alpha: 0.1);
  }
}

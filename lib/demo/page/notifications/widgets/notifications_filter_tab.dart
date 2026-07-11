import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/providers/notification_provider.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsFilterTab extends ConsumerWidget {
  const NotificationsFilterTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(notificationProvider.notifier);
    final state = ref.watch(notificationProvider);

    Widget buildItem(String label, NotificationFilter filter) {
      final isActive = state.filter == filter;
      final themeData = Theme.of(context);

      return GestureDetector(
        onTap: () => controller.setFilter(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isActive
                ? themeData.colorScheme.surface
                : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: kBodySmall,
              color: isActive
                  ? themeData.colorScheme.onSurface
                  : themeData.colorScheme.onSurface,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: kSecondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          buildItem("All", NotificationFilter.all),
          const SizedBox(width: kDefaultPadding / 4),
          buildItem("Unread", NotificationFilter.unread),
          const SizedBox(width: kDefaultPadding / 4),
          buildItem("Read", NotificationFilter.read),
        ],
      ),
    );
  }
}

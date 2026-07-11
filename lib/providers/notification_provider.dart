// state management + filtering logic

import 'package:flutter_ademin/demo/page/notifications/notifications_data.dart';
import 'package:flutter_ademin/demo/page/notifications/notifications_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NotificationFilter { all, unread, read }

class NotificationState {
  final List<AppNotification> notifications;
  final NotificationFilter filter;

  NotificationState({
    required this.notifications,
    this.filter = NotificationFilter.all,
  });

  NotificationState copyWith({
    List<AppNotification>? notifications,
    NotificationFilter? filter,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      filter: filter ?? this.filter,
    );
  }
}

class NotificationController extends Notifier<NotificationState> {
  @override
  NotificationState build() {
    return NotificationState(notifications: mockNotifications);
  }

  //  Filter change
  void setFilter(NotificationFilter filter) {
    state = state.copyWith(filter: filter);
  }

  //  Mark single as read
  void markAsRead(String id) {
    final updated = state.notifications.map((n) {
      if (n.id == id) {
        return AppNotification(
          id: n.id,
          title: n.title,
          description: n.description,
          time: n.time,
          type: n.type,
          status: NotificationStatus.read,
        );
      }
      return n;
    }).toList();

    state = state.copyWith(notifications: updated);
  }

  //  Mark all as read
  void markAllAsRead() {
    final updated = state.notifications.map((n) {
      return AppNotification(
        id: n.id,
        title: n.title,
        description: n.description,
        time: n.time,
        type: n.type,
        status: NotificationStatus.read,
      );
    }).toList();

    state = state.copyWith(notifications: updated);
  }

  //  Filtered list (computed)
  List<AppNotification> get filteredNotifications {
    switch (state.filter) {
      case NotificationFilter.unread:
        return state.notifications
            .where((n) => n.status == NotificationStatus.unread)
            .toList();
      case NotificationFilter.read:
        return state.notifications
            .where((n) => n.status == NotificationStatus.read)
            .toList();
      case NotificationFilter.all:
        return state.notifications;
    }
  }

  //  Unread count (important for badge)
  int get unreadCount {
    return state.notifications
        .where((n) => n.status == NotificationStatus.unread)
        .length;
  }

  // latest notification for notification bell

  List<AppNotification> get latestNotifications {
    final sorted = [...state.notifications]
      ..sort((a, b) => b.time.compareTo(a.time));

    return sorted.take(4).toList();
  }
}

// provider
final notificationProvider =
    NotifierProvider<NotificationController, NotificationState>(
      NotificationController.new,
    );

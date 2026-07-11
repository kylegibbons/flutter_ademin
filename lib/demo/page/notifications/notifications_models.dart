// Enum

enum NotificationType { order, payment, user, system }

enum NotificationStatus { unread, read }

// DATA MODEL

class AppNotification {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final NotificationType type;
  NotificationStatus status;

  AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.status = NotificationStatus.unread,
  });
}

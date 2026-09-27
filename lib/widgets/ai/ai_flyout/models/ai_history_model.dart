enum AIHistoryType {
  chat,
  insight,
  action,
  workflow,
  report,
  forecast,
  automation,
}

class AIHistoryItem {
  const AIHistoryItem({
    required this.id,
    required this.title,
    required this.type,
    required this.createdAt,
    this.description,
  });

  /// Unique identifier
  final String id;

  /// History title
  final String title;

  /// Optional description
  final String? description;

  /// Activity type
  final AIHistoryType type;

  /// Timestamp
  final DateTime createdAt;
}

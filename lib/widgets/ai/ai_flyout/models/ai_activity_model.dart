enum AIActivityType {
  conversation,
  insight,
  action,
  workflow,
  report,
  export,
  approval,
  automation,
  agent,
  system,
}

enum AIActivityStatus { pending, running, completed, failed, cancelled }

class AIActivity {
  const AIActivity({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.createdAt,

    this.conversationId,
    this.entityId,
    this.entityType,

    this.metadata = const {},
  });

  final String id;

  final AIActivityType type;

  final AIActivityStatus status;

  final String title;

  final String description;

  final DateTime createdAt;

  /// jika activity berasal dari sebuah chat
  final String? conversationId;

  /// id object
  /// report_001
  /// workflow_03
  /// approval_15
  final String? entityId;

  final String? entityType;

  final Map<String, dynamic> metadata;
}

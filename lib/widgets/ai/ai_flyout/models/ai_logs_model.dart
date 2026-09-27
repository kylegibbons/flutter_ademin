enum AILogLevel { info, success, warning, error }

enum AILogSource { system, agent, automation, workflow, integration }

enum AILogType {
  report,
  analysis,
  insight,
  workflow,
  automation,
  forecast,
  campaign,
  dashboard,
  notification,
  integration,
  api,
  sync,
  data,
}

class AILogItem {
  const AILogItem({
    required this.id,
    required this.title,
    required this.message,
    required this.level,
    required this.source,
    required this.type,
    required this.sourceName,
    required this.createdAt,
    this.user,
    this.details,
  });

  /// Unique identifier
  final String id;

  /// Short title
  final String title;

  /// Detail message
  final String message;

  /// Info / Success / Warning / Error
  final AILogLevel level;

  /// System / Agent / Workflow
  final AILogSource source;

  /// Report / Analysis / etc.
  final AILogType type;

  /// CRM Agent / Finance Advisor / System
  final String sourceName;

  /// Timestamp
  final DateTime createdAt;

  /// Optional user / agent
  final String? user;

  /// Long description
  final String? details;
}

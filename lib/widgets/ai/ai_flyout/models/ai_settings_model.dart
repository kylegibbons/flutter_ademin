class AISettings {
  const AISettings({
    required this.behavior,
    required this.memory,
    required this.reports,
  });

  final AIBehaviorSettings behavior;
  final AIMemorySettings memory;
  final AIReportSettings reports;
}

class AIBehaviorSettings {
  const AIBehaviorSettings({
    required this.autoSaveConversations,
    required this.autoOpenInsights,
    required this.confirmBeforeAction,
    required this.showAIReasoning,
  });

  final bool autoSaveConversations;

  final bool autoOpenInsights;

  final bool confirmBeforeAction;

  final bool showAIReasoning;
}

enum AIMemoryRetention { days7, days30, days90, days180, forever }

class AIMemorySettings {
  const AIMemorySettings({
    required this.memoryRetention,
    required this.conversationHistory,
  });

  final AIMemoryRetention memoryRetention;

  final AIMemoryRetention conversationHistory;
}

enum AIExportFormat { pdf, excel, csv, word }

enum AIPageSize { a4, letter, legal }

class AIReportSettings {
  const AIReportSettings({
    required this.exportFormat,
    required this.includeVisualizations,
    required this.pageSize,
  });

  final AIExportFormat exportFormat;

  final bool includeVisualizations;

  final AIPageSize pageSize;
}

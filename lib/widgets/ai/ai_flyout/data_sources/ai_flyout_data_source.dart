import 'package:flutter/foundation.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';

/// Abstract data source for providing page-specific context to the AI flyout.
abstract class AIFlyoutDataSource {
  /// Fetches contextual data for the current page.
  Future<Map<String, dynamic>> fetch();
}

/// Simple static data source returning provided map or AI operator model.
class StaticDataSource implements AIFlyoutDataSource {
  final dynamic data;

  StaticDataSource(this.data);

  @override
  Future<Map<String, dynamic>> fetch() async {
    if (data is Map<String, dynamic>) {
      return Map<String, dynamic>.from(data as Map<String, dynamic>);
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data as Map);
    }

    if (data is AIOperatorData) {
      final aiData = data as AIOperatorData;
      return {
        'home': aiData.home,
        'conversations': aiData.conversations,
        'chat': aiData.conversations
            .expand((conversation) => conversation.chat)
            .toList(),
        'insights': aiData.insights,
        'actions': aiData.actions
            .map(
              (action) => {
                'id': action.id,
                'title': action.title,
                'description': action.description,
                'status': action.status,
                'priority': action.priority,
                'createdAt': action.createdAt,
                'completedAt': action.completedAt,
                'progress': action.progress,
                'icon': action.icon,
              },
            )
            .toList(),
        'agents': aiData.agents
            .whereType<AIAgent>()
            .map(
              (agent) => {
                'id': agent.id,
                'name': agent.name,
                'description': agent.description,
                'category': agent.category,
                'status': agent.status,
                'state': agent.state,
                'tasksCompleted': agent.tasksCompleted,
                'successRate': agent.successRate,
                'lastUsed': agent.lastUsed,
                'icon': agent.icon,
                'enabled': agent.enabled,
              },
            )
            .toList(),
        'logs': aiData.logs
            .whereType<AILogItem>()
            .map(
              (log) => {
                'id': log.id,
                'title': log.title,
                'message': log.message,
                'level': log.level,
                'source': log.source,
                'type': log.type,
                'sourceName': log.sourceName,
                'createdAt': log.createdAt,
                'user': log.user,
                'details': log.details,
              },
            )
            .toList(),
        'settings': aiData.settings == null
            ? null
            : {
                'behavior': {
                  'autoSaveConversations':
                      aiData.settings!.behavior.autoSaveConversations,
                  'autoOpenInsights':
                      aiData.settings!.behavior.autoOpenInsights,
                  'confirmBeforeAction':
                      aiData.settings!.behavior.confirmBeforeAction,
                  'showAIReasoning': aiData.settings!.behavior.showAIReasoning,
                },
                'memory': {
                  'memoryRetention': aiData.settings!.memory.memoryRetention
                      .toString()
                      .split('.')
                      .last,
                  'conversationHistory': aiData
                      .settings!
                      .memory
                      .conversationHistory
                      .toString()
                      .split('.')
                      .last,
                },
                'reports': {
                  'exportFormat': aiData.settings!.reports.exportFormat
                      .toString()
                      .split('.')
                      .last,
                  'includeVisualizations':
                      aiData.settings!.reports.includeVisualizations,
                  'pageSize': aiData.settings!.reports.pageSize
                      .toString()
                      .split('.')
                      .last,
                },
              },
      };
    }

    return {};
  }
}

/// Example remote API data source. Replace `fetchFromApi` implementation.
class RemoteApiDataSource implements AIFlyoutDataSource {
  final String endpoint;

  RemoteApiDataSource(this.endpoint);

  @override
  Future<Map<String, dynamic>> fetch() async {
    // Placeholder: developer should implement real HTTP call here.
    // Return a minimal structure so features depending on dataSource keep working.
    debugPrint('Fetching AI flyout data from: $endpoint');
    await Future.delayed(const Duration(milliseconds: 200));
    return {'endpoint': endpoint};
  }
}

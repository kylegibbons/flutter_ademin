import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

class AIOperatorData {
  const AIOperatorData({
    required this.home,
    required this.conversations,
    this.insights = const [],
    this.actions = const [],
    this.agents = const [],
    this.logs = const [],
    this.settings,
  });

  /// Home screen
  final AIHome home;

  /// Chat conversations
  final List<AIConversation> conversations;

  /// Insights tab
  final List<AIInsight> insights;

  /// Actions tab
  final List<AIActionItem> actions;

  /// Agents tab
  final List<AIAgent> agents;

  /// History tab
  final List<AILogItem> logs;

  /// Settings tab
  final AISettings? settings;
}

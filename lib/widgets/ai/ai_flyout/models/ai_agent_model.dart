import 'package:flutter/material.dart';

enum AIAgentHealthStatus { healthy, warning, degraded, unhealthy, offline }

enum AIAgentState { running, paused, starting, stopping, stopped }

enum AIAgentCategory {
  crm,
  analytics,
  finance,
  marketing,
  inventory,
  support,
  productivity,
  integration,
}

class AIAgent {
  const AIAgent({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.state,
    required this.tasksCompleted,
    required this.successRate,
    required this.lastUsed,
    required this.icon,
    this.enabled = true,
  });

  final String id;

  final String name;

  final String description;

  final AIAgentCategory category;

  final AIAgentHealthStatus status;
  final AIAgentState state;

  final int tasksCompleted;

  /// 0-100
  final int successRate;

  final DateTime lastUsed;

  final IconData icon;

  final bool enabled;
}

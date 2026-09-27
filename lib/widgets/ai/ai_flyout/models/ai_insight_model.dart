import 'package:flutter/material.dart';

enum AIInsightSeverity { critical, warning, opportunity, information }

enum AIInsightStatus { unread, viewed, acknowledged, dismissed, archived }

enum AIInsightCategory {
  analytics,
  sales,
  finance,
  marketing,
  crm,
  inventory,
  support,
  security,
  workflow,
  system,
  crypto,
  project,
  nft,
  saas,
}

enum AIConfidenceLevel { low, medium, high }

enum AIImpactLevel { low, medium, high, critical, positive }

class AIInsight {
  const AIInsight({
    required this.id,
    required this.title,
    required this.summary,
    required this.severity,
    required this.category,
    required this.status,
    required this.generatedAt,
    required this.confidence,
    this.description,
    this.impact,
    this.why,
    this.relatedResources = const [],
    this.suggestions = const [],
    this.actions = const [],
    this.tags = const [],
  });

  /// Unique id
  final String id;

  /// Revenue turun 23%
  final String title;

  /// Ringkasan singkat
  final String summary;

  /// Penjelasan lengkap
  final String? description;

  final AIInsightSeverity severity;

  final AIInsightCategory category;

  final AIInsightStatus status;

  final DateTime generatedAt;

  final AIConfidence confidence;

  /// Dampak bisnis
  final AIImpact? impact;

  /// Penyebab
  final AIWhy? why;

  /// Link ke data terkait
  final List<AIRelatedResource> relatedResources;

  /// Rekomendasi
  final List<AISuggestion> suggestions;

  /// Action executable
  final List<AIAction> actions;

  final List<String> tags;
}

class AIConfidence {
  const AIConfidence({required this.level, required this.score});

  final AIConfidenceLevel level;

  /// 0-100
  final int score;
}

class AIImpact {
  const AIImpact({required this.level, this.title, this.description});

  final AIImpactLevel level;

  final String? title;

  final String? description;
}

class AIWhy {
  const AIWhy({this.title = "Why", this.reasons = const []});

  final String title;

  final List<String> reasons;
}

enum AIRelatedResourceType {
  dashboard,
  report,
  workflow,
  customer,
  product,
  page,
}

class AIRelatedResource {
  const AIRelatedResource({
    required this.id,
    required this.title,
    required this.type,
  });

  final String id;

  final String title;

  final AIRelatedResourceType type;
}

class AISuggestion {
  const AISuggestion({required this.id, required this.title, this.description});

  final String id;

  final String title;

  final String? description;
}

enum AIActionType { primary, secondary, destructive }

class AIAction {
  const AIAction({
    required this.id,
    required this.label,
    required this.type,
    this.icon,
  });

  final String id;

  final String label;

  final IconData? icon;

  final AIActionType type;
}

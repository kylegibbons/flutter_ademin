import 'package:flutter/material.dart';

enum AIActionStatus { pending, running, completed, failed, cancelled }

enum AIActionPriority { low, medium, high }

class AIActionItem {
  const AIActionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.createdAt,
    this.completedAt,
    this.progress,
    this.icon,
  });

  /// Unique identifier
  final String id;

  /// Action title
  final String title;

  /// Action description
  final String description;

  /// Current status
  final AIActionStatus status;

  /// Priority level
  final AIActionPriority priority;

  /// Created timestamp
  final DateTime createdAt;

  /// Completed timestamp
  final DateTime? completedAt;

  /// Progress percentage (0-100)
  final int? progress;

  /// Optional leading icon
  final IconData? icon;
}

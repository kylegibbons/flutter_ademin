import 'package:flutter/material.dart';

// centered timeline data model

class TimelineEvent {
  final String imageUrl;
  final String username;
  final String timeAgo;
  final String description;

  TimelineEvent({
    required this.imageUrl,
    required this.username,
    required this.timeAgo,
    required this.description,
  });
}

// leading timeline data model

class LeadingTimelineStep {
  final String title;
  final String description;
  final String date;
  final String dueDate;
  final String status;
  final IconData icon;
  final bool isCompleted;
  final Color color;

  LeadingTimelineStep({
    required this.title,
    required this.description,
    required this.date,
    required this.dueDate,
    required this.status,
    required this.icon,
    required this.isCompleted,
    required this.color,
  });
}

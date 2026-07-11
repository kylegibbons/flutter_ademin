import 'package:flutter/material.dart';

// project data model

class ProjectData {
  ProjectData({
    required this.month,
    required this.projects,
    required this.activeProjects,
    required this.revenue,
  });

  final String month;
  final int projects;
  final int activeProjects;
  final double revenue; // Revenue in thousands of dollars
}

// projet status data model
class ProjectStatusData {
  final String status;
  final int projects;
  final int tasks;
  final Color color;

  ProjectStatusData({
    required this.status,
    required this.projects,
    required this.tasks,
    required this.color,
  });
}

// Project Hours data model

class ProjectHours {
  final String name;
  final int estimated;
  final int actual;

  ProjectHours({
    required this.name,
    required this.estimated,
    required this.actual,
  });
}

// Tickets by Issue Type and Status

class TicketStatusData {
  final String issueType;
  final int resolved;
  final int open;
  final int unresolved;

  TicketStatusData({
    required this.issueType,
    required this.resolved,
    required this.open,
    required this.unresolved,
  });
}

// Ticket by Source model

class TicketSourceData {
  final String source;
  final int count;
  final Color color;

  TicketSourceData({
    required this.source,
    required this.count,
    required this.color,
  });
}

// Avg. Resolution and Response Times data model

class SupportTimeData {
  final String month;
  final int resolutionTime; // in hours
  final double responseTime; // in hours

  SupportTimeData({
    required this.month,
    required this.resolutionTime,
    required this.responseTime,
  });
}

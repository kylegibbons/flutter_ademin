// 1. Ticket Overview Data Model
import 'package:flutter/material.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TicketOverview {
  final String title;
  final double value;

  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor; // Color for the icon itself
  final double changes;

  TicketOverview({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.changes,
  });
}

// ticket list data model

class TicketData {
  final String id;
  final String title;
  final UserInfo client;
  final List<UserInfo> assignedTo;
  final TicketStatus status;
  final TicketPriority priority;
  final DateTime createdDate;
  final DateTime dueDate;

  TicketData({
    required this.id,
    required this.title,
    required this.client,
    required this.assignedTo,
    required this.status,
    required this.priority,
    required this.createdDate,
    required this.dueDate,
  });
}

class UserInfo {
  final String userId;
  final String name;
  final String avatarUrl;

  UserInfo({required this.userId, required this.name, required this.avatarUrl});
}

enum TicketStatus { newTicket, open, closed, inProgress }

enum TicketPriority { low, high, medium }

class StatusInfo {
  final String label;
  final Color color;

  StatusInfo({required this.label, required this.color});
}

// get status color

StatusInfo getStatusInfo(TicketStatus status) {
  late String label;
  late Color color;

  switch (status) {
    case TicketStatus.closed:
      label = 'Closed';
      color = kSuccessColor;
      break;
    case TicketStatus.inProgress:
      label = 'In Progress';
      color = kWarningColor;
      break;
    case TicketStatus.newTicket:
      label = 'New';
      color = kInfoColor;
      break;
    case TicketStatus.open:
      label = 'Open';
      color = kErrorColor;
      break;
  }

  return StatusInfo(label: label, color: color);
}

// get priority color

Color getPriorityColor(TicketPriority priority) {
  switch (priority) {
    case TicketPriority.medium:
      return kWarningColor;
    case TicketPriority.low:
      return kInfoColor;
    case TicketPriority.high:
      return kErrorColor;
  }
}

// data model

class TicketDetail {
  final String id;
  final String subject;
  final String description;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String priority;
  final String category;
  final UserInfo client;
  final List<UserInfo> assignedTo;
  final ProjectInfo? project;
  final List<String> labels;
  final List<TicketComment> comments;
  final List<TicketAttachment> attachments;

  TicketDetail({
    required this.id,
    required this.subject,
    required this.description,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.priority,
    required this.category,
    required this.client,
    this.assignedTo = const [],
    this.project,
    this.labels = const [],
    this.comments = const [],
    this.attachments = const [],
  });
}

class ProjectInfo {
  final String id;
  final String name;

  ProjectInfo({required this.id, required this.name});
}

class TicketComment {
  final String id;
  final String userId;
  final String message;
  final DateTime timestamp;
  final List<TicketComment> replies;

  TicketComment({
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
    this.replies = const [],
  });
}

class TicketAttachment {
  final String id;
  final String fileName;
  final String fileUrl;
  final DateTime uploadedAt;
  final double fileSize;

  TicketAttachment({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.uploadedAt,
    required this.fileSize,
  });
}

// File Icon info data model

class FileIconInfo {
  final FaIconData icon;
  final Color color;

  FileIconInfo(this.icon, this.color);
}

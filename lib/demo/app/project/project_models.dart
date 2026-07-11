import 'package:flutter/material.dart';
import 'package:flutter_ademin/theme/themes.dart';

// Data model

class Project {
  final String title;
  final int totalTasks;
  final int completedTasks;
  final List<String> teamMemberAvatars;
  final String priority;
  final String description;
  final DateTime assignedDate;
  final DateTime dueDate;

  Project({
    required this.title,
    required this.totalTasks,
    required this.completedTasks,
    required this.teamMemberAvatars,
    required this.priority,
    required this.description,
    required this.assignedDate,
    required this.dueDate,
  });
}

class ProjectDetails {
  final String id;
  final String title;
  final String client;
  final String description;
  final String bgImage;
  final String status;
  final String priority;
  final DateTime dateCreated;
  final DateTime startDate;
  final DateTime endDate;
  final double progress;
  final List<String> tags;
  final String billingType;
  final List<Member> members;
  final List<ProjectMilestone> milestones;
  final List<ProjectTask> tasks;
  final List<ProjectAttachment> attachments;
  final List<ProjectActivity> activities;
  final List<ProjectDiscussion> discussions;
  final List<ProjectChecklistItem> checklists;

  ProjectDetails({
    required this.id,
    required this.title,
    required this.client,
    required this.description,
    required this.bgImage,
    required this.status,
    required this.priority,
    required this.dateCreated,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.tags,
    required this.billingType,
    required this.members,
    required this.milestones,
    required this.tasks,
    required this.attachments,
    required this.activities,
    required this.discussions,
    required this.checklists,
  });
}

// team member data model
class Member {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });
}

// project milestone data model
class ProjectMilestone {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  ProjectMilestone({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });
}

// project attachment data model
class ProjectAttachment {
  final String id;
  final String name;
  final String url;
  final String fileType; // e.g., 'pdf', 'docx', 'pdf'
  final double fileSize;
  final DateTime uploadedAt;

  ProjectAttachment({
    required this.id,
    required this.name,
    required this.url,
    required this.fileType,
    required this.fileSize,
    required this.uploadedAt,
  });
}

class ProjectChecklistItem {
  final String id;
  final String title;
  final bool isDone;

  ProjectChecklistItem({
    required this.id,
    required this.title,
    required this.isDone,
  });
}

// project task data model
class ProjectTask {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime startDate;
  final DateTime dueDate;
  final double? progress;

  final List<String> assignedMemberIds;

  /// relations by ID
  final List<String> attachmentIds;
  final List<String> activityIds;
  final List<String> discussionIds;
  final List<String> checklistIds;

  final List<String>? tags;
  final int? discussionCount;
  final int? attachmentCount;

  ProjectTask({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.assignedMemberIds,
    required this.attachmentIds,
    required this.activityIds,
    required this.discussionIds,
    required this.checklistIds,
    this.progress,
    this.tags,
    this.discussionCount,
    this.attachmentCount,
  });

  /// Progress in percent (0..100) based on this task's checklist IDs.
  double progressFromChecklists(List<ProjectChecklistItem> allChecklists) {
    if (checklistIds.isEmpty) return 0;

    final checklistById = {for (final item in allChecklists) item.id: item};
    final doneCount = checklistIds
        .where((id) => checklistById[id]?.isDone == true)
        .length;

    return (doneCount / checklistIds.length) * 100;
  }
}

// project activity data model
class ProjectActivity {
  final String id;
  final String type; // e.g., 'comment', 'status_change', 'file_upload'
  final String description; // A readable description or message
  final String memberId; // Who performed the action
  final DateTime timestamp;
  final String? relatedTaskId; // Optional: Link to a task
  final String? attachmentUrl; // Optional: e.g., for file uploads

  ProjectActivity({
    required this.id,
    required this.type,
    required this.description,
    required this.memberId,
    required this.timestamp,
    this.relatedTaskId,
    this.attachmentUrl,
  });
}

// Project Discussion

class ProjectDiscussion {
  final String id;
  final String taskId; // Related task
  final String memberId; // Author
  final String message;
  final DateTime createdAt;

  final List<String>? attachmentIds; // optional
  final String? parentDiscussionId; // reply / thread

  ProjectDiscussion({
    required this.id,
    required this.taskId,
    required this.memberId,
    required this.message,
    required this.createdAt,
    this.attachmentIds,
    this.parentDiscussionId,
  });
}

/// Simple container for task form values.
/// Shared between add/edit/view dialogs.
class TaskFormData {
  final String title;
  String description;
  final String startDate;
  final String dueDate;
  final String priority;
  final String status;
  final List<String> assignees;
  final List<String>? tags;
  final List<TaskChecklistItemData>? checklist;
  final List<String>? attachments;
  final List<String>? activities;
  final List<String>? discussions;
  final List<TaskLogEntryData>? activityEntries;
  final List<TaskLogEntryData>? discussionEntries;

  TaskFormData({
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.assignees,
    this.tags,
    this.checklist,
    this.attachments,
    this.activities,
    this.discussions,
    this.activityEntries,
    this.discussionEntries,
  });
}

/// Checklist item container for add/edit/view task dialogs.
class TaskChecklistItemData {
  final String? id;
  final String title;
  final bool isDone;

  TaskChecklistItemData({this.id, required this.title, this.isDone = false});
}

/// Richer log item data for task activity/discussion rendering.
class TaskLogEntryData {
  final String text;
  final DateTime timestamp;
  final String memberName;
  final String memberAvatarUrl;

  TaskLogEntryData({
    required this.text,
    required this.timestamp,
    required this.memberName,
    required this.memberAvatarUrl,
  });
}

// Task Status data model

enum TaskStatus { notStarted, inProgress, testing, awaitFeedback, completed }

extension TaskStatusX on TaskStatus {
  String get key {
    switch (this) {
      case TaskStatus.notStarted:
        return 'notStarted';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.testing:
        return 'testing';
      case TaskStatus.awaitFeedback:
        return 'awaitFeedback';
      case TaskStatus.completed:
        return 'completed';
    }
  }

  String get label {
    switch (this) {
      case TaskStatus.notStarted:
        return 'Not Started';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.testing:
        return 'Testing';
      case TaskStatus.awaitFeedback:
        return 'Awaiting Feedback';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.notStarted:
        return kInfoColor;
      case TaskStatus.inProgress:
        return kPrimaryColor;
      case TaskStatus.testing:
        return kWarningColor;
      case TaskStatus.awaitFeedback:
        return kErrorColor;
      case TaskStatus.completed:
        return kSuccessColor;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskStatus.notStarted:
        return Icons.hourglass_empty_outlined;
      case TaskStatus.inProgress:
        return Icons.autorenew_outlined;
      case TaskStatus.testing:
        return Icons.science_outlined;
      case TaskStatus.awaitFeedback:
        return Icons.feedback_outlined;
      case TaskStatus.completed:
        return Icons.check_circle_outline;
    }
  }

  Color get iconColor {
    switch (this) {
      case TaskStatus.notStarted:
        return kTextColor;
      case TaskStatus.inProgress:
        return kInfoColor;
      case TaskStatus.testing:
        return kSecondaryColor;
      case TaskStatus.awaitFeedback:
        return kErrorColor;
      case TaskStatus.completed:
        return kSuccessColor;
    }
  }
}

extension TaskStatusParser on String {
  TaskStatus toTaskStatus() {
    switch (replaceAll(' ', '').toLowerCase()) {
      case 'notstarted':
        return TaskStatus.notStarted;
      case 'inprogress':
        return TaskStatus.inProgress;
      case 'testing':
        return TaskStatus.testing;
      case 'awaitfeedback':
      case 'awaitingfeedback':
        return TaskStatus.awaitFeedback;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.notStarted;
    }
  }
}

// board list order

const List<TaskStatus> statusOrder = [
  TaskStatus.notStarted,
  TaskStatus.inProgress,
  TaskStatus.testing,
  TaskStatus.awaitFeedback,
  TaskStatus.completed,
];

// project & task priority

enum Priority { high, medium, low }

extension PriorityX on Priority {
  String get label {
    switch (this) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
    }
  }

  Color get color {
    switch (this) {
      case Priority.high:
        return kErrorColor;
      case Priority.medium:
        return kSecondaryColor;
      case Priority.low:
        return kSuccessColor;
    }
  }
}

extension PriorityParser on String {
  Priority toPriority() {
    switch (toLowerCase()) {
      case 'high':
        return Priority.high;
      case 'medium':
        return Priority.medium;
      case 'low':
        return Priority.low;
      default:
        return Priority.low;
    }
  }
}

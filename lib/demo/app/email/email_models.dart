import 'package:flutter/material.dart';

enum EmailFolder {
  inbox,
  starred,
  snoozed,
  important,
  sent,
  scheduled,
  draft,
  spam,
  trash,
}

extension EmailFolderExtension on EmailFolder {
  String get label {
    switch (this) {
      case EmailFolder.inbox:
        return 'Inbox';
      case EmailFolder.starred:
        return 'Starred';
      case EmailFolder.snoozed:
        return 'Snoozed';
      case EmailFolder.important:
        return 'Important';
      case EmailFolder.sent:
        return 'Sent';
      case EmailFolder.scheduled:
        return 'Scheduled';
      case EmailFolder.draft:
        return 'Draft';
      case EmailFolder.spam:
        return 'Spam';
      case EmailFolder.trash:
        return 'Trash';
    }
  }

  IconData get icon {
    switch (this) {
      case EmailFolder.inbox:
        return Icons.inbox;
      case EmailFolder.starred:
        return Icons.star_outline;
      case EmailFolder.snoozed:
        return Icons.access_time;
      case EmailFolder.important:
        return Icons.label_important_outline;
      case EmailFolder.sent:
        return Icons.send_outlined;
      case EmailFolder.scheduled:
        return Icons.schedule_outlined;
      case EmailFolder.draft:
        return Icons.drafts_outlined;
      case EmailFolder.spam:
        return Icons.report_outlined;
      case EmailFolder.trash:
        return Icons.delete_outline;
    }
  }
}

enum EmailCategory { social, updates, forums, promotions }

extension EmailCategoryExtension on EmailCategory {
  String get label {
    switch (this) {
      case EmailCategory.social:
        return 'Social';
      case EmailCategory.updates:
        return 'Updates';
      case EmailCategory.forums:
        return 'Forums';
      case EmailCategory.promotions:
        return 'Promotions';
    }
  }

  IconData get icon {
    switch (this) {
      case EmailCategory.social:
        return Icons.people_outline;
      case EmailCategory.updates:
        return Icons.update;
      case EmailCategory.forums:
        return Icons.forum_outlined;
      case EmailCategory.promotions:
        return Icons.local_offer_outlined;
    }
  }
}

class Email {
  final String id;
  final String sender;
  final String senderName;
  final String subject;
  final List<String>? recipient;
  final String body;
  final DateTime timestamp;
  final bool isRead;
  EmailFolder? folder;
  final EmailCategory? category;
  final List<String>? cc;
  final List<String>? bcc;

  Email({
    required this.id,
    required this.sender,
    required this.senderName,
    required this.subject,
    this.recipient,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.folder = EmailFolder.inbox,
    this.category,
    this.cc,
    this.bcc,
  });
}

class EmailService {
  EmailService({List<Email>? emails}) : _emails = emails ?? [];

  final List<Email> _emails;

  List<Email> getAllEmails() => List.from(_emails);

  List<Email> search(String query) {
    return _emails.where((email) {
      final lowerQuery = query.toLowerCase();
      return email.sender.toLowerCase().contains(lowerQuery) ||
          email.subject.toLowerCase().contains(lowerQuery) ||
          email.body.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  List<Email> filterByFolder(EmailFolder folder) {
    return _emails.where((email) => email.folder == folder).toList();
  }

  List<Email> filterByCategory(EmailCategory category) {
    return _emails.where((email) => email.category == category).toList();
  }

  int countUnreadByFolder(EmailFolder folder) {
    return _emails
        .where((email) => email.folder == folder && email.isRead == false)
        .length;
  }

  int countUnreadByCategory(EmailCategory category) {
    return _emails
        .where((email) => email.category == category && email.isRead == false)
        .length;
  }
}

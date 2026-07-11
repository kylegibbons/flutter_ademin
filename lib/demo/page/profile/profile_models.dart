// Friend Suggestion model

import 'package:flutter/material.dart';

class Suggestion {
  final String name;
  final String role;
  final String imageUrl;

  Suggestion({required this.name, required this.role, required this.imageUrl});
}

// popular post model
class Post {
  final String title;
  final String imageUrl;
  final String date;

  Post({required this.title, required this.imageUrl, required this.date});
}

// user activity data model

class UserActivity {
  final String name;
  final String subtitle;
  final String time;
  final String description;
  final String avatarUrl;

  UserActivity({
    required this.name,
    required this.subtitle,
    required this.time,
    required this.description,
    required this.avatarUrl,
  });
}

// personal information data model

class InfoItem {
  final String label;
  final String value;

  const InfoItem({required this.label, required this.value});
}

// project data model

class Project {
  final String title;
  final String status;
  final String time;
  final List<String> members;
  final Color cardColor;

  Project({
    required this.title,
    required this.status,
    required this.time,
    required this.members,
    required this.cardColor,
  });
}

// data model for basic table

class DocumentData {
  final String fileName;
  final String fileType;
  final double fileSize; // in kB
  final DateTime uploadDate; // Stored as 'yyyy-MM-dd'

  DocumentData({
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.uploadDate,
  });
}

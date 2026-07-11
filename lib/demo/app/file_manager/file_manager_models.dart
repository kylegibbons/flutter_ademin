import 'package:flutter/material.dart';

// Storage model

class StorageCategory {
  final String title;
  final int fileCount;
  final double sizeGB;
  final double usagePercentage;
  final IconData icon;
  final Color color;

  StorageCategory({
    required this.title,
    required this.fileCount,
    required this.sizeGB,
    required this.usagePercentage,
    required this.icon,
    required this.color,
  });
}

// Folder model
class FolderModel {
  final String name;
  final int fileCount;
  final double sizeGB;

  FolderModel({
    required this.name,
    required this.fileCount,
    required this.sizeGB,
  });
}

// File model
class FileModel {
  final String name;
  final String category;
  final String size;
  final String dateModified;
  final IconData icon;

  FileModel({
    required this.name,
    required this.category,
    required this.size,
    required this.dateModified,
    required this.icon,
  });
}

// Model sederhana untuk file yang akan diupload
class UploadTask {
  final String fileName;
  final String size;
  double progress; // 0.0 sampai 1.0
  bool isComplete;

  UploadTask({
    required this.fileName,
    required this.size,
    this.progress = 0.0,
    this.isComplete = false,
  });
}

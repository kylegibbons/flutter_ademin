import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class MockData {
  // Data for All Media & Chart
  static List<StorageCategory> categories = [
    StorageCategory(
      title: 'Downloads',
      fileCount: 345,
      sizeGB: 26.40,
      usagePercentage: 16,
      icon: Icons.file_download_outlined,
      color: Colors.deepPurpleAccent,
    ),
    StorageCategory(
      title: 'Apps',
      fileCount: 130,
      sizeGB: 14.40,
      usagePercentage: 46,
      icon: Icons.grid_view_rounded,
      color: kSecondaryColor,
    ),
    StorageCategory(
      title: 'Docs',
      fileCount: 345,
      sizeGB: 67.30,
      usagePercentage: 18,
      icon: Icons.description_outlined,
      color: kWarningColor,
    ),
    StorageCategory(
      title: 'Media',
      fileCount: 712,
      sizeGB: 34.40,
      usagePercentage: 17,
      icon: Icons.image_outlined,
      color: kSuccessColor,
    ),

    StorageCategory(
      title: 'Audio',
      fileCount: 241,
      sizeGB: 21.80,
      usagePercentage: 17,
      icon: Icons.music_note,
      color: kInfoColor,
    ),

    StorageCategory(
      title: 'Videos',
      fileCount: 281,
      sizeGB: 29.10,
      usagePercentage: 17,
      icon: Icons.play_arrow_outlined,
      color: kErrorColor,
    ),
  ];

  // Data for Recent Files
  static List<FileModel> recentFiles = [
    FileModel(
      name: 'Video_947954_pisah_sambut_oyabun.mp4',
      category: 'Video',
      size: '89 MB',
      dateModified: '12 Jan, 2027',
      icon: Icons.video_library_outlined,
    ),
    FileModel(
      name: 'Travel-to-lampung-way-kambas.jpeg',
      category: 'Image',
      size: '5 MB',
      dateModified: '19 Feb, 2027',
      icon: Icons.image_outlined,
    ),
    FileModel(
      name: 'Document_proposal_x1.pdf',
      category: 'Document',
      size: '10 MB',
      dateModified: '15 Mar, 2027',
      icon: Icons.picture_as_pdf_outlined,
    ),
    FileModel(
      name: 'Mountain_deew.png',
      category: 'Image',
      size: '8 MB',
      dateModified: '20 May, 2027',
      icon: Icons.image_outlined,
    ),
    FileModel(
      name: 'Work_Report_Ali_fix_final.docx',
      category: 'Document',
      size: '2.4 MB',
      dateModified: '05 Jun, 2027',
      icon: Icons.description_outlined,
    ),
    FileModel(
      name: 'Holiday_Vlog_Company.mp4',
      category: 'Video',
      size: '256 MB',
      dateModified: '12 Jul, 2027',
      icon: Icons.movie_outlined,
    ),
    FileModel(
      name: 'Budget_2027_approved_final.xlsx',
      category: 'Spreadsheet',
      size: '1.2 MB',
      dateModified: '25 Aug, 2027',
      icon: Icons.table_chart_outlined,
    ),
    FileModel(
      name: 'Profile_Picture_linkedin.jpg',
      category: 'Image',
      size: '3.1 MB',
      dateModified: '10 Sep, 2027',
      icon: Icons.portrait_outlined,
    ),
    FileModel(
      name: 'Presentation_Final.pptx',
      category: 'Document',
      size: '15 MB',
      dateModified: '02 Oct, 2027',
      icon: Icons.slideshow_outlined,
    ),
    FileModel(
      name: 'Design_System_flutkit.fig',
      category: 'Design',
      size: '42 MB',
      dateModified: '15 Nov, 2027',
      icon: Icons.palette_outlined,
    ),
    FileModel(
      name: 'Song_Demo_future_rock_king.mp3',
      category: 'Audio',
      size: '6.5 MB',
      dateModified: '20 Dec, 2027',
      icon: Icons.audiotrack_outlined,
    ),
    FileModel(
      name: 'Project_12_Backup.zip',
      category: 'Archive',
      size: '1.2 GB',
      dateModified: '30 Dec, 2027',
      icon: Icons.archive_outlined,
    ),
  ];

  //  folder details
  static List<FolderModel> folders = [
    FolderModel(name: "Image", fileCount: 145, sizeGB: 18.70),
    FolderModel(name: "Documents", fileCount: 130, sizeGB: 19.13),
    FolderModel(name: "Recordings", fileCount: 110, sizeGB: 26.40),
    FolderModel(name: "Downloads", fileCount: 345, sizeGB: 35.50),
    FolderModel(name: "Projects", fileCount: 176, sizeGB: 75.50),
    FolderModel(name: "Users", fileCount: 145, sizeGB: 105.50),
  ];
}

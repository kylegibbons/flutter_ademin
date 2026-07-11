import 'package:flutter_ademin/demo/page/profile/profile_models.dart';
import 'package:flutter_ademin/theme/themes.dart';

// tech stacks data

final List<Map<String, dynamic>> techStacks = [
  {'label': 'Flutter', 'progress': 0.9},
  {'label': 'Firebase', 'progress': 0.6},
  {'label': 'Dart', 'progress': 0.85},
  {'label': 'REST API', 'progress': 0.65},
  {'label': 'GraphQL', 'progress': 0.45},
];

// Friend Suggestion data

final List<Suggestion> suggestions = [
  Suggestion(
    name: 'John Doe',
    role: 'Frontend Developer',
    imageUrl: 'assets/images/avatar_3.jpg',
  ),
  Suggestion(
    name: 'Jane Smith',
    role: 'UI/UX Designer',
    imageUrl: 'assets/images/avatar_4.jpg',
  ),
  Suggestion(
    name: 'Alice Johnson',
    role: 'Backend Developer',
    imageUrl: 'assets/images/avatar_5.jpg',
  ),
];

// popular post mockup
final List<Post> popularPosts = [
  Post(
    title:
        'Beyond the Buzzwords: Demystifying the Latest Trends in Artificial Intelligence',
    imageUrl: 'assets/images/bg_2.jpg',
    date: '15 Feb 2025',
  ),
  Post(
    title:
        'Cybersecurity in the Hybrid Workplace: Essential Strategies for Protecting Your Data',
    imageUrl: 'assets/images/bg_4.jpg',
    date: '21 Jan 2025',
  ),
  Post(
    title:
        'The Rise of Low-Code/No-Code Platforms: Empowering Citizen Developers in the Digital Transformation Era',
    imageUrl: 'assets/images/bg_6.jpg',
    date: '24 Nov 2024',
  ),
];

// user activities data mockup

final activities = [
  UserActivity(
    name: 'Lewis Arnold',
    subtitle: 'Create new project building product',
    time: '10:05AM',
    description:
        'Every team project can have a velzon. Use the velzon to share information with your team to understand and contribute to your project.',
    avatarUrl: 'assets/images/avatar_2.jpg',
  ),
  UserActivity(
    name: 'Nancy Martino',
    subtitle: 'Commented on project brief',
    time: '12:57PM',
    description:
        'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.',
    avatarUrl: 'assets/images/avatar_4.jpg',
  ),
  UserActivity(
    name: 'Erica245',
    subtitle: 'Submitted a ticket',
    time: '02:33PM',
    description:
        'Please review the issue with the upload feature. It seems to be broken after the latest update.',
    avatarUrl: 'assets/images/avatar_6.jpg',
  ),
  UserActivity(
    name: 'Megan Elmore',
    subtitle: 'Adding a new event with attachments',
    time: '04:45PM',
    description:
        'Uploaded "UI/UX design template" and "Bank Management System - PSD" to shared project resources.',
    avatarUrl: 'assets/images/avatar_8.jpg',
  ),
  UserActivity(
    name: 'Jacqueline Steve',
    subtitle: 'Changed 2 attributes',
    time: '05:16PM',
    description:
        'In an awareness campaign, it is vital for people to begin to recognize your cause. Spacing and clarity in design helps people engage better.',
    avatarUrl: 'assets/images/avatar_10.jpg',
  ),
  UserActivity(
    name: 'Lewis Arnold',
    subtitle: 'Create new project building product',
    time: '10:05AM',
    description:
        'Every team project can have a velzon. Use the velzon to share information with your team to understand and contribute to your project.',
    avatarUrl: 'assets/images/avatar_2.jpg',
  ),
  UserActivity(
    name: 'Nancy Martino',
    subtitle: 'Commented on project brief',
    time: '12:57PM',
    description:
        'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.',
    avatarUrl: 'assets/images/avatar_4.jpg',
  ),
  UserActivity(
    name: 'Erica245',
    subtitle: 'Submitted a ticket',
    time: '02:33PM',
    description:
        'Please review the issue with the upload feature. It seems to be broken after the latest update.',
    avatarUrl: 'assets/images/avatar_6.jpg',
  ),
  UserActivity(
    name: 'Megan Elmore',
    subtitle: 'Adding a new event with attachments',
    time: '04:45PM',
    description:
        'Uploaded "UI/UX design template" and "Bank Management System - PSD" to shared project resources.',
    avatarUrl: 'assets/images/avatar_8.jpg',
  ),
  UserActivity(
    name: 'Jacqueline Steve',
    subtitle: 'Changed 2 attributes',
    time: '05:16PM',
    description:
        'In an awareness campaign, it is vital for people to begin to recognize your cause. Spacing and clarity in design helps people engage better.',
    avatarUrl: 'assets/images/avatar_10.jpg',
  ),
];

// personal information data mockup

final List<InfoItem> userInfoData = [
  InfoItem(label: 'Full Name:', value: 'Umar Hamzah'),
  InfoItem(label: 'Email:', value: 'umar@example.com'),
  InfoItem(label: 'Phone:', value: '+62 812-3456-7890'),
  InfoItem(label: 'Location:', value: 'Jakarta, Indonesia'),
  InfoItem(label: 'Joining Date:', value: '24 Januari 2020'),
];

// projects data mockup

final List<Project> projects = [
  Project(
    title: 'Brand logo Design of Ademin',
    status: 'In progress',
    time: '2 hr Ago',
    members: ['assets/images/avatar_2.jpg'],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'UI/UX Design of Viona Design System',
    status: 'Completed',
    time: '7 hr Ago',
    members: ['assets/images/avatar_1.jpg', 'assets/images/avatar_3.jpg'],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'AI Chat App Firebase',
    status: 'In progress',
    time: '1 hr Ago',
    members: [
      'assets/images/avatar_4.jpg',
      'assets/images/avatar_6.jpg',
      'assets/images/avatar_5.jpg',
    ],
    cardColor: kErrorColor,
  ),
  Project(
    title: 'Car Towing App Redesign',
    status: 'Completed',
    time: '4 hr Ago',
    members: ['assets/images/avatar_6.jpg', 'assets/images/avatar_7.jpg'],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'Flutter Fitness App',
    status: 'In progress',
    time: '9 hr Ago',
    members: ['assets/images/avatar_10.jpg', 'assets/images/avatar_9.jpg'],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'Recipe Sharing App',
    status: 'Completed',
    time: '2 days Ago',
    members: [
      'assets/images/avatar_10.jpg',
      'assets/images/avatar_8.jpg',
      'assets/images/avatar_5.jpg',
      'assets/images/avatar_2.jpg',
    ],
    cardColor: kWarningColor,
  ),
  Project(
    title: 'Travel Planner',
    status: 'Pending',
    time: '1 week Ago',
    members: ['assets/images/avatar_5.jpg'],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'E-commerce Redesign',
    status: 'In progress',
    time: '3 hr Ago',
    members: [
      'assets/images/avatar_1.jpg',
      'assets/images/avatar_5.jpg',
      'assets/images/avatar_6.jpg',
    ],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'Task Management System',
    status: 'delayed',
    time: '1 day Ago',
    members: [
      'assets/images/avatar_2.jpg',
      'assets/images/avatar_4.jpg',
      'assets/images/avatar_8.jpg',
    ],
    cardColor: kSuccessColor,
  ),
  Project(
    title: 'Music Streaming App',
    status: 'Completed',
    time: '5 hr Ago',
    members: ['assets/images/avatar_8.jpg'],
    cardColor: kErrorColor,
  ),
  Project(
    title: 'Blog Platform',
    status: 'Completed',
    time: '3 days Ago',
    members: ['assets/images/avatar_9.jpg', 'assets/images/avatar_1.jpg'],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'Social Media App',
    status: 'In progress',
    time: '11 hr Ago',
    members: [
      'assets/images/avatar_8.jpg',
      'assets/images/avatar_5.jpg',
      'assets/images/avatar_2.jpg',
    ],
    cardColor: kSecondaryColor,
  ),
  Project(
    title: 'Finance Tracker',
    status: 'Delayed',
    time: '2 weeks Ago',
    members: ['assets/images/avatar_2.jpg', 'assets/images/avatar_7.jpg'],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'Online Education Platform',
    status: 'In Progress',
    time: '7 hr Ago',
    members: ['assets/images/avatar_4.jpg'],
    cardColor: kSuccessColor,
  ),
  Project(
    title: 'Podcast App',
    status: 'Testing',
    time: '1 day Ago',
    members: ['assets/images/avatar_3.jpg', 'assets/images/avatar_10.jpg'],
    cardColor: kWarningColor,
  ),
  Project(
    title: 'Book Review App',
    status: 'Completed',
    time: '4 days Ago',
    members: [
      'assets/images/avatar_7.jpg',
      'assets/images/avatar_5.jpg',
      'assets/images/avatar_9.jpg',
      'assets/images/avatar_11.jpg',
    ],
    cardColor: kErrorColor,
  ),
  Project(
    title: 'Event Management App',
    status: 'In progress',
    time: '6 hr Ago',
    members: [
      'assets/images/avatar_1.jpg',
      'assets/images/avatar_11.jpg',
      'assets/images/avatar_4.jpg',
      'assets/images/avatar_7.jpg',
    ],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'Job Board App',
    status: 'Pending',
    time: '10 days Ago',
    members: ['assets/images/avatar_2.jpg', 'assets/images/avatar_5.jpg'],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'Real Estate App',
    status: 'Delayed',
    time: '8 hr Ago',
    members: [
      'assets/images/avatar_9.jpg',
      'assets/images/avatar_8.jpg',
      'assets/images/avatar_7.jpg',
      'assets/images/avatar_6.jpg',
    ],
    cardColor: kInfoColor,
  ),
  Project(
    title: 'Language Learning App',
    status: 'In Progress',
    time: '2 days Ago',
    members: ['assets/images/avatar_3.jpg'],
    cardColor: kSuccessColor,
  ),
  Project(
    title: 'Personal Portfolio Website',
    status: 'Completed',
    time: '1 week Ago',
    members: [
      'assets/images/avatar_9.jpg',
      'assets/images/avatar_8.jpg',
      'assets/images/avatar_6.jpg',
    ],
    cardColor: kSecondaryColor,
  ),
  Project(
    title: 'Grocery Delivery App',
    status: 'In progress',
    time: '4 hr Ago',
    members: ['assets/images/avatar_7.jpg', 'assets/images/avatar_6.jpg'],
    cardColor: kPrimaryColor,
  ),
  Project(
    title: 'Mental Wellness App',
    status: 'Completed',
    time: '3 weeks Ago',
    members: ['assets/images/avatar_8.jpg', 'assets/images/avatar_7.jpg'],
    cardColor: kErrorColor,
  ),
  Project(
    title: 'Car Rental App',
    status: 'In Progress',
    time: '9 hr Ago',
    members: [
      'assets/images/avatar_1.jpg',
      'assets/images/avatar_2.jpg',
      'assets/images/avatar_7.jpg',
      'assets/images/avatar_6.jpg',
    ],
    cardColor: kSuccessColor,
  ),
  Project(
    title: 'Plant Care App',
    status: 'Testing',
    time: '1 day Ago',
    members: [
      'assets/images/avatar_1.jpg',
      'assets/images/avatar_4.jpg',
      'assets/images/avatar_9.jpg',
      'assets/images/avatar_2.jpg',
    ],
    cardColor: kWarningColor,
  ),
];

// data mockup

final List<DocumentData> documents = [
  DocumentData(
    fileName: 'How to build a website with Flutter Vibe Codding',
    fileType: 'pdf',
    fileSize: 3000.0,
    uploadDate: DateTime(2025, 4, 20),
  ),
  DocumentData(
    fileName: 'Flutter State Management Guide',
    fileType: 'docx',
    fileSize: 1500.0,
    uploadDate: DateTime(2025, 3, 14),
  ),
  DocumentData(
    fileName: 'API Documentation for Flutter E-Commerce App',
    fileType: 'xslx',
    fileSize: 7800.0,
    uploadDate: DateTime(2025, 1, 28),
  ),
  DocumentData(
    fileName: 'Firebase Integration for Flutter Apps',
    fileType: 'pptx',
    fileSize: 2200.0,
    uploadDate: DateTime(2025, 4, 10),
  ),
  DocumentData(
    fileName: 'Mastering Dart Collections',
    fileType: 'pdf',
    fileSize: 1150.5,
    uploadDate: DateTime(2025, 2, 5),
  ),
  DocumentData(
    fileName: 'Responsive Layouts in Flutter',
    fileType: 'zip',
    fileSize: 98000.0,
    uploadDate: DateTime(2024, 12, 19),
  ),
  DocumentData(
    fileName: 'Flutter Clean Architecture',
    fileType: 'docx',
    fileSize: 1320.0,
    uploadDate: DateTime(2025, 3, 2),
  ),
  DocumentData(
    fileName: 'Working with REST APIs in Flutter',
    fileType: 'xslx',
    fileSize: 2100.0,
    uploadDate: DateTime(2025, 4, 5),
  ),
  DocumentData(
    fileName: 'Animations and Motion in Flutter',
    fileType: 'pptx',
    fileSize: 1950.0,
    uploadDate: DateTime(2025, 1, 10),
  ),
  DocumentData(
    fileName: 'Flutter UI Kit: E-commerce Template',
    fileType: 'zip',
    fileSize: 5400.0,
    uploadDate: DateTime(2025, 4, 21),
  ),
  DocumentData(
    fileName: 'Getting Started with Riverpod',
    fileType: 'pdf',
    fileSize: 890.0,
    uploadDate: DateTime(2025, 3, 29),
  ),
];

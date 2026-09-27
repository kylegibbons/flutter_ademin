// 2. Mockup Data
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:material_symbols_icons/symbols.dart';

List<TicketOverview> mockTicketOverviewData = [
  TicketOverview(
    title: 'Total Tickets',
    value: 233120,
    changes: 12.7,
    icon: Symbols.call,
    iconBackgroundColor: kInfoColor.withValues(alpha: 0.2),
    iconColor: kInfoColor,
  ),
  TicketOverview(
    title: 'Pending Tickets',
    value: 678148,
    changes: -15.7,
    icon: Symbols.access_time,
    iconBackgroundColor: kWarningColor.withValues(alpha: 0.2),
    iconColor: kWarningColor,
  ),
  TicketOverview(
    title: 'Closed Tickets',
    value: 124185,
    changes: -16.7,
    icon: Symbols.close,
    iconBackgroundColor: kSuccessColor.withValues(alpha: 0.2),
    iconColor: kSuccessColor,
  ),
  TicketOverview(
    title: 'Deleted Tickets',
    value: 97435,
    changes: 13.4,
    icon: Symbols.delete_outline,
    iconBackgroundColor: kErrorColor.withValues(alpha: 0.2),
    iconColor: kErrorColor,
  ),
];

final Map<String, UserInfo> userMap = {
  'U001': UserInfo(
    userId: 'U001',
    name: 'Moro Amm',
    avatarUrl: 'assets/images/avatar_1.jpg',
  ),
  'U002': UserInfo(
    userId: 'U002',
    name: 'Devon White',
    avatarUrl: 'assets/images/avatar_2.jpg',
  ),
  'U003': UserInfo(
    userId: 'U003',
    name: 'Rocky Johnson',
    avatarUrl: 'assets/images/avatar_3.jpg',
  ),
  'U004': UserInfo(
    userId: 'U004',
    name: 'Alice Smith',
    avatarUrl: 'assets/images/avatar_4.jpg',
  ),
  'U005': UserInfo(
    userId: 'U005',
    name: 'Michael Chen',
    avatarUrl: 'assets/images/avatar_5.jpg',
  ),
  'U006': UserInfo(
    userId: 'U006',
    name: 'Sarah Williams',
    avatarUrl: 'assets/images/avatar_6.jpg',
  ),
  'U007': UserInfo(
    userId: 'U007',
    name: 'John Doe',
    avatarUrl: 'assets/images/avatar_7.jpg',
  ),
  'U008': UserInfo(
    userId: 'U008',
    name: 'Emily Brown',
    avatarUrl: 'assets/images/avatar_8.jpg',
  ),
  'U009': UserInfo(
    userId: 'U009',
    name: 'David Kim',
    avatarUrl: 'assets/images/avatar_9.jpg',
  ),
  'U010': UserInfo(
    userId: 'U010',
    name: 'Olivia Garcia',
    avatarUrl: 'assets/images/avatar_10.jpg',
  ),
  'U011': UserInfo(
    userId: 'U011',
    name: 'Dumia Olf',
    avatarUrl: 'assets/images/avatar_11.jpg',
  ),
};

// tickets data mockup

final List<TicketData> mockTickets = [
  TicketData(
    id: 'TKT-001',
    title: 'Website redesign for e-commerce platform',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [
      userMap['U002']!,
      userMap['U003']!,
      userMap['U004']!,
      userMap['U005']!,
      userMap['U006']!,
    ], // Devon White, Rocky Johnson
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 15),
    dueDate: DateTime(2025, 7, 30),
  ),
  TicketData(
    id: 'TKT-002',
    title: 'Bug: Login issue on mobile app for Android 14',
    client: userMap['U003']!, // Rocky Johnson
    assignedTo: [
      userMap['U002']!,
      userMap['U004']!,
      userMap['U005']!,
      userMap['U006']!,
    ], // Devon White
    status: TicketStatus.newTicket,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 10, 9, 0), // Recent
    dueDate: DateTime(2025, 7, 14),
  ),
  TicketData(
    id: 'TKT-003',
    title: 'Feature Request: Dark mode implementation',
    client: userMap['U004']!, // Alice Smith
    assignedTo: [userMap['U005']!, userMap['U007']!], // Michael Chen, John Doe
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 6, 20),
    dueDate: DateTime(2025, 8, 15),
  ),
  TicketData(
    id: 'TKT-004',
    title: 'Database migration to cloud provider',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [userMap['U009']!, userMap['U005']!], // David Kim, Michael Chen
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 1),
    dueDate: DateTime(2025, 7, 25),
  ),
  TicketData(
    id: 'TKT-005',
    title: 'Content update for About Us page',
    client: userMap['U006']!, // Sarah Williams
    assignedTo: [userMap['U010']!], // Olivia Garcia
    status: TicketStatus.closed,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 5, 20),
    dueDate: DateTime(2025, 6, 10),
  ),
  TicketData(
    id: 'TKT-006',
    title: 'Payment gateway integration for new region',
    client: userMap['U007']!, // John Doe
    assignedTo: [userMap['U002']!, userMap['U009']!], // Devon White, David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 5),
    dueDate: DateTime(2025, 8, 1),
  ),
  TicketData(
    id: 'TKT-007',
    title: 'User onboarding flow optimization',
    client: userMap['U008']!, // Emily Brown
    assignedTo: [userMap['U004']!, userMap['U002']!], // Alice Smith
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 2),
    dueDate: DateTime(2025, 7, 28),
  ),
  TicketData(
    id: 'TKT-008',
    title: 'Security audit for user authentication module',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [userMap['U005']!], // Michael Chen
    status: TicketStatus.newTicket,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 11, 7, 0), // Today
    dueDate: DateTime(2025, 7, 20),
  ),
  TicketData(
    id: 'TKT-009',
    title: 'Performance bottleneck in reporting module',
    client: userMap['U003']!, // Rocky Johnson
    assignedTo: [userMap['U009']!], // David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 25),
    dueDate: DateTime(2025, 7, 15),
  ),
  TicketData(
    id: 'TKT-010',
    title: 'Update terms of service and privacy policy',
    client: userMap['U006']!, // Sarah Williams
    assignedTo: [userMap['U010']!], // Olivia Garcia
    status: TicketStatus.closed,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 6, 1),
    dueDate: DateTime(2025, 6, 20),
  ),
  TicketData(
    id: 'TKT-011',
    title: 'Bug: Incorrect calculation on checkout page',
    client: userMap['U004']!, // Alice Smith
    assignedTo: [userMap['U002']!, userMap['U007']!], // Devon White, John Doe
    status: TicketStatus.open,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 8),
    dueDate: DateTime(2025, 7, 18),
  ),
  TicketData(
    id: 'TKT-012',
    title: 'Integrate new analytics dashboard',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [userMap['U005']!, userMap['U009']!], // Michael Chen, David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 6, 28),
    dueDate: DateTime(2025, 8, 5),
  ),
  TicketData(
    id: 'TKT-013',
    title: 'Accessibility improvements for main navigation',
    client: userMap['U008']!, // Emily Brown
    assignedTo: [userMap['U004']!, userMap['U002']!], // Alice Smith
    status: TicketStatus.newTicket,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 10, 10, 0),
    dueDate: DateTime(2025, 8, 20),
  ),
  TicketData(
    id: 'TKT-014',
    title: 'Refactor user profile management module',
    client: userMap['U003']!, // Rocky Johnson
    assignedTo: [userMap['U005']!, userMap['U007']!], // Michael Chen, John Doe
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 18),
    dueDate: DateTime(2025, 7, 12),
  ),
  TicketData(
    id: 'TKT-015',
    title: 'Implement email verification during registration',
    client: userMap['U006']!, // Sarah Williams
    assignedTo: [
      userMap['U002']!,
      userMap['U009']!,
      userMap['U008']!,
      userMap['U007']!,
    ], // Devon White
    status: TicketStatus.closed,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 5, 15),
    dueDate: DateTime(2025, 6, 5),
  ),
  TicketData(
    id: 'TKT-016',
    title: 'Add new language support (Spanish)',
    client: userMap['U004']!, // Alice Smith
    assignedTo: [userMap['U010']!], // Olivia Garcia
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 7),
    dueDate: DateTime(2025, 8, 10),
  ),
  TicketData(
    id: 'TKT-017',
    title: 'Troubleshoot image upload failures',
    client: userMap['U007']!, // John Doe
    assignedTo: [userMap['U003']!], // Rocky Johnson
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 9, 14, 0),
    dueDate: DateTime(2025, 7, 16),
  ),
  TicketData(
    id: 'TKT-018',
    title: 'UI/UX review of search results page',
    client: userMap['U008']!, // Emily Brown
    assignedTo: [userMap['U004']!], // Alice Smith
    status: TicketStatus.newTicket,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 7, 11, 9, 30), // Today
    dueDate: DateTime(2025, 8, 5),
  ),
  TicketData(
    id: 'TKT-019',
    title: 'Server capacity planning and scaling',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [userMap['U009']!, userMap['U005']!], // David Kim, Michael Chen
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 10),
    dueDate: DateTime(2025, 7, 20),
  ),
  TicketData(
    id: 'TKT-020',
    title: 'Review and update knowledge base articles',
    client: userMap['U006']!, // Sarah Williams
    assignedTo: [userMap['U010']!], // Olivia Garcia
    status: TicketStatus.closed,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 5, 2),
    dueDate: DateTime(2025, 5, 25),
  ),
  TicketData(
    id: 'TKT-021',
    title: 'Feature Request: Implement user referral system',
    client: userMap['U004']!, // Alice Smith
    assignedTo: [userMap['U007']!, userMap['U002']!], // John Doe, Devon White
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 10, 11, 0),
    dueDate: DateTime(2025, 8, 25),
  ),
  TicketData(
    id: 'TKT-022',
    title: 'Bug: Broken link on contact us page',
    client: userMap['U003']!, // Rocky Johnson
    assignedTo: [userMap['U002']!], // Devon White
    status: TicketStatus.newTicket,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 7, 11, 6, 0), // Today
    dueDate: DateTime(2025, 7, 14),
  ),
  TicketData(
    id: 'TKT-023',
    title: 'Develop new API for external partners',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [
      userMap['U005']!,
      userMap['U009']!,
      userMap['U010']!,
    ], // Michael Chen, David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 1),
    dueDate: DateTime(2025, 8, 30),
  ),
  TicketData(
    id: 'TKT-024',
    title: 'A/B test different CTA buttons on homepage',
    client: userMap['U008']!, // Emily Brown
    assignedTo: [
      userMap['U004']!,
      userMap['U010']!,
    ], // Alice Smith, Olivia Garcia
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 5),
    dueDate: DateTime(2025, 7, 29),
  ),
  TicketData(
    id: 'TKT-025',
    title: 'Setup monitoring alerts for critical services',
    client: userMap['U007']!, // John Doe
    assignedTo: [userMap['U009']!], // David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 6, 22),
    dueDate: DateTime(2025, 7, 18),
  ),
  TicketData(
    id: 'TKT-026',
    title: 'Integrate live chat support widget',
    client: userMap['U006']!, // Sarah Williams
    assignedTo: [
      userMap['U002']!,
      userMap['U010']!,
    ], // Devon White, Olivia Garcia
    status: TicketStatus.newTicket,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 11, 8, 0), // Today
    dueDate: DateTime(2025, 8, 15),
  ),
  TicketData(
    id: 'TKT-027',
    title: 'SEO optimization for product pages',
    client: userMap['U004']!, // Alice Smith
    assignedTo: [userMap['U003']!], // Rocky Johnson
    status: TicketStatus.closed,
    priority: TicketPriority.low,
    createdDate: DateTime(2025, 5, 10),
    dueDate: DateTime(2025, 6, 1),
  ),
  TicketData(
    id: 'TKT-028',
    title: 'Review and optimize database indices',
    client: userMap['U001']!, // Moro Amm
    assignedTo: [userMap['U005']!, userMap['U009']!], // Michael Chen, David Kim
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 3),
    dueDate: DateTime(2025, 7, 17),
  ),
  TicketData(
    id: 'TKT-029',
    title: 'Bug: Incorrect currency display on some devices',
    client: userMap['U003']!, // Rocky Johnson
    assignedTo: [userMap['U002']!], // Devon White
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    createdDate: DateTime(2025, 7, 9, 16, 0),
    dueDate: DateTime(2025, 7, 24),
  ),
  TicketData(
    id: 'TKT-030',
    title: 'Feature Request: Add multi-factor authentication',
    client: userMap['U007']!, // John Doe
    assignedTo: [userMap['U005']!, userMap['U007']!], // Michael Chen, John Doe
    status: TicketStatus.newTicket,
    priority: TicketPriority.high,
    createdDate: DateTime(2025, 7, 11, 7, 15), // Today
    dueDate: DateTime(2025, 9, 1),
  ),
];

// mockup data

final dummyTicketDetail = TicketDetail(
  id: 'TKT-1001',
  subject: 'App crashes on login',
  description: """
**PROBLEM DESCRIPTION**

Users are reporting a critical issue where the mobile application crashes immediately after they enter their login credentials (**username** and **password**) and attempt to log in.

This issue seems to be widespread and is preventing a significant number of users from accessing the app.

**OBSERVED BEHAVIOR**
1. User opens the mobile application.
2. User navigates to the login screen.
3. User inputs valid email/username and password.
4. User taps the **"Login"** button.
5. The app freezes for a brief moment *(less than 1 second)*, then closes abruptly without any error message displayed to the user.
6. The app does not generate a crash report within the app itself, but Android system crash logs might be present.

**AFFECTED USERS / DEVICES**

Initial reports indicate this is primarily affecting Android users.

We've received multiple reports from users on various Android devices:

- Samsung Galaxy S23
- Google Pixel 7
- Xiaomi Redmi Note 12

Running:

- Android 13
- Android 14

**STEPS TO REPRODUCE**

1. Install the latest version of the app (**v2.3.1**) from the Google Play Store on an Android device.
2. Open the app and navigate to the login screen.
3. Enter valid login credentials for an existing user account.
4. Tap the **"Login"** button.

**EXPECTED BEHAVIOR**

Upon tapping the **"Login"** button, the user should be successfully authenticated and redirected to the application's main dashboard.

**IMPACT**
**High**

This is a critical bug preventing users from accessing core functionalities, leading to significant user frustration and potential loss of engagement.

Business operations relying on user login are currently halted for affected users.

**URGENCY**

This issue needs to be prioritized and resolved as soon as possible.
""",
  status: TicketStatus.newTicket,
  createdAt: DateTime.now().subtract(const Duration(days: 2)),
  updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
  priority: 'High',
  category: 'Bug',
  client: userMap['U003']!,
  assignedTo: [userMap['U002']!, userMap['U001']!],
  project: ProjectInfo(id: 'PRJ-001', name: 'Flutter App v3.0'),
  labels: ['#urgent', '#login', '#crash'],
  comments: [
    TicketComment(
      id: 'CMT-001',
      userId: 'U003', // Client: Rocky Johnson
      message:
          'Still crashing even after restarting my phone. Tried clearing cache as well, no luck.',
      timestamp: DateTime(2025, 7, 9, 10, 15), // Yesterday morning
      replies: [
        TicketComment(
          id: 'CMT-002',
          userId: 'U002', // CS: Devon White
          message:
              'Thank you for the update, Mr./Ms. Rocky. We have received your report and are investigating this issue further. Please bear with us while our team works on it.',
          timestamp: DateTime(2025, 7, 9, 10, 45), // 30 minutes after
        ),
        TicketComment(
          id: 'CMT-003',
          userId: 'U002', // CS: Devon White
          message:
              'Could you also provide your exact device model and operating system version? This information would be very helpful for our technical team in diagnosing the issue.',
          timestamp: DateTime(2025, 7, 9, 11, 0), // 15 minutes after
        ),
        TicketComment(
          id: 'CMT-004',
          userId: 'U003', // Client: Rocky Johnson
          message:
              'My phone is a Samsung Galaxy S23, running Android 14. The build number is SP1A.210812.016.',
          timestamp: DateTime(2025, 7, 9, 13, 20), // Yesterday afternoon
        ),
        TicketComment(
          id: 'CMT-005',
          userId: 'U001', // CS Lead / Dev Team: Moro Amm (Escalation)
          message:
              'Thank you Mr./Ms. Rocky for the device details. We have escalated this information to our development team who are currently analyzing the crash logs. We will provide an update as soon as there is progress.',
          timestamp: DateTime(2025, 7, 10, 8, 0), // This morning (WIB)
        ),
      ],
    ),
    TicketComment(
      id: 'CMT-006',
      userId: 'U003', // Client: Rocky Johnson
      message:
          'Is there any temporary workaround for this login issue? I urgently need to access my account.',
      timestamp: DateTime(2025, 7, 9, 15, 0), // Yesterday afternoon
      replies: [
        TicketComment(
          id: 'CMT-007',
          userId: 'U002', // CS: Devon White
          message:
              'Currently, there is no known workaround for the mobile app crash. However, as an alternative, you can try accessing your account via our web application in your browser. Would that be able to help you temporarily?',
          timestamp: DateTime(2025, 7, 9, 15, 45), // Yesterday afternoon
        ),
        TicketComment(
          id: 'CMT-008',
          userId: 'U003', // Client: Rocky Johnson
          message:
              'Okay, I will try to access it via the web. Thank you for the suggestion.',
          timestamp: DateTime(2025, 7, 9, 16, 0), // Yesterday afternoon
        ),
        TicketComment(
          id: 'CMT-009',
          userId:
              'U001', // CS Lead / Dev Team: Moro Amm (Responding to general query)
          message:
              'We understand your urgency. Our team is working diligently to release a fix as soon as possible. We will provide an updated timeline for resolution as soon as it becomes available.',
          timestamp: DateTime(2025, 7, 10, 8, 30), // This morning (WIB)
        ),
      ],
    ),
    TicketComment(
      id: 'CMT-010',
      userId: 'U003', // Client: Rocky Johnson
      message:
          'The app still cannot be opened at all. Do you have an estimate of when this issue can be resolved?',
      timestamp: DateTime(2025, 7, 10, 8, 10), // This morning
      replies: [
        TicketComment(
          id: 'CMT-011',
          userId: 'U002', // CS: Devon White
          message:
              'Good morning, Mr./Ms. Rocky. Our development team is still working to resolve this issue. We will provide another update in the next few hours. We apologize for the inconvenience.',
          timestamp: DateTime(2025, 7, 10, 8, 45), // This morning
        ),
      ],
    ),
    TicketComment(
      id: 'CMT-012',
      userId:
          'U001', // CS Lead / Dev Team (Internal update, visible to client if app flow allows)
      message:
          'Internal update: Dev team has identified the root cause related to token authentication. Hotfix is undergoing testing. Target release this afternoon.',
      timestamp: DateTime(
        2025,
        7,
        10,
        9,
        0,
      ), // This morning (this could be an internal update visible to the client or not, depending on UI design)
      replies: [
        TicketComment(
          id: 'CMT-013',
          userId: 'U002', // CS: Devon White
          message:
              'Mr./Ms. Rocky, we have good news! Our technical team has identified the issue and is preparing a fix. We are targeting to release the fix this afternoon. We will notify you once the fix is available.',
          timestamp: DateTime(
            2025,
            7,
            10,
            9,
            15,
          ), // This morning, CS informs client
        ),
      ],
    ),
  ],
  attachments: [
    TicketAttachment(
      id: 'ATT-001',
      fileName: 'screenshot_login_error.png',
      fileUrl: 'https://example.com/uploads/screenshot_login_error.png',
      uploadedAt: DateTime.now().subtract(const Duration(days: 1)), // Yesterday
      fileSize: 3.4,
    ),
    TicketAttachment(
      id: 'ATT-002',
      fileName: 'device_logs.txt',
      fileUrl: 'https://example.com/uploads/device_logs.txt',
      uploadedAt: DateTime.now().subtract(
        const Duration(hours: 22),
      ), // Yesterday evening
      fileSize: 2.9,
    ),
    TicketAttachment(
      id: 'ATT-003',
      fileName: 'crash_report_20250711.docx',
      fileUrl: 'https://example.com/uploads/crash_report_20250711.docx',
      uploadedAt: DateTime.now().subtract(
        const Duration(hours: 18),
      ), // Earlier today
      fileSize: 0.8,
    ),
    TicketAttachment(
      id: 'ATT-004',
      fileName: 'network_traffic_capture.xlsx',
      fileUrl: 'https://example.com/uploads/network_traffic_capture.xlsx',
      uploadedAt: DateTime.now().subtract(
        const Duration(hours: 5),
      ), // A few hours ago
      fileSize: 12.1,
    ),
    TicketAttachment(
      id: 'ATT-005',
      fileName: 'expected_behavior.pdf',
      fileUrl: 'https://example.com/uploads/expected_behavior.pdf',
      uploadedAt: DateTime.now().subtract(
        const Duration(days: 2, hours: 3),
      ), // Day before yesterday
      fileSize: 0.5,
    ),
    TicketAttachment(
      id: 'ATT-006',
      fileName: 'user_flow_diagram.jpeg',
      fileUrl: 'https://example.com/uploads/user_flow_diagram.jpeg',
      uploadedAt: DateTime.now().subtract(
        const Duration(days: 3),
      ), // Three days ago
      fileSize: 1.7,
    ),
    TicketAttachment(
      id: 'ATT-007',
      fileName: 'api_response_sample.pptx',
      fileUrl: 'https://example.com/uploads/api_response_sample.pptx',
      uploadedAt: DateTime.now().subtract(
        const Duration(hours: 1),
      ), // Very recently
      fileSize: 0.1,
    ),
  ],
);

// Create Ticket Form Data

final List<DropdownMenuItem<String>> ticketStatus = [
  const DropdownMenuItem(value: 'open', child: Text('Open')),
  const DropdownMenuItem(value: 'in_progress', child: Text('In Progress')),
  const DropdownMenuItem(value: 'pending', child: Text('Pending')),
  const DropdownMenuItem(value: 'resolved', child: Text('Resolved')),
  const DropdownMenuItem(value: 'closed', child: Text('Closed')),
];

final List<DropdownMenuItem<String>> ticketPriorities = [
  const DropdownMenuItem(value: 'low', child: Text('Low')),
  const DropdownMenuItem(value: 'medium', child: Text('Medium')),
  const DropdownMenuItem(value: 'high', child: Text('High')),
  const DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
  const DropdownMenuItem(value: 'critical', child: Text('Critical')),
];

final List<DropdownMenuItem<String>> slaOptions = [
  const DropdownMenuItem(value: 'standard', child: Text('Standard (72 Hours)')),
  const DropdownMenuItem(value: 'silver', child: Text('Silver (48 Hours)')),
  const DropdownMenuItem(value: 'gold', child: Text('Gold (24 Hours)')),
  const DropdownMenuItem(value: 'platinum', child: Text('Platinum (12 Hours)')),
  const DropdownMenuItem(
    value: 'enterprise',
    child: Text('Enterprise (4 Hours)'),
  ),
];

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  @override
  String getNotes(int index) {
    return _getMeetingData(index).description;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

// label color list
final List<Color> colorOptions = [
  kSuccessColor,
  Color(0xFF8B1FA9),
  kErrorColor,
  kWarningColor,
  kInfoColor,
  kPrimaryColor,
];

final Map<String, Color> eventTypes = {
  'Work': kSuccessColor,
  'Personal': Color(0xFF8B1FA9),
  'Urgent': kErrorColor,
  'Meeting': kWarningColor,
  'Holiday': kInfoColor,
  'Other': kPrimaryColor,
};

List<Meeting> getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();

  DateTime date(int dayOffset, int hour) {
    DateTime d = today.add(Duration(days: dayOffset));
    return DateTime(d.year, d.month, d.day, hour);
  }

  // --- 4 days ago ---
  meetings.add(
    Meeting(
      'Final Report',
      date(-4, 9),
      date(-4, 11),
      kSuccessColor,
      false,
      description: 'Review final document for Q1 performance.',
    ),
  );
  meetings.add(
    Meeting(
      'Client Feedback',
      date(-4, 14),
      date(-4, 15),
      kInfoColor,
      false,
      description: 'Discussing revisions with the main stakeholder.',
    ),
  );

  // --- 7 days ago ---
  meetings.add(
    Meeting(
      'Weekly Planning',
      date(-7, 8),
      date(-7, 10),
      const Color(0xFF8B1FA9),
      false,
      description: 'Define tasks and goals for the upcoming week.',
    ),
  );
  meetings.add(
    Meeting(
      'Staff Sync',
      date(-7, 13),
      date(-7, 14),
      kPrimaryColor,
      false,
      description: 'General updates from each department.',
    ),
  );
  meetings.add(
    Meeting(
      'System Update',
      date(-7, 20),
      date(-7, 22),
      kErrorColor,
      false,
      description: 'Critical server maintenance and patch deployment.',
    ),
  );

  // --- 10 days ago ---
  meetings.add(
    Meeting(
      'Budget Review',
      date(-10, 10),
      date(-10, 12),
      kWarningColor,
      false,
      description: 'Analyzing department expenses vs allocated budget.',
    ),
  );
  meetings.add(
    Meeting(
      'Inventory Check',
      date(-10, 13),
      date(-10, 15),
      kSuccessColor,
      false,
      description: 'Physical counting of stock in the main warehouse.',
    ),
  );
  meetings.add(
    Meeting(
      'Supplier Meeting',
      date(-10, 16),
      date(-10, 17),
      kInfoColor,
      false,
      description: 'Negotiating contract terms with the new vendor.',
    ),
  );

  // --- 12 days ago ---
  meetings.add(
    Meeting(
      'Brainstorming',
      date(-12, 9),
      date(-12, 11),
      const Color(0xFF8B1FA9),
      false,
      description: 'Exploring creative ideas for the new marketing campaign.',
    ),
  );
  meetings.add(
    Meeting(
      'Lunch with Vendor',
      date(-12, 12),
      date(-12, 13),
      kSuccessColor,
      false,
      description: 'Casual networking lunch at Blue Cafe.',
    ),
  );
  meetings.add(
    Meeting(
      'Documentation',
      date(-12, 14),
      date(-12, 16),
      kPrimaryColor,
      false,
      description: 'Updating technical manuals for the version 2.0 release.',
    ),
  );
  meetings.add(
    Meeting(
      'Yoga Session',
      date(-12, 17),
      date(-12, 18),
      kWarningColor,
      false,
      description: 'Corporate wellness program at the rooftop.',
    ),
  );

  // --- 13 days ago ---
  meetings.add(
    Meeting(
      'Morning Briefing',
      date(-13, 8),
      date(-13, 9),
      kSuccessColor,
      false,
      description: 'Quick alignment on daily priorities.',
    ),
  );
  meetings.add(
    Meeting(
      'Product Design',
      date(-13, 10),
      date(-13, 12),
      kInfoColor,
      false,
      description: 'User interface review for the mobile application.',
    ),
  );
  meetings.add(
    Meeting(
      'HR Interview',
      date(-13, 13),
      date(-13, 14),
      kWarningColor,
      false,
      description: 'Technical interview with Senior Developer candidate.',
    ),
  );
  meetings.add(
    Meeting(
      'Testing QA',
      date(-13, 15),
      date(-13, 17),
      kErrorColor,
      false,
      description: 'Stress testing for the new payment gateway.',
    ),
  );
  meetings.add(
    Meeting(
      'Dinner Event',
      date(-13, 19),
      date(-13, 21),
      const Color(0xFF8B1FA9),
      false,
      description: 'Company anniversary dinner at Grand Ballroom.',
    ),
  );

  // --- 14 days ago ---
  meetings.add(
    Meeting(
      'Kickoff Sprint',
      date(-14, 9),
      date(-14, 11),
      kSuccessColor,
      false,
      description: 'Sprint planning and backlog grooming session.',
    ),
  );
  meetings.add(
    Meeting(
      'Content Strategy',
      date(-14, 11),
      date(-14, 12),
      kPrimaryColor,
      false,
      description: 'Planning social media calendar for next month.',
    ),
  );
  meetings.add(
    Meeting(
      'Data Backup',
      date(-14, 15),
      date(-14, 16),
      kErrorColor,
      false,
      description: 'Automated backup validation and integrity check.',
    ),
  );
  meetings.add(
    Meeting(
      'Team Building',
      date(-14, 16),
      date(-14, 18),
      kInfoColor,
      false,
      description: 'Fun outdoor activities for employee engagement.',
    ),
  );

  // --- 19 days ago ---
  meetings.add(
    Meeting(
      'Market Research',
      date(-19, 10),
      date(-19, 12),
      kWarningColor,
      false,
      description: 'Analyzing competitor pricing and customer trends.',
    ),
  );
  meetings.add(
    Meeting(
      'Competitor Analysis',
      date(-19, 14),
      date(-19, 15),
      const Color(0xFF8B1FA9),
      false,
      description: 'Deep dive into rival product features.',
    ),
  );
  meetings.add(
    Meeting(
      'Project Audit',
      date(-19, 16),
      date(-19, 17),
      kSuccessColor,
      false,
      description: 'External auditor review of project compliance.',
    ),
  );

  // --- 23 days ago ---
  meetings.add(
    Meeting(
      'Monthly Review - Reviewing key performance indicators for the month.',
      date(-23, 9),
      date(-23, 11),
      kPrimaryColor,
      false,
      description: 'Reviewing key performance indicators for the month.',
    ),
  );
  meetings.add(
    Meeting(
      'Asset Management',
      date(-23, 13),
      date(-23, 14),
      kSuccessColor,
      false,
      description: 'Tracking and labeling company hardware assets.',
    ),
  );
  meetings.add(
    Meeting(
      'App Maintenance',
      date(-23, 22),
      date(-22, 1),
      kErrorColor,
      false,
      description: 'Routine maintenance of the production server environment.',
    ),
  );

  // --- KEMARIN ---
  meetings.add(
    Meeting(
      'Project Kickoff',
      date(-1, 9),
      date(-1, 10),
      kPrimaryColor,
      false,
      description: 'Official start of the Solar Energy project.',
    ),
  );
  meetings.add(
    Meeting(
      'Consultation',
      date(-1, 10),
      date(-1, 11),
      kInfoColor,
      false,
      description: 'Legal advice on the new partnership agreement.',
    ),
  );
  meetings.add(
    Meeting(
      'Board Meeting',
      date(-1, 13),
      date(-1, 15),
      kSuccessColor,
      false,
      description: 'Quarterly strategic meeting with board members.',
    ),
  );
  meetings.add(
    Meeting(
      'Refactoring',
      date(-1, 15),
      date(-1, 16),
      kErrorColor,
      false,
      description: 'Cleaning up legacy code in the authentication module.',
    ),
  );
  meetings.add(
    Meeting(
      'Admin Work',
      date(-1, 16),
      date(-1, 17),
      const Color(0xFF8B1FA9),
      false,
      description: 'Filling out expense reports and administrative tasks.',
    ),
  );
  meetings.add(
    Meeting(
      'Team Dinner',
      date(-1, 19),
      date(-1, 21),
      kWarningColor,
      false,
      description: 'Celebrating the successful product launch.',
    ),
  );

  // --- today ---
  meetings.add(
    Meeting(
      'Daily Standup',
      date(0, 8),
      date(0, 9),
      kSuccessColor,
      false,
      description: '15-minute quick sync about today tasks.',
    ),
  );
  meetings.add(
    Meeting(
      'Client Demo',
      date(0, 10),
      date(0, 12),
      kSecondaryColor,
      false,
      description: 'Presenting the prototype to the Australian clients.',
    ),
  );
  meetings.add(
    Meeting(
      'Lunch Break',
      date(0, 12),
      date(0, 13),
      kWarningColor,
      false,
      description: 'Personal break and lunch.',
    ),
  );
  meetings.add(
    Meeting(
      'Internal Sync',
      date(0, 14),
      date(0, 15),
      const Color(0xFF8B1FA9),
      false,
      description: 'Meeting between designers and developers.',
    ),
  );
  meetings.add(
    Meeting(
      'Tech Talk',
      date(0, 15),
      date(0, 16),
      kPrimaryColor,
      false,
      description: 'Sharing knowledge about Flutter state management.',
    ),
  );
  meetings.add(
    Meeting(
      'Bug Bash',
      date(0, 16),
      date(0, 18),
      kErrorColor,
      false,
      description: 'Full team session to hunt and fix bugs.',
    ),
  );
  meetings.add(
    Meeting(
      'Gym Time',
      date(0, 19),
      date(0, 20),
      kSuccessColor,
      false,
      description: 'Evening workout at the local gym.',
    ),
  );

  // --- tommorow ---
  meetings.add(
    Meeting(
      'Planning',
      date(1, 9),
      date(1, 11),
      kSuccessColor,
      false,
      description: 'Resource allocation for next month project.',
    ),
  );
  meetings.add(
    Meeting(
      'Hiring Interview',
      date(1, 11),
      date(1, 12),
      kInfoColor,
      false,
      description: 'Interviewing Junior UI Designer candidate.',
    ),
  );
  meetings.add(
    Meeting(
      'Design Review',
      date(1, 13),
      date(1, 14),
      const Color(0xFF8B1FA9),
      false,
      description: 'Critical feedback on the new brand identity.',
    ),
  );
  meetings.add(
    Meeting(
      'Marketing Call',
      date(1, 14),
      date(1, 15),
      kWarningColor,
      false,
      description: 'Discussing Facebook Ads strategy.',
    ),
  );
  meetings.add(
    Meeting(
      'Code Review',
      date(1, 16),
      date(1, 17),
      kErrorColor,
      false,
      description: 'Reviewing PR for the security enhancement.',
    ),
  );
  meetings.add(
    Meeting(
      'Weekly Wrap-up',
      date(1, 17),
      date(1, 18),
      kSuccessColor,
      false,
      description: 'Reflecting on achievements during the week.',
    ),
  );

  // DAY +2
  meetings.add(
    Meeting(
      'Sprint Planning',
      date(2, 9),
      date(2, 11),
      kPrimaryColor,
      false,
      description: 'Plan tasks and priorities for the next sprint.',
    ),
  );
  meetings.add(
    Meeting(
      'Client Call',
      date(2, 14),
      date(2, 15),
      const Color(0xFF8B1FA9),
      false,
      description: 'Discuss project requirements and timeline.',
    ),
  );

  // DAY +3
  // meetings.add(
  //   Meeting(
  //     'UI Review',
  //     date(3, 10),
  //     date(3, 11),
  //     kSuccessColor,
  //     false,
  //     description: 'Review dashboard UI and usability.',
  //   ),
  // );

  // DAY +4
  meetings.add(
    Meeting(
      'Backend Sync',
      date(4, 9),
      date(4, 10),
      kPrimaryColor,
      false,
      description: 'Align API changes with frontend team.',
    ),
  );
  meetings.add(
    Meeting(
      'Design Workshop',
      date(4, 13),
      date(4, 16),
      kInfoColor,
      false,
      description: 'Collaborative session for new feature UX.',
    ),
  );
  meetings.add(
    Meeting(
      'Evening Yoga',
      date(4, 18),
      date(4, 19),
      kSuccessColor,
      false,
      description: 'Wellness activity for employees.',
    ),
  );

  // DAY +5
  meetings.add(
    Meeting(
      'QA Testing',
      date(5, 9),
      date(5, 12),
      kWarningColor,
      false,
      description: 'Manual testing of release candidate.',
    ),
  );
  meetings.add(
    Meeting(
      'Bug Triage',
      date(5, 14),
      date(5, 15),
      kErrorColor,
      false,
      description: 'Prioritize reported bugs.',
    ),
  );

  // DAY +6
  meetings.add(
    Meeting(
      'Marketing Brief',
      date(6, 10),
      date(6, 11),
      const Color(0xFF8B1FA9),
      false,
      description: 'Campaign strategy for product launch.',
    ),
  );

  // DAY +7
  meetings.add(
    Meeting(
      'Code Review',
      date(7, 9),
      date(7, 11),
      kPrimaryColor,
      false,
      description: 'Review merge requests.',
    ),
  );
  meetings.add(
    Meeting(
      'Town Hall',
      date(7, 15),
      date(7, 17),
      kSuccessColor,
      true,
      description: 'Company-wide update and Q&A.',
    ),
  );

  // DAY +8
  // meetings.add(
  //   Meeting(
  //     'Database Migration',
  //     date(8, 22),
  //     date(9, 2),
  //     kErrorColor,
  //     false,
  //     description: 'Scheduled schema migration.',
  //   ),
  // );

  // DAY +9
  meetings.add(
    Meeting(
      'UX Research',
      date(9, 10),
      date(9, 12),
      kInfoColor,
      false,
      description: 'Interview users for feedback.',
    ),
  );
  meetings.add(
    Meeting(
      'Prototype Demo',
      date(9, 14),
      date(9, 15),
      kSuccessColor,
      false,
      description: 'Show interactive prototype to stakeholders.',
    ),
  );

  // DAY +10
  meetings.add(
    Meeting(
      'Performance Audit',
      date(10, 9),
      date(10, 11),
      kWarningColor,
      false,
      description: 'Analyze dashboard performance metrics.',
    ),
  );

  // DAY +11
  meetings.add(
    Meeting(
      'Partner Meeting',
      date(11, 13),
      date(11, 15),
      kPrimaryColor,
      false,
      description: 'Discuss integration roadmap.',
    ),
  );
  meetings.add(
    Meeting(
      'Security Review',
      date(11, 16),
      date(11, 17),
      kErrorColor,
      false,
      description: 'Assess vulnerability risks.',
    ),
  );

  // DAY +12
  // meetings.add(
  //   Meeting(
  //     'Content Planning',
  //     date(12, 10),
  //     date(12, 11),
  //     kInfoColor,
  //     false,
  //     description: 'Plan blog and tutorial topics.',
  //   ),
  // );

  // DAY +13
  meetings.add(
    Meeting(
      'Release Prep',
      date(13, 9),
      date(13, 12),
      kSuccessColor,
      false,
      description: 'Prepare production release checklist.',
    ),
  );
  meetings.add(
    Meeting(
      'Stakeholder Update',
      date(13, 15),
      date(13, 16),
      kPrimaryColor,
      false,
      description: 'Weekly progress update.',
    ),
  );

  // DAY +14
  meetings.add(
    Meeting(
      'System Monitoring',
      date(14, 0),
      date(14, 23),
      kWarningColor,
      true,
      description: 'Observe system stability after patch.',
    ),
  );

  // DAY +15
  meetings.add(
    Meeting(
      'Feature Grooming',
      date(15, 9),
      date(15, 11),
      kInfoColor,
      false,
      description: 'Refine backlog items.',
    ),
  );

  // DAY +16
  meetings.add(
    Meeting(
      'Analytics Review',
      date(16, 10),
      date(16, 12),
      kSuccessColor,
      false,
      description: 'Evaluate user behavior data.',
    ),
  );
  meetings.add(
    Meeting(
      'Team Lunch',
      date(16, 12),
      date(16, 13),
      kPrimaryColor,
      false,
      description: 'Informal team bonding.',
    ),
  );

  // DAY +17
  // meetings.add(
  //   Meeting(
  //     'Design Sprint',
  //     date(17, 9),
  //     date(17, 17),
  //     kInfoColor,
  //     false,
  //     description: 'Rapid ideation and prototyping.',
  //   ),
  // );

  // DAY +18
  meetings.add(
    Meeting(
      'Infrastructure Check',
      date(18, 11),
      date(18, 12),
      const Color(0xFF8B1FA9),
      false,
      description: 'Verify server capacity.',
    ),
  );

  // DAY +19
  meetings.add(
    Meeting(
      'API Review',
      date(19, 10),
      date(19, 12),
      kPrimaryColor,
      false,
      description: 'Review endpoint design.',
    ),
  );
  meetings.add(
    Meeting(
      'Refactoring Session',
      date(19, 14),
      date(19, 16),
      kSuccessColor,
      false,
      description: 'Clean up legacy modules.',
    ),
  );

  // DAY +20
  meetings.add(
    Meeting(
      'Compliance Audit',
      date(20, 9),
      date(20, 11),
      kErrorColor,
      false,
      description: 'Ensure regulatory compliance.',
    ),
  );

  // DAY +21
  // meetings.add(
  //   Meeting(
  //     'Customer Demo',
  //     date(21, 13),
  //     date(21, 15),
  //     kInfoColor,
  //     false,
  //     description: 'Demonstrate new dashboard features.',
  //   ),
  // );

  // DAY +22
  meetings.add(
    Meeting(
      'Monthly Review',
      date(22, 10),
      date(22, 12),
      kSuccessColor,
      false,
      description: 'Review KPIs and OKRs.',
    ),
  );
  meetings.add(
    Meeting(
      'One-on-One',
      date(22, 15),
      date(22, 16),
      kPrimaryColor,
      false,
      description: 'Individual performance discussion.',
    ),
  );

  // DAY +23
  meetings.add(
    Meeting(
      'Backup Verification',
      date(23, 11),
      date(23, 12),
      kWarningColor,
      false,
      description: 'Ensure backup integrity.',
    ),
  );

  // DAY +24
  meetings.add(
    Meeting(
      'Architecture Review',
      date(24, 9),
      date(24, 11),
      kPrimaryColor,
      false,
      description: 'Assess system scalability.',
    ),
  );
  meetings.add(
    Meeting(
      'Design Critique',
      date(24, 14),
      date(24, 15),
      kInfoColor,
      false,
      description: 'Evaluate UI consistency.',
    ),
  );

  // DAY +25
  meetings.add(
    Meeting(
      'HR Policy Update',
      date(25, 10),
      date(25, 11),
      kSuccessColor,
      false,
      description: 'Review updated company policies.',
    ),
  );

  // DAY +26
  meetings.add(
    Meeting(
      'Integration Testing',
      date(26, 9),
      date(26, 12),
      kWarningColor,
      false,
      description: 'Test cross-module workflows.',
    ),
  );

  // DAY +27
  meetings.add(
    Meeting(
      'Roadmap Planning',
      date(27, 13),
      date(27, 16),
      kPrimaryColor,
      false,
      description: 'Plan Q4 product roadmap.',
    ),
  );

  // DAY +28
  meetings.add(
    Meeting(
      'Retrospective',
      date(28, 10),
      date(28, 12),
      kSuccessColor,
      false,
      description: 'Reflect on sprint outcomes.',
    ),
  );
  meetings.add(
    Meeting(
      'Company Event',
      date(28, 15),
      date(28, 18),
      kInfoColor,
      false,
      description: 'Internal celebration and awards.',
    ),
  );

  return meetings;
}

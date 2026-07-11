import 'package:flutter_ademin/demo/dashboard/project/dashboard_project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';

List<ProjectData> getProjectData() {
  return <ProjectData>[
    ProjectData(month: 'Jan', projects: 34, activeProjects: 8, revenue: 89.25),
    ProjectData(month: 'Feb', projects: 45, activeProjects: 12, revenue: 95.25),
    ProjectData(
      month: 'Mar',
      projects: 60,
      activeProjects: 18,
      revenue: 120.25,
    ),
    ProjectData(
      month: 'Apr',
      projects: 50,
      activeProjects: 15,
      revenue: 110.75,
    ),
    ProjectData(
      month: 'May',
      projects: 70,
      activeProjects: 22,
      revenue: 140.75,
    ),
    ProjectData(
      month: 'Jun',
      projects: 65,
      activeProjects: 20,
      revenue: 130.50,
    ),
    ProjectData(
      month: 'Jul',
      projects: 40,
      activeProjects: 14,
      revenue: 105.50,
    ),
    ProjectData(
      month: 'Aug',
      projects: 55,
      activeProjects: 18,
      revenue: 125.00,
    ),
    ProjectData(
      month: 'Sep',
      projects: 75,
      activeProjects: 25,
      revenue: 150.00,
    ),
    ProjectData(
      month: 'Oct',
      projects: 85,
      activeProjects: 28,
      revenue: 160.00,
    ),
    ProjectData(
      month: 'Nov',
      projects: 50,
      activeProjects: 16,
      revenue: 115.00,
    ),
    ProjectData(
      month: 'Dec',
      projects: 90,
      activeProjects: 30,
      revenue: 175.00,
    ),
  ];
}

// project status mockup data

final List<ProjectStatusData> data = [
  ProjectStatusData(
    status: 'Completed',
    projects: 113,
    tasks: 1687,
    color: kSuccessColor,
  ),
  ProjectStatusData(
    status: 'In Progress',
    projects: 46,
    tasks: 283,
    color: kInfoColor,
  ),
  ProjectStatusData(
    status: 'Not Started',
    projects: 59,
    tasks: 1010,
    color: kWarningColor,
  ),
  ProjectStatusData(
    status: 'Cancelled',
    projects: 69,
    tasks: 670,
    color: kErrorColor,
  ),
];

// project hours data mockup

final List<ProjectHours> projectHoursData = [
  ProjectHours(name: 'Website Redesign', estimated: 54000, actual: 63504),
  ProjectHours(name: 'Mobile App Dev', estimated: 28000, actual: 38400),
  ProjectHours(name: 'API Integration', estimated: 7000, actual: 41232),
  ProjectHours(name: 'UI/UX Overhaul', estimated: 12000, actual: 28056),
  ProjectHours(name: 'CRM Migration', estimated: 28500, actual: 39212),
  ProjectHours(name: 'Marketing Platform', estimated: 30000, actual: 49488),
  ProjectHours(name: 'Internal Tooling', estimated: 29500, actual: 47976),
  ProjectHours(name: 'Landing Pages', estimated: 14500, actual: 25080),
  ProjectHours(name: 'Analytics Dashboard', estimated: 31000, actual: 45768),
];

// ticket status data mockup

final List<TicketStatusData> ticketStatusData = [
  TicketStatusData(issueType: 'CMS', resolved: 40, open: 28, unresolved: 8),
  TicketStatusData(
    issueType: 'Hardware',
    resolved: 30,
    open: 20,
    unresolved: 18,
  ),
  TicketStatusData(issueType: 'DNS', resolved: 28, open: 22, unresolved: 14),
  TicketStatusData(
    issueType: 'Registry',
    resolved: 9,
    open: 14,
    unresolved: 13,
  ),
  TicketStatusData(issueType: 'Network', resolved: 12, open: 9, unresolved: 11),
  TicketStatusData(issueType: 'WINS', resolved: 11, open: 10, unresolved: 4),
];

// ticket source data mockup

final List<TicketSourceData> ticketSourceData = [
  TicketSourceData(source: 'Email', count: 120, color: kSuccessColor),
  TicketSourceData(source: 'Web', count: 80, color: kWarningColor),
  TicketSourceData(source: 'Phone', count: 50, color: kInfoColor),
  TicketSourceData(source: 'Chat', count: 40, color: kSecondaryColor),
  TicketSourceData(source: 'Social Media', count: 20, color: kErrorColor),
];

final List<SupportTimeData> supportTimeData = [
  SupportTimeData(month: 'Jan 2025', resolutionTime: 54, responseTime: 4.42),
  SupportTimeData(month: 'Feb 2025', resolutionTime: 86, responseTime: 4.18),
  SupportTimeData(month: 'Mar 2025', resolutionTime: 70, responseTime: 4.67),
  SupportTimeData(month: 'Apr 2025', resolutionTime: 72, responseTime: 4.61),
  SupportTimeData(month: 'May 2025', resolutionTime: 96, responseTime: 4.56),
  SupportTimeData(month: 'Jun 2025', resolutionTime: 48, responseTime: 4.38),
];

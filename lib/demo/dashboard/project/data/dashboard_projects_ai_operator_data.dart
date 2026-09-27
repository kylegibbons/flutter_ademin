import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for Project Management dashboard demo.
AIOperatorData getProjectsAIOperatorData() {
  return AIOperatorData(
    home: getProjectsHome(),
    conversations: getProjectsConversations(),
    insights: getProjectsInsights(),
    actions: getProjectsActions(),
    agents: getProjectsAgents(),
    logs: getProjectsLogs(),
  );
}

/// Returns the Projects home screen configuration
AIHome getProjectsHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your project timelines, team workload, and sprint goals. Ask any questions or choose an analysis below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "Project Overview",
        prompt: "Show project overview",
      ),
      AIQuickAction(
        id: "sprint",
        icon: Icons.directions_run_outlined,
        title: "Sprint Velocity",
        prompt: "Analyze sprint velocity",
      ),
      AIQuickAction(
        id: "workload",
        icon: Icons.people_alt_outlined,
        title: "Team Workload",
        prompt: "Check team workload",
      ),
      AIQuickAction(
        id: "blockers",
        icon: Icons.gpp_bad_outlined,
        title: "Active Blockers",
        prompt: "Show active blockers",
      ),
      AIQuickAction(
        id: "budget",
        icon: Icons.attach_money_outlined,
        title: "Budget Burn Rate",
        prompt: "Analyze budget burn rate",
      ),
      AIQuickAction(
        id: "milestones",
        icon: Icons.flag_outlined,
        title: "Upcoming Milestones",
        prompt: "Show upcoming milestones",
      ),
    ],
  );
}

/// Returns the list of Projects conversations
List<AIConversation> getProjectsConversations() {
  return [
    AIConversation(
      id: "sprint_status",
      title: "Sprint Analysis",
      preview:
          "Sprint velocity dropped by 12% due to scope creep in the backend API.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 3,
      chat: sprintConversation,
    ),
    AIConversation(
      id: "workload_forecast",
      title: "Resource Forecast",
      preview: "UI/UX design team is projected to be over-allocated next week.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: workloadConversation,
    ),
    AIConversation(
      id: "blockers",
      title: "Active Blockers",
      preview: "4 critical tasks blocked waiting for client asset approvals.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: blockerConversation,
    ),
    AIConversation(
      id: "budget_tracking",
      title: "Project Budgets",
      preview:
          "Project Alpha has burned 80% of its budget with 30% work remaining.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: budgetProjectsConversation,
    ),
    AIConversation(
      id: "executive_pm",
      title: "PMO Dashboard",
      preview: "Executive portfolio overview successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: executiveProjectsConversation,
    ),
    AIConversation(
      id: "backlog_grooming",
      title: "Backlog Health",
      preview: "12 stale Jira tickets need to be reviewed or archived.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: backlogConversation,
    ),
    AIConversation(
      id: "client_comms",
      title: "Client Updates",
      preview: "Weekly status report sent to the Stakeholder group.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: clientConversation,
    ),
    AIConversation(
      id: "bug_triage",
      title: "Bug Triage",
      preview: "3 new severe bugs reported in the latest staging release.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: bugTriageConversation,
    ),
    AIConversation(
      id: "deployment",
      title: "CI/CD & Deployments",
      preview: "Production deployment for v2.4.0 completed successfully.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: deploymentConversation,
    ),
    AIConversation(
      id: "weekly_standup",
      title: "Weekly Standup Summary",
      preview: "8 epics closed, 3 features moved to the next sprint.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyStandupConversation,
    ),
  ];
}

/// Returns the list of Projects insights for AI operator
List<AIInsight> getProjectsInsights() {
  return [
    AIInsight(
      id: "sprint_risk",
      title: "Sprint 42 delivery is at high risk",
      summary:
          "Current burn-down chart indicates we will miss the Friday deadline due to unexpected complexity in the payment module.",
      description:
          "AI detected a sustained slowdown in ticket resolution over the past 3 days. The primary contributors are blocked dependencies and code review delays.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 92),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Potential delay of the core product release by 1 week if scope is not reduced.",
      ),
      why: AIWhy(
        reasons: [
          "Payment API documentation was outdated",
          "2 Senior Devs out on sick leave",
          "Scope creep in the checkout UI",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "reduce_scope",
          title: "Move non-critical UI tasks to backlog",
        ),
        AISuggestion(
          id: "assign_help",
          title: "Assign additional reviewer to clear PR queue",
        ),
      ],
      actions: [
        AIAction(
          id: "view_burndown",
          label: "View Burndown",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "update_sprint",
          label: "Adjust Sprint Scope",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "resource_bottleneck",
      title: "Design team is over-allocated by 25%",
      summary:
          "The UI/UX designers have been assigned more story points than their historical velocity allows for this week.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 88),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Risk of burnout and delayed asset delivery for the frontend engineering team.",
      ),
      why: AIWhy(
        reasons: [
          "New client revisions added mid-sprint",
          "Concurrent deadlines for Project Alpha and Beta",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "reassign_tasks",
          title: "Rebalance tasks or push deadline for Project Beta",
        ),
      ],
      actions: [
        AIAction(
          id: "view_workload",
          label: "View Workload",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "schedule_sync",
          label: "Sync with Lead Designer",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "early_completion",
      title: "Database Migration completed ahead of schedule",
      summary:
          "The DevOps team finished the cloud database migration 2 days early with zero downtime.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Opportunity to pull forward QA testing tasks and accelerate the overall project timeline.",
      ),
      why: AIWhy(
        reasons: [
          "Automated migration scripts ran flawlessly",
          "No data corruption detected during validation",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "start_qa",
          title: "Begin integration testing phase early",
        ),
        AISuggestion(
          id: "praise_team",
          title: "Send kudos to the DevOps channel",
        ),
      ],
      actions: [
        AIAction(
          id: "view_gantt",
          label: "Update Timeline",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "assign_qa",
          label: "Assign QA Tasks",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_report",
      title: "Monthly PMO Status Report is ready",
      summary:
          "The cross-portfolio status report for June 2026 has been successfully generated for stakeholder review.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into budget burn, milestone completion, and cross-team dependencies.",
      ),
      actions: [
        AIAction(
          id: "open_report",
          label: "Open PDF",
          type: AIActionType.primary,
        ),
      ],
      why: AIWhy(
        reasons: [
          "Jira and Asana data successfully synchronized",
          "Timesheets locked and approved",
        ],
      ),
    ),
    AIInsight(
      id: "budget_optimal",
      title: "Project Delta budget is tracking optimally",
      summary:
          "Current hourly burn rate perfectly aligns with the estimated milestones for the MVP phase.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected to complete MVP phase with 15% budget contingency intact.",
      ),
      why: AIWhy(
        reasons: [
          "No major scope changes requested",
          "Freelance developer hours stayed within cap",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "lock_scope",
          title: "Maintain strict change request policy to preserve margin",
        ),
      ],
      actions: [
        AIAction(
          id: "view_budget",
          label: "View Ledger",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "invoice_client",
          label: "Draft Milestone Invoice",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getProjectsActions() {
  return [
    AIActionItem(
      id: "generate_status_report",
      title: "Generate Client Status Report",
      description:
          "Create an executive summary for Project Alpha including completed features and next steps.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "ping_blockers",
      title: "Follow-up on Blocked Tasks",
      description:
          "Automatically message assignees on Slack for tasks blocked for more than 48 hours.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.notifications_active_outlined,
    ),

    AIActionItem(
      id: "forecast_completion",
      title: "Generate Delivery Forecast",
      description:
          "Predict project completion dates based on historical team velocity and current backlog.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "analyze_capacity",
      title: "Analyze Resource Capacity",
      description:
          "Evaluate team workload for the upcoming sprint to prevent over-allocation.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.groups_outlined,
    ),

    AIActionItem(
      id: "stale_branches",
      title: "Detect Stale PRs & Branches",
      description:
          "Identify GitHub pull requests that have been awaiting review for over 3 days.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.merge_type_outlined,
    ),

    AIActionItem(
      id: "tag_bugs",
      title: "Auto-Triage New Bugs",
      description:
          "Read incoming bug reports and automatically assign severity and components tags.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.bug_report_outlined,
    ),

    AIActionItem(
      id: "detect_scope_creep",
      title: "Analyze Scope Creep",
      description:
          "Compare originally planned story points against total points added mid-sprint.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.zoom_out_map_outlined,
    ),

    AIActionItem(
      id: "workflow_jira",
      title: "Automate Jira Transitions",
      description:
          "Automatically move tickets to 'QA' when GitHub PRs are merged to staging.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.account_tree_outlined,
    ),

    AIActionItem(
      id: "refresh_gantt",
      title: "Refresh Gantt Charts",
      description:
          "Synchronize timelines, dependencies, and milestones with the latest task data.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_standup",
      title: "Generate Standup Summary",
      description:
          "Prepare a concise AI summary of yesterday's updates, today's goals, and active blockers.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getProjectsAgents() {
  return [
    AIAgent(
      id: "scrum_master",
      name: "Scrum Master Agent",
      description:
          "Facilitates sprints, tracks velocity, identifies blockers, and optimizes team workflows.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.directions_run_outlined,
    ),

    AIAgent(
      id: "resource_manager",
      name: "Resource Manager",
      description:
          "Monitors team capacity, timesheets, allocations, and prevents burnout.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.people_outline,
    ),

    AIAgent(
      id: "client_comms",
      name: "Stakeholder Agent",
      description:
          "Drafts status reports, manages client updates, and flags project risk levels.",
      category: AIAgentCategory.marketing,
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.campaign_outlined,
    ),

    AIAgent(
      id: "backlog_groomer",
      name: "Backlog Organizer",
      description:
          "Cleans up stale tickets, flags missing requirements, and prioritizes epics.",
      category: AIAgentCategory.inventory,
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.format_list_bulleted_outlined,
    ),

    AIAgent(
      id: "budget_controller",
      name: "Budget Controller",
      description:
          "Tracks project expenses, billable hours, profit margins, and budget burndowns.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.attach_money_outlined,
    ),

    AIAgent(
      id: "devops_qa",
      name: "DevOps & QA Bot",
      description:
          "Monitors CI/CD pipelines, tracks test coverage, and reports deployment status.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.build_circle_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getProjectsLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly PMO Report",
      message: "Portfolio report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Scrum Master Agent",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly PMO Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Scrum Master Agent",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "Sprint Risk Alert",
      message: "Sprint 42 burndown falls below target trajectory.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "Scrum Master Agent",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Capacity Analysis Started",
      message: "Analyzing resource availability for next week.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Resource Manager",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Jira Automation Workflow",
      message: "14 tickets automatically transitioned based on PR merges.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "DevOps & QA Bot",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "Stale Pull Requests",
      message: "4 Pull Requests have been waiting for review for > 3 days.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "DevOps & QA Bot",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Completion Forecast Done",
      message: "Project Beta completion date forecast generated.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Scrum Master Agent",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "GitHub Webhook Synced",
      message: "Latest commits mapped to active tasks.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "Trello Sync Failed",
      message: "Failed to fetch board data for Design Team.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Resource Manager",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "Trello API returned HTTP 403 Forbidden (Token Expired).",
    ),

    AILogItem(
      id: "log_010",
      title: "Client Email Drafted",
      message: "Weekly project update email drafted for review.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Stakeholder Agent",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Dashboard Refreshed",
      message: "Executive PMO metrics and Gantt charts synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Daily standup reminder sent to Slack channel.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "Scrum Master Agent",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Slack Integration Failed",
      message: "Unable to send deployment alert to #devops.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Slack API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Timesheet Audit Completed",
      message: "Billable vs Non-Billable hours report generated.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Budget Controller",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Missing Acceptance Criteria",
      message: "8 tickets in 'Ready for Dev' lack clear acceptance criteria.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "Backlog Organizer",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getProjectsSettings() {
  return const AISettings(
    behavior: AIBehaviorSettings(
      autoSaveConversations: true,
      autoOpenInsights: false,
      confirmBeforeAction: true,
      showAIReasoning: true,
    ),

    memory: AIMemorySettings(
      memoryRetention: AIMemoryRetention.days30,
      conversationHistory: AIMemoryRetention.days90,
    ),

    reports: AIReportSettings(
      exportFormat: AIExportFormat.pdf,
      includeVisualizations: true,
      pageSize: AIPageSize.a4,
    ),
  );
}

// sprint conversation
final sprintConversation = [
  AIChatMessage(
    id: 'sprnt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed the current Sprint 42 data. There are some velocity metrics and risks you should review.''',
  ),

  AIChatMessage(
    id: 'sprnt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.dashboard_outlined,
        title: 'Sprint Overview',
        prompt: 'Show sprint overview',
      ),

      AIQuickAction(
        id: 'burndown',
        icon: Icons.trending_down_outlined,
        title: 'Burndown Chart',
        prompt: 'Show burndown chart',
      ),

      AIQuickAction(
        id: 'velocity',
        icon: Icons.speed_outlined,
        title: 'Team Velocity',
        prompt: 'Analyze team velocity',
      ),

      AIQuickAction(
        id: 'scope_creep',
        icon: Icons.zoom_out_map_outlined,
        title: 'Scope Creep',
        prompt: 'Check for scope creep',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sprnt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze team velocity',
  ),

  AIChatMessage(
    id: 'sprnt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Team velocity dropped by 12% compared to the 3-sprint average.

The biggest causes:

• 18 story points were added mid-sprint (Scope Creep)

• Payment module API integration is taking 2x longer than estimated

• QA cycle is bottlenecked; 5 tickets are stuck in "In Review"''',
  ),

  AIChatMessage(
    id: 'sprnt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last sprint'),

      AIQuickAction(id: 'segment_epic', title: 'Segment by Epic'),

      AIQuickAction(id: 'rollover', title: 'Calculate likely rollover points'),
    ],
  ),

  AIChatMessage(
    id: 'sprnt_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last sprint',
  ),

  AIChatMessage(
    id: 'sprnt_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to Sprint 41:

• Completed points dropped by 15 (Expected: 80, Current pace: 65)

• Bugs reported during sprint increased by 30%

• Cycle time from "In Progress" to "Done" increased from 2.1 days to 3.4 days

I suspect the main issue lies in unclear requirements for the payment module tickets.''',
  ),

  AIChatMessage(
    id: 'sprnt_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'flag_tickets',
        icon: Icons.flag_outlined,
        title: 'Flag Risky Tickets in Jira',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Notify Scrum Team',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sprnt_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as an Agile Scrum Master. Please perform a comparative analysis of the Sprint Velocity for this sprint versus last sprint.
Include the following components:

Quantitative Comparison: State the current projected velocity vs. last sprint's actual velocity.

Segment Breakdown: Analyze the velocity across different disciplines (Frontend vs Backend).

Bottleneck Analysis: Identify the specific workflow stage where tickets are stalling.

Causal Insights: Provide potential reasons for the slowdown (e.g., technical debt, missing assets).

Actionable Recommendations: Suggest 3 concrete steps to improve flow before sprint review.''',
  ),
];

// workload conversation
List<AIChatMessage> workloadConversation = [
  AIChatMessage(
    id: 'wkld_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the resource allocation and team workload for the upcoming weeks.

There are some capacity risks you should balance to prevent team burnout.
''',
  ),

  AIChatMessage(
    id: 'wkld_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'capacity_overview',
        icon: Icons.pie_chart_outline,
        title: 'Capacity Overview',
        prompt: 'Show capacity overview',
      ),

      AIQuickAction(
        id: 'over_allocated',
        icon: Icons.warning_amber_outlined,
        title: 'Over-Allocated Members',
        prompt: 'Identify over-allocated members',
      ),

      AIQuickAction(
        id: 'under_utilized',
        icon: Icons.person_add_alt_1_outlined,
        title: 'Available Capacity',
        prompt: 'Show team members with free time',
      ),

      AIQuickAction(
        id: 'pto_calendar',
        icon: Icons.event_busy_outlined,
        title: 'PTO Impact',
        prompt: 'Analyze upcoming PTO impact',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkld_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify over-allocated members',
  ),

  AIChatMessage(
    id: 'wkld_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I identified 2 team members who are assigned over 110% of their available capacity for next week:

• Sarah (Lead Designer): Allocated 45 hours (Target: 35h). She is split between Project Alpha and the sudden client revision on Beta.

• Mike (DevOps): Allocated 42 hours (Target: 35h). Assigned to both the CI/CD pipeline upgrade and standard release duties.
''',
  ),

  AIChatMessage(
    id: 'wkld_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'reassign_design', title: 'Find available designers'),

      AIQuickAction(
        id: 'delay_cicd',
        title: 'Calculate impact of delaying CI/CD task',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkld_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_csv',
        icon: Icons.table_view,
        title: 'Export Workload Report',
      ),

      AIQuickAction(
        id: 'adjust_gantt',
        icon: Icons.edit_calendar_outlined,
        title: 'Adjust Project Schedule',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkld_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Find available designers',
  ),

  AIChatMessage(
    id: 'wkld_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Looking at the cross-project resource pool:

• Alex (Junior UI Designer) has 15 hours of unallocated capacity next week.

Recommendation: Offload the "Dashboard Icon Updates" and "Export Assets" tasks from Sarah (approx 12 hours of work) to Alex. This will bring Sarah's allocation down to a healthy 94%.
''',
  ),

  AIChatMessage(
    id: 'wkld_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'reassign_tickets',
        icon: Icons.swap_horiz,
        title: 'Reassign Tickets in Jira',
      ),

      AIQuickAction(
        id: 'notify_sarah',
        icon: Icons.mail_outline,
        title: 'Notify Sarah and Alex',
      ),
    ],
  ),
];

List<AIChatMessage> blockerConversation = [
  AIChatMessage(
    id: 'blck_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the active project boards and issue trackers.

We have several critical path tasks that are currently blocked.
''',
  ),

  AIChatMessage(
    id: 'blck_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'blocker_list',
        icon: Icons.gpp_bad_outlined,
        title: 'Active Blockers',
        prompt: 'List all active blockers',
      ),

      AIQuickAction(
        id: 'dependency_graph',
        icon: Icons.account_tree_outlined,
        title: 'Dependencies',
        prompt: 'Show blocker dependencies',
      ),

      AIQuickAction(
        id: 'stalled_tickets',
        icon: Icons.hourglass_empty_outlined,
        title: 'Stalled Tasks',
        prompt: 'Identify stalled tasks',
      ),
    ],
  ),

  AIChatMessage(
    id: 'blck_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'List all active blockers',
  ),

  AIChatMessage(
    id: 'blck_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
There are 4 high-priority tasks currently marked as 'Blocked':

• PRJ-102 (Frontend): Blocked waiting for final API payload structure from backend team.

• PRJ-115 (Content): Blocked waiting for legal team approval on Terms of Service copy (Stalled for 4 days).

• PRJ-120 (Design): Blocked waiting for high-res logo assets from the client.
''',
  ),

  AIChatMessage(
    id: 'blck_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'ping_legal', title: 'Draft follow-up to legal team'),
      AIQuickAction(
        id: 'client_email',
        title: 'Draft email to client for assets',
      ),
    ],
  ),

  AIChatMessage(
    id: 'blck_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_blocker_list',
        icon: Icons.download_outlined,
        title: 'Export Blocker Report',
      ),
      AIQuickAction(
        id: 'add_comments',
        icon: Icons.comment_outlined,
        title: 'Add status pings in Jira',
      ),
    ],
  ),

  AIChatMessage(
    id: 'blck_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Draft follow-up to legal team',
  ),

  AIChatMessage(
    id: 'blck_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have drafted a professional follow-up email to the Legal department:

"Subject: URGENT: PRJ-115 Terms of Service Approval Required
Hi Team, 
Just following up on the ToS copy approval for Project Alpha. This ticket has been blocked for 4 days and is now on the critical path for our Friday launch. 
Could we get an ETA on when this will be reviewed? Let me know if you need any additional context."
''',
  ),

  AIChatMessage(
    id: 'blck_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'send_email',
        icon: Icons.send_outlined,
        title: 'Send Email Now',
      ),
    ],
  ),
];

List<AIChatMessage> budgetProjectsConversation = [
  AIChatMessage(
    id: 'bdgp_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the financial health and budget burn rate report for active projects.

One of our fixed-bid projects is at risk of going over budget.
''',
  ),

  AIChatMessage(
    id: 'bdgp_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'burn_rate',
        icon: Icons.local_fire_department_outlined,
        title: 'Budget Burn Rate',
        prompt: 'Analyze budget burn rate',
      ),

      AIQuickAction(
        id: 'profit_margin',
        icon: Icons.savings_outlined,
        title: 'Profit Margins',
        prompt: 'Check estimated profit margins',
      ),

      AIQuickAction(
        id: 'time_tracking',
        icon: Icons.timer_outlined,
        title: 'Billable Hours',
        prompt: 'Show billable hours summary',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bdgp_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze budget burn rate',
  ),

  AIChatMessage(
    id: 'bdgp_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Project Alpha's budget utilization is alarming. 

Key observations:

• Total Budget: \$50,000 | Spent to date: \$40,000 (80% burned)

• Project Completion: Only 65% of deliverables are approved.

• The main cause of the burn is the extended "Discovery & Design" phase, which took 60 billable hours more than estimated.
''',
  ),

  AIChatMessage(
    id: 'bdgp_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'change_order',
        title: 'Draft a Change Request (CR) for scope',
      ),
      AIQuickAction(
        id: 'cost_reduction',
        title: 'Show options to reduce remaining cost',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bdgp_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_harvest',
        icon: Icons.access_time,
        title: 'Open Timesheet Software',
      ),
      AIQuickAction(
        id: 'alert_account_manager',
        icon: Icons.campaign_outlined,
        title: 'Alert Account Manager',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bdgp_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show options to reduce remaining cost',
  ),

  AIChatMessage(
    id: 'bdgp_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
To preserve the remaining 20% margin, consider these operational adjustments:

• Swap Resources: Transition remaining QA tasks from the Senior QA Engineer (\$85/hr cost) to the Junior QA Analyst (\$35/hr cost).

• Lock Scope: Strictly enforce the "No revisions" clause for the final two modules. Any new requests must be billed as a separate retainer.

• Use Pre-built Assets: Utilize existing UI kit components instead of custom-building the admin dashboard tables.
''',
  ),

  AIChatMessage(
    id: 'bdgp_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'apply_changes',
        icon: Icons.check_circle_outlined,
        title: 'Implement Cost Strategy',
      ),
    ],
  ),
];

List<AIChatMessage> executiveProjectsConversation = [
  AIChatMessage(
    id: 'execp_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your PMO (Project Management Office) executive dashboard summary for this month.

Overall portfolio health is stable, with 4 out of 5 major projects tracking on time and within budget.
''',
  ),

  AIChatMessage(
    id: 'execp_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'portfolio_health',
        icon: Icons.health_and_safety_outlined,
        title: 'Portfolio Health',
        prompt: 'Show portfolio health summary',
      ),

      AIQuickAction(
        id: 'resource_utilization',
        icon: Icons.data_usage_outlined,
        title: 'Global Utilization',
        prompt: 'Analyze global resource utilization',
      ),

      AIQuickAction(
        id: 'client_satisfaction',
        icon: Icons.thumb_up_alt_outlined,
        title: 'Client Satisfaction',
        prompt: 'Check recent client feedback',
      ),
    ],
  ),

  AIChatMessage(
    id: 'execp_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show portfolio health summary',
  ),

  AIChatMessage(
    id: 'execp_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level portfolio matrix:

• Active Projects: 12 (3 in Initiation, 7 in Execution, 2 in Closing)

• On-Time Delivery Rate: 88% (Target: 90%)

• Overall Profit Margin: 24.2% (Healthy)

• Critical Risks: Project Alpha (Budget Overrun), Project Gamma (Key Resource Resignation).
''',
  ),

  AIChatMessage(
    id: 'execp_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'deep_dive_gamma',
        title: 'Show mitigation plan for Project Gamma',
      ),
      AIQuickAction(id: 'forecast_q3', title: 'View Q3 pipeline capacity'),
    ],
  ),

  AIChatMessage(
    id: 'execp_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'download_board_deck',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Executive Status Report',
      ),
    ],
  ),
];

List<AIChatMessage> backlogConversation = [
  AIChatMessage(
    id: 'bklg_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have run an automated grooming check on the product backlog.

We have a buildup of stale and poorly-defined tickets that are cluttering the board.
''',
  ),

  AIChatMessage(
    id: 'bklg_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'stale_tickets',
        icon: Icons.delete_sweep_outlined,
        title: 'Stale Tickets',
        prompt: 'Identify stale tickets',
      ),

      AIQuickAction(
        id: 'missing_reqs',
        icon: Icons.rule_outlined,
        title: 'Missing Requirements',
        prompt: 'Show tickets missing acceptance criteria',
      ),

      AIQuickAction(
        id: 'epic_progress',
        icon: Icons.view_timeline_outlined,
        title: 'Epic Progress',
        prompt: 'Check progress of active epics',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bklg_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify stale tickets',
  ),

  AIChatMessage(
    id: 'bklg_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 45 tickets in the backlog that have not been updated, commented on, or moved in over 90 days.

• 30 are marked as "Low Priority" feature requests.
• 10 are minor UI bugs reported on old browser versions.
• 5 are duplicate tickets.
''',
  ),

  AIChatMessage(
    id: 'bklg_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'bulk_close',
        title: 'Bulk close low priority > 90 days',
      ),
      AIQuickAction(id: 'merge_dupes', title: 'Auto-merge duplicate tickets'),
    ],
  ),

  AIChatMessage(
    id: 'bklg_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_jira_backlog',
        icon: Icons.format_list_bulleted_outlined,
        title: 'Open Backlog Board',
      ),
    ],
  ),
];

List<AIChatMessage> clientConversation = [
  AIChatMessage(
    id: 'clnt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have evaluated our recent client communications and approval workflows.

We have a pending milestone sign-off that is delaying invoicing.
''',
  ),

  AIChatMessage(
    id: 'clnt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'pending_approvals',
        icon: Icons.fact_check_outlined,
        title: 'Pending Approvals',
        prompt: 'Show pending client approvals',
      ),

      AIQuickAction(
        id: 'communication_log',
        icon: Icons.forum_outlined,
        title: 'Communication Log',
        prompt: 'Summarize recent client emails',
      ),
    ],
  ),

  AIChatMessage(
    id: 'clnt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show pending client approvals',
  ),

  AIChatMessage(
    id: 'clnt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
The "Phase 2: Backend Architecture" milestone has been awaiting client sign-off for 5 days.

The client lead (Sarah Jenkins) opened the staging link on Tuesday but has not formally responded to the Basecamp thread to approve the deliverable.
''',
  ),

  AIChatMessage(
    id: 'clnt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'draft_reminder', title: 'Draft polite reminder email'),
      AIQuickAction(
        id: 'prep_invoice',
        title: 'Prep invoice draft for accounting',
      ),
    ],
  ),

  AIChatMessage(
    id: 'clnt_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_basecamp',
        icon: Icons.web_outlined,
        title: 'Open Project Portal',
      ),
    ],
  ),
];

List<AIChatMessage> bugTriageConversation = [
  AIChatMessage(
    id: 'bug_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the QA and bug tracking reports from the latest staging release.

We have a spike in severe bugs that need to be triaged before production deployment.
''',
  ),

  AIChatMessage(
    id: 'bug_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'new_bugs',
        icon: Icons.bug_report_outlined,
        title: 'New Bugs',
        prompt: 'Show new critical bugs',
      ),

      AIQuickAction(
        id: 'qa_coverage',
        icon: Icons.checklist_rtl_outlined,
        title: 'Test Coverage',
        prompt: 'Review test coverage',
      ),

      AIQuickAction(
        id: 'regression_alerts',
        icon: Icons.history_outlined,
        title: 'Regressions',
        prompt: 'Show regression bugs',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bug_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show new critical bugs',
  ),

  AIChatMessage(
    id: 'bug_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 3 'Critical' severity bugs reported by QA in the last 24 hours:

• BUG-401: App crashes on iOS 17 when uploading a profile picture larger than 5MB.

• BUG-405: Password reset token expires immediately after generation.

• BUG-409: Database connection pool exhausts during stress testing (500 concurrent users).
''',
  ),

  AIChatMessage(
    id: 'bug_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'assign_bugs', title: 'Auto-assign based on component'),
      AIQuickAction(id: 'delay_release', title: 'Propose new release schedule'),
    ],
  ),

  AIChatMessage(
    id: 'bug_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_sentry',
        icon: Icons.error_outline,
        title: 'Open Crash Logs (Sentry)',
      ),
    ],
  ),
];

List<AIChatMessage> deploymentConversation = [
  AIChatMessage(
    id: 'dploy_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have cross-referenced our CI/CD pipelines and deployment schedules.

The production deployment for v2.4.0 is ready for final approval.
''',
  ),

  AIChatMessage(
    id: 'dploy_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'pipeline_status',
        icon: Icons.linear_scale_outlined,
        title: 'Pipeline Status',
        prompt: 'Show pipeline status',
      ),

      AIQuickAction(
        id: 'release_notes',
        icon: Icons.article_outlined,
        title: 'Release Notes',
        prompt: 'Generate release notes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'dploy_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show pipeline status',
  ),

  AIChatMessage(
    id: 'dploy_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
The GitHub Actions workflow for `main` branch completed successfully.

Key steps:
• Unit Tests: Passed (402/402)
• E2E Cypress Tests: Passed
• Docker Image Build: Successful
• Security Scan (Snyk): 0 Critical Vulnerabilities

The staging environment has been stable for 48 hours. Ready to merge to production.
''',
  ),

  AIChatMessage(
    id: 'dploy_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'trigger_deploy', title: 'Trigger Production Deploy'),
      AIQuickAction(
        id: 'draft_announcement',
        title: 'Draft Slack announcement',
      ),
    ],
  ),

  AIChatMessage(
    id: 'dploy_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_github',
        icon: Icons.code_outlined,
        title: 'Open GitHub Actions',
      ),
    ],
  ),
];

List<AIChatMessage> weeklyStandupConversation = [
  AIChatMessage(
    id: 'stnd_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly automated standup summary for the engineering and design teams.

Overall alignment is good, but cross-team dependencies need to be addressed.
''',
  ),

  AIChatMessage(
    id: 'stnd_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'done_this_week',
        icon: Icons.check_circle_outlined,
        title: 'Accomplishments',
        prompt: 'Summarize accomplishments',
      ),

      AIQuickAction(
        id: 'goals_next_week',
        icon: Icons.flag_outlined,
        title: 'Next Week Goals',
        prompt: 'Show next week goals',
      ),

      AIQuickAction(
        id: 'team_morale',
        icon: Icons.mood_outlined,
        title: 'Team Morale',
        prompt: 'Analyze team check-ins',
      ),
    ],
  ),

  AIChatMessage(
    id: 'stnd_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Summarize accomplishments',
  ),

  AIChatMessage(
    id: 'stnd_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the AI summary of this week's completed work:

• Frontend Team: Finished the responsive dashboard layouts and merged the new charting library.
• Backend Team: Completed the refactoring of the user authentication service (now 30% faster).
• Design Team: Handed off all high-fidelity prototypes for the 'Settings' module.

Total Story Points Delivered: 85
''',
  ),

  AIChatMessage(
    id: 'stnd_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'share_summary',
        title: 'Share summary to #general channel',
      ),
    ],
  ),

  AIChatMessage(
    id: 'stnd_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_confluence',
        icon: Icons.menu_book_outlined,
        title: 'Save to Confluence Wiki',
      ),
    ],
  ),
];

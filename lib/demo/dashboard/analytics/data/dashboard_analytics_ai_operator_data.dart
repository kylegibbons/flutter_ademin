import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for Website Analytics dashboard demo.
AIOperatorData getAnalyticsAIOperatorData() {
  return AIOperatorData(
    home: getAnalyticsHome(),
    conversations: getAnalyticsConversations(),
    insights: getAnalyticsInsights(),
    actions: getAnalyticsActions(),
    agents: getAnalyticsAgents(),
    logs: getAnalyticsLogs(),
  );
}

/// Returns the Analytics home screen configuration
AIHome getAnalyticsHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your website traffic and user behavior. Ask any questions or choose one of the analyses below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "Traffic Overview",
        prompt: "Show traffic overview",
      ),
      AIQuickAction(
        id: "audience",
        icon: Icons.show_chart,
        title: "Audience Trend",
        prompt: "Show audience trend",
      ),
      AIQuickAction(
        id: "pages",
        icon: Icons.description_outlined,
        title: "Top Pages",
        prompt: "Show top pages",
      ),
      AIQuickAction(
        id: "forecast",
        icon: Icons.insights_outlined,
        title: "Traffic Forecast",
        prompt: "Forecast next month traffic",
      ),
      AIQuickAction(
        id: "acquisition",
        icon: Icons.campaign_outlined,
        title: "Acquisition Channels",
        prompt: "Analyze acquisition channels",
      ),
      AIQuickAction(
        id: "performance",
        icon: Icons.speed_outlined,
        title: "Web Performance",
        prompt: "Analyze core web vitals",
      ),
    ],
  );
}

/// Returns the list of Analytics conversations
List<AIConversation> getAnalyticsConversations() {
  return [
    AIConversation(
      id: "traffic",
      title: "Traffic Analysis",
      preview: "Organic search traffic dropped by 12% due to core update.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 2,
      chat: trafficConversation,
    ),
    AIConversation(
      id: "forecast",
      title: "Traffic Forecast",
      preview: "Monthly unique visitors projected to increase by 8.3%.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: audienceConversation,
    ),
    AIConversation(
      id: "bounce",
      title: "High Bounce Rate",
      preview: "Checkout page bounce rate spiked to 65% on mobile devices.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: bounceConversation,
    ),
    AIConversation(
      id: "acquisition",
      title: "Acquisition Channels",
      preview: "Referral traffic from Reddit has the highest engagement.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: acquisitionConversation,
    ),
    AIConversation(
      id: "executive",
      title: "Executive Dashboard",
      preview: "Executive web analytics dashboard successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: executiveConversation,
    ),
    AIConversation(
      id: "performance",
      title: "Core Web Vitals",
      preview: "LCP on 12 landing pages is exceeding the 2.5s threshold.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: performanceConversation,
    ),
    AIConversation(
      id: "referral",
      title: "Backlink Analysis",
      preview:
          "Domain Authority increased, 5 new high-quality backlinks detected.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: referralConversation,
    ),
    AIConversation(
      id: "conversion",
      title: "Goal Completions",
      preview: "Newsletter signups increased by 14% compared to last month.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: conversionConversation,
    ),
    AIConversation(
      id: "ad_spend",
      title: "CPC & Ad Traffic",
      preview: "Paid search CAC exceeded the target by 8%.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: adSpendConversation,
    ),
    AIConversation(
      id: "weekly",
      title: "Weekly SEO Review",
      preview: "6 keywords entered top 3, 2 keywords dropped in ranking.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyAnalyticsConversation,
    ),
  ];
}

/// Returns the list of Analytics insights for AI operator
List<AIInsight> getAnalyticsInsights() {
  return [
    AIInsight(
      id: "traffic_drop",
      title: "Organic traffic dropped 23% compared to last week",
      summary:
          "Weekly sessions decreased significantly due to a recent Google Core Update and server response issues in the EU region.",
      description:
          "AI detected a sustained decline in organic search visibility over the past seven days. The primary contributors are keyword ranking drops and high server latency.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 92),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated loss of approximately 15,000 unique visitors and related ad revenue if no action is taken.",
      ),
      why: AIWhy(
        reasons: [
          "Recent search engine algorithm update",
          "EU server response time increased by 300ms",
          "Loss of featured snippets for 3 core pages",
        ],
      ),
      suggestions: [
        AISuggestion(id: "audit_seo", title: "Run technical SEO audit"),
        AISuggestion(
          id: "check_server",
          title: "Review EU region CDN configuration",
        ),
      ],
      actions: [
        AIAction(
          id: "analysis",
          label: "View Impact",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "recovery",
          label: "Create Recovery Plan",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "high_bounce",
      title: "Checkout page bounce rate spiked to 65%",
      summary:
          "Average session duration on the checkout flow dropped, increasing the risk of cart abandonment.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 88),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Potential decline in e-commerce conversion rate by up to 9%.",
      ),
      why: AIWhy(
        reasons: [
          "Payment gateway loading slowly on mobile",
          "New UI update caused button overlapping",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "rollback_ui",
          title: "Revert recent checkout UI changes",
        ),
      ],
      actions: [
        AIAction(
          id: "show_funnel",
          label: "Show Funnel",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "alert_devs",
          label: "Alert Dev Team",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "viral_traffic",
      title: "Referral traffic from Reddit increased by 180%",
      summary:
          "A recent blog post went viral in the last 48 hours, creating a surge in concurrent users and newsletter signups.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 89),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Opportunity to capture 5,000+ new email subscribers by utilizing exit-intent popups.",
      ),
      why: AIWhy(
        reasons: [
          "Link shared in a top-ranking Reddit thread",
          "High average engagement time (3m 40s)",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "enable_popup",
          title: "Enable targeted lead capture popup",
        ),
        AISuggestion(
          id: "scale_server",
          title: "Scale up web server instances",
        ),
      ],
      actions: [
        AIAction(
          id: "view_source",
          label: "View Source",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "optimize",
          label: "Optimize Conversion",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_report",
      title: "Monthly web analytics report is ready",
      summary:
          "The comprehensive traffic report for June 2026 has been successfully generated and is ready for review.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into June 2026 audience behavior, acquisition sources, and key metrics.",
      ),
      actions: [
        AIAction(
          id: "open_report",
          label: "Open Report",
          type: AIActionType.primary,
        ),
      ],
      why: AIWhy(
        reasons: [
          "Monthly report generated successfully",
          "GA4 and Search Console data synchronized",
          "Ready for review",
        ],
      ),
    ),
    AIInsight(
      id: "forecast_q3",
      title: "Traffic is projected to grow by 12.5% next quarter",
      summary:
          "Current organic growth trends indicate positive momentum if SEO efforts are maintained.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected audience size of approximately 2.8M unique visitors for Q3.",
      ),
      why: AIWhy(
        reasons: [
          "Consistent month-over-month organic growth",
          "Higher return visitor rate",
          "Improved Core Web Vitals scores",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "prepare_content",
          title: "Prepare content calendar to sustain growth",
        ),
      ],
      actions: [
        AIAction(
          id: "forecast_report",
          label: "View Projection",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "planning",
          label: "Create SEO Strategy",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getAnalyticsActions() {
  return [
    AIActionItem(
      id: "generate_monthly_report",
      title: "Generate Monthly Traffic Report",
      description:
          "Create an executive summary for June web traffic performance including KPIs and channel breakdown.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "audit_core_vitals",
      title: "Audit Core Web Vitals for Landing Pages",
      description:
          "Automatically run Lighthouse tests on top 50 landing pages with high bounce rates.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.speed_outlined,
    ),

    AIActionItem(
      id: "forecast_q3",
      title: "Generate Traffic Forecast",
      description:
          "Predict visitor volume for the next quarter based on historical seasonality.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "analyze_social",
      title: "Analyze Social Media Acquisition",
      description:
          "Evaluate the conversion efficiency of active Facebook, X, and LinkedIn referral traffic.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.share_outlined,
    ),

    AIActionItem(
      id: "detect_404",
      title: "Detect 404 Error Spikes",
      description:
          "Identify broken links and missing assets causing 404 Not Found errors in the past 7 days.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.link_off_outlined,
    ),

    AIActionItem(
      id: "audience_segmentation",
      title: "Build Audience Segmentation",
      description:
          "Cluster users based on session duration, device type, and geolocation.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.groups_outlined,
    ),

    AIActionItem(
      id: "detect_bounce",
      title: "Analyze Bounce Rate Trends",
      description:
          "Analyze user navigation flow and identify pages with a high probability of immediate exit.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.call_missed_outgoing_outlined,
    ),

    AIActionItem(
      id: "workflow_tracking",
      title: "Create Event Tracking Workflow",
      description:
          "Generate custom Google Tag Manager configurations for tracking specific button clicks.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.code_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh Analytics Dashboard",
      description:
          "Synchronize real-time visitor metrics, charts, and geo-maps with the latest GA4 data.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly Traffic Summary",
      description:
          "Prepare a concise summary of key metric shifts, SEO opportunities, and performance risks.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getAnalyticsAgents() {
  return [
    AIAgent(
      id: "user_behavior_agent",
      name: "User Behavior Agent",
      description:
          "Analyzes session recordings, navigation paths, and recommends UX improvements.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.touch_app_outlined,
    ),

    AIAgent(
      id: "traffic_analyst",
      name: "Traffic Analyst",
      description:
          "Monitors visitor volume, detects anomalies, and generates audience insights.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.bar_chart_outlined,
    ),

    AIAgent(
      id: "seo_agent",
      name: "SEO & Campaign Agent",
      description:
          "Evaluates keyword rankings, backlinks, organic reach, and marketing ROI.",
      category: AIAgentCategory.marketing,
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.travel_explore_outlined,
    ),

    AIAgent(
      id: "performance_monitor",
      name: "Web Performance Monitor",
      description:
          "Monitors Core Web Vitals, server response times, and frontend errors.",
      category: AIAgentCategory.inventory,
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.speed_outlined,
    ),

    AIAgent(
      id: "conversion_advisor",
      name: "Conversion & Goal Advisor",
      description:
          "Analyzes funnel drop-offs, goal completions, and e-commerce transactions.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.shopping_cart_checkout_outlined,
    ),

    AIAgent(
      id: "tag_support_agent",
      name: "Tag & Tracking Support",
      description:
          "Validates event trackers, Google Tag Manager data layers, and API integrations.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.code_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getAnalyticsLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly Traffic Report",
      message: "Report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Traffic Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly Traffic Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Traffic Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "High Bounce Rate Alert",
      message: "Checkout page bounce rate exceeded 60% on mobile devices.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "User Behavior Agent",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Audience Analysis Started",
      message: "Analyzing Q2 visitor demographic breakdown.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Traffic Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Event Tracking Workflow",
      message: "New GTM triggers mapped successfully.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "Tag & Tracking Support",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "Missing Meta Tags",
      message: "43 indexed pages are missing standard meta descriptions.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "SEO & Campaign Agent",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Traffic Forecast Completed",
      message: "Q3 traffic and session forecast generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Traffic Analyst",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Search Console Synced",
      message: "Google Search Console keyword data updated.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "SEO & Campaign Agent",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "PageSpeed Sync Failed",
      message: "Failed to fetch Core Web Vitals from PSI API.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Web Performance Monitor",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "Google PSI API returned HTTP 429 Too Many Requests.",
    ),

    AILogItem(
      id: "log_010",
      title: "Funnel Drop-off Summary",
      message: "Registration funnel #F-1024 summarized successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Conversion & Goal Advisor",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Dashboard Refreshed",
      message: "Executive analytics dashboard metrics synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Weekly 404 Broken Link scan executed.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "Web Performance Monitor",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Slack Integration Failed",
      message: "Unable to send traffic alert to #marketing-alerts.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Slack API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Attribution Report Generated",
      message: "Multi-channel conversion attribution report completed.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Traffic Analyst",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Missing GA4 Tags",
      message: "23 internal URLs are missing global site tags.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "Tag & Tracking Support",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getAnalyticsSettings() {
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

// traffic conversation
final trafficConversation = [
  AIChatMessage(
    id: 'traf_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed the web analytics data for June. There are some interesting insights regarding your traffic.''',
  ),

  AIChatMessage(
    id: 'traf_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.dashboard_outlined,
        title: 'Traffic Overview',
        prompt: 'Show traffic overview',
      ),

      AIQuickAction(
        id: 'top_pages',
        icon: Icons.description_outlined,
        title: 'Top Landing Pages',
        prompt: 'Show top landing pages',
      ),

      AIQuickAction(
        id: 'conversion',
        icon: Icons.show_chart,
        title: 'Goal Conversion Rate',
        prompt: 'Analyze conversion rate',
      ),

      AIQuickAction(
        id: 'devices',
        icon: Icons.devices_outlined,
        title: 'Device Breakdown',
        prompt: 'Show device breakdown',
      ),
    ],
  ),

  AIChatMessage(
    id: 'traf_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze conversion rate',
  ),

  AIChatMessage(
    id: 'traf_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Goal conversion rate dropped by 12%.

The biggest causes:

• Page load time on mobile increased to 7.2 seconds

• 23% of users dropped off at the shipping form

• The main landing page has an unusually high bounce rate''',
  ),

  AIChatMessage(
    id: 'traf_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment', title: 'Segment by acquisition source'),

      AIQuickAction(id: 'funnel', title: 'Show funnel visualization'),
    ],
  ),

  AIChatMessage(
    id: 'traf_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last month',
  ),

  AIChatMessage(
    id: 'traf_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to May:

• E-commerce Conversion dropped by 12%

• Total Sessions increased by 8%

• Newsletter Signups dropped by 15%

I suspect the main issue lies within the mobile user experience.''',
  ),

  AIChatMessage(
    id: 'traf_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'lighthouse',
        icon: Icons.speed,
        title: 'Run Lighthouse Audit',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Notify UI/UX Team',
      ),
    ],
  ),

  AIChatMessage(
    id: 'traf_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as a Web Analytics Expert. Please perform a comparative analysis of the Goal Conversion Rate for this month versus last month.
Include the following components:

Quantitative Comparison: State the current month's conversion rate vs. last month's rate, showing the exact percentage point difference and the growth/decline percentage.

Segment Breakdown: Analyze the conversion rate across different segments (e.g., Organic Traffic, Paid Social, or Direct) to identify which channel performed best and which declined.

Funnel Analysis: Identify the specific page in the user journey where the most drop-offs occurred compared to last month.

Causal Insights: Provide potential reasons for the shift (e.g., changes in site speed, broken UI elements, or traffic quality).

Actionable Recommendations: Suggest 3 concrete steps to improve the conversion rate in the upcoming month.''',
  ),
];

// audience conversation

List<AIChatMessage> audienceConversation = [
  AIChatMessage(
    id: 'aud_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the audience retention and traffic growth data for Q2.

There are some interesting insights.
''',
  ),

  AIChatMessage(
    id: 'aud_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'aud_overview',
        icon: Icons.group_outlined,
        title: 'Audience Overview',
        prompt: 'Show audience overview',
      ),

      AIQuickAction(
        id: 'growth_breakdown',
        icon: Icons.trending_up,
        title: 'Traffic Growth',
        prompt: 'Analyze session growth',
      ),

      AIQuickAction(
        id: 'returning_impact',
        icon: Icons.assignment_return_outlined,
        title: 'New vs Returning',
        prompt: 'Analyze returning visitor ratio',
      ),

      AIQuickAction(
        id: 'geo_performance',
        icon: Icons.map_outlined,
        title: 'Geo Demographics',
        prompt: 'Show sessions by country',
      ),
    ],
  ),

  AIChatMessage(
    id: 'aud_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze session growth',
  ),

  AIChatMessage(
    id: 'aud_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Total Sessions grew by 14.5% this month.

The primary drivers:

• Organic search improvements added 12,400 new sessions

• Social media referral traffic increased by 6.8%

• This new acquisition completely offset a minor 2.1% drop in Direct traffic
''',
  ),

  AIChatMessage(
    id: 'aud_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'compare_quarter', title: 'Compare with last quarter'),

      AIQuickAction(id: 'geo_traffic', title: 'Breakdown by city'),

      AIQuickAction(id: 'top_landing', title: 'Show top entry pages'),
    ],
  ),

  AIChatMessage(
    id: 'aud_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_csv',
        icon: Icons.table_view,
        title: 'Export Audience CSV',
      ),

      AIQuickAction(
        id: 'share_marketing',
        icon: Icons.connect_without_contact,
        title: 'Share with SEO Team',
      ),

      AIQuickAction(
        id: 'adjust_forecast',
        icon: Icons.auto_graph,
        title: 'Update Q3 Projection',
      ),
    ],
  ),

  AIChatMessage(
    id: 'aud_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last quarter',
  ),

  AIChatMessage(
    id: 'aud_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Compared to Q1:

• Total Pageviews increased by 18.2%

• Pages per Session rose by 1.5 pages

• Average Session Duration improved by 45 seconds

The data indicates very healthy content engagement and improved site structure.
''',
  ),

  AIChatMessage(
    id: 'aud_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'sync_ga4',
        icon: Icons.sync,
        title: 'Sync GA4 Properties',
      ),

      AIQuickAction(
        id: 'slack_milestone',
        icon: Icons.celebration,
        title: 'Post Milestone to Slack',
      ),
    ],
  ),
];

List<AIChatMessage> bounceConversation = [
  AIChatMessage(
    id: 'bounce_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the bounce rate and user exit metrics for this month.

We have some critical pages that are bleeding traffic and need immediate attention.
''',
  ),

  AIChatMessage(
    id: 'bounce_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'bounce_rate',
        icon: Icons.gpp_bad_outlined,
        title: 'Bounce Rate Overview',
        prompt: 'Show bounce rate overview',
      ),

      AIQuickAction(
        id: 'exit_pages',
        icon: Icons.exit_to_app_outlined,
        title: 'Top Exit Pages',
        prompt: 'Analyze top exit pages',
      ),

      AIQuickAction(
        id: 'at_risk_funnels',
        icon: Icons.warning_amber_outlined,
        title: 'Broken Funnels',
        prompt: 'Identify broken user flows',
      ),

      AIQuickAction(
        id: 'device_dropoff',
        icon: Icons.smartphone_outlined,
        title: 'Device Drop-off',
        prompt: 'Show bounce rate by device',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bounce_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze top exit pages',
  ),

  AIChatMessage(
    id: 'bounce_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our site-wide bounce rate spiked by 3.4% compared to last month.

Based on session recordings and scroll depth, the main drivers are:

• Slow Rendering: 42% of mobile users leave before the hero image loads

• Intrusive Popups: 28% exited immediately when the newsletter modal appeared

• Confusing Navigation: 18% failed to find the pricing page link from the blog
''',
  ),

  AIChatMessage(
    id: 'bounce_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'compare_industry',
        title: 'Compare with industry benchmark',
      ),

      AIQuickAction(
        id: 'segment_os',
        title: 'Segment bounce by Operating System',
      ),

      AIQuickAction(id: 'ux_ideas', title: 'Show UX improvement options'),
    ],
  ),

  AIChatMessage(
    id: 'bounce_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_exit_list',
        icon: Icons.download_outlined,
        title: 'Export Exit Page List',
      ),

      AIQuickAction(
        id: 'trigger_hotjar',
        icon: Icons.visibility_outlined,
        title: 'View Hotjar Heatmaps',
      ),

      AIQuickAction(
        id: 'schedule_ux_meeting',
        icon: Icons.calendar_today_outlined,
        title: 'Sync with UX Team',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bounce_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show UX improvement options',
  ),

  AIChatMessage(
    id: 'bounce_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here are 3 recommended optimization strategies for our top exit points:

• For Slow Pages: Implement lazy loading for off-screen images and minify CSS.

• For Popups: Delay the newsletter modal trigger until the user scrolls 50% or shows exit-intent.

• For Navigation: Add a sticky header or clear Call-to-Action buttons at the end of blog posts.

Historical data shows a 12% improvement in retention using these targeted approaches.
''',
  ),

  AIChatMessage(
    id: 'bounce_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'create_jira_tickets',
        icon: Icons.bug_report_outlined,
        title: 'Create Tickets for Devs',
      ),

      AIQuickAction(
        id: 'slack_alert_design',
        icon: Icons.notifications_active_outlined,
        title: 'Alert Design Team on Slack',
      ),
    ],
  ),
];

List<AIChatMessage> acquisitionConversation = [
  AIChatMessage(
    id: 'acq_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the traffic acquisition report for this past week.

We are seeing some massive traffic growth, but quality and session duration are fluctuating by source.
''',
  ),

  AIChatMessage(
    id: 'acq_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'acq_overview',
        icon: Icons.share_outlined,
        title: 'Channels Overview',
        prompt: 'Show acquisition overview',
      ),

      AIQuickAction(
        id: 'paid_traffic',
        icon: Icons.ads_click_outlined,
        title: 'Paid vs Organic',
        prompt: 'Analyze paid vs organic traffic',
      ),

      AIQuickAction(
        id: 'referral_sources',
        icon: Icons.filter_alt_outlined,
        title: 'Top Referrals',
        prompt: 'Identify top referring domains',
      ),

      AIQuickAction(
        id: 'seo_performance',
        icon: Icons.travel_explore_outlined,
        title: 'Organic Search Queries',
        prompt: 'Show top performing search queries',
      ),
    ],
  ),

  AIChatMessage(
    id: 'acq_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze paid vs organic traffic',
  ),

  AIChatMessage(
    id: 'acq_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our Paid Search traffic is driving volume, but Organic Search has better retention.

Key observations across active mediums:

• Paid Social (Meta): Bounce rate is high (74%) due to audience fatigue on ad creatives

• Organic Search (Google): Converting exceptionally well with an average duration of 4m 20s

• Display Ads: Low engagement rates; Quality of incoming traffic is unsustainable here
''',
  ),

  AIChatMessage(
    id: 'acq_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'social_breakdown',
        title: 'Show breakdown of social channels',
      ),

      AIQuickAction(
        id: 'utm_analysis',
        title: 'Analyze UTM campaign parameters',
      ),

      AIQuickAction(
        id: 'competitor_share',
        title: 'Compare organic search share',
      ),
    ],
  ),

  AIChatMessage(
    id: 'acq_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'pause_display_ads',
        icon: Icons.pause_circle_outline,
        title: 'Pause Underperforming Ads',
      ),

      AIQuickAction(
        id: 'download_acq_deck',
        icon: Icons.slideshow_outlined,
        title: 'Export Source Analytics Slide',
      ),

      AIQuickAction(
        id: 'open_search_console',
        icon: Icons.open_in_new_outlined,
        title: 'Open Search Console',
      ),
    ],
  ),

  AIChatMessage(
    id: 'acq_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze UTM campaign parameters',
  ),

  AIChatMessage(
    id: 'acq_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on UTM tracking data, here is the performance of your recent tagged links:

• utm_campaign=summer_sale: Driving 1,500 highly engaged sessions, conversion rate is strong.

• utm_source=newsletter_june: Excellent retention, but CTR from the email was lower than expected.

• utm_medium=banner_affiliate: Showing 0 conversions, likely bot traffic or irrelevant placement.
''',
  ),

  AIChatMessage(
    id: 'acq_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'block_bot_traffic',
        icon: Icons.security_outlined,
        title: 'Configure Bot Exclusion',
      ),

      AIQuickAction(
        id: 'notif_mkt_slack',
        icon: Icons.maps_ugc_outlined,
        title: 'Notify Growth Team',
      ),
    ],
  ),
];

List<AIChatMessage> executiveConversation = [
  AIChatMessage(
    id: 'exec_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your executive cross-platform web analytics summary for this month.

All core metrics and acquisition channels are operating within healthy margins, with a few key highlights.
''',
  ),

  AIChatMessage(
    id: 'exec_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'kpi_summary',
        icon: Icons.insights_outlined,
        title: 'Core KPI Summary',
        prompt: 'Show core KPI summary',
      ),

      AIQuickAction(
        id: 'site_health',
        icon: Icons.speed_outlined,
        title: 'Site Technical Health',
        prompt: 'Check technical health status',
      ),

      AIQuickAction(
        id: 'traffic_cap',
        icon: Icons.cloud_done_outlined,
        title: 'Bandwidth & Server Load',
        prompt: 'Analyze server bandwidth usage',
      ),

      AIQuickAction(
        id: 'strategic_growth',
        icon: Icons.track_changes_outlined,
        title: 'SEO Strategic OKRs',
        prompt: 'Show SEO OKR progress tracking',
      ),
    ],
  ),

  AIChatMessage(
    id: 'exec_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show core KPI summary',
  ),

  AIChatMessage(
    id: 'exec_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level analytics matrix:

• Total Sessions: 142,500 (+12.4% MoM)

• Unique Active Users: 98,840 (+8.1% MoM)

• Average Engagement Time: 2m 14s (Healthy interaction)

• Goal Conversion Rate: 4.2% (Excellent funnel efficiency)
''',
  ),

  AIChatMessage(
    id: 'exec_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'breakdown_by_country',
        title: 'Breakdown traffic by country',
      ),

      AIQuickAction(
        id: 'view_anomalies',
        title: 'Check active tracking alerts',
      ),

      AIQuickAction(id: 'forecast_q3', title: 'View end-of-quarter forecast'),
    ],
  ),

  AIChatMessage(
    id: 'exec_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'download_board_deck',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Analytics Briefing PDF',
      ),

      AIQuickAction(
        id: 'trigger_data_sync',
        icon: Icons.cloud_sync_outlined,
        title: 'Force Global Data Refresh',
      ),
    ],
  ),

  AIChatMessage(
    id: 'exec_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check active tracking alerts',
  ),

  AIChatMessage(
    id: 'exec_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I detected 1 minor tracking anomaly requiring technical review:

• Client-side errors increased by 14% due to a failing script on the `/contact` page.

• Recommendation: Review the third-party CAPTCHA widget loading sequence to stabilize the browser thread.

No critical GA4 configuration issues or missing data streams detected.
''',
  ),

  AIChatMessage(
    id: 'exec_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_tag_manager',
        icon: Icons.admin_panel_settings_outlined,
        title: 'Open Tag Manager Console',
      ),

      AIQuickAction(
        id: 'notify_dev_lead',
        icon: Icons.forum_outlined,
        title: 'Ping Web Dev Team',
      ),
    ],
  ),
];

List<AIChatMessage> performanceConversation = [
  AIChatMessage(
    id: 'perf_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest Core Web Vitals and PageSpeed status report.

We have a few rendering bottlenecks that need your immediate review to avoid search ranking penalties.
''',
  ),

  AIChatMessage(
    id: 'perf_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'cwv_status',
        icon: Icons.speed_outlined,
        title: 'Core Web Vitals',
        prompt: 'Show core web vitals overview',
      ),

      AIQuickAction(
        id: 'cls_alerts',
        icon: Icons.warning_amber_outlined,
        title: 'Layout Shift (CLS) Alerts',
        prompt: 'Check high CLS pages',
      ),

      AIQuickAction(
        id: 'server_response',
        icon: Icons.storage_outlined,
        title: 'TTFB & Server Response',
        prompt: 'Analyze time to first byte',
      ),

      AIQuickAction(
        id: 'asset_size',
        icon: Icons.image_outlined,
        title: 'Heavy Assets',
        prompt: 'Show unoptimized heavy assets',
      ),
    ],
  ),

  AIChatMessage(
    id: 'perf_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check high CLS pages',
  ),

  AIChatMessage(
    id: 'perf_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
There are 3 high-traffic templates currently exceeding the 0.1 CLS (Cumulative Layout Shift) safe threshold:

• Blog Post Template: CLS is 0.25 (Caused by dynamically loading ad banners without fixed dimensions)

• Home Page: CLS is 0.15 (Web fonts loading late, causing text flash)

• Product Gallery: CLS is 0.12 (Images lacking explicit width and height attributes)
''',
  ),

  AIChatMessage(
    id: 'perf_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'fix_suggestions',
        title: 'Show code optimization recommendations',
      ),

      AIQuickAction(id: 'lighthouse_test', title: 'Run fresh Lighthouse test'),

      AIQuickAction(
        id: 'mobile_vs_desktop',
        title: 'Compare Mobile vs Desktop scores',
      ),
    ],
  ),

  AIChatMessage(
    id: 'perf_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'generate_report',
        icon: Icons.note_add_outlined,
        title: 'Draft Performance Report',
      ),

      AIQuickAction(
        id: 'view_source_code',
        icon: Icons.code_outlined,
        title: 'Inspect Page Source',
      ),

      AIQuickAction(
        id: 'download_audit',
        icon: Icons.download_for_offline_outlined,
        title: 'Export Technical Audit',
      ),
    ],
  ),

  AIChatMessage(
    id: 'perf_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show code optimization recommendations',
  ),

  AIChatMessage(
    id: 'perf_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on current rendering waterfalls, here is the optimized frontend strategy:

• Blog Posts: Add CSS `min-height` reservations for ad container `div`s before the JS injects the iframe.

• Home Page: Use `<link rel="preload" as="font">` for your primary WOFF2 files and apply `font-display: swap`.

• Product Gallery: Automatically inject `width` and `height` properties to all `<img>` tags via your CMS templates.

Applying these updates will secure "Good" Core Web Vitals URLs for the next search index crawl.
''',
  ),

  AIChatMessage(
    id: 'perf_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'create_pr',
        icon: Icons.merge_type_outlined,
        title: 'Suggest Code to Repo',
      ),

      AIQuickAction(
        id: 'notify_frontend',
        icon: Icons.mail_outline,
        title: 'Email Frontend Devs',
      ),
    ],
  ),
];

List<AIChatMessage> referralConversation = [
  AIChatMessage(
    id: 'ref_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have evaluated our referral traffic and backlink profile matrix for this quarter.

We have a few updates regarding new linking domains and minor authority drops from some older partners.
''',
  ),

  AIChatMessage(
    id: 'ref_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'domain_authority',
        icon: Icons.stacked_bar_chart_outlined,
        title: 'Authority Scorecard',
        prompt: 'Show domain authority scorecard',
      ),

      AIQuickAction(
        id: 'new_backlinks',
        icon: Icons.link_outlined,
        title: 'New Backlinks',
        prompt: 'Analyze new referring domains',
      ),

      AIQuickAction(
        id: 'lost_links',
        icon: Icons.link_off_outlined,
        title: 'Lost Backlinks',
        prompt: 'Check recently lost links',
      ),

      AIQuickAction(
        id: 'toxic_links',
        icon: Icons.warning_outlined,
        title: 'Toxic Score',
        prompt: 'Review toxic link profile',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ref_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze new referring domains',
  ),

  AIChatMessage(
    id: 'ref_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
We acquired 18 new referring domains in the last 14 days, driving a 1.8% increase in overall Trust Flow.

Key factors and specific domain performance:

• TechCrunch (DA 92): Linked to our latest press release, driving 4,500 highly engaged referral sessions.

• Github (DA 95): Steady referral traffic from the open-source repository readme.

• Medium Blogs: Average referral volume, mostly contextual links from tutorials.
''',
  ),

  AIChatMessage(
    id: 'ref_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'view_anchor_text',
        title: 'Show anchor text distribution',
      ),

      AIQuickAction(
        id: 'outreach_targets',
        title: 'Find similar outreach targets',
      ),

      AIQuickAction(
        id: 'competitor_links',
        title: 'Review competitor backlinks',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ref_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_ahrefs',
        icon: Icons.travel_explore_outlined,
        title: 'Open SEO Tool Portal',
      ),

      AIQuickAction(
        id: 'download_link_report',
        icon: Icons.description_outlined,
        title: 'Export Backlink Report',
      ),

      AIQuickAction(
        id: 'disavow_file',
        icon: Icons.block_outlined,
        title: 'Generate Disavow File',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ref_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Find similar outreach targets',
  ),

  AIChatMessage(
    id: 'ref_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have identified 2 vetted high-authority domains related to TechCrunch that haven't linked to us yet:

• The Verge (DA 90): Often covers similar software releases. Their editorial team is currently accepting guest contributions.

• Smashing Magazine (DA 87): Ideal for our design-related UI kit content. They have a resource roundup published monthly.

Securing a link from either will significantly boost our rankings for the "Flutter Dashboard" keyword cluster.
''',
  ),

  AIChatMessage(
    id: 'ref_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'draft_pitch',
        icon: Icons.edit_note_outlined,
        title: 'Draft Pitch Email',
      ),

      AIQuickAction(
        id: 'notify_pr',
        icon: Icons.campaign_outlined,
        title: 'Alert PR Team',
      ),
    ],
  ),
];

List<AIChatMessage> conversionConversation = [
  AIChatMessage(
    id: 'conv_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest macro and micro conversion updates for this week.

We have a strong surge in form submissions, but some e-commerce transactions are stalling at the final step.
''',
  ),

  AIChatMessage(
    id: 'conv_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'goal_value',
        icon: Icons.monetization_on_outlined,
        title: 'Goal Value',
        prompt: 'Show total goal value',
      ),

      AIQuickAction(
        id: 'top_events',
        icon: Icons.touch_app_outlined,
        title: 'Top Events',
        prompt: 'Show top tracked events',
      ),

      AIQuickAction(
        id: 'checkout_funnel',
        icon: Icons.shopping_cart_checkout_outlined,
        title: 'Checkout Funnel',
        prompt: 'Analyze checkout behavior',
      ),

      AIQuickAction(
        id: 'stalled_conversions',
        icon: Icons.hourglass_disabled_outlined,
        title: 'Cart Abandonment',
        prompt: 'Identify abandoned carts',
      ),
    ],
  ),

  AIChatMessage(
    id: 'conv_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify abandoned carts',
  ),

  AIChatMessage(
    id: 'conv_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 2 high-value segments that have been abandoning the checkout process right after viewing shipping costs:

• International Users (EU Region): Dropping off mostly on the final review step.

• Mobile Safari Users: Experiencing friction with the Apple Pay integration button loading slowly.

Resolving these could push our monthly transaction target up by 5%.
''',
  ),

  AIChatMessage(
    id: 'conv_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'view_eu_behavior', title: 'View EU user flow'),

      AIQuickAction(id: 'test_apple_pay', title: 'Run Safari payment test'),

      AIQuickAction(
        id: 'abandonment_emails',
        title: 'Check recovery email stats',
      ),
    ],
  ),

  AIChatMessage(
    id: 'conv_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_ga4_explore',
        icon: Icons.open_in_browser_outlined,
        title: 'Open Exploration Tool',
      ),

      AIQuickAction(
        id: 'assign_qa',
        icon: Icons.bug_report_outlined,
        title: 'Assign QA to Intervene',
      ),

      AIQuickAction(
        id: 'download_funnel',
        icon: Icons.trending_up_outlined,
        title: 'Export Funnel PDF',
      ),
    ],
  ),

  AIChatMessage(
    id: 'conv_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check recovery email stats',
  ),

  AIChatMessage(
    id: 'conv_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have auto-generated an overview of our current "Cart Abandonment Recovery Workflow". 

The brief shows:
• Open Rate: 42% (Above industry average)
• Click-Through Rate: 8% (Slightly low)
• Recovery Conversion Rate: 2.1%

Sending a dynamic discount code within the second reminder email (24 hours later) has historically accelerated the recovery loop.
''',
  ),

  AIChatMessage(
    id: 'conv_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'update_email_flow',
        icon: Icons.forward_to_inbox_outlined,
        title: 'Update Automation Rules',
      ),

      AIQuickAction(
        id: 'slack_ecommerce',
        icon: Icons.tag_outlined,
        title: 'Share in #ecommerce-alerts',
      ),
    ],
  ),
];

List<AIChatMessage> adSpendConversation = [
  AIChatMessage(
    id: 'ads_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have cross-referenced our acquisition costs against the Q2 traffic volume plan.

We are currently trending under budget overall, but a few PPC (Pay-Per-Click) categories are showing a high variance in CPC (Cost Per Click).
''',
  ),

  AIChatMessage(
    id: 'ads_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'cpc_vs_actual',
        icon: Icons.balance_outlined,
        title: 'Target vs Actual CPC',
        prompt: 'Show target vs actual CPC',
      ),

      AIQuickAction(
        id: 'spend_breakdown',
        icon: Icons.pie_chart_outline,
        title: 'Spend Breakdown',
        prompt: 'Analyze ad channel expenses',
      ),

      AIQuickAction(
        id: 'bid_optimization',
        icon: Icons.savings_outlined,
        title: 'Bid Optimization',
        prompt: 'Identify CPC saving opportunities',
      ),

      AIQuickAction(
        id: 'roas_caps',
        icon: Icons.account_balance_wallet_outlined,
        title: 'ROAS Limits',
        prompt: 'Show minimum ROAS by campaign',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ads_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show target vs actual CPC',
  ),

  AIChatMessage(
    id: 'ads_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our blended CPC sits at \$1.84 for this quarter. 

However, we have significant variance in these specific campaigns:

• Google Search (Non-Branded): \$3.20 actual vs \$2.50 target (+28% Over cost)

• Facebook Retargeting: \$0.85 actual vs \$1.00 target (-15% Under cost)

• LinkedIn B2B: \$5.40 actual vs \$5.50 target (-1.8% Under cost)
''',
  ),

  AIChatMessage(
    id: 'ads_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'search_deep_dive', title: 'Analyze search CPC spike'),

      AIQuickAction(id: 'reallocate_fb_budget', title: 'Reallocate FB surplus'),

      AIQuickAction(id: 'view_keyword_bids', title: 'Check expensive keywords'),
    ],
  ),

  AIChatMessage(
    id: 'ads_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_ad_ledger',
        icon: Icons.receipt_long_outlined,
        title: 'Export Ad Spend Ledger',
      ),

      AIQuickAction(
        id: 'adjust_bid_limits',
        icon: Icons.tune_outlined,
        title: 'Adjust Max CPC Caps',
      ),

      AIQuickAction(
        id: 'pause_expensive',
        icon: Icons.pause_circle_outlined,
        title: 'Pause Expensive Terms',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ads_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Reallocate FB surplus',
  ),

  AIChatMessage(
    id: 'ads_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have prepared a reallocation model to stabilize our Google Search overages using the highly efficient Facebook retargeting surplus:

• Transfer \$3,500 from the top-of-funnel display ads directly into the high-intent Google Search exact-match keyword clusters.

• Adjust the Smart Bidding algorithm on Facebook to maximize conversions with the remaining budget.

This adjustment neutralizes our high CPC penalty by focusing on visitors with higher conversion intent.
''',
  ),

  AIChatMessage(
    id: 'ads_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'execute_bid_change',
        icon: Icons.swap_horiz,
        title: 'Execute Platform Transfer',
      ),

      AIQuickAction(
        id: 'notify_media_buyer',
        icon: Icons.mail_outline,
        title: 'Send Notice to Agency',
      ),
    ],
  ),
];

List<AIChatMessage> weeklyAnalyticsConversation = [
  AIChatMessage(
    id: 'wkanl_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly site traffic and SEO indexation report.

Overall organic visibility is high, but we have a couple of crawl blockers threatening our new page indexation.
''',
  ),

  AIChatMessage(
    id: 'wkanl_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'crawl_stats',
        icon: Icons.language_outlined,
        title: 'Crawl Stats',
        prompt: 'Show weekly Googlebot crawl stats',
      ),

      AIQuickAction(
        id: 'index_velocity',
        icon: Icons.speed_outlined,
        title: 'Index Velocity',
        prompt: 'Analyze new page indexation',
      ),

      AIQuickAction(
        id: 'active_errors',
        icon: Icons.gpp_bad_outlined,
        title: 'Active Errors',
        prompt: 'Identify active crawl errors',
      ),

      AIQuickAction(
        id: 'next_content',
        icon: Icons.next_plan_outlined,
        title: 'Content Gaps',
        prompt: 'Show keyword gaps for next week',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkanl_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify active crawl errors',
  ),

  AIChatMessage(
    id: 'wkanl_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
We currently have 2 critical blockers preventing Search Engines from accessing new URLs:

• Robots.txt Misconfiguration: The `/products/` directory is accidentally being blocked by a wildcard disallow rule.

• Server 500 Errors: 12 dynamic URLs are timing out during rendering, causing Googlebot to abandon the crawl.

Resolving these today keeps our organic indexation perfectly on track.
''',
  ),

  AIChatMessage(
    id: 'wkanl_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'view_server_logs', title: 'View server error logs'),

      AIQuickAction(id: 'validate_robots', title: 'Test robots.txt file'),

      AIQuickAction(id: 'reindex_request', title: 'Request manual indexing'),
    ],
  ),

  AIChatMessage(
    id: 'wkanl_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_gsc',
        icon: Icons.travel_explore_outlined,
        title: 'Open Search Console',
      ),

      AIQuickAction(
        id: 'download_audit_weekly',
        icon: Icons.summarize_outlined,
        title: 'Export SEO Audit Brief',
      ),

      AIQuickAction(
        id: 'schedule_dev_sync',
        icon: Icons.calendar_today_outlined,
        title: 'Schedule Dev Sync',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkanl_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'View server error logs',
  ),

  AIChatMessage(
    id: 'wkanl_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I analyzed the last 50 server logs for Googlebot requests. 

The core issue stems from an outdated caching plugin conflicting with the new URL routing, which triggers a `500 Internal Server Error` before the HTML can generate.

Clearing the cache and updating the plugin rules will fix the crawl failures immediately.
''',
  ),

  AIChatMessage(
    id: 'wkanl_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'purge_cache',
        icon: Icons.build_circle_outlined,
        title: 'Purge Global Cache',
      ),

      AIQuickAction(
        id: 'ping_devops_channel',
        icon: Icons.bolt,
        title: 'Alert DevOps Channel on Slack',
      ),
    ],
  ),
];

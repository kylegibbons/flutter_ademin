import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for SaaS dashboard demo.
AIOperatorData getSaaSAIOperatorData() {
  return AIOperatorData(
    home: getSaaSHome(),
    conversations: getSaaSConversations(),
    insights: getSaaSInsights(),
    actions: getSgetActionItems(),
    agents: getSaasAgents(),
    logs: getSaasLogs(),
  );
}

/// Returns the SaaS home screen configuration
AIHome getSaaSHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your SaaS subscription metrics, MRR growth, and user churn. Ask any questions or choose an analysis below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "SaaS Overview",
        prompt: "Show SaaS overview",
      ),
      AIQuickAction(
        id: "mrr",
        icon: Icons.monetization_on_outlined,
        title: "MRR & ARR Growth",
        prompt: "Show MRR and ARR growth trend",
      ),
      AIQuickAction(
        id: "churn",
        icon: Icons.trending_down_outlined,
        title: "Customer Churn",
        prompt: "Analyze customer churn rate",
      ),
      AIQuickAction(
        id: "trials",
        icon: Icons.timer_outlined,
        title: "Trial Conversions",
        prompt: "Show trial-to-paid conversion rate",
      ),
      AIQuickAction(
        id: "ltv_cac",
        icon: Icons.balance_outlined,
        title: "LTV vs CAC",
        prompt: "Analyze LTV to CAC ratio",
      ),
      AIQuickAction(
        id: "infrastructure",
        icon: Icons.cloud_done_outlined,
        title: "System Uptime",
        prompt: "Check API and infrastructure health",
      ),
    ],
  );
}

/// Returns the list of SaaS conversations
List<AIConversation> getSaaSConversations() {
  return [
    AIConversation(
      id: "mrr_trend",
      title: "MRR Growth Analysis",
      preview:
          "MRR grew by 14.5% this month, driven by enterprise tier upgrades.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 3,
      chat: mrrSaasConversation,
    ),
    AIConversation(
      id: "churn_analysis",
      title: "Churn Rate Alert",
      preview: "Logo churn spiked by 2.4% among self-serve tier accounts.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: churnSaasConversation,
    ),
    AIConversation(
      id: "trial_conversion",
      title: "Trial Conversions",
      preview:
          "Free trial conversion rate improved to 8.2% after onboarding tweak.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: trialSaasConversation,
    ),
    AIConversation(
      id: "expansion_revenue",
      title: "Expansion & Add-ons",
      preview: "Seat-based upgrades added \$12,400 in net new expansion MRR.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: expansionConversation,
    ),
    AIConversation(
      id: "executive_saas",
      title: "Executive SaaS Board",
      preview:
          "Executive SaaS overview and cohort retention updated successfully.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: executiveSaasConversation,
    ),
    AIConversation(
      id: "api_health",
      title: "API Performance",
      preview: "Webhook delivery success rate is at 99.98% for this epoch.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: apiSaasConversation,
    ),
    AIConversation(
      id: "customer_success",
      title: "CS Account Health",
      preview: "15 enterprise accounts flagged as low engagement risk.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: customerSuccessConversation,
    ),
    AIConversation(
      id: "pricing_tiers",
      title: "Pricing Strategy",
      preview: "Pro tier annual billing adoption increased by 22% MoM.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: pricingConversation,
    ),
    AIConversation(
      id: "gateway_ops",
      title: "Billing Gateway",
      preview: "Stripe invoicing webhooks synchronized with accounting ledger.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: billingSaasConversation,
    ),
    AIConversation(
      id: "weekly_saas",
      title: "Weekly SaaS Standup",
      preview: "ARR crossed \$1.8M milestone, net revenue retention at 112%.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklySaasConversation,
    ),
  ];
}

/// Returns the list of SaaS insights for AI operator
List<AIInsight> getSaaSInsights() {
  return [
    AIInsight(
      id: "churn_spike",
      title: "Logo churn spiked 2.4% among self-serve tier accounts",
      summary:
          "An unusual number of monthly subscribers cancelled their subscriptions immediately following the latest billing cycle.",
      description:
          "AI detected a sustained rise in cancellations over the past week. The primary exit survey reason is 'Lack of feature usage' and unexpected price tier limitations.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 93),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated MRR loss of approximately \$3,400/month if retention workflows are not triggered.",
      ),
      why: AIWhy(
        reasons: [
          "Inactivity: 60% of churned users hadn't logged in for 10+ days",
          "Friction in self-serve cancellation flow",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "trigger_winback",
          title: "Launch win-back email campaign with 20% discount",
        ),
        AISuggestion(
          id: "review_onboarding",
          title: "Improve self-serve activation email sequence",
        ),
      ],
      actions: [
        AIAction(
          id: "view_churn_cohort",
          label: "View Churn Cohort",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "deploy_retention",
          label: "Deploy Retention Flow",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "mrr_expansion",
      title: "Expansion MRR grew by 18% due to seat add-ons",
      summary:
          "Existing enterprise customers are rapidly upgrading their workspaces and adding extra seat licenses.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 96),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Net Revenue Retention (NRR) reached a record high of 114%.",
      ),
      why: AIWhy(
        reasons: [
          "New team collaboration feature released last month",
          "Successful automated upsell prompts when hitting limits",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "target_upsell",
          title: "Run targeted upsell campaign for accounts near capacity",
        ),
      ],
      actions: [
        AIAction(
          id: "view_expansion",
          label: "View Expansion Metrics",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "push_upsell",
          label: "Automate Upsell Rule",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "trial_drop",
      title: "Trial conversion rate dropped on mobile devices",
      summary:
          "Users signing up via mobile browsers exhibit a 40% lower activation rate compared to desktop users.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 85),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Potential loss of 120+ paid conversions per month from mobile acquisition channels.",
      ),
      why: AIWhy(
        reasons: [
          "Onboarding wizard layout breaks on small screens",
          "Password confirmation field bug on Safari mobile",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "fix_mobile_ui",
          title: "Fix mobile onboarding CSS bug",
        ),
      ],
      actions: [
        AIAction(
          id: "view_funnel",
          label: "View Trial Funnel",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "alert_frontend",
          label: "Create Jira Ticket",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_saas_report",
      title: "Monthly SaaS Financial & Cohort Report is ready",
      summary:
          "The comprehensive SaaS subscription report for June 2026 has been successfully generated.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into MRR movements, ARR, LTV:CAC ratio, and cohort retention.",
      ),
      actions: [
        AIAction(
          id: "open_report",
          label: "Open PDF Report",
          type: AIActionType.primary,
        ),
      ],
      why: AIWhy(
        reasons: [
          "End of month financial reconciliation complete",
          "Stripe and billing ledgers synchronized",
        ],
      ),
    ),
    AIInsight(
      id: "arr_forecast",
      title: "ARR is projected to cross \$2M next quarter",
      summary:
          "Current pipeline velocity and net revenue retention indicate strong multi-tenant growth.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 82),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected 15% increase in annual recurring revenue for Q3.",
      ),
      why: AIWhy(
        reasons: [
          "Consistent compounding MRR growth",
          "Low enterprise churn rate (< 0.8%)",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "expand_sales",
          title: "Hire additional enterprise account executive",
        ),
      ],
      actions: [
        AIAction(
          id: "view_forecast",
          label: "View Forecast Model",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "approve_budget",
          label: "Approve Hiring Plan",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getSgetActionItems() {
  return [
    AIActionItem(
      id: "generate_saas_report",
      title: "Generate Monthly SaaS Metric Report",
      description:
          "Create executive summary including MRR breakdown, churn cohorts, and NRR.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "trigger_winback",
      title: "Launch Churn Winback Sequence",
      description:
          "Automatically email recently cancelled self-serve subscribers with special retention offers.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.mail_outline,
    ),

    AIActionItem(
      id: "forecast_arr",
      title: "Generate ARR Projection Model",
      description:
          "Predict annual recurring revenue for the next 4 quarters based on growth trends.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "analyze_activation",
      title: "Analyze User Activation Funnel",
      description:
          "Evaluate drop-off rates across multi-step product onboarding wizard.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.filter_alt_outlined,
    ),

    AIActionItem(
      id: "audit_subscriptions",
      title: "Audit Failed Invoices & Dunning",
      description:
          "Scan Stripe ledger for expired credit cards and trigger automated dunning emails.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.credit_card_off_outlined,
    ),

    AIActionItem(
      id: "customer_segmentation",
      title: "Build LTV Segmentation",
      description:
          "Cluster customers into tiers based on usage intensity and lifetime value.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.groups_outlined,
    ),

    AIActionItem(
      id: "detect_downgrades",
      title: "Detect Account Downgrade Risks",
      description:
          "Identify workspaces with declining activity that are likely to downgrade plans.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.trending_down_outlined,
    ),

    AIActionItem(
      id: "workflow_billing",
      title: "Automate Billing Webhooks",
      description:
          "Setup instant synchronization between payment gateway events and internal database.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.account_tree_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh SaaS Executive Board",
      description:
          "Synchronize real-time billing metrics, MRR counters, and active tenant data.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly SaaS Brief",
      description:
          "Prepare a concise summary of new signups, MRR net adds, and open support tickets.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getSaasAgents() {
  return [
    AIAgent(
      id: "saas_growth_agent",
      name: "SaaS Growth Agent",
      description:
          "Monitors MRR expansion, trial conversion rates, and acquisition funnel efficiency.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.trending_up_outlined,
    ),

    AIAgent(
      id: "revenue_analyst",
      name: "Revenue Analyst",
      description:
          "Analyzes ARR, LTV to CAC ratios, churn cohorts, and net revenue retention.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.monetization_on_outlined,
    ),

    AIAgent(
      id: "customer_success_agent",
      name: "Customer Success Bot",
      description:
          "Tracks user engagement scores, identifies churn risks, and triggers proactive outreach.",
      category: AIAgentCategory.marketing,
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.support_agent_outlined,
    ),

    AIAgent(
      id: "uptime_monitor",
      name: "Infrastructure Monitor",
      description:
          "Monitors API response times, server uptime, database latency, and webhooks.",
      category: AIAgentCategory.inventory,
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.cloud_done_outlined,
    ),

    AIAgent(
      id: "billing_advisor",
      name: "Billing & Dunning Advisor",
      description:
          "Manages payment gateways, failed subscription invoices, and automated dunning flows.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.credit_card_outlined,
    ),

    AIAgent(
      id: "support_desk_agent",
      name: "Support Desk Agent",
      description:
          "Summarizes incoming support tickets, categorizes bugs, and suggests knowledge base articles.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.forum_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getSaasLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly SaaS Metric Report",
      message: "Report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "SaaS Growth Agent",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly SaaS Metric Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "SaaS Growth Agent",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "Logo Churn Spike",
      message: "Self-serve tier churn rate increased by 2.4% this week.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "Revenue Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Activation Analysis Started",
      message: "Analyzing onboarding drop-off rates.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "SaaS Growth Agent",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Winback Flow Triggered",
      message: "Automated retention emails sent to 45 churned users.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "Customer Success Bot",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "Failed Dunning Charge",
      message: "12 credit card charges failed due to insufficient funds.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Billing & Dunning Advisor",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "ARR Forecast Completed",
      message: "Q3 ARR projection model generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Revenue Analyst",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Stripe Billing Synced",
      message: "Subscription events and invoices updated.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "Billing & Dunning Advisor",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "API Gateway Timeout",
      message: "Failed to fetch telemetry data from secondary region.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Infrastructure Monitor",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "AWS API Gateway returned HTTP 504 Gateway Timeout.",
    ),

    AILogItem(
      id: "log_010",
      title: "Support Ticket Summary",
      message: "Ticket #SR-8802 summarized successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Support Desk Agent",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Executive Board Refreshed",
      message: "SaaS dashboard counters synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Low Engagement Risk workflow executed.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "Customer Success Bot",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Slack Integration Failed",
      message: "Unable to send alert to #saas-metrics.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Slack API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Cohort Retention Report",
      message: "Monthly user retention matrix completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Revenue Analyst",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Unverified Workspaces",
      message: "23 trial accounts contain incomplete organization details.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "SaaS Growth Agent",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getSaaSRealSettings() {
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

// mrr conversation
final mrrSaasConversation = [
  AIChatMessage(
    id: 'mrr_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed the SaaS subscription and MRR growth data for June. There are some interesting expansion insights.''',
  ),

  AIChatMessage(
    id: 'mrr_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.dashboard_outlined,
        title: 'MRR Overview',
        prompt: 'Show MRR overview',
      ),

      AIQuickAction(
        id: 'expansion',
        icon: Icons.trending_up,
        title: 'Expansion MRR',
        prompt: 'Analyze expansion MRR',
      ),

      AIQuickAction(
        id: 'conversion',
        icon: Icons.show_chart,
        title: 'Trial Conversion',
        prompt: 'Analyze trial conversion rate',
      ),

      AIQuickAction(
        id: 'cohorts',
        icon: Icons.groups_outlined,
        title: 'Cohort Retention',
        prompt: 'Show cohort retention matrix',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mrr_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze expansion MRR',
  ),

  AIChatMessage(
    id: 'mrr_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Expansion MRR grew by 14.5% this month.

The biggest drivers:

• Seat add-ons from enterprise workspaces added \$12,400

• Upgrades from Pro to Enterprise tier increased by 6.8%

• Expansion easily offset a minor 2.4% logo churn rate''',
  ),

  AIChatMessage(
    id: 'mrr_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment', title: 'Segment by pricing plan'),

      AIQuickAction(id: 'nrr', title: 'Calculate Net Revenue Retention'),
    ],
  ),

  AIChatMessage(
    id: 'mrr_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last month',
  ),

  AIChatMessage(
    id: 'mrr_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to May:

• MRR grew by 14.5% (Total: \$154,200)

• New Customer MRR increased by 8%

• Churn MRR increased by \$1,200

I suspect the churn increase is concentrated in the lowest self-serve tier.''',
  ),

  AIChatMessage(
    id: 'mrr_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_mrr',
        icon: Icons.table_view,
        title: 'Export MRR Ledger CSV',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Notify Finance Channel',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mrr_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as a SaaS Metrics Expert. Please perform a comparative analysis of MRR growth for this month versus last month.
Include the following components:

Quantitative Comparison: State current MRR vs last month's MRR, net new MRR, and growth percentage.

Segment Breakdown: Analyze MRR across Self-Serve, Pro, and Enterprise tiers.

Retention Analysis: Evaluate Net Revenue Retention (NRR) and Gross Churn.

Causal Insights: Identify primary drivers for expansion and contraction.

Actionable Recommendations: Suggest 3 concrete steps to boost expansion MRR next month.''',
  ),
];

// churn conversation
List<AIChatMessage> churnSaasConversation = [
  AIChatMessage(
    id: 'chn_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the customer churn and retention metrics for this month.

We have a spike in cancellations in the self-serve tier that needs your attention.
''',
  ),

  AIChatMessage(
    id: 'chn_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'churn_rate',
        icon: Icons.gpp_bad_outlined,
        title: 'Churn Overview',
        prompt: 'Show churn rate overview',
      ),

      AIQuickAction(
        id: 'exit_reasons',
        icon: Icons.help_outline,
        title: 'Exit Survey Reasons',
        prompt: 'Analyze reasons for churn',
      ),

      AIQuickAction(
        id: 'at_risk',
        icon: Icons.warning_amber_outlined,
        title: 'At-Risk Accounts',
        prompt: 'Identify at-risk workspaces',
      ),
    ],
  ),

  AIChatMessage(
    id: 'chn_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze reasons for churn',
  ),

  AIChatMessage(
    id: 'chn_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our logo churn spiked by 2.4% this month.

Based on exit surveys and app activity logs:

• Inactivity: 60% of churned users hadn't logged in for 14 days

• Price Sensitivity: 25% switched to a cheaper competitor tool

• Missing Features: 15% requested advanced SSO integrations available only on enterprise
''',
  ),

  AIChatMessage(
    id: 'chn_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'winback_flow', title: 'Show win-back email templates'),
      AIQuickAction(id: 'cs_outreach', title: 'Trigger proactive CS alerts'),
    ],
  ),

  AIChatMessage(
    id: 'chn_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_churn',
        icon: Icons.download_outlined,
        title: 'Export Churn List CSV',
      ),
    ],
  ),
];

// trial conversation
List<AIChatMessage> trialSaasConversation = [
  AIChatMessage(
    id: 'trl_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the free trial conversion performance report for this week.

Conversion rates have improved following our recent onboarding updates.
''',
  ),

  AIChatMessage(
    id: 'trl_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'trial_overview',
        icon: Icons.timer_outlined,
        title: 'Trial Funnel',
        prompt: 'Show trial conversion overview',
      ),

      AIQuickAction(
        id: 'activation_rate',
        icon: Icons.bolt_outlined,
        title: 'User Activation',
        prompt: 'Analyze activation milestones',
      ),
    ],
  ),

  AIChatMessage(
    id: 'trl_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show trial conversion overview',
  ),

  AIChatMessage(
    id: 'trl_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our 14-day free trial conversion rate sits at 8.2% (up 1.5% MoM).

Key milestones:
• Email Verification: 92% completion rate
• Core Feature Trigger ("Aha Moment"): 45% completion rate within 24 hours
• Trial-to-Paid Upgrade: 8.2% successfully converted before trial expiry
''',
  ),

  AIChatMessage(
    id: 'trl_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'extend_trial',
        title: 'Configure automated trial extension rules',
      ),
    ],
  ),

  AIChatMessage(
    id: 'trl_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_mixpanel',
        icon: Icons.insights_outlined,
        title: 'Open Product Analytics',
      ),
    ],
  ),
];

// expansion conversation
List<AIChatMessage> expansionConversation = [
  AIChatMessage(
    id: 'exp_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the cross-sell and upsell metrics for our existing tenant base.

Expansion revenue is performing exceptionally well this quarter.
''',
  ),

  AIChatMessage(
    id: 'exp_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'expansion_mrr',
        icon: Icons.trending_up,
        title: 'Expansion MRR',
        prompt: 'Show expansion MRR breakdown',
      ),
    ],
  ),

  AIChatMessage(
    id: 'exp_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show expansion MRR breakdown',
  ),

  AIChatMessage(
    id: 'exp_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Expansion MRR contributed \$12,400 net new recurring revenue this month.

• Seat Add-ons: 65% of expansion
• Plan Upgrades (Pro to Enterprise): 25% of expansion
• Add-on Storage Purchases: 10% of expansion
''',
  ),

  AIChatMessage(
    id: 'exp_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'identify_candidates',
        title: 'Identify workspaces close to seat limits',
      ),
    ],
  ),

  AIChatMessage(
    id: 'exp_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_stripe_billing',
        icon: Icons.receipt_long_outlined,
        title: 'View Stripe Subscriptions',
      ),
    ],
  ),
];

// executive saas conversation
List<AIChatMessage> executiveSaasConversation = [
  AIChatMessage(
    id: 'execs_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your executive SaaS dashboard summary for this month.

All core metrics—MRR, ARR, NRR, and LTV:CAC—are operating within healthy margins.
''',
  ),

  AIChatMessage(
    id: 'execs_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'saas_kpis',
        icon: Icons.insights_outlined,
        title: 'SaaS Core KPIs',
        prompt: 'Show SaaS core KPI summary',
      ),
    ],
  ),

  AIChatMessage(
    id: 'execs_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show SaaS core KPI summary',
  ),

  AIChatMessage(
    id: 'execs_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level SaaS performance matrix:

• Monthly Recurring Revenue (MRR): \$154,200 (+14.5% MoM)

• Annual Recurring Revenue (ARR): \$1,850,400

• Net Revenue Retention (NRR): 114% (World-class retention)

• Customer LTV to CAC Ratio: 5.2x (Highly efficient acquisition)
''',
  ),

  AIChatMessage(
    id: 'execs_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'forecast_q3',
        title: 'View end-of-quarter ARR projection',
      ),
    ],
  ),

  AIChatMessage(
    id: 'execs_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_board_pdf',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Board Briefing PDF',
      ),
    ],
  ),
];

// api saas conversation
List<AIChatMessage> apiSaasConversation = [
  AIChatMessage(
    id: 'apis_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the infrastructure and API performance report.

System uptime and webhook delivery speeds remain optimal.
''',
  ),

  AIChatMessage(
    id: 'apis_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'uptime_status',
        icon: Icons.cloud_done_outlined,
        title: 'API Uptime',
        prompt: 'Show API uptime metrics',
      ),
    ],
  ),

  AIChatMessage(
    id: 'apis_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show API uptime metrics',
  ),

  AIChatMessage(
    id: 'apis_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
API Gateway Performance:

• Uptime: 99.98% over the last 30 days
• Average Response Latency: 84ms
• Webhook Delivery Success Rate: 99.95%
''',
  ),

  AIChatMessage(
    id: 'apis_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'check_logs', title: 'View AWS CloudWatch error logs'),
    ],
  ),

  AIChatMessage(
    id: 'apis_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_aws_console',
        icon: Icons.admin_panel_settings_outlined,
        title: 'Open AWS Console',
      ),
    ],
  ),
];

// customer success conversation
List<AIChatMessage> customerSuccessConversation = [
  AIChatMessage(
    id: 'cs_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed customer success engagement scores and workspace health telemetry.

We have 15 enterprise accounts showing signs of disengagement.
''',
  ),

  AIChatMessage(
    id: 'cs_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'health_scores',
        icon: Icons.health_and_safety_outlined,
        title: 'Account Health Scores',
        prompt: 'Show low engagement accounts',
      ),
    ],
  ),

  AIChatMessage(
    id: 'cs_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show low engagement accounts',
  ),

  AIChatMessage(
    id: 'cs_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I flagged 15 enterprise accounts whose weekly active users (WAU) dropped by more than 30%.

• Acme Corp: Login frequency dropped to 0 this week.
• Initech Systems: Key admin user hasn't accessed workspace in 10 days.
''',
  ),

  AIChatMessage(
    id: 'cs_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'assign_cs',
        title: 'Assign Customer Success Manager to check-in',
      ),
    ],
  ),

  AIChatMessage(
    id: 'cs_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_hubspot',
        icon: Icons.forum_outlined,
        title: 'Open CRM Account View',
      ),
    ],
  ),
];

// pricing conversation
List<AIChatMessage> pricingConversation = [
  AIChatMessage(
    id: 'prc_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed subscription plan distribution and annual billing adoption.

Annual billing packages are seeing strong growth.
''',
  ),

  AIChatMessage(
    id: 'prc_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'annual_plans',
        icon: Icons.calendar_today_outlined,
        title: 'Annual vs Monthly',
        prompt: 'Show annual billing adoption',
      ),
    ],
  ),

  AIChatMessage(
    id: 'prc_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show annual billing adoption',
  ),

  AIChatMessage(
    id: 'prc_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Annual billing adoption increased by 22% MoM.

• 42% of new Pro subscribers selected the annual 20% discount plan.
• Cash flow predictability improved with upfront yearly collections.
''',
  ),

  AIChatMessage(
    id: 'prc_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'optimize_pricing',
        title: 'Test annual discount incentives',
      ),
    ],
  ),

  AIChatMessage(
    id: 'prc_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_pricing_settings',
        icon: Icons.tune_outlined,
        title: 'Open Pricing Table Settings',
      ),
    ],
  ),
];

// billing saas conversation
List<AIChatMessage> billingSaasConversation = [
  AIChatMessage(
    id: 'bil_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have checked payment gateway synchronization and failed dunning invoices.

Everything is balanced with our accounting records.
''',
  ),

  AIChatMessage(
    id: 'bil_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'dunning_status',
        icon: Icons.credit_card_off_outlined,
        title: 'Failed Invoices',
        prompt: 'Show dunning status',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bil_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show dunning status',
  ),

  AIChatMessage(
    id: 'bil_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Dunning Recovery Status:

• 12 failed invoices currently in automated retry sequence.
• 4 accounts recovered successfully after automated SMS and email reminders.
''',
  ),

  AIChatMessage(
    id: 'bil_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'retry_charges',
        title: 'Manually trigger Stripe card retry',
      ),
    ],
  ),

  AIChatMessage(
    id: 'bil_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_stripe_invoices',
        icon: Icons.receipt_outlined,
        title: 'Open Stripe Invoices',
      ),
    ],
  ),
];

// weekly saas conversation
List<AIChatMessage> weeklySaasConversation = [
  AIChatMessage(
    id: 'wks_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly SaaS sprint and revenue update report.

ARR crossed the \$1.8M milestone this week.
''',
  ),

  AIChatMessage(
    id: 'wks_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'weekly_mrr_add',
        icon: Icons.trending_up_outlined,
        title: 'Net MRR Add',
        prompt: 'Show weekly net MRR additions',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wks_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show weekly net MRR additions',
  ),

  AIChatMessage(
    id: 'wks_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Weekly Subscription Summary:

• New MRR Added: \$6,200
• Expansion MRR: \$3,400
• Churned MRR: -\$1,200
• Net New MRR This Week: +\$8,400
''',
  ),

  AIChatMessage(
    id: 'wks_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'share_slack',
        title: 'Post weekly milestone to #saas-metrics',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wks_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_dashboard',
        icon: Icons.dashboard_outlined,
        title: 'Open Main Dashboard',
      ),
    ],
  ),
];

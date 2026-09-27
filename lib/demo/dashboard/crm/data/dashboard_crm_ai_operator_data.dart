import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for CRM dashboard demo.
AIOperatorData getCrmAIOperatorData() {
  return AIOperatorData(
    home: getCrmHome(),
    conversations: getCrmConversations(),
    insights: getCrmInsights(),
    actions: getCrmActions(),
    agents: getCrmAgents(),
    logs: getCrmLogs(),
  );
}

/// Returns the CRM home screen configuration
AIHome getCrmHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your business data. Ask any questions or choose one of the analyses below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "CRM Overview",
        prompt: "Show CRM overview",
      ),
      AIQuickAction(
        id: "revenue",
        icon: Icons.show_chart,
        title: "Revenue Trend",
        prompt: "Show revenue trend",
      ),
      AIQuickAction(
        id: "customer",
        icon: Icons.people_alt_outlined,
        title: "Top Customers",
        prompt: "Show top customers",
      ),
      AIQuickAction(
        id: "forecast",
        icon: Icons.insights_outlined,
        title: "Revenue Forecast",
        prompt: "Forecast next quarter revenue",
      ),
      AIQuickAction(
        id: "marketing",
        icon: Icons.campaign_outlined,
        title: "Marketing Performance",
        prompt: "Analyze marketing campaign",
      ),
      AIQuickAction(
        id: "inventory",
        icon: Icons.inventory_2_outlined,
        title: "Inventory Analysis",
        prompt: "Analyze inventory",
      ),
    ],
  );
}

/// Returns the list of CRM conversations
List<AIConversation> getCrmConversations() {
  return [
    AIConversation(
      id: "crm",
      title: "CRM Analysis",
      preview: "Conversion rate dropped by 12% due to increased response time.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 3,
      chat: crmConversation,
    ),
    AIConversation(
      id: "forecast",
      title: "Revenue Forecast",
      preview: "Revenue is projected to increase by 8.3% in Q3.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: revenueConversation,
    ),
    AIConversation(
      id: "churn",
      title: "Customer Churn",
      preview: "45 customers are at risk of churning within 30 days.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: churnConversation,
    ),
    AIConversation(
      id: "marketing",
      title: "Marketing Campaign",
      preview: "Facebook campaign has the highest ROI.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: marketingConversation,
    ),
    AIConversation(
      id: "dashboard",
      title: "Executive Dashboard",
      preview: "Executive dashboard successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: dashboardConversation,
    ),
    AIConversation(
      id: "inventory",
      title: "Inventory Analysis",
      preview: "12 products are predicted to run out of stock within 7 days.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: inventoryConversation,
    ),
    AIConversation(
      id: "supplier",
      title: "Supplier Evaluation",
      preview: "Supplier Alpha has the best performance.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: supplierConversation,
    ),
    AIConversation(
      id: "sales",
      title: "Sales Performance",
      preview: "Sales increased by 14% compared to last month.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: salesConversation,
    ),
    AIConversation(
      id: "budget",
      title: "Budget Planning",
      preview: "Marketing exceeded the budget by 8%.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: budgetConversation,
    ),
    AIConversation(
      id: "weekly",
      title: "Weekly KPI Review",
      preview: "6 KPIs increased, 2 KPIs require attention.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyConversation,
    ),
  ];
}

/// Returns the list of CRM insights for AI operator
List<AIInsight> getCrmInsights() {
  return [
    AIInsight(
      id: "revenue_drop",
      title: "Revenue dropped 23% compared to last week",
      summary:
          "Weekly revenue decreased significantly due to overdue invoices and lower sales performance in the West Region.",
      description:
          "AI detected a sustained decline in revenue over the past seven days. The primary contributors are overdue invoices and a decrease in regional sales.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 92),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated revenue loss of approximately \$125,000 if no action is taken.",
      ),
      why: AIWhy(
        reasons: [
          "12 overdue invoices",
          "West Region sales decreased by 31%",
          "Customer response time slowed down",
        ],
      ),
      suggestions: [
        AISuggestion(id: "follow_invoice", title: "Follow up overdue invoices"),
        AISuggestion(
          id: "review_sales",
          title: "Review West Region sales performance",
        ),
      ],
      actions: [
        AIAction(
          id: "analysis",
          label: "View Analysis",
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
      id: "inactive_leads",
      title: "43 leads have not been followed up",
      summary:
          "Average response time has reached six days, increasing the risk of losing potential customers.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 88),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description: "Potential decline in lead conversion rate by up to 9%.",
      ),
      why: AIWhy(
        reasons: [
          "Sales workload increased",
          "No automatic follow-up workflow",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "assign_sales",
          title: "Assign pending leads to available sales representatives",
        ),
      ],
      actions: [
        AIAction(
          id: "show_leads",
          label: "Show Leads",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "assign",
          label: "Assign Sales",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "top_product",
      title: "Product A search volume increased by 180%",
      summary:
          "Demand has grown consistently over the last two weeks, creating an opportunity to increase sales.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 89),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Potential revenue increase if inventory and promotions are adjusted.",
      ),
      why: AIWhy(
        reasons: [
          "Organic search traffic increased",
          "High engagement from recent campaigns",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "increase_stock",
          title: "Increase inventory for Product A",
        ),
        AISuggestion(
          id: "boost_campaign",
          title: "Launch a promotional campaign",
        ),
      ],
      actions: [
        AIAction(
          id: "forecast",
          label: "Forecast Demand",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "notify",
          label: "Notify Purchasing",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_report",
      title: "Monthly sales report is ready",
      summary:
          "The sales report for June 2026 has been successfully generated and is ready for review.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into June 2026 sales performance and key metrics for strategic decision-making.",
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
          "Data has been synchronized",
          "Ready for review",
        ],
      ),
    ),
    AIInsight(
      id: "forecast_q3",
      title: "Revenue is projected to grow by 8.3% next quarter",
      summary:
          "Current sales trends indicate positive growth if existing performance is maintained.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description: "Projected revenue of approximately \$2.8M for Q3.",
      ),
      why: AIWhy(
        reasons: [
          "Consistent monthly sales growth",
          "Higher customer retention",
          "Improved conversion rate",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "prepare_inventory",
          title: "Prepare inventory for expected demand",
        ),
      ],
      actions: [
        AIAction(
          id: "forecast_report",
          label: "View Forecast",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "planning",
          label: "Create Budget Plan",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getCrmActions() {
  return [
    AIActionItem(
      id: "generate_monthly_report",
      title: "Generate Monthly Sales Report",
      description:
          "Create an executive summary for June sales performance including KPIs and regional breakdown.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "follow_up_leads",
      title: "Assign Follow-up for 43 Pending Leads",
      description:
          "Automatically distribute inactive leads to available sales representatives.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.people_alt_outlined,
    ),

    AIActionItem(
      id: "forecast_q3",
      title: "Generate Revenue Forecast",
      description:
          "Predict revenue performance for the next quarter based on historical trends.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "marketing_campaign",
      title: "Analyze Marketing Campaign ROI",
      description:
          "Evaluate the effectiveness of active Facebook, Google Ads, and Email campaigns.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.campaign_outlined,
    ),

    AIActionItem(
      id: "inventory_prediction",
      title: "Predict Low Stock Products",
      description:
          "Identify products that are likely to run out of stock within the next seven days.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.inventory_2_outlined,
    ),

    AIActionItem(
      id: "customer_segmentation",
      title: "Build Customer Segmentation",
      description:
          "Cluster customers based on purchase frequency, lifetime value, and engagement.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.groups_outlined,
    ),

    AIActionItem(
      id: "detect_churn",
      title: "Detect Customer Churn Risk",
      description:
          "Analyze customer behavior and identify accounts with a high probability of churn.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.trending_down_outlined,
    ),

    AIActionItem(
      id: "workflow_followup",
      title: "Create Follow-up Workflow",
      description:
          "Generate an automated CRM workflow for inactive leads and overdue opportunities.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.account_tree_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh Executive Dashboard",
      description:
          "Synchronize KPIs, charts, and executive metrics with the latest business data.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly AI Summary",
      description:
          "Prepare a concise summary of key business insights, opportunities, and risks.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getCrmAgents() {
  return [
    AIAgent(
      id: "crm_agent",
      name: "CRM Agent",
      description:
          "Manages customer relationships, analyzes interactions, and recommends follow-up actions.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.people_alt_outlined,
    ),

    AIAgent(
      id: "sales_analyst",
      name: "Sales Analyst",
      description:
          "Analyzes sales performance, detects trends, and generates actionable insights.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.bar_chart_outlined,
    ),

    AIAgent(
      id: "marketing_agent",
      name: "Marketing Agent",
      description:
          "Evaluates campaigns, customer engagement, and marketing ROI business growth.",
      category: AIAgentCategory.marketing,
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.campaign_outlined,
    ),

    AIAgent(
      id: "inventory_agent",
      name: "Inventory Analyst",
      description:
          "Monitors inventory levels, predicts shortages, and recommends replenishment.",
      category: AIAgentCategory.inventory,
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.inventory_2_outlined,
    ),

    AIAgent(
      id: "finance_advisor",
      name: "Finance Advisor",
      description:
          "Analyzes financial performance, budgets, cash flow, and business sustainability.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.attach_money_outlined,
    ),

    AIAgent(
      id: "support_agent",
      name: "Support Agent",
      description:
          "Handles support tickets, summarizes conversations, and suggests customer solutions.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.support_agent_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getCrmLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly Sales Report",
      message: "Report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly Sales Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "High Overdue Invoices",
      message: "12 invoices are overdue for more than 30 days.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "Finance Advisor",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Sales Analysis Started",
      message: "Analyzing Q2 sales performance.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Sales Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Lead Follow-up Workflow",
      message: "Workflow created successfully.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "Pending Leads",
      message: "43 leads have not been followed up for more than 6 days.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Revenue Forecast Completed",
      message: "Q3 revenue forecast generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Finance Advisor",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Campaign Data Synced",
      message: "Facebook Ads and Google Ads data updated.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "Marketing Agent",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "Inventory Sync Failed",
      message: "Failed to fetch inventory data from Warehouse API.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Inventory Analyst",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "Warehouse API returned HTTP 500 Internal Server Error.",
    ),

    AILogItem(
      id: "log_010",
      title: "Support Ticket Summary",
      message: "Ticket #SR-1024 summarized successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Support Agent",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Dashboard Refreshed",
      message: "Executive dashboard metrics synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Inactive Lead Reminder workflow executed.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Slack Integration Failed",
      message: "Unable to send notification to #sales-alerts.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Slack API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Budget Report Generated",
      message: "Budget vs Actual report completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Finance Advisor",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Missing Customer Data",
      message: "23 customer profiles contain incomplete information.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "CRM Agent",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getCrmSettings() {
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

// crm conversation
final crmConversation = [
  AIChatMessage(
    id: 'crm_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed the CRM data for June. There are some interesting insights.''',
  ),

  AIChatMessage(
    id: 'crm_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.dashboard_outlined,
        title: 'CRM Overview',
        prompt: 'Show CRM overview',
      ),

      AIQuickAction(
        id: 'customer',
        icon: Icons.people_outline,
        title: 'Top Customers',
        prompt: 'Show top customers',
      ),

      AIQuickAction(
        id: 'conversion',
        icon: Icons.show_chart,
        title: 'Conversion Rate',
        prompt: 'Analyze conversion rate',
      ),

      AIQuickAction(
        id: 'pipeline',
        icon: Icons.account_tree_outlined,
        title: 'Sales Pipeline',
        prompt: 'Show sales pipeline',
      ),
    ],
  ),

  AIChatMessage(
    id: 'crm_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze conversion rate',
  ),

  AIChatMessage(
    id: 'crm_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Conversion rate dropped by 12%.

The biggest causes:

• Response time increased to 7.2 hours

• 23% of leads were never followed up

• Landing page has a high bounce rate''',
  ),

  AIChatMessage(
    id: 'crm_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment', title: 'Segment by region'),

      AIQuickAction(id: 'lost', title: 'Show lost opportunities'),
    ],
  ),

  AIChatMessage(
    id: 'crm_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last month',
  ),

  AIChatMessage(
    id: 'crm_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to May:

• Conversion dropped by 12%

• Qualified Leads increased by 8%

• Closed Deals dropped by 15%

I suspect the main issue lies within the follow-up process.''',
  ),

  AIChatMessage(
    id: 'crm_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'workflow',
        icon: Icons.play_circle_outline,
        title: 'Run Follow-up Workflow',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Notify Sales Team',
      ),
    ],
  ),

  AIChatMessage(
    id: 'crm_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as a CRM Analytics Expert. Please perform a comparative analysis of the Conversion Rate for this month versus last month.
Include the following components:

Quantitative Comparison: State the current month's conversion rate vs. last month's rate, showing the exact percentage point difference and the growth/decline percentage.

Segment Breakdown: Analyze the conversion rate across different segments (e.g., Lead Source, Campaign, or Industry) to identify which segment performed best and which declined.

Funnel Analysis: Identify the specific stage in the sales funnel where the most drop-offs occurred compared to last month.

Causal Insights: Provide potential reasons for the shift (e.g., changes in lead quality, marketing messaging, or sales process execution).

Actionable Recommendations: Suggest 3 concrete steps to improve the conversion rate in the upcoming month.''',
  ),
];

// revenue conversation

List<AIChatMessage> revenueConversation = [
  AIChatMessage(
    id: 'rev_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the financial and revenue data for Q2.

There are some interesting insights.
''',
  ),

  AIChatMessage(
    id: 'rev_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'rev_overview',
        icon: Icons.payments_outlined,
        title: 'Revenue Overview',
        prompt: 'Show revenue overview',
      ),

      AIQuickAction(
        id: 'mrr_breakdown',
        icon: Icons.monetization_on_outlined,
        title: 'MRR Breakdown',
        prompt: 'Analyze MRR growth',
      ),

      AIQuickAction(
        id: 'churn_impact',
        icon: Icons.trending_down,
        title: 'Churn & Expansion',
        prompt: 'Analyze churn impact',
      ),

      AIQuickAction(
        id: 'product_performance',
        icon: Icons.inventory_2_outlined,
        title: 'Product Revenue',
        prompt: 'Show revenue by product',
      ),
    ],
  ),

  AIChatMessage(
    id: 'rev_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze MRR growth',
  ),

  AIChatMessage(
    id: 'rev_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Monthly Recurring Revenue (MRR) grew by 14.5% this month.

The primary drivers:

• New sales expansion added \$12,400

• Upgrades from existing licenses increased by 6.8%

• Expansion offset a minor 2.1% churn rate
''',
  ),

  AIChatMessage(
    id: 'rev_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'compare_quarter', title: 'Compare with last quarter'),

      AIQuickAction(id: 'geo_revenue', title: 'Breakdown by geography'),

      AIQuickAction(id: 'top_addons', title: 'Show top-selling add-ons'),
    ],
  ),

  AIChatMessage(
    id: 'rev_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_csv',
        icon: Icons.table_view,
        title: 'Export Revenue CSV',
      ),

      AIQuickAction(
        id: 'share_finance',
        icon: Icons.connect_without_contact,
        title: 'Share with Finance Team',
      ),

      AIQuickAction(
        id: 'adjust_forecast',
        icon: Icons.auto_graph,
        title: 'Update Q3 Forecast',
      ),
    ],
  ),

  AIChatMessage(
    id: 'rev_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last quarter',
  ),

  AIChatMessage(
    id: 'rev_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Compared to Q1:

• Total Revenue increased by 18.2%

• Average Revenue Per User (ARPU) rose by \$4.50

• Customer Acquisition Cost (CAC) decreased by 5.3%

The data indicates very healthy growth and improved marketing efficiency.
''',
  ),

  AIChatMessage(
    id: 'rev_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'sync_billing',
        icon: Icons.sync,
        title: 'Sync Billing Gateway',
      ),

      AIQuickAction(
        id: 'slack_milestone',
        icon: Icons.celebration,
        title: 'Post Milestone to Slack',
      ),
    ],
  ),
];

List<AIChatMessage> churnConversation = [
  AIChatMessage(
    id: 'churn_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the customer retention and churn metrics for this month.

We have some critical areas that need immediate attention.
''',
  ),

  AIChatMessage(
    id: 'churn_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'churn_rate',
        icon: Icons.gpp_bad_outlined,
        title: 'Churn Rate Overview',
        prompt: 'Show churn rate overview',
      ),

      AIQuickAction(
        id: 'churn_reasons',
        icon: Icons.help_outline,
        title: 'Top Churn Reasons',
        prompt: 'Analyze reasons for churn',
      ),

      AIQuickAction(
        id: 'at_risk_customers',
        icon: Icons.warning_amber_outlined,
        title: 'At-Risk Accounts',
        prompt: 'Identify at-risk accounts',
      ),

      AIQuickAction(
        id: 'cohort_retention',
        icon: Icons.hourglass_empty,
        title: 'Cohort Retention',
        prompt: 'Show cohort retention analysis',
      ),
    ],
  ),

  AIChatMessage(
    id: 'churn_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze reasons for churn',
  ),

  AIChatMessage(
    id: 'churn_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our revenue churn spiked by 3.4% compared to last month.

Based on exit surveys and usage patterns, the main drivers are:

• Inactivity: 42% of churned users hadn't logged in for 14+ days

• Price Sensitivity: 28% switched to lower-tier competitors

• Integration Issues: 18% failed to set up their webhooks properly
''',
  ),

  AIChatMessage(
    id: 'churn_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'compare_industry',
        title: 'Compare with industry benchmark',
      ),

      AIQuickAction(id: 'segment_tier', title: 'Segment churn by plan tier'),

      AIQuickAction(
        id: 'winback_ideas',
        title: 'Show win-back campaign options',
      ),
    ],
  ),

  AIChatMessage(
    id: 'churn_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_churn_list',
        icon: Icons.download_outlined,
        title: 'Export Churn List',
      ),

      AIQuickAction(
        id: 'trigger_intercom',
        icon: Icons.bolt,
        title: 'Trigger Re-engagement Email',
      ),

      AIQuickAction(
        id: 'schedule_success_meeting',
        icon: Icons.calendar_today_outlined,
        title: 'Sync with Customer Success',
      ),
    ],
  ),

  AIChatMessage(
    id: 'churn_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show win-back campaign options',
  ),

  AIChatMessage(
    id: 'churn_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here are 3 recommended win-back strategies for our top segments:

• For Inactive Users: Offer a free 1-on-1 onboarding recovery session.

• For Price Sensitive: Send a personalized 20% discount code for the next 3 months.

• For Technical Issues: Automatically trigger a specialized documentation guide helper.

Historical data shows a 12% recovery rate using these targeted approaches.
''',
  ),

  AIChatMessage(
    id: 'churn_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'launch_discount_workflow',
        icon: Icons.auto_fix_high,
        title: 'Launch Discount Campaign',
      ),

      AIQuickAction(
        id: 'slack_alert_cs',
        icon: Icons.notifications_active_outlined,
        title: 'Alert CS Team on Slack',
      ),
    ],
  ),
];

List<AIChatMessage> marketingConversation = [
  AIChatMessage(
    id: 'mkt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the marketing campaign performance report for this past week.

We are seeing some massive traffic growth, but acquisition costs are fluctuating.
''',
  ),

  AIChatMessage(
    id: 'mkt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'mkt_overview',
        icon: Icons.campaign_outlined,
        title: 'Campaign Overview',
        prompt: 'Show marketing overview',
      ),

      AIQuickAction(
        id: 'ad_spend',
        icon: Icons.ads_click_outlined,
        title: 'ROAS & Ad Spend',
        prompt: 'Analyze ad spend efficiency',
      ),

      AIQuickAction(
        id: 'lead_gen',
        icon: Icons.filter_alt_outlined,
        title: 'Lead Channels',
        prompt: 'Identify top acquisition channels',
      ),

      AIQuickAction(
        id: 'seo_performance',
        icon: Icons.travel_explore_outlined,
        title: 'Organic SEO Traffic',
        prompt: 'Show organic traffic growth',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mkt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze ad spend efficiency',
  ),

  AIChatMessage(
    id: 'mkt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our average Return on Ad Spend (ROAS) currently sits at 3.2x, but cost-per-click is rising.

Key observations across active channels:

• Meta Ads: ROAS dropped to 2.4x due to high audience fatigue on ad creatives

• Google Search: Converting exceptionally well at 4.8x ROAS for high-intent keywords

• Twitter/X Ads: Low conversion rates; Customer Acquisition Cost (CAC) is unsustainable here
''',
  ),

  AIChatMessage(
    id: 'mkt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'creative_fatigue',
        title: 'Show underperforming creatives',
      ),

      AIQuickAction(
        id: 'reallocate_budget',
        title: 'Optimize budget distribution',
      ),

      AIQuickAction(
        id: 'competitor_share',
        title: 'Compare search share of voice',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mkt_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'pause_x_ads',
        icon: Icons.pause_circle_outline,
        title: 'Pause Underperforming Ads',
      ),

      AIQuickAction(
        id: 'download_mkt_deck',
        icon: Icons.slideshow_outlined,
        title: 'Export Analytics Slide',
      ),

      AIQuickAction(
        id: 'open_meta_manager',
        icon: Icons.open_in_new_outlined,
        title: 'Open Meta Ads Manager',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mkt_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Optimize budget distribution',
  ),

  AIChatMessage(
    id: 'mkt_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on channel efficiency, here is the recommended smart budget reallocation:

• Shift \$1,500 from Twitter/X Ads directly into Google Search high-intent keyword pools.

• Scale down Meta Ads top-of-funnel daily budget by 15% until fresh creative sets are uploaded.

Implementing this setup is projected to lower overall CAC by 11% and boost total conversions by next week.
''',
  ),

  AIChatMessage(
    id: 'mkt_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'apply_budget_rules',
        icon: Icons.published_with_changes,
        title: 'Apply Budget Adjustments',
      ),

      AIQuickAction(
        id: 'notif_mkt_slack',
        icon: Icons.maps_ugc_outlined,
        title: 'Notify Marketing Group',
      ),
    ],
  ),
];

List<AIChatMessage> dashboardConversation = [
  AIChatMessage(
    id: 'exec_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your executive cross-platform dashboard summary for this month.

All core product engines and business channels are operating within healthy margins, with a few key highlights.
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
        id: 'product_health',
        icon: Icons.speed_outlined,
        title: 'Product Ecosystem',
        prompt: 'Check product health status',
      ),

      AIQuickAction(
        id: 'burn_runway',
        icon: Icons.hourglass_full_outlined,
        title: 'Runway & Burn Rate',
        prompt: 'Analyze financial runway',
      ),

      AIQuickAction(
        id: 'strategic_growth',
        icon: Icons.track_changes_outlined,
        title: 'Strategic OKRs',
        prompt: 'Show OKR progress tracking',
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
Here is the consolidated high-level performance matrix:

• Total Revenue: \$142,500 (+12.4% MoM)

• Active Subscriptions: 3,840 users (+8.1% MoM)

• Net Revenue Retention (NRR): 104.2% (Healthy expansion)

• Customer LTV to CAC Ratio: 4.2x (Excellent marketing efficiency)
''',
  ),

  AIChatMessage(
    id: 'exec_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'breakdown_by_product',
        title: 'Breakdown revenue by product asset',
      ),

      AIQuickAction(id: 'view_anomalies', title: 'Check active risk alerts'),

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
        title: 'Export Board Briefing PDF',
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
    text: 'Check active risk alerts',
  ),

  AIChatMessage(
    id: 'exec_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I detected 1 minor operational anomaly requiring structural review:

• Infrastructure costs increased by 14% due to higher query volumes on the analytics engine.

• Recommendation: Optimize database indexing or update the caching layer for dashboard telemetry cards to stabilize server load.

No critical security threats or payment gateway blockers detected.
''',
  ),

  AIChatMessage(
    id: 'exec_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_cloud_console',
        icon: Icons.admin_panel_settings_outlined,
        title: 'Open Cloud Console',
      ),

      AIQuickAction(
        id: 'notify_dev_lead',
        icon: Icons.forum_outlined,
        title: 'Ping Engineering Team',
      ),
    ],
  ),
];
List<AIChatMessage> inventoryConversation = [
  AIChatMessage(
    id: 'inv_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest inventory and warehouse status report.

We have a few stock alerts that need your immediate review to avoid fulfillment delays.
''',
  ),

  AIChatMessage(
    id: 'inv_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'stock_status',
        icon: Icons.inventory_2_outlined,
        title: 'Stock Status Overview',
        prompt: 'Show stock status overview',
      ),

      AIQuickAction(
        id: 'low_stock_alerts',
        icon: Icons.warning_amber_outlined,
        title: 'Low Stock Alerts',
        prompt: 'Check low stock alerts',
      ),

      AIQuickAction(
        id: 'fulfillment_rate',
        icon: Icons.local_shipping_outlined,
        title: 'Fulfillment Rate',
        prompt: 'Analyze order fulfillment rate',
      ),

      AIQuickAction(
        id: 'supplier_orders',
        icon: Icons.pending_actions,
        title: 'Pending Purchase Orders',
        prompt: 'Show pending supplier orders',
      ),
    ],
  ),

  AIChatMessage(
    id: 'inv_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check low stock alerts',
  ),

  AIChatMessage(
    id: 'inv_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
There are 3 high-demand items currently falling below their safety stock thresholds:

• Core UI Assets Bundle: Only 15 licenses remaining (Velocity indicates out-of-stock in 3 days)

• Extended Team Pass: 8 items left in stock (Demand spiked by 34% this week)

• Premium Icon Packs: 0 remaining (Backorders are piling up, currently 42 orders waiting)
''',
  ),

  AIChatMessage(
    id: 'inv_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'restock_suggestions',
        title: 'Show auto-restock recommendations',
      ),

      AIQuickAction(
        id: 'supplier_lead_times',
        title: 'Check supplier delivery lead times',
      ),

      AIQuickAction(id: 'backorder_list', title: 'View pending backorders'),
    ],
  ),

  AIChatMessage(
    id: 'inv_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'generate_po',
        icon: Icons.note_add_outlined,
        title: 'Draft Purchase Orders',
      ),

      AIQuickAction(
        id: 'allocate_stock',
        icon: Icons.assignment_turned_in_outlined,
        title: 'Reallocate Existing Stock',
      ),

      AIQuickAction(
        id: 'download_inv_manifest',
        icon: Icons.download_for_offline_outlined,
        title: 'Export Stock Manifest',
      ),
    ],
  ),

  AIChatMessage(
    id: 'inv_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show auto-restock recommendations',
  ),

  AIChatMessage(
    id: 'inv_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on current sales velocity and supplier lead times, here is the optimized replenishment strategy:

• Core UI Assets Bundle: Trigger an immediate restock of 250 units from Vendor A (Lead time: 2 days).

• Extended Team Pass: Schedule a standard batch allocation of 100 units by Friday.

• Premium Icon Packs: Release the digital vault queue override to immediately clear the 42 backorders.

Applying these updates will secure inventory health for the next 45 days.
''',
  ),

  AIChatMessage(
    id: 'inv_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'approve_restock',
        icon: Icons.assignment_turned_in,
        title: 'Approve and Release Stock',
      ),

      AIQuickAction(
        id: 'notify_procurement',
        icon: Icons.mail_outline,
        title: 'Email Procurement Team',
      ),
    ],
  ),
];

List<AIChatMessage> supplierConversation = [
  AIChatMessage(
    id: 'sup_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have evaluated our supplier and vendor performance matrix for this quarter.

We have a few updates regarding contract renewals and minor fulfillment delays from our primary partners.
''',
  ),

  AIChatMessage(
    id: 'sup_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'vendor_performance',
        icon: Icons.assignment_ind_outlined,
        title: 'Vendor Scorecard',
        prompt: 'Show vendor performance scorecard',
      ),

      AIQuickAction(
        id: 'lead_times',
        icon: Icons.shutter_speed_outlined,
        title: 'Delivery Lead Times',
        prompt: 'Analyze supplier lead times',
      ),

      AIQuickAction(
        id: 'contract_renewals',
        icon: Icons.draw_outlined,
        title: 'Pending Contracts',
        prompt: 'Check pending contract renewals',
      ),

      AIQuickAction(
        id: 'cost_negotiation',
        icon: Icons.price_check_outlined,
        title: 'Procurement Costs',
        prompt: 'Review procurement cost breakdown',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sup_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze supplier lead times',
  ),

  AIChatMessage(
    id: 'sup_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Average supplier delivery lead time has increased by 1.8 days this month.

Key factors and specific vendor performance:

• Global UI Logistics: SLA compliance dropped to 84% due to customs clearance bottlenecks

• Apex Digital Hosting: Maintained a perfect 100% availability and instantaneous API delivery

• Nexus Asset Foundry: Average delivery time delayed to 4.2 days (up from 2.5 days)
''',
  ),

  AIChatMessage(
    id: 'sup_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'sla_breaches', title: 'Show active SLA breaches'),

      AIQuickAction(
        id: 'alternative_vendors',
        title: 'Find alternative backup suppliers',
      ),

      AIQuickAction(
        id: 'dispute_history',
        title: 'Review open quality disputes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sup_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_vendor_portal',
        icon: Icons.handshake_outlined,
        title: 'Open Vendor Portal',
      ),

      AIQuickAction(
        id: 'download_sla_report',
        icon: Icons.description_outlined,
        title: 'Export Vendor SLA Report',
      ),

      AIQuickAction(
        id: 'initiate_dispute',
        icon: Icons.gavel_outlined,
        title: 'File Formal SLA Dispute',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sup_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Find alternative backup suppliers',
  ),

  AIChatMessage(
    id: 'sup_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have identified 2 vetted alternative suppliers to mitigate risk for Nexus Asset Foundry:

• Vertex Design Lab: Offers a matching catalog with a guaranteed 2-day delivery SLA. Rates are 4% higher.

• Prime Core Assets: Standard 3-day lead time with a bulk volume discount option (-7% on orders over \$5,000).

Switching 30% of our volume to Vertex Design Lab will eliminate our current pipeline bottleneck.
''',
  ),

  AIChatMessage(
    id: 'sup_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'request_rfp',
        icon: Icons.request_quote_outlined,
        title: 'Send Request for Proposal (RFP)',
      ),

      AIQuickAction(
        id: 'notify_legal',
        icon: Icons.gavel,
        title: 'Alert Procurement & Legal',
      ),
    ],
  ),
];

List<AIChatMessage> salesConversation = [
  AIChatMessage(
    id: 'sales_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest sales performance and pipeline updates for this week.

We have a strong surge in closed-won deals, but some enterprise accounts require immediate negotiation support.
''',
  ),

  AIChatMessage(
    id: 'sales_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'pipeline_value',
        icon: Icons.monetization_on_outlined,
        title: 'Pipeline Value',
        prompt: 'Show sales pipeline value',
      ),

      AIQuickAction(
        id: 'leaderboard',
        icon: Icons.emoji_events_outlined,
        title: 'Rep Leaderboard',
        prompt: 'Show sales rep leaderboard',
      ),

      AIQuickAction(
        id: 'deal_velocity',
        icon: Icons.speed_outlined,
        title: 'Deal Velocity',
        prompt: 'Analyze average deal velocity',
      ),

      AIQuickAction(
        id: 'stalled_deals',
        icon: Icons.hourglass_disabled_outlined,
        title: 'Stalled Deals',
        prompt: 'Identify stalled enterprise deals',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sales_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify stalled enterprise deals',
  ),

  AIChatMessage(
    id: 'sales_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 2 high-value enterprise accounts that have been stuck in the "Proposal/Negotiation" stage for over 10 days:

• Acme Corp (\$45,000): Delayed due to a pending custom legal SLA review.

• Initech Systems (\$28,500): Decision maker requested an additional technical architecture breakdown.

Resolving these could push us past our monthly target early.
''',
  ),

  AIChatMessage(
    id: 'sales_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'view_deal_history',
        title: 'View Acme Corp interaction history',
      ),

      AIQuickAction(
        id: 'send_tech_doc',
        title: 'Prepare Initech architecture draft',
      ),

      AIQuickAction(
        id: 'discount_options',
        title: 'Check approved incentive margins',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sales_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_crm_deals',
        icon: Icons.open_in_browser_outlined,
        title: 'Open Deals Board',
      ),

      AIQuickAction(
        id: 'assign_sales_lead',
        icon: Icons.person_add_alt_1_outlined,
        title: 'Assign VP to Intervene',
      ),

      AIQuickAction(
        id: 'download_sales_forecast',
        icon: Icons.trending_up_outlined,
        title: 'Export Sales Forecast PDF',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sales_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Prepare Initech architecture draft',
  ),

  AIChatMessage(
    id: 'sales_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have auto-generated an "AI-Ready Tech Infrastructure & Deployment Guide" customized for Initech Systems. 

The brief answers their specific concerns regarding:
• Data isolation rules and regional compliance.
• Webhook security protocols and fallback mechanisms.
• Scalability parameters matching their Q3 expansion plans.

Sending this now has historically accelerated the contract signing loop by 4 days.
''',
  ),

  AIChatMessage(
    id: 'sales_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'email_ini_rep',
        icon: Icons.forward_to_inbox_outlined,
        title: 'Send Briefing to Lead Rep',
      ),

      AIQuickAction(
        id: 'slack_sales_room',
        icon: Icons.tag_outlined,
        title: 'Share in #sales-alerts',
      ),
    ],
  ),
];

List<AIChatMessage> budgetConversation = [
  AIChatMessage(
    id: 'budget_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have cross-referenced our departmental expenditures against the Q2 fiscal plan.

We are currently trending under budget overall, but a few operational categories are showing a high variance.
''',
  ),

  AIChatMessage(
    id: 'budget_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'budget_vs_actual',
        icon: Icons.balance_outlined,
        title: 'Budget vs Actual',
        prompt: 'Show budget vs actual variance',
      ),

      AIQuickAction(
        id: 'expense_breakdown',
        icon: Icons.pie_chart_outline,
        title: 'Expense Breakdown',
        prompt: 'Analyze core operational expenses',
      ),

      AIQuickAction(
        id: 'cost_saving_ops',
        icon: Icons.savings_outlined,
        title: 'Cost Saving Tips',
        prompt: 'Identify cost saving opportunities',
      ),

      AIQuickAction(
        id: 'department_caps',
        icon: Icons.account_balance_wallet_outlined,
        title: 'Departmental Caps',
        prompt: 'Show budget limits by department',
      ),
    ],
  ),

  AIChatMessage(
    id: 'budget_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show budget vs actual variance',
  ),

  AIChatMessage(
    id: 'budget_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our net budget utilization sits at 84.5% for this quarter. 

However, we have significant variance in these specific categories:

• Cloud Infrastructure: \$18,200 spent vs \$15,000 allocated (+21.3% Over budget)

• Marketing & Ads: \$34,000 spent vs \$40,000 allocated (-15.0% Under budget)

• SaaS & Tools: \$8,400 spent vs \$9,000 allocated (-6.6% Under budget)
''',
  ),

  AIChatMessage(
    id: 'budget_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'cloud_deep_dive', title: 'Analyze cloud spend spike'),

      AIQuickAction(
        id: 'reallocate_surplus',
        title: 'Reallocate marketing surplus',
      ),

      AIQuickAction(
        id: 'view_unapproved',
        title: 'Check pending expense claims',
      ),
    ],
  ),

  AIChatMessage(
    id: 'budget_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_ledger',
        icon: Icons.receipt_long_outlined,
        title: 'Export Expense Ledger CSV',
      ),

      AIQuickAction(
        id: 'adjust_limits',
        icon: Icons.tune_outlined,
        title: 'Adjust Category Thresholds',
      ),

      AIQuickAction(
        id: 'request_audit',
        icon: Icons.request_quote_outlined,
        title: 'Flag for Internal Audit',
      ),
    ],
  ),

  AIChatMessage(
    id: 'budget_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Reallocate marketing surplus',
  ),

  AIChatMessage(
    id: 'budget_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I have prepared a reallocation model to stabilize our cloud infrastructure overages using the unused marketing surplus:

• Transfer \$3,500 from the under-utilized Meta Ads line item directly to the AWS/Cloud cluster reserve.

• Lock the remaining \$2,500 marketing surplus into the Q2 net profit reserves.

This operational adjustment instantly neutralizes our cloud deficit without expanding the total Q2 ceiling.
''',
  ),

  AIChatMessage(
    id: 'budget_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'execute_transfer',
        icon: Icons.swap_horiz,
        title: 'Execute Budget Transfer',
      ),

      AIQuickAction(
        id: 'notify_finance_lead',
        icon: Icons.mail_outline,
        title: 'Send Approval Request to CFO',
      ),
    ],
  ),
];

List<AIChatMessage> weeklyConversation = [
  AIChatMessage(
    id: 'week_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly team activity and sprint completion report.

Overall velocity is high, but we have a couple of blockers threatening our Friday release target.
''',
  ),

  AIChatMessage(
    id: 'week_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'sprint_burndown',
        icon: Icons.hourglass_bottom_outlined,
        title: 'Sprint Burndown',
        prompt: 'Show weekly sprint progress',
      ),

      AIQuickAction(
        id: 'team_velocity',
        icon: Icons.speed_outlined,
        title: 'Team Velocity',
        prompt: 'Analyze team velocity and output',
      ),

      AIQuickAction(
        id: 'active_blockers',
        icon: Icons.gpp_bad_outlined,
        title: 'Active Blockers',
        prompt: 'Identify active sprint blockers',
      ),

      AIQuickAction(
        id: 'next_week_planning',
        icon: Icons.next_plan_outlined,
        title: 'Next Sprint Prep',
        prompt: 'Show backlog items for next week',
      ),
    ],
  ),

  AIChatMessage(
    id: 'week_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify active sprint blockers',
  ),

  AIChatMessage(
    id: 'week_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
We currently have 2 critical blockers holding up the remaining weekly story points:

• UI Design System: 4 high-priority dashboard layout tasks are stuck waiting for final asset approval.

• Payment Gateway Refactor: Integration test is failing consistently on webhooks (API Timeout error).

Resolving these today keeps our release timeline perfectly on track.
''',
  ),

  AIChatMessage(
    id: 'week_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'view_failed_logs',
        title: 'View payment webhook error logs',
      ),

      AIQuickAction(
        id: 'reassign_design',
        title: 'Reassign pending asset reviews',
      ),

      AIQuickAction(
        id: 'extend_sprint',
        title: 'Calculate impact of moving deadline',
      ),
    ],
  ),

  AIChatMessage(
    id: 'week_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_jira_board',
        icon: Icons.view_kanban_outlined,
        title: 'Open Sprint Kanban Board',
      ),

      AIQuickAction(
        id: 'download_weekly_summary',
        icon: Icons.summarize_outlined,
        title: 'Export Weekly Standup Brief',
      ),

      AIQuickAction(
        id: 'schedule_retro',
        icon: Icons.calendar_today_outlined,
        title: 'Schedule Friday Retrospective',
      ),
    ],
  ),

  AIChatMessage(
    id: 'week_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'View payment webhook error logs',
  ),

  AIChatMessage(
    id: 'week_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I analyzed the last 50 gateway network logs. 

The core issue stems from an expired test environment client token, which triggers a `401 Unauthorized` response before the webhook callback can complete.

Updating the token config variables will fix the failing tests immediately.
''',
  ),

  AIChatMessage(
    id: 'week_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'update_tokens',
        icon: Icons.build_circle_outlined,
        title: 'Update Config Secret Tokens',
      ),

      AIQuickAction(
        id: 'ping_dev_channel',
        icon: Icons.bolt,
        title: 'Alert Standup Channel on Slack',
      ),
    ],
  ),
];

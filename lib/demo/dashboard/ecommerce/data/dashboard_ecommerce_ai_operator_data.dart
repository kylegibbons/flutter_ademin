import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for E-commerce dashboard demo.
AIOperatorData getEcommerceAIOperatorData() {
  return AIOperatorData(
    home: getEcommerceHome(),
    conversations: getEcommerceConversations(),
    insights: getEcommerceInsights(),
    actions: getEcommerceActions(),
    agents: getEcommerceAgents(),
    logs: getEcommerceLogs(),
  );
}

/// Returns the E-commerce home screen configuration
AIHome getEcommerceHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your e-commerce store performance. Ask any questions or choose one of the analyses below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "Store Overview",
        prompt: "Show store overview",
      ),
      AIQuickAction(
        id: "sales",
        icon: Icons.point_of_sale_outlined,
        title: "Sales & GMV",
        prompt: "Show sales and GMV trend",
      ),
      AIQuickAction(
        id: "abandonment",
        icon: Icons.remove_shopping_cart_outlined,
        title: "Cart Abandonment",
        prompt: "Analyze cart abandonment",
      ),
      AIQuickAction(
        id: "products",
        icon: Icons.inventory_2_outlined,
        title: "Top Products",
        prompt: "Show top selling products",
      ),
      AIQuickAction(
        id: "fulfillment",
        icon: Icons.local_shipping_outlined,
        title: "Fulfillment Status",
        prompt: "Check fulfillment and shipping",
      ),
      AIQuickAction(
        id: "marketing",
        icon: Icons.campaign_outlined,
        title: "ROAS & Ads",
        prompt: "Analyze marketing ROAS",
      ),
    ],
  );
}

/// Returns the list of E-commerce conversations
List<AIConversation> getEcommerceConversations() {
  return [
    AIConversation(
      id: "sales_trend",
      title: "Sales Analysis",
      preview:
          "Store conversion rate dropped by 1.2% due to payment gateway timeout.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 4,
      chat: salesConversation,
    ),
    AIConversation(
      id: "gmv_forecast",
      title: "GMV Forecast",
      preview: "Q3 GMV is projected to reach \$245,000 based on current AOV.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: gmvConversation,
    ),
    AIConversation(
      id: "abandonment",
      title: "Cart Abandonment",
      preview:
          "68 carts abandoned today, mostly at the shipping calculation step.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: abandonmentConversation,
    ),
    AIConversation(
      id: "marketing_roas",
      title: "Ad Spend & ROAS",
      preview:
          "Facebook Ads ROAS is currently at 3.2x for the Summer Campaign.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: marketingEcommerceConversation,
    ),
    AIConversation(
      id: "executive_ecom",
      title: "Executive Dashboard",
      preview: "Executive e-commerce overview successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: executiveEcommerceConversation,
    ),
    AIConversation(
      id: "inventory_alerts",
      title: "Inventory Alerts",
      preview: "12 high-velocity SKUs will run out of stock within 5 days.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: inventoryEcommerceConversation,
    ),
    AIConversation(
      id: "fulfillment",
      title: "Fulfillment & Shipping",
      preview:
          "Average delivery time increased to 4.5 days for West Coast orders.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: fulfillmentConversation,
    ),
    AIConversation(
      id: "refunds",
      title: "Refunds & Returns",
      preview: "Return rate for 'Premium Hoodie' spiked to 14%.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: refundConversation,
    ),
    AIConversation(
      id: "operations",
      title: "Store Operations",
      preview: "Shopify API limits reached during the flash sale event.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: operationsConversation,
    ),
    AIConversation(
      id: "weekly_sprint",
      title: "Weekly Store Review",
      preview: "AOV increased by \$12, total orders up by 8%.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyStoreConversation,
    ),
  ];
}

/// Returns the list of E-commerce insights for AI operator
List<AIInsight> getEcommerceInsights() {
  return [
    AIInsight(
      id: "sales_drop",
      title: "Checkout conversions dropped 18% today",
      summary:
          "Daily orders decreased significantly due to a recurring timeout error on the Stripe payment gateway integration.",
      description:
          "AI detected a sustained decline in completed checkouts over the last 6 hours. Users are abandoning their carts after clicking 'Pay Now'.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 95),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated revenue loss of approximately \$4,200/day if the gateway issue is not resolved.",
      ),
      why: AIWhy(
        reasons: [
          "Stripe API timeout errors (HTTP 504)",
          "High cart abandonment at payment step",
        ],
      ),
      suggestions: [
        AISuggestion(id: "check_gateway", title: "Review payment gateway logs"),
        AISuggestion(
          id: "enable_paypal",
          title: "Promote alternative payment (PayPal/Apple Pay)",
        ),
      ],
      actions: [
        AIAction(
          id: "view_logs",
          label: "View Error Logs",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "alert_dev",
          label: "Alert Tech Team",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "high_abandonment",
      title: "68 carts abandoned with value > \$100",
      summary:
          "High-value carts are being abandoned primarily due to unexpected shipping costs calculated at checkout.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 88),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Potential recovery of \$6,800+ if retargeting or free shipping thresholds are applied.",
      ),
      why: AIWhy(
        reasons: [
          "Shipping costs exceed 15% of total order value",
          "No free shipping threshold visible on product page",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "trigger_email",
          title: "Trigger abandoned cart email sequence with 10% discount",
        ),
      ],
      actions: [
        AIAction(
          id: "view_carts",
          label: "View Carts",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "run_campaign",
          label: "Send Recovery Emails",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "trending_product",
      title: "Demand for 'Ergonomic Chair' spiked by 210%",
      summary:
          "Product views and add-to-carts have grown consistently over the last 48 hours, likely driven by a viral TikTok review.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 94),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Opportunity to maximize GMV, but stock levels for the 'Black' variant are critically low.",
      ),
      why: AIWhy(
        reasons: [
          "High referral traffic from TikTok",
          "Conversion rate for this SKU increased to 6.2%",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "increase_price",
          title: "Slightly increase price to manage stock velocity",
        ),
        AISuggestion(
          id: "expedite_stock",
          title: "Expedite purchase order for restock",
        ),
      ],
      actions: [
        AIAction(
          id: "view_product",
          label: "View Product Stats",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "notify_procurement",
          label: "Restock Inventory",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_report",
      title: "Monthly Store Performance report is ready",
      summary:
          "The comprehensive E-commerce GMV and Order report for June 2026 has been successfully generated.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into June 2026 sales, AOV, refunds, and fulfillment metrics.",
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
          "Store data synced with ERP",
        ],
      ),
    ),
    AIInsight(
      id: "forecast_q3",
      title: "AOV is projected to grow to \$145 next quarter",
      summary:
          "Successful upselling bundles and free shipping thresholds are driving higher cart values.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected 12% increase in net profit margins due to higher Average Order Value.",
      ),
      why: AIWhy(
        reasons: [
          "Frequently Bought Together widget performing well",
          "Customers adding items to reach \$100 free shipping limit",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "create_bundles",
          title: "Create more preset product bundles",
        ),
      ],
      actions: [
        AIAction(
          id: "view_bundles",
          label: "Analyze Bundles",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "apply_strategy",
          label: "Optimize Upsells",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getEcommerceActions() {
  return [
    AIActionItem(
      id: "generate_monthly_report",
      title: "Generate Store GMV Report",
      description:
          "Create an executive summary for June sales performance, AOV, and category breakdown.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "recover_abandoned_carts",
      title: "Send Abandoned Cart Emails",
      description:
          "Automatically trigger recovery sequence for 68 high-value abandoned carts.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.remove_shopping_cart_outlined,
    ),

    AIActionItem(
      id: "forecast_q3",
      title: "Generate Inventory Demand Forecast",
      description:
          "Predict SKU demand for Q3 to prevent stockouts during the upcoming holiday sales.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "marketing_roas",
      title: "Analyze Ad Spend & ROAS",
      description:
          "Evaluate the conversion efficiency of active Meta and Google Shopping campaigns.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.campaign_outlined,
    ),

    AIActionItem(
      id: "inventory_prediction",
      title: "Predict Low Stock SKUs",
      description:
          "Identify product variants that are likely to run out of stock within 7 days.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.inventory_2_outlined,
    ),

    AIActionItem(
      id: "customer_segmentation",
      title: "Build Customer LTV Segments",
      description:
          "Cluster customers into VIP, At-Risk, and New buyers based on Lifetime Value.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.card_giftcard_outlined,
    ),

    AIActionItem(
      id: "detect_refunds",
      title: "Analyze High Return Rates",
      description:
          "Identify products with abnormal refund rates and scan customer review sentiment.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.assignment_return_outlined,
    ),

    AIActionItem(
      id: "workflow_fulfillment",
      title: "Automate Fulfillment Routing",
      description:
          "Update logic to route orders to the nearest warehouse to reduce shipping time.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.local_shipping_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh E-commerce Dashboard",
      description:
          "Synchronize live orders, revenue metrics, and inventory data with the platform API.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly Sales Summary",
      description:
          "Prepare a concise summary of revenue shifts, top products, and fulfillment status.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getEcommerceAgents() {
  return [
    AIAgent(
      id: "store_manager_agent",
      name: "Store Manager Agent",
      description:
          "Monitors overall GMV, conversion rates, abandoned carts, and store operations.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.storefront_outlined,
    ),

    AIAgent(
      id: "sales_analyst",
      name: "E-commerce Analyst",
      description:
          "Analyzes AOV, customer lifetime value (LTV), and revenue trends.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.point_of_sale_outlined,
    ),

    AIAgent(
      id: "marketing_agent",
      name: "Growth & Ads Agent",
      description:
          "Evaluates ROAS, ad spend efficiency, and promotional campaign performance.",
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
      name: "Inventory Manager",
      description:
          "Monitors SKU levels, predicts stockouts, and manages purchase orders.",
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
      name: "Payment & Gateway Agent",
      description:
          "Monitors payment success rates, chargebacks, fees, and revenue processing.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.credit_card_outlined,
    ),

    AIAgent(
      id: "fulfillment_agent",
      name: "Logistics Agent",
      description:
          "Tracks shipping times, courier performance, and automates tracking updates.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.local_shipping_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getEcommerceLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly GMV Report",
      message: "Sales report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Store Manager Agent",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly GMV Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Store Manager Agent",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "Payment Gateway Alert",
      message: "12 transactions failed due to Stripe timeout.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "Payment & Gateway Agent",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "AOV Analysis Started",
      message: "Analyzing Q2 Average Order Value trends.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "E-commerce Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Cart Recovery Workflow",
      message: "Abandoned cart email sequence triggered for 68 users.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "Store Manager Agent",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "High Shipping Cost",
      message: "43 carts abandoned at shipping calculator step.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Store Manager Agent",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Demand Forecast Completed",
      message: "Q3 inventory demand forecast generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Inventory Manager",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Google Shopping Synced",
      message: "Product feed updated in Google Merchant Center.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "Growth & Ads Agent",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "Inventory Sync Failed",
      message: "Failed to fetch stock levels from ERP system.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Inventory Manager",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "ERP API returned HTTP 500 Internal Server Error.",
    ),

    AILogItem(
      id: "log_010",
      title: "Refund Processed",
      message: "Order #ORD-1024 refund completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Payment & Gateway Agent",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Store Dashboard Refreshed",
      message: "Executive e-commerce metrics synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Low Stock Alert routing workflow executed.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "Inventory Manager",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "ShipStation Integration Failed",
      message: "Unable to push 15 orders to fulfillment queue.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "ShipStation API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Profit Margin Report",
      message: "COGS vs Revenue report completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "E-commerce Analyst",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Missing SKU Data",
      message: "23 new products are missing weight and dimension attributes.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "Inventory Manager",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getEcommerceSettings() {
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

// sales conversation
final salesConversation = [
  AIChatMessage(
    id: 'sales_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed the store sales data for June. There are some interesting insights regarding your conversion funnel.''',
  ),

  AIChatMessage(
    id: 'sales_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.dashboard_outlined,
        title: 'Sales Overview',
        prompt: 'Show sales overview',
      ),

      AIQuickAction(
        id: 'top_products',
        icon: Icons.inventory_2_outlined,
        title: 'Top Products',
        prompt: 'Show top selling products',
      ),

      AIQuickAction(
        id: 'conversion',
        icon: Icons.show_chart,
        title: 'Conversion Rate',
        prompt: 'Analyze conversion rate',
      ),

      AIQuickAction(
        id: 'funnel',
        icon: Icons.filter_alt_outlined,
        title: 'Checkout Funnel',
        prompt: 'Show checkout funnel',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sales_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze conversion rate',
  ),

  AIChatMessage(
    id: 'sales_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Checkout conversion rate dropped by 1.2%.

The biggest causes:

• Payment gateway experienced timeouts (Stripe 504 errors)

• 23% of users abandoned carts after viewing high shipping fees

• Mobile checkout button requires scrolling to be visible''',
  ),

  AIChatMessage(
    id: 'sales_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment_device', title: 'Segment by device'),

      AIQuickAction(id: 'lost_rev', title: 'Calculate lost revenue'),
    ],
  ),

  AIChatMessage(
    id: 'sales_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last month',
  ),

  AIChatMessage(
    id: 'sales_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to May:

• Conversion dropped by 1.2%

• Total Traffic (Sessions) increased by 8%

• Completed Orders dropped by 4%

I suspect the main issue is technical friction at the final payment step.''',
  ),

  AIChatMessage(
    id: 'sales_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'test_checkout',
        icon: Icons.bug_report_outlined,
        title: 'Run Checkout Diagnostic',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Notify Web Team',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sales_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as an E-commerce Expert. Please perform a comparative analysis of the Conversion Rate for this month versus last month.
Include the following components:

Quantitative Comparison: State the current month's conversion rate vs. last month's rate.

Segment Breakdown: Analyze the conversion rate across device types (Mobile vs Desktop).

Funnel Analysis: Identify the specific checkout step where the most drop-offs occurred.

Causal Insights: Provide potential reasons for the shift.

Actionable Recommendations: Suggest 3 concrete steps to improve e-commerce conversions next month.''',
  ),
];

// gmv conversation
List<AIChatMessage> gmvConversation = [
  AIChatMessage(
    id: 'gmv_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the GMV (Gross Merchandise Value) and AOV (Average Order Value) data for Q2.

There are some positive trends in customer spending.
''',
  ),

  AIChatMessage(
    id: 'gmv_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'gmv_overview',
        icon: Icons.payments_outlined,
        title: 'GMV Overview',
        prompt: 'Show GMV overview',
      ),

      AIQuickAction(
        id: 'aov_breakdown',
        icon: Icons.monetization_on_outlined,
        title: 'AOV Growth',
        prompt: 'Analyze AOV growth',
      ),

      AIQuickAction(
        id: 'ltv_impact',
        icon: Icons.diamond_outlined,
        title: 'Customer LTV',
        prompt: 'Analyze Customer LTV',
      ),

      AIQuickAction(
        id: 'category_performance',
        icon: Icons.category_outlined,
        title: 'Sales by Category',
        prompt: 'Show revenue by category',
      ),
    ],
  ),

  AIChatMessage(
    id: 'gmv_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze AOV growth',
  ),

  AIChatMessage(
    id: 'gmv_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Average Order Value (AOV) grew by \$14.50 this month, reaching \$128.

The primary drivers:

• 'Frequently Bought Together' widget drove 12% of bundle sales

• Customers adding \$15+ items to reach the \$100 Free Shipping threshold

• Price adjustments on flagship products absorbed well by the market
''',
  ),

  AIChatMessage(
    id: 'gmv_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'compare_quarter', title: 'Compare with last quarter'),

      AIQuickAction(id: 'top_upsells', title: 'Show top upsold items'),
    ],
  ),

  AIChatMessage(
    id: 'gmv_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_csv',
        icon: Icons.table_view,
        title: 'Export Sales CSV',
      ),

      AIQuickAction(
        id: 'adjust_forecast',
        icon: Icons.auto_graph,
        title: 'Update Q3 Projection',
      ),
    ],
  ),

  AIChatMessage(
    id: 'gmv_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last quarter',
  ),

  AIChatMessage(
    id: 'gmv_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Compared to Q1:

• Total GMV increased by 18.2%

• Average Order Value (AOV) rose by 11%

• Repeat Customer Rate increased to 34%

The data indicates very healthy catalog pricing and effective retention strategies.
''',
  ),

  AIChatMessage(
    id: 'gmv_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'sync_erp',
        icon: Icons.sync,
        title: 'Sync Financial ERP',
      ),

      AIQuickAction(
        id: 'slack_milestone',
        icon: Icons.celebration,
        title: 'Post Milestone to Slack',
      ),
    ],
  ),
];

List<AIChatMessage> abandonmentConversation = [
  AIChatMessage(
    id: 'abnd_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the cart abandonment metrics for this week.

We have a significant amount of revenue sitting in abandoned carts that requires attention.
''',
  ),

  AIChatMessage(
    id: 'abnd_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'abandon_rate',
        icon: Icons.gpp_bad_outlined,
        title: 'Abandonment Rate',
        prompt: 'Show abandonment rate',
      ),

      AIQuickAction(
        id: 'abandon_reasons',
        icon: Icons.help_outline,
        title: 'Top Drop-off Points',
        prompt: 'Analyze drop-off points',
      ),

      AIQuickAction(
        id: 'lost_value',
        icon: Icons.money_off_outlined,
        title: 'Total Value Lost',
        prompt: 'Show total abandoned value',
      ),
    ],
  ),

  AIChatMessage(
    id: 'abnd_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze drop-off points',
  ),

  AIChatMessage(
    id: 'abnd_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our cart abandonment rate spiked to 68% this week.

Based on checkout flow analytics, the main drop-off points are:

• Shipping Calculation: 42% of users left after seeing shipping and tax costs

• Account Creation: 28% left when asked to create an account (Guest checkout is hidden)

• Payment Step: 18% failed due to technical timeouts
''',
  ),

  AIChatMessage(
    id: 'abnd_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'recovery_ideas', title: 'Show cart recovery options'),
      AIQuickAction(id: 'shipping_rules', title: 'Review shipping rules'),
    ],
  ),

  AIChatMessage(
    id: 'abnd_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_abandon_list',
        icon: Icons.download_outlined,
        title: 'Export Abandoned Carts',
      ),

      AIQuickAction(
        id: 'trigger_klaviyo',
        icon: Icons.bolt,
        title: 'Trigger Klaviyo Flow',
      ),
    ],
  ),

  AIChatMessage(
    id: 'abnd_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show cart recovery options',
  ),

  AIChatMessage(
    id: 'abnd_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here are 3 recommended recovery strategies:

• For Shipping Drop-offs: Send an email after 2 hours offering a "Free Shipping" code for completion.

• For Account Drop-offs: Make the "Guest Checkout" button more prominent on the UI.

• For Payment Drop-offs: Send a plain-text customer service check-in asking if they need help completing the order.
''',
  ),

  AIChatMessage(
    id: 'abnd_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'launch_discount_workflow',
        icon: Icons.auto_fix_high,
        title: 'Activate Discount Flow',
      ),
    ],
  ),
];

List<AIChatMessage> marketingEcommerceConversation = [
  AIChatMessage(
    id: 'mkte_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the e-commerce marketing and ROAS (Return on Ad Spend) report for this past week.

Traffic volume is great, but our acquisition costs (CAC) are fluctuating.
''',
  ),

  AIChatMessage(
    id: 'mkte_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'ad_spend',
        icon: Icons.ads_click_outlined,
        title: 'ROAS & Ad Spend',
        prompt: 'Analyze ad spend efficiency',
      ),

      AIQuickAction(
        id: 'cac_ltv',
        icon: Icons.balance_outlined,
        title: 'CAC vs LTV',
        prompt: 'Compare CAC and LTV',
      ),

      AIQuickAction(
        id: 'promo_codes',
        icon: Icons.local_offer_outlined,
        title: 'Promo Code Usage',
        prompt: 'Show top promo codes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mkte_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze ad spend efficiency',
  ),

  AIChatMessage(
    id: 'mkte_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our average Return on Ad Spend (ROAS) currently sits at 3.2x, but cost-per-click is rising.

Key observations:

• Meta Ads (Instagram): ROAS dropped to 2.4x due to ad fatigue on the video creatives.

• Google Shopping: Converting exceptionally well at 4.8x ROAS for core product lines.

• TikTok Ads: High traffic volume, but very low conversion rate (ROAS 0.9x).
''',
  ),

  AIChatMessage(
    id: 'mkte_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'reallocate_budget',
        title: 'Optimize budget distribution',
      ),
      AIQuickAction(id: 'creative_fatigue', title: 'Show fatigued creatives'),
    ],
  ),

  AIChatMessage(
    id: 'mkte_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'pause_tiktok_ads',
        icon: Icons.pause_circle_outline,
        title: 'Pause TikTok Campaigns',
      ),
      AIQuickAction(
        id: 'open_merchant_center',
        icon: Icons.shopping_bag_outlined,
        title: 'Open Merchant Center',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mkte_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Optimize budget distribution',
  ),

  AIChatMessage(
    id: 'mkte_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on channel efficiency, here is the recommended reallocation:

• Shift \$1,500 from TikTok Ads directly into Google Shopping Performance Max campaigns.

• Scale down Meta Ads daily budget by 15% until fresh product photos are uploaded.

This setup is projected to lower overall CAC by 11% and boost total ROAS to 3.8x by next week.
''',
  ),

  AIChatMessage(
    id: 'mkte_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'apply_budget_rules',
        icon: Icons.published_with_changes,
        title: 'Apply Budget Adjustments',
      ),
    ],
  ),
];

List<AIChatMessage> executiveEcommerceConversation = [
  AIChatMessage(
    id: 'exece_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your executive e-commerce dashboard summary for this month.

All core sales engines and fulfillment channels are operating within healthy margins.
''',
  ),

  AIChatMessage(
    id: 'exece_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'kpi_summary',
        icon: Icons.insights_outlined,
        title: 'Core Store KPIs',
        prompt: 'Show core KPI summary',
      ),

      AIQuickAction(
        id: 'net_profit',
        icon: Icons.account_balance_outlined,
        title: 'Net Profit Margins',
        prompt: 'Analyze net profit margins',
      ),

      AIQuickAction(
        id: 'inventory_health',
        icon: Icons.inventory_outlined,
        title: 'Global Stock Value',
        prompt: 'Check total inventory value',
      ),
    ],
  ),

  AIChatMessage(
    id: 'exece_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show core KPI summary',
  ),

  AIChatMessage(
    id: 'exece_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level performance matrix:

• Gross Merchandise Value (GMV): \$142,500 (+12.4% MoM)

• Total Orders: 1,113 (+8.1% MoM)

• Average Order Value (AOV): \$128 (Healthy upsell rate)

• Return/Refund Rate: 2.1% (Well below industry average of 5%)
''',
  ),

  AIChatMessage(
    id: 'exece_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'breakdown_by_category',
        title: 'Breakdown GMV by category',
      ),
      AIQuickAction(id: 'forecast_q3', title: 'View end-of-quarter forecast'),
    ],
  ),

  AIChatMessage(
    id: 'exece_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'download_board_deck',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Executive Briefing PDF',
      ),
    ],
  ),
];

List<AIChatMessage> inventoryEcommerceConversation = [
  AIChatMessage(
    id: 'inve_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest warehouse and SKU stock status report.

We have a few fast-moving items that need immediate restocking to avoid missing out on sales.
''',
  ),

  AIChatMessage(
    id: 'inve_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'low_stock_alerts',
        icon: Icons.warning_amber_outlined,
        title: 'Low Stock Alerts',
        prompt: 'Check low stock alerts',
      ),

      AIQuickAction(
        id: 'dead_stock',
        icon: Icons.remove_circle_outline,
        title: 'Dead Stock Analysis',
        prompt: 'Identify slow moving inventory',
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
    id: 'inve_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check low stock alerts',
  ),

  AIChatMessage(
    id: 'inve_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
There are 3 high-demand SKUs currently falling below their safety stock thresholds:

• Ergonomic Chair (Black): Only 15 units remaining (Velocity indicates out-of-stock in 3 days)

• Standing Desk (Oak): 8 items left in stock (Demand spiked by 34% this week)

• Cable Management Tray: 0 remaining (Backorders are piling up, currently 42 orders waiting)
''',
  ),

  AIChatMessage(
    id: 'inve_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'restock_suggestions',
        title: 'Show auto-restock recommendations',
      ),
    ],
  ),

  AIChatMessage(
    id: 'inve_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'generate_po',
        icon: Icons.note_add_outlined,
        title: 'Draft Purchase Orders',
      ),
    ],
  ),

  AIChatMessage(
    id: 'inve_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show auto-restock recommendations',
  ),

  AIChatMessage(
    id: 'inve_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on current sales velocity and supplier lead times, here is the optimized replenishment strategy:

• Ergonomic Chair: Trigger an immediate PO for 250 units from Vendor A (Lead time: 14 days).

• Cable Management Tray: Route 50 units from the secondary warehouse to fulfill backorders immediately.

Applying these updates will secure inventory health for the next 45 days.
''',
  ),

  AIChatMessage(
    id: 'inve_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'approve_restock',
        icon: Icons.assignment_turned_in,
        title: 'Approve Purchase Orders',
      ),
    ],
  ),
];

List<AIChatMessage> fulfillmentConversation = [
  AIChatMessage(
    id: 'fulf_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have evaluated our shipping carriers and fulfillment performance for this month.

There are some minor delays happening in specific regions that might impact customer satisfaction.
''',
  ),

  AIChatMessage(
    id: 'fulf_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'delivery_times',
        icon: Icons.shutter_speed_outlined,
        title: 'Average Delivery Time',
        prompt: 'Analyze delivery times',
      ),

      AIQuickAction(
        id: 'courier_performance',
        icon: Icons.local_shipping_outlined,
        title: 'Courier Performance',
        prompt: 'Review courier performance',
      ),

      AIQuickAction(
        id: 'shipping_costs',
        icon: Icons.price_check_outlined,
        title: 'Shipping Cost Margins',
        prompt: 'Review shipping costs',
      ),
    ],
  ),

  AIChatMessage(
    id: 'fulf_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze delivery times',
  ),

  AIChatMessage(
    id: 'fulf_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Average delivery lead time has increased by 1.8 days this month.

Key factors and specific courier performance:

• Standard Shipping (FedEx): SLA compliance dropped to 84% for West Coast deliveries due to weather routing.

• Expedited (UPS): Maintained a perfect 98% on-time delivery rate.

• International (DHL): Average delivery time delayed to 8.2 days at customs.
''',
  ),

  AIChatMessage(
    id: 'fulf_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'affected_orders',
        title: 'Show orders affected by delays',
      ),
      AIQuickAction(
        id: 'alternative_routing',
        title: 'Find alternative routing',
      ),
    ],
  ),

  AIChatMessage(
    id: 'fulf_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_shipstation',
        icon: Icons.inventory_outlined,
        title: 'Open ShipStation Portal',
      ),
      AIQuickAction(
        id: 'email_customers',
        icon: Icons.mail_outline,
        title: 'Send Delay Apology Emails',
      ),
    ],
  ),
];

List<AIChatMessage> refundConversation = [
  AIChatMessage(
    id: 'refnd_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest returns, refunds, and chargeback data.

We have a spike in returns for one specific product category.
''',
  ),

  AIChatMessage(
    id: 'refnd_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'refund_rate',
        icon: Icons.assignment_return_outlined,
        title: 'Total Refund Rate',
        prompt: 'Show refund rate',
      ),

      AIQuickAction(
        id: 'top_returns',
        icon: Icons.warning_amber_outlined,
        title: 'Most Returned Items',
        prompt: 'Identify top returned products',
      ),

      AIQuickAction(
        id: 'chargebacks',
        icon: Icons.gavel_outlined,
        title: 'Active Chargebacks',
        prompt: 'Show active chargeback disputes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'refnd_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Identify top returned products',
  ),

  AIChatMessage(
    id: 'refnd_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 1 product that is driving 60% of all our returns this week:

• "Premium Cotton Hoodie" (SKU: HD-COT-01) has a return rate of 14%.

Reading through the return reason notes, 85% of customers state "Sizing runs too small".
''',
  ),

  AIChatMessage(
    id: 'refnd_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'update_size_chart',
        title: 'Suggest size chart update',
      ),
      AIQuickAction(
        id: 'pause_product',
        title: 'Temporarily hide product from store',
      ),
    ],
  ),

  AIChatMessage(
    id: 'refnd_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_product_page',
        icon: Icons.edit_outlined,
        title: 'Edit Product Description',
      ),
    ],
  ),
];

List<AIChatMessage> operationsConversation = [
  AIChatMessage(
    id: 'ops_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have cross-referenced our store operation costs against the monthly budget.

We are currently trending under budget overall, but a few SaaS tools are costing more than allocated.
''',
  ),

  AIChatMessage(
    id: 'ops_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'platform_fees',
        icon: Icons.account_balance_wallet_outlined,
        title: 'Platform & App Fees',
        prompt: 'Show store platform fees',
      ),

      AIQuickAction(
        id: 'gateway_fees',
        icon: Icons.credit_card_outlined,
        title: 'Payment Gateway Costs',
        prompt: 'Analyze payment gateway fees',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ops_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show store platform fees',
  ),

  AIChatMessage(
    id: 'ops_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Our SaaS and App subscription costs hit \$850 this month. 

Key variances:

• Email Marketing App: Tier increased automatically to \$299/mo due to subscriber list crossing 50k.

• Review Plugin: \$49/mo (Under-utilized, only 12 reviews collected this month).
''',
  ),

  AIChatMessage(
    id: 'ops_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'clean_email_list',
        title: 'Clean inactive email subscribers',
      ),
      AIQuickAction(
        id: 'cancel_plugin',
        title: 'Find alternative review plugins',
      ),
    ],
  ),

  AIChatMessage(
    id: 'ops_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_billing',
        icon: Icons.receipt_long_outlined,
        title: 'Open Store Billing Settings',
      ),
    ],
  ),
];

List<AIChatMessage> weeklyStoreConversation = [
  AIChatMessage(
    id: 'wkstore_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly store performance sprint report.

Overall sales velocity is high, and the new product launch was a success.
''',
  ),

  AIChatMessage(
    id: 'wkstore_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'weekly_gmv',
        icon: Icons.trending_up_outlined,
        title: 'Weekly GMV',
        prompt: 'Show weekly GMV',
      ),

      AIQuickAction(
        id: 'launch_results',
        icon: Icons.rocket_launch_outlined,
        title: 'Launch Results',
        prompt: 'Analyze new product launch',
      ),

      AIQuickAction(
        id: 'next_promo',
        icon: Icons.next_plan_outlined,
        title: 'Next Promotion',
        prompt: 'Show planned promos for next week',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkstore_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze new product launch',
  ),

  AIChatMessage(
    id: 'wkstore_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
The launch of the "Summer Collection" generated \$14,200 in the first 48 hours.

Key performance indicators:
• VIP Early Access Email: Drove 60% of initial sales.
• Instagram Teasers: Generated highest traffic volume, but lower conversion.
• Stock Levels: "Teal" color variant sold out on day one.
''',
  ),

  AIChatMessage(
    id: 'wkstore_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'enable_preorders',
        title: 'Enable pre-orders for sold out variants',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkstore_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_storeadmin',
        icon: Icons.admin_panel_settings_outlined,
        title: 'Open Store Admin',
      ),
      AIQuickAction(
        id: 'post_update',
        icon: Icons.campaign_outlined,
        title: 'Post Social Media Update',
      ),
    ],
  ),
];

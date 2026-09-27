import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for NFT dashboard demo.
AIOperatorData getNFTsAIOperatorData() {
  return AIOperatorData(
    home: getNFTHome(),
    conversations: getNFTConversations(),
    insights: getNFTInsights(),
    actions: getNFTActions(),
    agents: getNFTAgents(),
    logs: getNFTLogs(),
  );
}

/// Returns the NFT home screen configuration
AIHome getNFTHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your NFT portfolio, floor prices, and marketplace trends. Ask any questions or choose an analysis below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.dashboard_outlined,
        title: "Portfolio Overview",
        prompt: "Show NFT portfolio overview",
      ),
      AIQuickAction(
        id: "floor",
        icon: Icons.trending_up_outlined,
        title: "Floor Prices",
        prompt: "Show floor price trends",
      ),
      AIQuickAction(
        id: "rarity",
        icon: Icons.auto_awesome_outlined,
        title: "Rarity Sniping",
        prompt: "Analyze rare traits",
      ),
      AIQuickAction(
        id: "mint",
        icon: Icons.rocket_launch_outlined,
        title: "Mint Tracker",
        prompt: "Track active mints",
      ),
      AIQuickAction(
        id: "lending",
        icon: Icons.account_balance_outlined,
        title: "NFT Loans",
        prompt: "Check NFT collateralized loans",
      ),
      AIQuickAction(
        id: "volume",
        icon: Icons.bar_chart_outlined,
        title: "Marketplace Volume",
        prompt: "Analyze marketplace volume",
      ),
    ],
  );
}

/// Returns the list of NFT conversations
List<AIConversation> getNFTConversations() {
  return [
    AIConversation(
      id: "portfolio_trend",
      title: "Portfolio Valuation",
      preview:
          "Total NFT portfolio value dropped by 8.4% due to blue-chip floor correction.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 2,
      chat: portfolioNftConversation,
    ),
    AIConversation(
      id: "floor_prices",
      title: "Floor Price Tracking",
      preview:
          "BAYC floor price stabilized at 11.2 ETH after heavy weekend sweeps.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: floorConversation,
    ),
    AIConversation(
      id: "rarity_sniping",
      title: "Rarity & Trait Sniping",
      preview: "Rare trait #4402 listed 40% below estimated market value.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: rarityConversation,
    ),
    AIConversation(
      id: "mint_tracker",
      title: "Hot Mints & Gas",
      preview:
          "New generative collection minting live with high gas utilization.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: mintConversation,
    ),
    AIConversation(
      id: "executive_nft",
      title: "Collector Dashboard",
      preview: "Cross-marketplace vault summary successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: vaultConversation,
    ),
    AIConversation(
      id: "nft_lending",
      title: "NFTfi & Loans",
      preview:
          "Health factor on BendDAO loan is approaching liquidation threshold.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: lendingConversation,
    ),
    AIConversation(
      id: "royalties",
      title: "Creator Royalties",
      preview:
          "June creator royalties distributed successfully: 4.5 ETH collected.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: royaltyConversation,
    ),
    AIConversation(
      id: "wash_trading",
      title: "Wash Trading Alerts",
      preview:
          "Suspicious volume detected on collection X; potential manipulation.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: washConversation,
    ),
    AIConversation(
      id: "metadata_sync",
      title: "Metadata & IPFS",
      preview: "All token URIs successfully pinned to IPFS gateway.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: metadataConversation,
    ),
    AIConversation(
      id: "weekly_recap",
      title: "Weekly Collector Recap",
      preview:
          "Net worth increased by 1.2 ETH, driven by rare trait appreciation.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyNftConversation,
    ),
  ];
}

/// Returns the list of NFT insights for AI operator
List<AIInsight> getNFTInsights() {
  return [
    AIInsight(
      id: "floor_drop",
      title: "Blue-chip floor prices dropped 15% across top collections",
      summary:
          "Overall NFT market capitalization decreased significantly following macro liquidations and low liquidity.",
      description:
          "AI detected a sustained downward trend in floor prices for major Ethereum collections over the past 48 hours.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 94),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated unrealized loss of approximately 3.4 ETH on your current vault holdings.",
      ),
      why: AIWhy(
        reasons: [
          "Overall crypto market correction affecting risk-on assets",
          "Whale wallet dumping 12 NFTs from collection Y",
          "Dwindling marketplace bid liquidity",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "list_items",
          title: "List liquid items to secure capital",
        ),
        AISuggestion(
          id: "lower_bids",
          title: "Adjust collection offers downward to mitigate risk",
        ),
      ],
      actions: [
        AIAction(
          id: "view_vault",
          label: "View Vault Valuation",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "manage_risk",
          label: "Create Risk Mitigation Plan",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "liquidation_warning",
      title: "NFT-backed loan health factor dropped to 1.12",
      summary:
          "Your collateralized loan on BendDAO is at risk of liquidation due to dropping floor prices.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory.crm, // Using CRM for alerts
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 90),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Potential loss of your collateralized NFT if health factor hits 1.0.",
      ),
      why: AIWhy(
        reasons: [
          "Collateral floor price dropped below threshold",
          "Accrued interest increased debt principal",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "repay_loan",
          title: "Repay part of the loan or add more collateral",
        ),
      ],
      actions: [
        AIAction(
          id: "open_benddao",
          label: "View Loan Position",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "repay",
          label: "Repay Debt Now",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "rare_snipe",
      title: "Rare trait detected: Top 1% rarity listed below floor",
      summary:
          "A mispriced NFT with 'Golden Laser' trait has been detected on Blur marketplace.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 96),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Estimated instant arbitrage profit of 2.5 ETH if sniped immediately.",
      ),
      why: AIWhy(
        reasons: [
          "Seller listed rare item at common floor price",
          "High historical demand for this specific trait",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "execute_snipe",
          title: "Execute instant purchase via sniper bot",
        ),
      ],
      actions: [
        AIAction(
          id: "view_item",
          label: "Inspect Token",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "buy_nft",
          label: "Snipe NFT Now",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "monthly_report",
      title: "Monthly NFT Portfolio Report is ready",
      summary:
          "The comprehensive portfolio and trade performance report for June 2026 has been successfully generated.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into realized gains, floor changes, gas spent, and royalties.",
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
          "Monthly snapshot generated successfully",
          "On-chain wallet data synchronized",
        ],
      ),
    ),
    AIInsight(
      id: "forecast_q3",
      title: "Market volume projected to rebound by 18% next quarter",
      summary:
          "Historical seasonality and upcoming protocol launches indicate stronger liquidity in Q3.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected increase in collection liquidity and sweep activity.",
      ),
      why: AIWhy(
        reasons: [
          "New layer 2 gaming integrations going live",
          "Institutional treasury accumulation trends",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "prepare_liquidity",
          title: "Allocate ETH reserves for Q3 collection launches",
        ),
      ],
      actions: [
        AIAction(
          id: "view_forecast",
          label: "View Analysis",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "strategy",
          label: "Update Vault Strategy",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getNFTActions() {
  return [
    AIActionItem(
      id: "generate_tax_report",
      title: "Generate NFT Capital Gains Report",
      description:
          "Compile on-chain sales and purchases to calculate realized profit and loss.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "sweep_floor",
      title: "Execute Floor Sweep Automation",
      description:
          "Automatically buy up the 3 lowest-priced items in target collection.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.shopping_bag_outlined,
    ),

    AIActionItem(
      id: "forecast_valuation",
      title: "Run Vault Valuation Model",
      description:
          "Predict collection floor trends using machine learning and recent trait sales.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "analyze_marketplace",
      title: "Analyze Blur vs OpenSea Volume",
      description:
          "Compare maker/taker fee structures and liquidity depth across marketplaces.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.swap_vert_outlined,
    ),

    AIActionItem(
      id: "metadata_refresh",
      title: "Refresh Stale Token Metadata",
      description:
          "Force OpenSea and Blur indexers to re-fetch IPFS metadata for newly revealed items.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.refresh_outlined,
    ),

    AIActionItem(
      id: "rarity_ranking",
      title: "Update Trait Rarity Database",
      description:
          "Recalculate statistical rarity ranks for upcoming project launches.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.auto_awesome_outlined,
    ),

    AIActionItem(
      id: "monitor_whales",
      title: "Track Whale Wallet Movements",
      description:
          "Monitor smart money wallets for sudden accumulation or dump patterns.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.waves_outlined,
    ),

    AIActionItem(
      id: "workflow_bidding",
      title: "Setup Auto-Bidding Rules",
      description:
          "Configure collection offer bots to bid 20% below floor across verified collections.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.account_tree_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh Vault Floor Prices",
      description:
          "Synchronize live floor quotes from Seaport and Blur orderbooks.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.dashboard_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly Collector Summary",
      description:
          "Prepare a concise summary of floor shifts, gas spent, and profit/loss.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getNFTAgents() {
  return [
    AIAgent(
      id: "vault_manager",
      name: "Vault Manager",
      description:
          "Monitors portfolio net worth, floor valuations, and asset diversification.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.account_balance_wallet_outlined,
    ),

    AIAgent(
      id: "floor_sniper",
      name: "Floor Sniper Agent",
      description:
          "Scans orderbooks for mispriced listings, rare traits, and arbitrage opportunities.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.radar_outlined,
    ),

    AIAgent(
      id: "royalty_tracker",
      name: "Royalty & Creator Agent",
      description:
          "Tracks creator earnings, secondary sales royalties, and smart contract distributions.",
      category: AIAgentCategory.marketing,
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.monetization_on_outlined,
    ),

    AIAgent(
      id: "lending_monitor",
      name: "NFTfi Risk Monitor",
      description:
          "Tracks collateralized loans, health factors, and liquidation warnings across lending protocols.",
      category: AIAgentCategory.inventory,
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.security_outlined,
    ),

    AIAgent(
      id: "metadata_agent",
      name: "Metadata & IPFS Bot",
      description:
          "Verifies token URIs, image hosting integrity, and smart contract standards.",
      category: AIAgentCategory.crm,
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.dns_outlined,
    ),

    AIAgent(
      id: "wash_detector",
      name: "Wash Trading Detector",
      description:
          "Analyzes wallet clusters and detects artificial volume manipulation on collections.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.policy_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getNFTLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Monthly Portfolio Report",
      message: "Report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Monthly Portfolio Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "Liquidation Risk Alert",
      message: "BendDAO health factor dropped to 1.12.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "NFTfi Risk Monitor",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Floor Scan Started",
      message: "Scanning Blur and OpenSea orderbooks for collection X.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Floor Sniper Agent",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Auto-Bidding Workflow",
      message: "Collection offers placed successfully.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "Wash Trading Detected",
      message: "Suspicious circular transfers found in collection Z.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Wash Trading Detector",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Valuation Forecast Completed",
      message: "Q3 portfolio valuation projection generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Marketplace Data Synced",
      message: "Seaport and Blur API orderbooks updated.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "Floor Sniper Agent",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "IPFS Gateway Failed",
      message: "Failed to fetch metadata from Pinata node.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Metadata & IPFS Bot",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "Pinata API returned HTTP 504 Gateway Timeout.",
    ),

    AILogItem(
      id: "log_010",
      title: "Royalty Distribution",
      message: "June creator royalties disbursed to treasury.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Royalty & Creator Agent",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Dashboard Refreshed",
      message: "Collector vault floor prices synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Metadata refresh webhook executed.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "Metadata & IPFS Bot",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Discord Webhook Failed",
      message: "Unable to send rarity alert to #alpha-feed.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Discord API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "PnL Report Generated",
      message: "Realized capital gains report completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Unlisted Assets Detected",
      message:
          "12 NFTs in your vault have no active collection bids or listings.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "Vault Manager",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getNFTSettings() {
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

// portfolio nft conversation
final portfolioNftConversation = [
  AIChatMessage(
    id: 'port_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed your NFT vault valuation for June. There are some interesting changes in your portfolio net worth.''',
  ),

  AIChatMessage(
    id: 'port_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.pie_chart_outline,
        title: 'Vault Breakdown',
        prompt: 'Show vault breakdown',
      ),

      AIQuickAction(
        id: 'top_gainers',
        icon: Icons.trending_up_outlined,
        title: 'Top Valued Items',
        prompt: 'Show top valued items',
      ),

      AIQuickAction(
        id: 'performance',
        icon: Icons.show_chart,
        title: 'Net Worth Chart',
        prompt: 'Analyze net worth trend',
      ),

      AIQuickAction(
        id: 'liquidity',
        icon: Icons.water_drop_outlined,
        title: 'Vault Liquidity',
        prompt: 'Show vault liquidity score',
      ),
    ],
  ),

  AIChatMessage(
    id: 'port_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze net worth trend',
  ),

  AIChatMessage(
    id: 'port_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Total portfolio valuation dropped by 8.4% this week.

The biggest causes:

• Blue-chip floor prices corrected across the board

• Low secondary market volume reduced immediate liquidation bids

• High gas fees deterred casual buyers from sweeping floors''',
  ),

  AIChatMessage(
    id: 'port_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment_collection', title: 'Segment by collection'),

      AIQuickAction(id: 'liquidation', title: 'Calculate quick-sell value'),
    ],
  ),

  AIChatMessage(
    id: 'port_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last month',
  ),

  AIChatMessage(
    id: 'port_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Compared to May:

• Total Portfolio Value is still up by 4.2% overall

• Realized profits from past flips stand at +1.8 ETH

• Creator royalties collected added 0.4 ETH in passive income

The macro trend remains stable despite the weekly floor correction.''',
  ),

  AIChatMessage(
    id: 'port_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_vault',
        icon: Icons.download_outlined,
        title: 'Export Vault CSV',
      ),

      AIQuickAction(
        id: 'discord',
        icon: Icons.chat_outlined,
        title: 'Share Snapshot to Discord',
      ),
    ],
  ),

  AIChatMessage(
    id: 'port_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as an NFT Portfolio Manager. Please perform a comparative analysis of the Vault Valuation for this month versus last month.
Include the following components:

Quantitative Comparison: State the current month's valuation vs. last month's valuation.

Segment Breakdown: Analyze performance across blue-chip vs generative art collections.

Liquidity Analysis: Identify how quickly the vault can be liquidated at current floor bids.

Causal Insights: Provide potential reasons for the valuation shift.

Actionable Recommendations: Suggest 3 concrete steps to optimize vault risk next month.''',
  ),
];

// floor conversation
List<AIChatMessage> floorConversation = [
  AIChatMessage(
    id: 'flr_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the floor price movements for top Ethereum collections this week.

There are some notable shifts in market sentiment.
''',
  ),

  AIChatMessage(
    id: 'flr_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'floor_overview',
        icon: Icons.trending_up_outlined,
        title: 'Floor Overview',
        prompt: 'Show floor overview',
      ),

      AIQuickAction(
        id: 'sweep_activity',
        icon: Icons.waves_outlined,
        title: 'Floor Sweeps',
        prompt: 'Analyze recent floor sweeps',
      ),

      AIQuickAction(
        id: 'bids_depth',
        icon: Icons.layers_outlined,
        title: 'Bid Depth',
        prompt: 'Show orderbook bid depth',
      ),
    ],
  ),

  AIChatMessage(
    id: 'flr_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze recent floor sweeps',
  ),

  AIChatMessage(
    id: 'flr_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Floor sweep activity increased by 34% yesterday.

The primary drivers:

• Whale wallet accumulated 45 items from collection A in a single transaction

• Creator announced upcoming utility roadmap, sparking FOMO

• Orderbook liquidity thickened significantly around the 11 ETH mark
''',
  ),

  AIChatMessage(
    id: 'flr_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'compare_marketplaces',
        title: 'Compare Blur vs OpenSea floor quotes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'flr_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_floor_data',
        icon: Icons.table_view,
        title: 'Export Floor Tracker CSV',
      ),
    ],
  ),
];

// rarity conversation
List<AIChatMessage> rarityConversation = [
  AIChatMessage(
    id: 'rar_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have scanned marketplace listings for rare trait mismatches and arbitrage opportunities.

We found an interesting item priced below its statistical value.
''',
  ),

  AIChatMessage(
    id: 'rar_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'trait_snipes',
        icon: Icons.auto_awesome_outlined,
        title: 'Trait Snipes',
        prompt: 'Show active trait snipes',
      ),

      AIQuickAction(
        id: 'rarity_rankings',
        icon: Icons.format_list_numbered_outlined,
        title: 'Top Ranks in Vault',
        prompt: 'Show vault rarity rankings',
      ),
    ],
  ),

  AIChatMessage(
    id: 'rar_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show active trait snipes',
  ),

  AIChatMessage(
    id: 'rar_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I detected 1 high-probability snipe on Blur:

• Collection: CyberPunks Genesis (#4402)
• Trait: Solid Gold Crown (Top 0.5% rarity)
• Listed Price: 12.5 ETH (Estimated value: 18.0 ETH)
''',
  ),

  AIChatMessage(
    id: 'rar_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'buy_now',
        title: 'Execute instant purchase transaction',
      ),
    ],
  ),

  AIChatMessage(
    id: 'rar_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_blur',
        icon: Icons.open_in_browser_outlined,
        title: 'Open Blur Listing',
      ),
    ],
  ),
];

// mint conversation
List<AIChatMessage> mintConversation = [
  AIChatMessage(
    id: 'mnt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest trending mints and gas utilization report for this week.

There is high activity in new generative art drops.
''',
  ),

  AIChatMessage(
    id: 'mnt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'trending_mints',
        icon: Icons.local_fire_department_outlined,
        title: 'Trending Mints',
        prompt: 'Show trending mints',
      ),

      AIQuickAction(
        id: 'gas_tracker',
        icon: Icons.local_gas_station_outlined,
        title: 'Gas Tracker',
        prompt: 'Check current gas gwei',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mnt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show trending mints',
  ),

  AIChatMessage(
    id: 'mnt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Top mints by volume in the last 6 hours:

• "EtherWorlds" (ERC-721A): 85% minted out, surging gas prices to 45 gwei.
• "PixelRealms": Whitelist phase ending soon, high smart contract interaction count.
''',
  ),

  AIChatMessage(
    id: 'mnt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'simulate_mint',
        title: 'Simulate gas cost for EtherWorlds mint',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mnt_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_etherscan',
        icon: Icons.open_in_new_outlined,
        title: 'Open Contract on Etherscan',
      ),
    ],
  ),
];

// vault conversation
List<AIChatMessage> vaultConversation = [
  AIChatMessage(
    id: 'vlt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your executive NFT collector vault summary for this month.

All cold storage wallets and connected vaults are secure and reporting correct balances.
''',
  ),

  AIChatMessage(
    id: 'vlt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'kpi_summary',
        icon: Icons.insights_outlined,
        title: 'Vault KPIs',
        prompt: 'Show vault KPI summary',
      ),

      AIQuickAction(
        id: 'net_worth',
        icon: Icons.account_balance_outlined,
        title: 'Total ETH Holdings',
        prompt: 'Analyze total portfolio ETH equivalent',
      ),
    ],
  ),

  AIChatMessage(
    id: 'vlt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show vault KPI summary',
  ),

  AIChatMessage(
    id: 'vlt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level collector matrix:

• Total Vault Items: 42 NFTs across 8 collections

• Estimated Net Worth: 48.5 ETH (\$142,500)

• Liquid Assets (WETH): 5.2 ETH ready for deployment

• Vault Security Status: 100% Hardware Wallet Protected (Ledger)
''',
  ),

  AIChatMessage(
    id: 'vlt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'breakdown_collection',
        title: 'Breakdown items by collection',
      ),
    ],
  ),

  AIChatMessage(
    id: 'vlt_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'download_pdf',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Collector Report PDF',
      ),
    ],
  ),
];

// lending conversation
List<AIChatMessage> lendingConversation = [
  AIChatMessage(
    id: 'lend_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed your active NFT-backed loans and collateral health factors across lending pools.

We have one position requiring your attention.
''',
  ),

  AIChatMessage(
    id: 'lend_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'active_loans',
        icon: Icons.account_balance_outlined,
        title: 'Active Loans',
        prompt: 'Show active loans',
      ),

      AIQuickAction(
        id: 'health_factor',
        icon: Icons.health_and_safety_outlined,
        title: 'Health Factor',
        prompt: 'Check health factors',
      ),
    ],
  ),

  AIChatMessage(
    id: 'lend_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check health factors',
  ),

  AIChatMessage(
    id: 'lend_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Your loan on BendDAO using Bored Ape #3021 as collateral is currently at a 1.12 Health Factor. 

Because the floor price dropped, your liquidation threshold is getting close. Safe zone is above 1.30.
''',
  ),

  AIChatMessage(
    id: 'lend_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'repay_part',
        title: 'Calculate repayment needed to reach 1.40 health factor',
      ),
    ],
  ),

  AIChatMessage(
    id: 'lend_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_benddao',
        icon: Icons.open_in_new_outlined,
        title: 'Open BendDAO Protocol',
      ),
    ],
  ),
];

// royalty conversation
List<AIChatMessage> royaltyConversation = [
  AIChatMessage(
    id: 'roy_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the creator royalties and secondary market sales report for this month.

Secondary trading generated steady passive income.
''',
  ),

  AIChatMessage(
    id: 'roy_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'royalty_earnings',
        icon: Icons.monetization_on_outlined,
        title: 'Royalty Earnings',
        prompt: 'Show royalty earnings summary',
      ),

      AIQuickAction(
        id: 'secondary_volume',
        icon: Icons.bar_chart_outlined,
        title: 'Secondary Volume',
        prompt: 'Analyze secondary trading volume',
      ),
    ],
  ),

  AIChatMessage(
    id: 'roy_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show royalty earnings summary',
  ),

  AIChatMessage(
    id: 'roy_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
You collected a total of 4.5 ETH in creator royalties across your deployed smart contracts this month.

• OpenSea: Collected 2.8 ETH
• Blur: Collected 1.2 ETH
• Magic Eden: Collected 0.5 ETH
''',
  ),

  AIChatMessage(
    id: 'roy_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'claim_royalties',
        title: 'Withdraw royalties to cold storage',
      ),
    ],
  ),

  AIChatMessage(
    id: 'roy_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_royalties',
        icon: Icons.download_outlined,
        title: 'Export Royalty Ledger CSV',
      ),
    ],
  ),
];

// wash conversation
List<AIChatMessage> washConversation = [
  AIChatMessage(
    id: 'wsh_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed recent collection trades to detect artificial volume manipulation and wash trading.

We have flagged one suspicious collection.
''',
  ),

  AIChatMessage(
    id: 'wsh_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'wash_score',
        icon: Icons.policy_outlined,
        title: 'Wash Trading Score',
        prompt: 'Check collection wash score',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wsh_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check collection wash score',
  ),

  AIChatMessage(
    id: 'wsh_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Collection "AlphaGen" is showing a 78% wash trading probability score.

Key indicators:
• 4 interconnected wallets trading the same 10 NFTs back and forth.
• High reported volume with zero unique buyer growth.
''',
  ),

  AIChatMessage(
    id: 'wsh_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'block_collection',
        title: 'Add collection to risk blacklist',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wsh_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'view_wallets',
        icon: Icons.troubleshoot_outlined,
        title: 'Inspect Connected Wallets',
      ),
    ],
  ),
];

// metadata conversation
List<AIChatMessage> metadataConversation = [
  AIChatMessage(
    id: 'meta_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have verified the IPFS pinning status and token metadata configurations for your smart contracts.

All endpoints are currently responding normally.
''',
  ),

  AIChatMessage(
    id: 'meta_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'ipfs_status',
        icon: Icons.dns_outlined,
        title: 'IPFS Pinning Status',
        prompt: 'Check IPFS pin health',
      ),
    ],
  ),

  AIChatMessage(
    id: 'meta_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check IPFS pin health',
  ),

  AIChatMessage(
    id: 'meta_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
IPFS Cluster Status: Healthy

• Total Pinned Files: 1,000 JSON metadata files + image assets.
• Gateway Latency: 120ms average response time across Cloudflare and Pinata nodes.
''',
  ),

  AIChatMessage(
    id: 'meta_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'repin_assets',
        title: 'Force backup pin on secondary node',
      ),
    ],
  ),

  AIChatMessage(
    id: 'meta_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_pinata',
        icon: Icons.cloud_done_outlined,
        title: 'Open Pinata Dashboard',
      ),
    ],
  ),
];

// weekly nft conversation
List<AIChatMessage> weeklyNftConversation = [
  AIChatMessage(
    id: 'wknft_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly NFT collector sprint and market recap report.

Overall portfolio performance remained positive despite macro fluctuations.
''',
  ),

  AIChatMessage(
    id: 'wknft_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'weekly_pnl',
        icon: Icons.trending_up_outlined,
        title: 'Weekly PnL',
        prompt: 'Show weekly collector PnL',
      ),

      AIQuickAction(
        id: 'trade_recap',
        icon: Icons.swap_horiz_outlined,
        title: 'Trade Recap',
        prompt: 'Analyze weekly flips',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wknft_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze weekly flips',
  ),

  AIChatMessage(
    id: 'wknft_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
The weekly flipping activity yielded positive net gains:

• Total Flips Executed: 4 items
• Realized Profit: +1.2 ETH
• Gas Fees Spent: 0.08 ETH total across all executions
''',
  ),

  AIChatMessage(
    id: 'wknft_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'optimize_gas',
        title: 'Optimize gas settings for future snipes',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wknft_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_blur_bids',
        icon: Icons.shopping_bag_outlined,
        title: 'Open Blur Bidding Manager',
      ),
    ],
  ),
];

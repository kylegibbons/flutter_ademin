import 'package:flutter/material.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_operator_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';

/// Mock AI operator data for Crypto dashboard demo.
AIOperatorData getCryptoAIOperatorData() {
  return AIOperatorData(
    home: getCryptoHome(),
    conversations: getCryptoConversations(),
    insights: getCryptoInsights(),
    actions: getCryptoActions(),
    agents: getCryptoAgents(),
    logs: getCryptoLogs(),
  );
}

/// Returns the Crypto home screen configuration
AIHome getCryptoHome() {
  return AIHome(
    greeting: "Hi Umar 👋",
    subtitle:
        "I'm ready to help analyze your crypto portfolio and DeFi assets. Ask any questions or choose one of the analyses below.",
    quickActions: const [
      AIQuickAction(
        id: "overview",
        icon: Icons.account_balance_wallet_outlined,
        title: "Portfolio Overview",
        prompt: "Show portfolio overview",
      ),
      AIQuickAction(
        id: "market",
        icon: Icons.candlestick_chart_outlined,
        title: "Market Trends",
        prompt: "Show market trends",
      ),
      AIQuickAction(
        id: "staking",
        icon: Icons.savings_outlined,
        title: "Staking & Yields",
        prompt: "Analyze staking yields",
      ),
      AIQuickAction(
        id: "gas_fees",
        icon: Icons.local_gas_station_outlined,
        title: "Gas Fees Tracker",
        prompt: "Check current gas fees",
      ),
      AIQuickAction(
        id: "liquidity",
        icon: Icons.water_drop_outlined,
        title: "Liquidity Pools",
        prompt: "Check liquidity status",
      ),
      AIQuickAction(
        id: "security",
        icon: Icons.security_outlined,
        title: "Wallet Security",
        prompt: "Run security audit",
      ),
    ],
  );
}

/// Returns the list of Crypto conversations
List<AIConversation> getCryptoConversations() {
  return [
    AIConversation(
      id: "portfolio_trend",
      title: "Portfolio Analysis",
      preview:
          "Total portfolio value dropped by 4.2% due to BTC market correction.",
      updatedAt: DateTime(2026, 7, 1, 9, 25),
      pinned: true,
      unreadCount: 1,
      chat: portfolioConversation,
    ),
    AIConversation(
      id: "yield_forecast",
      title: "Yield Forecast",
      preview: "Estimated Q3 staking rewards is projected to reach 1.4 ETH.",
      updatedAt: DateTime(2026, 7, 1, 8, 50),
      pinned: true,
      chat: yieldConversation,
    ),
    AIConversation(
      id: "gas_alerts",
      title: "High Gas Fees",
      preview: "Ethereum network gwei spiked to 85. 3 pending swaps stalled.",
      updatedAt: DateTime(2026, 6, 30, 17, 20),
      chat: gasConversation,
    ),
    AIConversation(
      id: "market_movers",
      title: "Market Movers",
      preview: "Solana ecosystem tokens are showing strong accumulation.",
      updatedAt: DateTime(2026, 6, 30, 14, 10),
      chat: marketConversation,
    ),
    AIConversation(
      id: "executive_crypto",
      title: "Wallet Dashboard",
      preview: "Cross-chain asset overview successfully updated.",
      updatedAt: DateTime(2026, 6, 29, 16, 55),
      chat: walletConversation,
    ),
    AIConversation(
      id: "liquidity_pools",
      title: "Liquidity Alerts",
      preview: "Impermanent loss detected on the ETH/USDC Uniswap V3 pool.",
      updatedAt: DateTime(2026, 6, 29, 11, 32),
      chat: liquidityConversation,
    ),
    AIConversation(
      id: "bridge_status",
      title: "Cross-Chain Bridges",
      preview: "Arbitrum to Mainnet transfer delayed by 15 minutes.",
      updatedAt: DateTime(2026, 6, 28, 15, 41),
      chat: bridgeConversation,
    ),
    AIConversation(
      id: "security_audit",
      title: "Security & Approvals",
      preview: "2 unlimited token spend approvals found on legacy contracts.",
      updatedAt: DateTime(2026, 6, 28, 10, 12),
      chat: securityConversation,
    ),
    AIConversation(
      id: "node_ops",
      title: "Node Operations",
      preview: "Validator node uptime remains at 99.98% for this epoch.",
      updatedAt: DateTime(2026, 6, 27, 9, 10),
      chat: nodeConversation,
    ),
    AIConversation(
      id: "weekly_recap",
      title: "Weekly Crypto Recap",
      preview:
          "Net worth increased by \$2,400, mostly driven by altcoin gains.",
      updatedAt: DateTime(2026, 6, 26, 14, 44),
      chat: weeklyCryptoConversation,
    ),
  ];
}

/// Returns the list of Crypto insights for AI operator
List<AIInsight> getCryptoInsights() {
  return [
    AIInsight(
      id: "portfolio_drop",
      title: "Portfolio value dropped 12% in the last 24h",
      summary:
          "Overall wallet balance decreased significantly following a broader market sell-off triggered by macroeconomic news.",
      description:
          "AI detected a sustained decline across your top 5 holdings. The primary contributors are heavy long liquidations on major exchanges and declining DeFi TVL.",
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 9, 10),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 95),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Potential risk of liquidation on your Aave borrow position if ETH drops below \$2,400.",
      ),
      why: AIWhy(
        reasons: [
          "Bitcoin dominance increased, draining altcoin liquidity",
          "Aave health factor dropped to 1.15",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "repay_debt",
          title: "Repay Aave loan to increase health factor",
        ),
        AISuggestion(
          id: "hedge_position",
          title: "Hedge exposure using stablecoins",
        ),
      ],
      actions: [
        AIAction(
          id: "view_health",
          label: "View Health Factor",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "rebalance",
          label: "Rebalance Portfolio",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "high_gas",
      title: "3 pending transactions stuck due to low gas",
      summary:
          "Network congestion on Ethereum mainnet has caused base fees to spike, stalling your recent DEX swaps.",
      severity: AIInsightSeverity.warning,
      category: AIInsightCategory
          .crm, // Using CRM category for alerts/user management
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 8, 35),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 88),
      impact: AIImpact(
        level: AIImpactLevel.medium,
        description:
            "Transactions will eventually drop or fail, costing you gas without executing the swap.",
      ),
      why: AIWhy(
        reasons: [
          "Network base fee spiked to 85 gwei",
          "Initial transaction sent with 25 gwei max limit",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "speed_up",
          title: "Speed up transactions with higher gas limit",
        ),
      ],
      actions: [
        AIAction(
          id: "view_txs",
          label: "View TX Hashes",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "cancel_tx",
          label: "Cancel Transactions",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "yield_opportunity",
      title: "New yield farming opportunity: 45% APY on USDC/SOL",
      summary:
          "A new incentivized liquidity pool has launched on Orca, offering exceptionally high yields for stablecoin pairs.",
      severity: AIInsightSeverity.opportunity,
      category: AIInsightCategory
          .marketing, // Using Marketing for growth/opportunities
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 7, 50),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 78),
      impact: AIImpact(
        level: AIImpactLevel.high,
        description:
            "Opportunity to generate passive income on idle stablecoins with minimal impermanent loss risk.",
      ),
      why: AIWhy(
        reasons: [
          "Protocol launched a new emissions program",
          "Current idle USDC in your Phantom wallet",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "bridge_funds",
          title: "Bridge USDC from Arbitrum to Solana",
        ),
        AISuggestion(
          id: "check_audit",
          title: "Review smart contract audit report for Orca",
        ),
      ],
      actions: [
        AIAction(
          id: "view_pool",
          label: "View Pool Stats",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "deposit_liquidity",
          label: "Deposit Liquidity",
          type: AIActionType.primary,
        ),
      ],
    ),
    AIInsight(
      id: "tax_report",
      title: "Monthly Crypto Tax Report is ready",
      summary:
          "The comprehensive capital gains and transaction history report for June 2026 has been successfully generated.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.analytics,
      status: AIInsightStatus.viewed,
      generatedAt: DateTime(2026, 7, 7, 18, 20),
      confidence: AIConfidence(level: AIConfidenceLevel.high, score: 100),
      impact: AIImpact(
        level: AIImpactLevel.low,
        description:
            "Provides full visibility into realized gains, losses, and gas fees for tax filing purposes.",
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
          "End of month data processing complete",
          "On-chain wallets synchronized successfully",
        ],
      ),
    ),
    AIInsight(
      id: "staking_forecast",
      title: "Staking APY is projected to stabilize at 4.2%",
      summary:
          "Based on current network participation rates, Ethereum staking yields are expected to remain steady.",
      severity: AIInsightSeverity.information,
      category: AIInsightCategory.finance,
      status: AIInsightStatus.unread,
      generatedAt: DateTime(2026, 7, 8, 6, 45),
      confidence: AIConfidence(level: AIConfidenceLevel.medium, score: 81),
      impact: AIImpact(
        level: AIImpactLevel.positive,
        description:
            "Projected continuous generation of 0.12 ETH per month from validator nodes.",
      ),
      why: AIWhy(
        reasons: [
          "Network validator queue has emptied",
          "MEV rewards have plateaued",
        ],
      ),
      suggestions: [
        AISuggestion(
          id: "compound_rewards",
          title: "Auto-compound rewards into Liquid Staking Tokens",
        ),
      ],
      actions: [
        AIAction(
          id: "view_nodes",
          label: "Check Validators",
          type: AIActionType.secondary,
        ),
        AIAction(
          id: "claim_rewards",
          label: "Claim Rewards",
          type: AIActionType.primary,
        ),
      ],
    ),
  ];
}

/// Return the list of actions
List<AIActionItem> getCryptoActions() {
  return [
    AIActionItem(
      id: "generate_tax_report",
      title: "Generate Capital Gains Report",
      description:
          "Compile on-chain transaction history for Q2 to calculate realized and unrealized PnL.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 68,
      createdAt: DateTime(2026, 7, 8, 9, 5),
      icon: Icons.description_outlined,
    ),

    AIActionItem(
      id: "speed_up_tx",
      title: "Speed Up Pending Transactions",
      description:
          "Automatically rebroadcast 3 stalled transactions with a 20% higher gas limit.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 8, 8, 42),
      icon: Icons.fast_forward_outlined,
    ),

    AIActionItem(
      id: "forecast_yield",
      title: "Calculate Staking Yield Projection",
      description:
          "Predict staking rewards for the next quarter based on current network APY.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 8, 15),
      createdAt: DateTime(2026, 7, 8, 8, 2),
      icon: Icons.insights_outlined,
    ),

    AIActionItem(
      id: "market_analysis",
      title: "Scan Market for Altcoin Breakouts",
      description:
          "Evaluate volume and momentum indicators for top 100 CMC tokens.",
      status: AIActionStatus.running,
      priority: AIActionPriority.medium,
      progress: 42,
      createdAt: DateTime(2026, 7, 8, 7, 55),
      icon: Icons.ssid_chart_outlined,
    ),

    AIActionItem(
      id: "impermanent_loss",
      title: "Check Impermanent Loss",
      description:
          "Calculate IL for active liquidity pools on Uniswap V3 and Curve.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 8, 7, 30),
      createdAt: DateTime(2026, 7, 8, 7, 10),
      icon: Icons.water_drop_outlined,
    ),

    AIActionItem(
      id: "wallet_segmentation",
      title: "Categorize Wallet Transactions",
      description:
          "Cluster past transactions into Swaps, Bridging, Staking, and NFT mints.",
      status: AIActionStatus.pending,
      priority: AIActionPriority.low,
      createdAt: DateTime(2026, 7, 8, 6, 50),
      icon: Icons.account_tree_outlined,
    ),

    AIActionItem(
      id: "security_audit",
      title: "Revoke Unlimited Allowances",
      description:
          "Scan connected wallets and revoke infinite spend permissions for unused dApps.",
      status: AIActionStatus.running,
      priority: AIActionPriority.high,
      progress: 81,
      createdAt: DateTime(2026, 7, 8, 6, 30),
      icon: Icons.security_outlined,
    ),

    AIActionItem(
      id: "workflow_bridging",
      title: "Automate Cross-Chain Bridge",
      description:
          "Setup logic to automatically bridge stablecoins to Arbitrum when gas fees drop below 15 gwei.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.medium,
      completedAt: DateTime(2026, 7, 7, 17, 45),
      createdAt: DateTime(2026, 7, 7, 17, 18),
      icon: Icons.compare_arrows_outlined,
    ),

    AIActionItem(
      id: "executive_dashboard",
      title: "Refresh Portfolio Balances",
      description:
          "Synchronize live prices, token balances, and NFT floor prices with RPC nodes.",
      status: AIActionStatus.failed,
      priority: AIActionPriority.high,
      createdAt: DateTime(2026, 7, 7, 15, 20),
      icon: Icons.refresh_outlined,
    ),

    AIActionItem(
      id: "weekly_summary",
      title: "Generate Weekly Wallet Summary",
      description:
          "Prepare a concise summary of asset allocation shifts, yields earned, and gas spent.",
      status: AIActionStatus.completed,
      priority: AIActionPriority.low,
      completedAt: DateTime(2026, 7, 7, 9, 10),
      createdAt: DateTime(2026, 7, 7, 8, 58),
      icon: Icons.summarize_outlined,
    ),
  ];
}

/// Return the list of AI Agents
List<AIAgent> getCryptoAgents() {
  return [
    AIAgent(
      id: "portfolio_manager",
      name: "Portfolio Manager",
      description:
          "Monitors overall asset allocation, PnL, risk exposure, and net worth.",
      category: AIAgentCategory.finance,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 156,
      successRate: 98,
      lastUsed: DateTime(2026, 7, 8, 9, 12),
      icon: Icons.account_balance_wallet_outlined,
    ),

    AIAgent(
      id: "market_analyst",
      name: "Market Analyst",
      description:
          "Analyzes price charts, tokenomics, on-chain volume, and market sentiment.",
      category: AIAgentCategory.analytics,
      status: AIAgentHealthStatus.healthy,
      state: AIAgentState.running,
      tasksCompleted: 243,
      successRate: 96,
      lastUsed: DateTime(2026, 7, 8, 8, 55),
      icon: Icons.candlestick_chart_outlined,
    ),

    AIAgent(
      id: "yield_farmer",
      name: "DeFi Yield Farmer",
      description:
          "Scans protocols for the best APYs, manages staking positions, and harvests rewards.",
      category: AIAgentCategory.marketing, // Used for growth
      status: AIAgentHealthStatus.warning,
      state: AIAgentState.running,
      tasksCompleted: 128,
      successRate: 94,
      lastUsed: DateTime(2026, 7, 8, 7, 42),
      icon: Icons.agriculture_outlined,
    ),

    AIAgent(
      id: "liquidity_agent",
      name: "Liquidity Monitor",
      description:
          "Tracks AMM pool health, slippage limits, and impermanent loss metrics.",
      category: AIAgentCategory.inventory, // Used for assets/liquidity
      status: AIAgentHealthStatus.degraded,
      state: AIAgentState.paused,
      tasksCompleted: 89,
      successRate: 97,
      lastUsed: DateTime(2026, 7, 8, 5, 30),
      icon: Icons.water_drop_outlined,
    ),

    AIAgent(
      id: "security_auditor",
      name: "Security Auditor",
      description:
          "Checks smart contract vulnerabilities, allowance risks, and phishing attempts.",
      category: AIAgentCategory.crm, // Used for security alerts
      status: AIAgentHealthStatus.unhealthy,
      state: AIAgentState.stopped,
      tasksCompleted: 67,
      successRate: 95,
      lastUsed: DateTime(2026, 7, 7, 18, 20),
      icon: Icons.shield_outlined,
    ),

    AIAgent(
      id: "node_operator",
      name: "Node Operator",
      description:
          "Tracks validator uptime, slashing risks, client updates, and MEV relays.",
      category: AIAgentCategory.support,
      status: AIAgentHealthStatus.offline,
      state: AIAgentState.stopped,
      tasksCompleted: 45,
      successRate: 90,
      lastUsed: DateTime(2026, 7, 6, 15, 15),
      icon: Icons.dns_outlined,
      enabled: false,
    ),
  ];
}

/// Return the list of AI Logs
List<AILogItem> getCryptoLogs() {
  return [
    AILogItem(
      id: "log_001",
      title: "Tax & Capital Gains Report",
      message: "Ledger syncing and report generation started.",
      level: AILogLevel.info,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Portfolio Manager",
      createdAt: DateTime(2026, 7, 8, 9, 25),
    ),

    AILogItem(
      id: "log_002",
      title: "Tax & Capital Gains Report",
      message: "Report generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.report,
      sourceName: "Portfolio Manager",
      createdAt: DateTime(2026, 7, 8, 9, 22),
    ),

    AILogItem(
      id: "log_003",
      title: "Liquidation Warning",
      message: "Aave Health Factor dropped below 1.15.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.insight,
      sourceName: "Portfolio Manager",
      createdAt: DateTime(2026, 7, 8, 9, 10),
    ),

    AILogItem(
      id: "log_004",
      title: "Market Scan Started",
      message: "Analyzing Layer 2 ecosystem token volumes.",
      level: AILogLevel.info,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Market Analyst",
      createdAt: DateTime(2026, 7, 8, 9, 5),
    ),

    AILogItem(
      id: "log_005",
      title: "Auto-Compound Workflow",
      message: "Pending rewards claimed and restaked automatically.",
      level: AILogLevel.success,
      source: AILogSource.workflow,
      type: AILogType.workflow,
      sourceName: "DeFi Yield Farmer",
      createdAt: DateTime(2026, 7, 8, 8, 42),
    ),

    AILogItem(
      id: "log_006",
      title: "High Slippage Alert",
      message: "Token liquidity dropped, expect >3% slippage on DEX swaps.",
      level: AILogLevel.warning,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Liquidity Monitor",
      createdAt: DateTime(2026, 7, 8, 8, 35),
    ),

    AILogItem(
      id: "log_007",
      title: "Reward Forecast Completed",
      message: "Q3 staking reward projection generated successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.forecast,
      sourceName: "DeFi Yield Farmer",
      createdAt: DateTime(2026, 7, 8, 8, 15),
    ),

    AILogItem(
      id: "log_008",
      title: "Oracle Data Synced",
      message: "Chainlink price feeds updated.",
      level: AILogLevel.info,
      source: AILogSource.integration,
      type: AILogType.sync,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 8, 7, 50),
    ),

    AILogItem(
      id: "log_009",
      title: "RPC Node Sync Failed",
      message: "Failed to fetch latest block from Infura RPC.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.api,
      sourceName: "Node Operator",
      createdAt: DateTime(2026, 7, 8, 7, 30),
      details: "RPC Endpoint returned HTTP 429 Too Many Requests.",
    ),

    AILogItem(
      id: "log_010",
      title: "Allowance Revoked",
      message: "Revoked spend permission for deprecated contract 0x4f...",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.analysis,
      sourceName: "Security Auditor",
      createdAt: DateTime(2026, 7, 7, 18, 20),
    ),

    AILogItem(
      id: "log_011",
      title: "Dashboard Refreshed",
      message: "Cross-chain balances and NFT floor prices synchronized.",
      level: AILogLevel.success,
      source: AILogSource.system,
      type: AILogType.dashboard,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 17, 45),
    ),

    AILogItem(
      id: "log_012",
      title: "Automation Executed",
      message: "Bridge stablecoin workflow executed via LayerZero.",
      level: AILogLevel.info,
      source: AILogSource.automation,
      type: AILogType.automation,
      sourceName: "DeFi Yield Farmer",
      createdAt: DateTime(2026, 7, 7, 16, 30),
    ),

    AILogItem(
      id: "log_013",
      title: "Telegram Alert Failed",
      message: "Unable to push liquidation warning to private channel.",
      level: AILogLevel.error,
      source: AILogSource.integration,
      type: AILogType.integration,
      sourceName: "System",
      createdAt: DateTime(2026, 7, 7, 15, 18),
      details: "Telegram API returned HTTP 401 Unauthorized.",
    ),

    AILogItem(
      id: "log_014",
      title: "Impermanent Loss Report",
      message: "LP position analysis completed successfully.",
      level: AILogLevel.success,
      source: AILogSource.agent,
      type: AILogType.report,
      sourceName: "Liquidity Monitor",
      createdAt: DateTime(2026, 7, 7, 14, 20),
    ),

    AILogItem(
      id: "log_015",
      title: "Dust Balances Detected",
      message:
          "23 tokens have dust balances < \$1, suggesting a consolidation swap.",
      level: AILogLevel.warning,
      source: AILogSource.system,
      type: AILogType.data,
      sourceName: "Portfolio Manager",
      createdAt: DateTime(2026, 7, 7, 11, 10),
    ),
  ];
}

/// Settings

AISettings getCryptoSettings() {
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

// portfolio conversation
final portfolioConversation = [
  AIChatMessage(
    id: 'port_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Hi Umar 👋
I have analyzed your crypto portfolio for June. There are some interesting changes in your asset allocation and overall value.''',
  ),

  AIChatMessage(
    id: 'port_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'overview',
        icon: Icons.pie_chart_outline,
        title: 'Asset Allocation',
        prompt: 'Show asset allocation',
      ),

      AIQuickAction(
        id: 'top_gainers',
        icon: Icons.trending_up_outlined,
        title: 'Top Gainers',
        prompt: 'Show top performing assets',
      ),

      AIQuickAction(
        id: 'performance',
        icon: Icons.show_chart,
        title: 'Net Worth Chart',
        prompt: 'Analyze portfolio performance',
      ),

      AIQuickAction(
        id: 'risk',
        icon: Icons.gpp_maybe_outlined,
        title: 'Risk Exposure',
        prompt: 'Show risk exposure',
      ),
    ],
  ),

  AIChatMessage(
    id: 'port_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze portfolio performance',
  ),

  AIChatMessage(
    id: 'port_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''Portfolio value dropped by 4.2% this week.

The biggest causes:

• BTC experienced a sharp correction to \$58,000

• 23% of your portfolio is in high-beta altcoins which bled heavily

• Stablecoin reserves sit at only 5%, limiting buying power''',
  ),

  AIChatMessage(
    id: 'port_5',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(id: 'compare', title: 'Compare with last month'),

      AIQuickAction(id: 'segment_chain', title: 'Segment by blockchain'),

      AIQuickAction(
        id: 'rebalance',
        title: 'Calculate rebalance to 20% stables',
      ),
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

• Total Portfolio Value is still up by 12%

• Realized PnL is positive at +\$3,400

• DeFi Yields generated \$245 in passive income

Despite the weekly drop, the macro monthly trend remains highly profitable.''',
  ),

  AIChatMessage(
    id: 'port_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'take_profit',
        icon: Icons.sell_outlined,
        title: 'Take Profit Workflow',
      ),

      AIQuickAction(
        id: 'slack',
        icon: Icons.chat_outlined,
        title: 'Alert Alpha Group',
      ),
    ],
  ),

  AIChatMessage(
    id: 'port_10',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text:
        '''Act as a Crypto Portfolio Analyst. Please perform a comparative analysis of the Portfolio Performance for this month versus last month.
Include the following components:

Quantitative Comparison: State the current month's ROI vs. last month's ROI.

Segment Breakdown: Analyze the performance across different chains (Ethereum vs Solana).

Risk Analysis: Identify the specific asset that caused the most drawdown.

Causal Insights: Provide potential reasons for the shift in market dynamics.

Actionable Recommendations: Suggest 3 concrete steps to manage risk next month.''',
  ),
];

// yield conversation
List<AIChatMessage> yieldConversation = [
  AIChatMessage(
    id: 'yld_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have analyzed the yield farming and staking data for Q2.

There are some positive trends in your passive income generation.
''',
  ),

  AIChatMessage(
    id: 'yld_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'yield_overview',
        icon: Icons.payments_outlined,
        title: 'Yield Overview',
        prompt: 'Show yield overview',
      ),

      AIQuickAction(
        id: 'apy_breakdown',
        icon: Icons.monetization_on_outlined,
        title: 'APY Comparison',
        prompt: 'Analyze current APYs',
      ),

      AIQuickAction(
        id: 'liquid_staking',
        icon: Icons.water_drop_outlined,
        title: 'LST Performance',
        prompt: 'Analyze LST metrics',
      ),

      AIQuickAction(
        id: 'protocol_risk',
        icon: Icons.shield_outlined,
        title: 'Protocol Risks',
        prompt: 'Show protocol security scores',
      ),
    ],
  ),

  AIChatMessage(
    id: 'yld_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze current APYs',
  ),

  AIChatMessage(
    id: 'yld_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Average portfolio APY grew by 1.5% this month, reaching 8.4%.

The primary drivers:

• Lido stETH rewards remained stable at 3.1%

• USDC lending rates on Aave spiked to 11% during market volatility

• Providing liquidity on Uniswap V3 generated significant fee revenue
''',
  ),

  AIChatMessage(
    id: 'yld_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'compare_quarter', title: 'Compare with last quarter'),

      AIQuickAction(id: 'top_pools', title: 'Show top performing pools'),
    ],
  ),

  AIChatMessage(
    id: 'yld_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_csv',
        icon: Icons.table_view,
        title: 'Export Rewards CSV',
      ),

      AIQuickAction(
        id: 'adjust_forecast',
        icon: Icons.auto_graph,
        title: 'Update Q3 Projection',
      ),
    ],
  ),

  AIChatMessage(
    id: 'yld_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare with last quarter',
  ),

  AIChatMessage(
    id: 'yld_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Compared to Q1:

• Total Passive Income increased by 18.2% (\$450 earned)

• Average APY across all assets rose by 1.1%

• Gas costs for harvesting rewards decreased due to Dencun upgrade

The data indicates a highly optimized and cost-efficient yield farming strategy.
''',
  ),

  AIChatMessage(
    id: 'yld_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'sync_zapper',
        icon: Icons.sync,
        title: 'Sync Zapper Dashboard',
      ),

      AIQuickAction(
        id: 'slack_milestone',
        icon: Icons.celebration,
        title: 'Post Milestone to Discord',
      ),
    ],
  ),
];

List<AIChatMessage> gasConversation = [
  AIChatMessage(
    id: 'gas_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have reviewed the network congestion and gas fee metrics for this week.

We have a significant amount of failed or pending transactions that require attention.
''',
  ),

  AIChatMessage(
    id: 'gas_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'gas_tracker',
        icon: Icons.local_gas_station_outlined,
        title: 'Live Gas Tracker',
        prompt: 'Show live gas tracker',
      ),

      AIQuickAction(
        id: 'stuck_txs',
        icon: Icons.hourglass_disabled_outlined,
        title: 'Stuck Transactions',
        prompt: 'Analyze stuck transactions',
      ),

      AIQuickAction(
        id: 'total_spent',
        icon: Icons.money_off_outlined,
        title: 'Total Gas Spent',
        prompt: 'Show total gas spent this month',
      ),
    ],
  ),

  AIChatMessage(
    id: 'gas_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze stuck transactions',
  ),

  AIChatMessage(
    id: 'gas_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
You currently have 3 transactions stuck in the mempool.

Based on network analytics, the main reasons are:

• Network Spike: Base gwei jumped from 15 to 85 due to a popular NFT mint.

• Low Max Fee: Your transactions were submitted with a strict 25 gwei limit.

• Nonce Blocking: The first stuck transaction is preventing the other two from executing.
''',
  ),

  AIChatMessage(
    id: 'gas_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'recovery_ideas', title: 'Show resolution options'),
      AIQuickAction(id: 'gas_alert', title: 'Set gas drop alert'),
    ],
  ),

  AIChatMessage(
    id: 'gas_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'export_nonce_list',
        icon: Icons.list_alt_outlined,
        title: 'View Wallet Nonces',
      ),

      AIQuickAction(
        id: 'trigger_cancel',
        icon: Icons.cancel_outlined,
        title: 'Send 0 ETH Cancel TX',
      ),
    ],
  ),

  AIChatMessage(
    id: 'gas_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show resolution options',
  ),

  AIChatMessage(
    id: 'gas_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here are 3 recommended strategies to clear your wallet queue:

• Speed Up: Rebroadcast the first transaction with a max priority fee of 3 gwei and max fee of 100 gwei.

• Cancel: Send a 0 ETH transaction to yourself using the exact same nonce to override and drop it.

• Wait: Gwei typically drops below 20 during Asian trading hours (in about 6 hours).
''',
  ),

  AIChatMessage(
    id: 'gas_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'launch_speedup',
        icon: Icons.fast_forward_outlined,
        title: 'Execute Speed Up',
      ),
    ],
  ),
];

List<AIChatMessage> marketConversation = [
  AIChatMessage(
    id: 'mktc_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the market trends and token momentum report for this past week.

Trading volume is great, but sentiment is shifting rapidly across ecosystems.
''',
  ),

  AIChatMessage(
    id: 'mktc_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'volume_tracker',
        icon: Icons.bar_chart_outlined,
        title: 'Volume Tracker',
        prompt: 'Analyze DEX volume',
      ),

      AIQuickAction(
        id: 'tvl_shift',
        icon: Icons.account_balance_outlined,
        title: 'TVL Migration',
        prompt: 'Compare chain TVL',
      ),

      AIQuickAction(
        id: 'trending_tokens',
        icon: Icons.local_fire_department_outlined,
        title: 'Trending Tokens',
        prompt: 'Show trending tokens',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mktc_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Compare chain TVL',
  ),

  AIChatMessage(
    id: 'mktc_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Total Value Locked (TVL) is migrating rapidly between Layer 2 networks.

Key observations:

• Base (L2): TVL increased by 24% due to a massive influx of meme coin liquidity.

• Arbitrum: TVL remains stable, serving as the primary hub for derivatives trading.

• Polygon: Experiencing capital flight as yields drop compared to newer Rollups.
''',
  ),

  AIChatMessage(
    id: 'mktc_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'reallocate_funds', title: 'Bridge funds to Base'),
      AIQuickAction(id: 'whale_tracker', title: 'Show whale movements'),
    ],
  ),

  AIChatMessage(
    id: 'mktc_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_defillama',
        icon: Icons.open_in_browser_outlined,
        title: 'Open DeFiLlama',
      ),
      AIQuickAction(
        id: 'open_dexscreener',
        icon: Icons.show_chart_outlined,
        title: 'Open DexScreener',
      ),
    ],
  ),

  AIChatMessage(
    id: 'mktc_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Bridge funds to Base',
  ),

  AIChatMessage(
    id: 'mktc_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on bridging efficiency, here is the recommended reallocation route:

• Bridge 2 ETH from Arbitrum to Base using the official bridge or Stargate for minimal slippage.

• Deploy 1 ETH into the Aerodrome liquidity pools to farm high emissions.

This setup positions your portfolio to capture the growing Base ecosystem narrative.
''',
  ),

  AIChatMessage(
    id: 'mktc_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'apply_bridge',
        icon: Icons.compare_arrows_outlined,
        title: 'Execute Bridge',
      ),
    ],
  ),
];

List<AIChatMessage> walletConversation = [
  AIChatMessage(
    id: 'execw_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

Here is your consolidated multi-wallet dashboard summary for this month.

All core holdings and cold storage assets are secure and tracking accurately.
''',
  ),

  AIChatMessage(
    id: 'execw_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'kpi_summary',
        icon: Icons.insights_outlined,
        title: 'Wallet Balances',
        prompt: 'Show total balances',
      ),

      AIQuickAction(
        id: 'net_profit',
        icon: Icons.account_balance_outlined,
        title: 'Realized PnL',
        prompt: 'Analyze realized PnL',
      ),

      AIQuickAction(
        id: 'nft_health',
        icon: Icons.image_outlined,
        title: 'NFT Valuations',
        prompt: 'Check NFT floor prices',
      ),
    ],
  ),

  AIChatMessage(
    id: 'execw_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show total balances',
  ),

  AIChatMessage(
    id: 'execw_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Here is the consolidated high-level portfolio matrix across Metamask, Phantom, and Ledger:

• Total Net Worth: \$142,500 (+12.4% MoM)

• Cold Storage Allocation: 65% (Very Secure)

• Stables/Cash: \$28,000 (Ready for deployment)

• NFT Portfolio Value: 4.2 ETH (Based on current trait floors)
''',
  ),

  AIChatMessage(
    id: 'execw_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'breakdown_by_wallet',
        title: 'Breakdown balance by wallet',
      ),
      AIQuickAction(id: 'forecast_q3', title: 'View end-of-quarter target'),
    ],
  ),

  AIChatMessage(
    id: 'execw_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'download_board_deck',
        icon: Icons.picture_as_pdf_outlined,
        title: 'Export Portfolio Snapshot',
      ),
    ],
  ),
];

List<AIChatMessage> liquidityConversation = [
  AIChatMessage(
    id: 'liq_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest AMM and Liquidity Provider status report.

We have a few concentrated positions that are moving out of range.
''',
  ),

  AIChatMessage(
    id: 'liq_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'pool_alerts',
        icon: Icons.warning_amber_outlined,
        title: 'Out of Range Alerts',
        prompt: 'Check out of range pools',
      ),

      AIQuickAction(
        id: 'il_analysis',
        icon: Icons.trending_down_outlined,
        title: 'Impermanent Loss',
        prompt: 'Analyze impermanent loss',
      ),

      AIQuickAction(
        id: 'fees_earned',
        icon: Icons.monetization_on_outlined,
        title: 'Fees Collected',
        prompt: 'Show total LP fees',
      ),
    ],
  ),

  AIChatMessage(
    id: 'liq_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Check out of range pools',
  ),

  AIChatMessage(
    id: 'liq_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
There are 2 Uniswap V3 positions currently sitting outside your specified price ticks:

• ETH/USDC (Arbitrum): Price has broken above your upper tick of 3,500. Position is now 100% USDC and earning no fees.

• WMATIC/WETH (Polygon): Price fell below the lower tick. Position is now 100% WMATIC.
''',
  ),

  AIChatMessage(
    id: 'liq_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'rebalance_suggestions',
        title: 'Show rebalancing recommendations',
      ),
    ],
  ),

  AIChatMessage(
    id: 'liq_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'withdraw_liquidity',
        icon: Icons.vertical_align_top_outlined,
        title: 'Withdraw Inactive Liquidity',
      ),
    ],
  ),

  AIChatMessage(
    id: 'liq_7',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show rebalancing recommendations',
  ),

  AIChatMessage(
    id: 'liq_8',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Based on current volatility bands, here is the optimized LP strategy:

• ETH/USDC: Withdraw the USDC, buy back 50% in ETH, and provide liquidity in a wider range (3,200 - 3,800).

• WMATIC/WETH: Hold the WMATIC if you expect a bounce, or withdraw and cut losses to deploy capital elsewhere.

Applying these updates will reactivate fee generation.
''',
  ),

  AIChatMessage(
    id: 'liq_9',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'approve_rebalance',
        icon: Icons.tune_outlined,
        title: 'Execute LP Rebalance',
      ),
    ],
  ),
];

List<AIChatMessage> bridgeConversation = [
  AIChatMessage(
    id: 'brdg_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have evaluated your cross-chain transfers and bridge history for this month.

There are some minor delays happening on specific interoperability protocols.
''',
  ),

  AIChatMessage(
    id: 'brdg_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'transfer_times',
        icon: Icons.shutter_speed_outlined,
        title: 'Average Bridge Time',
        prompt: 'Analyze bridge times',
      ),

      AIQuickAction(
        id: 'bridge_fees',
        icon: Icons.price_check_outlined,
        title: 'Bridging Costs',
        prompt: 'Review bridging costs',
      ),
    ],
  ),

  AIChatMessage(
    id: 'brdg_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze bridge times',
  ),

  AIChatMessage(
    id: 'brdg_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Average bridging time has increased by 15 minutes this week.

Key factors and specific protocol performance:

• Optimistic Rollups (Arbitrum/OP to Mainnet): Standard 7-day challenge period applies.

• Fast Bridges (Stargate/Across): Average time delayed to 18 minutes due to liquidity rebalancing on the destination chain.
''',
  ),

  AIChatMessage(
    id: 'brdg_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'affected_txs', title: 'Show pending transfers'),
      AIQuickAction(
        id: 'alternative_routing',
        title: 'Find alternative bridges',
      ),
    ],
  ),

  AIChatMessage(
    id: 'brdg_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_explorer',
        icon: Icons.travel_explore_outlined,
        title: 'Open Block Explorer',
      ),
    ],
  ),
];

List<AIChatMessage> securityConversation = [
  AIChatMessage(
    id: 'sec_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the latest wallet security and smart contract audit data.

We have a few risky permissions that should be revoked to protect your funds.
''',
  ),

  AIChatMessage(
    id: 'sec_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'token_allowances',
        icon: Icons.lock_open_outlined,
        title: 'Token Allowances',
        prompt: 'Show unlimited allowances',
      ),

      AIQuickAction(
        id: 'phishing_alerts',
        icon: Icons.warning_amber_outlined,
        title: 'Phishing Detection',
        prompt: 'Check for scam tokens',
      ),

      AIQuickAction(
        id: 'contract_audits',
        icon: Icons.gavel_outlined,
        title: 'Protocol Health',
        prompt: 'Check dApp security scores',
      ),
    ],
  ),

  AIChatMessage(
    id: 'sec_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show unlimited allowances',
  ),

  AIChatMessage(
    id: 'sec_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
I found 2 smart contracts with unlimited spend approvals for your USDC and WETH:

• Contract 0x8a... (Old Yield Farm): Not interacted with in 14 months. Has an unlimited USDC allowance.

• Contract 0x1c... (DEX Router): Standard router, but safe to revoke if you aren't trading frequently.
''',
  ),

  AIChatMessage(
    id: 'sec_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'revoke_all', title: 'Revoke old allowances now'),
    ],
  ),

  AIChatMessage(
    id: 'sec_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_revoke_cash',
        icon: Icons.shield_outlined,
        title: 'Open Revoke.cash',
      ),
    ],
  ),
];

List<AIChatMessage> nodeConversation = [
  AIChatMessage(
    id: 'node_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have cross-referenced our validator node health against the network requirements.

Your infrastructure is performing well, but a software update is pending.
''',
  ),

  AIChatMessage(
    id: 'node_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'node_uptime',
        icon: Icons.dns_outlined,
        title: 'Validator Uptime',
        prompt: 'Show node uptime',
      ),

      AIQuickAction(
        id: 'client_updates',
        icon: Icons.system_update_alt_outlined,
        title: 'Client Updates',
        prompt: 'Check for consensus updates',
      ),
    ],
  ),

  AIChatMessage(
    id: 'node_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Show node uptime',
  ),

  AIChatMessage(
    id: 'node_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Your Ethereum Validator node uptime sits at 99.98% for this epoch. 

Key metrics:

• Attestation Effectiveness: 98% (Excellent)

• Missed Blocks: 0 in the last 30 days.

• Server Load: CPU usage at 45%, RAM at 12GB (Normal).
''',
  ),

  AIChatMessage(
    id: 'node_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(id: 'check_logs', title: 'Review execution client logs'),
    ],
  ),

  AIChatMessage(
    id: 'node_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_terminal',
        icon: Icons.terminal_outlined,
        title: 'Open SSH Terminal',
      ),
    ],
  ),
];

List<AIChatMessage> weeklyCryptoConversation = [
  AIChatMessage(
    id: 'wkcrpt_1',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
Hi Umar 👋

I have compiled the weekly crypto market sprint report.

Overall portfolio velocity is high, and the recent swing trades were successful.
''',
  ),

  AIChatMessage(
    id: 'wkcrpt_2',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'weekly_pnl',
        icon: Icons.trending_up_outlined,
        title: 'Weekly PnL',
        prompt: 'Show weekly PnL',
      ),

      AIQuickAction(
        id: 'trade_results',
        icon: Icons.swap_horiz_outlined,
        title: 'Trade Results',
        prompt: 'Analyze recent trades',
      ),

      AIQuickAction(
        id: 'upcoming_unlocks',
        icon: Icons.lock_open_outlined,
        title: 'Token Unlocks',
        prompt: 'Show upcoming token unlocks',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkcrpt_3',
    role: ChatRole.user,
    type: ChatMessageType.text,
    text: 'Analyze recent trades',
  ),

  AIChatMessage(
    id: 'wkcrpt_4',
    role: ChatRole.assistant,
    type: ChatMessageType.text,
    text: '''
The rotation out of large-caps into AI-narrative tokens generated \$1,200 in the first 48 hours.

Key performance indicators:
• FET Buy Limit: Hit perfectly at \$1.45.
• ARB Sell: Executed at a 12% profit before the token unlock dump.
• Gas Spent: \$45 total for 8 swaps.
''',
  ),

  AIChatMessage(
    id: 'wkcrpt_5',
    role: ChatRole.assistant,
    type: ChatMessageType.suggestions,
    actions: [
      AIQuickAction(
        id: 'set_stops',
        title: 'Set trailing stop losses for AI tokens',
      ),
    ],
  ),

  AIChatMessage(
    id: 'wkcrpt_6',
    role: ChatRole.assistant,
    type: ChatMessageType.actions,
    actions: [
      AIQuickAction(
        id: 'open_dex',
        icon: Icons.currency_exchange_outlined,
        title: 'Open Decentralized Exchange',
      ),
    ],
  ),
];

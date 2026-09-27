import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';

class DummyAiInsights {
  static AIInsight getSaaSChurnInsight() {
    return AIInsight(
      id: 'ins-001',
      title: 'Customer churn rate spiked 22% this month',
      summary:
          'Subscription cancellations increased due to low feature adoption during the onboarding phase and slower support resolution times.',
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.saas,
      status: AIInsightStatus.unread,
      generatedAt: DateTime.now().subtract(const Duration(minutes: 35)),
      confidence: const AIConfidence(level: AIConfidenceLevel.high, score: 94),
      impact: const AIImpact(
        level: AIImpactLevel.high,
        title: 'High',
        description:
            'Estimated Monthly Recurring Revenue (MRR) loss of approximately \$12,400 if retention actions are delayed.',
      ),
      why: const AIWhy(
        title: 'Why?',
        reasons: [
          "Low adoption rate of core onboarding features",
          "Delayed customer support response times",
          "Higher cancellation rate in the mid-tier plan",
        ],
      ),
      actions: const [
        AIAction(
          id: 'act-001',
          label: 'View Churn Analytics',
          type: AIActionType.secondary,
        ),
        AIAction(
          id: 'act-002',
          label: 'Launch Retention Campaign',
          type: AIActionType.primary,
        ),
      ],
      tags: ['saas', 'mrr', 'churn'],
    );
  }
}

// dummy ai action for SaaS dashboard

class DummyAIActionData {
  static List<RecommendedAction> get aiActions => [
    RecommendedAction(
      title: 'Send automated re-engagement emails',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Send automated re-engagement emails');
      },
    ),
    RecommendedAction(
      title: 'Offer annual plan discounts',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Offer annual plan discounts');
      },
    ),
    RecommendedAction(
      title: 'Review support ticket backlog',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Review support ticket backlog');
      },
    ),
    RecommendedAction(
      title: 'Analyze trial-to-paid funnel',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Analyze trial-to-paid funnel');
      },
    ),
  ];
}

// Conversion funnel data mockup
final List<FunnelData> funnelData = [
  FunnelData(
    month: 'Jan',
    impressions: 120,
    sessions: 85,
    downloads: 65,
    newUsers: 45,
  ),
  FunnelData(
    month: 'Feb',
    impressions: 140,
    sessions: 100,
    downloads: 78,
    newUsers: 55,
  ),
  FunnelData(
    month: 'Mar',
    impressions: 130,
    sessions: 95,
    downloads: 75,
    newUsers: 40,
  ),
  FunnelData(
    month: 'Apr',
    impressions: 150,
    sessions: 110,
    downloads: 90,
    newUsers: 70,
  ),
  FunnelData(
    month: 'May',
    impressions: 100,
    sessions: 78,
    downloads: 55,
    newUsers: 30,
  ),
  FunnelData(
    month: 'Jun',
    impressions: 135,
    sessions: 92,
    downloads: 70,
    newUsers: 45,
  ),
  FunnelData(
    month: 'Jul',
    impressions: 145,
    sessions: 105,
    downloads: 85,
    newUsers: 55,
  ),
  FunnelData(
    month: 'Aug',
    impressions: 150,
    sessions: 108,
    downloads: 84,
    newUsers: 42,
  ),
];

// sales data mockup

final salesData = [
  SalesData('Mon', 150),
  SalesData('Tue', 360),
  SalesData('Wed', 190),
  SalesData('Thu', 280),
  SalesData('Fri', 170),
  SalesData('Sat', 180),
  SalesData('Sun', 160),
];

// Recent Invoices data mockup

List<Order> getOrderData() {
  return [
    Order(
      '#AD001',
      '2024-02-25',
      'Completed',
      'John Doe',
      'Product A',
      120.0,
      'assets/images/avatar_1.jpg',
    ),
    Order(
      '#AD002',
      '2024-02-24',
      'Pending',
      'Jane Smith',
      'Product B',
      80.5,
      'assets/images/avatar_2.jpg',
    ),
    Order(
      '#AD003',
      '2024-02-23',
      'Cancelled',
      'Alice Brown',
      'Product C',
      50.0,
      'assets/images/avatar_3.jpg',
    ),
    Order(
      '#AD004',
      '2024-02-22',
      'Completed',
      'Bob Johnson',
      'Product D',
      200.0,
      'assets/images/avatar_4.jpg',
    ),
    Order(
      '#AD005',
      '2024-02-21',
      'Completed',
      'Charlie Wilson',
      'Product E',
      150.0,
      'assets/images/avatar_5.jpg',
    ),
    Order(
      '#AD006',
      '2024-02-20',
      'Pending',
      'Diana Evans',
      'Product F',
      90.0,
      'assets/images/avatar_6.jpg',
    ),
    Order(
      '#AD007',
      '2024-02-19',
      'Cancelled',
      'Ethan Carter',
      'Product G',
      60.0,
      'assets/images/avatar_7.jpg',
    ),
    Order(
      '#AD008',
      '2024-02-18',
      'Completed',
      'Fiona Green',
      'Product H',
      220.0,
      'assets/images/avatar_8.jpg',
    ),
    Order(
      '#AD009',
      '2024-02-17',
      'Completed',
      'George Hall',
      'Product I',
      175.0,
      'assets/images/avatar_9.jpg',
    ),
    Order(
      '#AD010',
      '2024-02-16',
      'Pending',
      'Hannah Lewis',
      'Product J',
      110.0,
      'assets/images/avatar_10.jpg',
    ),
    Order(
      '#AD011',
      '2024-02-15',
      'Cancelled',
      'Ian Martin',
      'Product K',
      70.0,
      'assets/images/avatar_11.jpg',
    ),
    // Order(
    //   '#AD012',
    //   '2024-02-14',
    //   'Completed',
    //   'Jack Nelson',
    //   'Product L',
    //   140.0,
    //   'assets/images/avatar_1.jpg',
    // ),
    // Order(
    //   '#AD013',
    //   '2024-02-13',
    //   'Pending',
    //   'Karen Owens',
    //   'Product M',
    //   95.0,
    //   'assets/images/avatar_3.jpg',
    // ),
    // Order(
    //   '#AD014',
    //   '2024-02-12',
    //   'Cancelled',
    //   'Liam Parker',
    //   'Product N',
    //   55.0,
    //   'assets/images/avatar_4.jpg',
    // ),
    // Order(
    //   '#AD015',
    //   '2024-02-11',
    //   'Completed',
    //   'Mia Quinn',
    //   'Product O',
    //   190.0,
    //   'assets/images/avatar_5.jpg',
    // ),
    // Order(
    //   '#AD016',
    //   '2024-02-10',
    //   'Completed',
    //   'Nathan Reed',
    //   'Product P',
    //   130.0,
    //   'assets/images/avatar_6.jpg',
    // ),
    // Order(
    //   '#AD017',
    //   '2024-02-09',
    //   'Pending',
    //   'Olivia Scott',
    //   'Product Q',
    //   85.0,
    //   'assets/images/avatar_7.jpg',
    // ),
    // Order(
    //   '#AD018',
    //   '2024-02-08',
    //   'Cancelled',
    //   'Paul Turner',
    //   'Product R',
    //   45.0,
    //   'assets/images/avatar_8.jpg',
    // ),
    // Order(
    //   '#AD019',
    //   '2024-02-07',
    //   'Completed',
    //   'Quinn Wood',
    //   'Product S',
    //   210.0,
    //   'assets/images/avatar_9.jpg',
    // ),
    // Order(
    //   '#AD020',
    //   '2024-02-06',
    //   'Completed',
    //   'Rachel Vaughn',
    //   'Product T',
    //   165.0,
    //   'assets/images/avatar_10.jpg',
    // ),
  ];
}

// recent activities data mockup

final List<Activity> activities = [
  Activity(
    title: "New User",
    description: "John Doe signed up",
    time: DateTime.now().subtract(const Duration(minutes: 5)),
    icon: Icons.person_add_alt_1,
    color: kInfoColor,
  ),
  Activity(
    title: "Payment Success",
    description: "Invoice #INV-102 paid",
    time: DateTime.now().subtract(const Duration(hours: 1)),
    icon: Icons.payments,
    color: kSuccessColor,
  ),
  Activity(
    title: "Project Updated",
    description: "Dashboard UI updated",
    time: DateTime.now().subtract(const Duration(hours: 3)),
    icon: Icons.edit_note,
    color: kWarningColor,
  ),
  Activity(
    title: "New Subscription",
    description: "Premium plan activated",
    time: DateTime.now().subtract(const Duration(hours: 4)),
    icon: Icons.workspace_premium,
    color: Colors.purple,
  ),
  Activity(
    title: "File Uploaded",
    description: "report_q4.pdf uploaded",
    time: DateTime.now().subtract(const Duration(hours: 6)),
    icon: Icons.upload_file,
    color: kSuccessColor,
  ),
  Activity(
    title: "Password Changed",
    description: "User changed account password",
    time: DateTime.now().subtract(const Duration(hours: 8)),
    icon: Icons.lock_reset,
    color: kErrorColor,
  ),
  Activity(
    title: "Team Member Added",
    description: "Sarah added to Marketing team",
    time: DateTime.now().subtract(const Duration(hours: 10)),
    icon: Icons.group_add,
    color: kSecondaryColor,
  ),
  Activity(
    title: "Invoice Generated",
    description: "Invoice #INV-103 created",
    time: DateTime.now().subtract(const Duration(hours: 12)),
    icon: Icons.receipt_long,
    color: kSecondaryColor,
  ),
  Activity(
    title: "Server Restarted",
    description: "Production server restarted",
    time: DateTime.now().subtract(const Duration(hours: 14)),
    icon: Icons.restart_alt,
    color: kWarningColor,
  ),
  Activity(
    title: "Bug Fixed",
    description: "Login issue resolved",
    time: DateTime.now().subtract(const Duration(hours: 16)),
    icon: Icons.bug_report,
    color: kSuccessColor,
  ),
  // Activity(
  //   title: "New Message",
  //   description: "Support ticket replied",
  //   time: DateTime.now().subtract(const Duration(hours: 18)),
  //   icon: Icons.message,
  //   color: Colors.cyan,
  // ),
  // Activity(
  //   title: "Backup Completed",
  //   description: "Daily backup finished successfully",
  //   time: DateTime.now().subtract(const Duration(hours: 20)),
  //   icon: Icons.backup,
  //   color: kInfoColorGrey,
  // ),
];

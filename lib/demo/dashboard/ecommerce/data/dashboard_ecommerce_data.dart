import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';

class DummyAiInsights {
  static AIInsight getCartAbandonmentInsight() {
    return AIInsight(
      id: 'ins-001',
      title: 'Cart abandonment rate spiked 34% this week',
      summary:
          'A significant increase in uncompleted checkouts due to high shipping fees and unexpected payment gateway timeout errors.',
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.marketing,
      status: AIInsightStatus.unread,
      generatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      confidence: const AIConfidence(level: AIConfidenceLevel.high, score: 95),
      impact: const AIImpact(
        level: AIImpactLevel.high,
        title: 'High',
        description:
            'Estimated potential lost revenue of approximately \$45,800 from abandoned checkouts.',
      ),
      why: const AIWhy(
        title: 'Why?',
        reasons: [
          "Shipping cost added late in the checkout process",
          "Payment gateway timeout errors for international cards",
          "Lack of guest checkout option on mobile view",
        ],
      ),
      actions: const [
        AIAction(
          id: 'act-001',
          label: 'View Funnel',
          type: AIActionType.secondary,
        ),
        AIAction(
          id: 'act-002',
          label: 'Send Recovery Campaign',
          type: AIActionType.primary,
        ),
      ],
      tags: ['ecommerce', 'conversion', 'checkout'],
    );
  }
}

// dummy ai action for e-commerce

class DummyAIActionData {
  static List<RecommendedAction> get aiActions => [
    RecommendedAction(
      title: 'Send cart recovery emails',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Send cart recovery emails');
      },
    ),
    RecommendedAction(
      title: 'Restock 3 bestselling items',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Restock 3 bestselling items');
      },
    ),
    RecommendedAction(
      title: 'Add \$50 free shipping banner',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Add \$50 free shipping banner');
      },
    ),
    RecommendedAction(
      title: 'Review return & refund metrics',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Review return & refund metrics');
      },
    ),
  ];
}

// revenue chart
final List<RevenueChartData> monthlyData = [
  RevenueChartData(month: 'Jan', revenue: 120000, conversionRate: 1.2),
  RevenueChartData(month: 'Feb', revenue: 105000, conversionRate: 1.0),
  RevenueChartData(month: 'Mar', revenue: 98000, conversionRate: 0.9),
  RevenueChartData(month: 'Apr', revenue: 130000, conversionRate: 1.5),
  RevenueChartData(month: 'May', revenue: 150000, conversionRate: 1.8),
  RevenueChartData(month: 'Jun', revenue: 170000, conversionRate: 2.4),
  RevenueChartData(month: 'Jul', revenue: 165000, conversionRate: 1.9),
  RevenueChartData(month: 'Aug', revenue: 180000, conversionRate: 2.1),
  RevenueChartData(month: 'Sep', revenue: 175000, conversionRate: 2.0),
  RevenueChartData(month: 'Oct', revenue: 190000, conversionRate: 2.2),
  RevenueChartData(month: 'Nov', revenue: 200000, conversionRate: 2.3),
  RevenueChartData(month: 'Dec', revenue: 210000, conversionRate: 2.6),
];

final List<RevenueSummary> revenueSummaries = [
  RevenueSummary(value: '\$1,893,000', label: 'Total Revenue'),
  RevenueSummary(
    value: '1.4%',
    label: 'Avg. Conversion Rate',
    valueColor: kSuccessColor,
  ),
  RevenueSummary(value: '\$210,000', label: 'Top Revenue Month'),
  RevenueSummary(
    value: '2.4%',
    label: 'Peak Conversion Rate',
    valueColor: kSuccessColor,
  ),
];

// top product revenue & conversion rate data mockup

final List<ProductData> topProductData = [
  ProductData(name: 'Smartwatch X1 Pro', revenue: 29503, conversionRate: 1.53),
  ProductData(
    name: 'Wireless Earbuds Aura',
    revenue: 67557,
    conversionRate: 1.47,
  ),
  ProductData(
    name: 'Portable Bluetooth Speaker Sonic',
    revenue: 30869,
    conversionRate: 1.53,
  ),
  ProductData(
    name: 'Fast Charger 65W PD',
    revenue: 40404,
    conversionRate: 1.46,
  ),
  ProductData(
    name: 'Noise-Cancelling Headphones Elite',
    revenue: 99944,
    conversionRate: 1.42,
  ),
];

// recent order data mockup

final List<Order> orders = [
  Order(
    orderId: '#AD236',
    customerName: 'Sophia Miller',
    customerImage: 'assets/images/avatar_6.jpg',
    product: 'Beauty Products',
    amount: 75.80,
    vendor: 'Glamour Essentials',
    status: 'Paid',
    rating: 5.0,
    votes: 90,
  ),
  Order(
    orderId: '#AD235',
    customerName: 'David Lee',
    customerImage: 'assets/images/avatar_5.jpg',
    product: 'Sports Equipment',
    amount: 120.00,
    vendor: 'Active Life',
    status: 'Unpaid',
    rating: 3.9,
    votes: 15,
  ),
  Order(
    orderId: '#AD234',
    customerName: 'Emily White',
    customerImage: 'assets/images/avatar_4.jpg',
    product: 'Home Goods',
    amount: 210.25,
    vendor: 'Cozy Living',
    status: 'Paid',
    rating: 4.2,
    votes: 20,
  ),
  Order(
    orderId: '#AD233',
    customerName: 'John Doe',
    customerImage: 'assets/images/avatar_3.jpg',
    product: 'Books',
    amount: 45.50,
    vendor: 'Book Nook',
    status: 'Paid',
    rating: 4.8,
    votes: 75,
  ),
  Order(
    orderId: '#AD232',
    customerName: 'Maria Garcia',
    customerImage: 'assets/images/avatar_2.jpg',
    product: 'Electronics',
    amount: 550.00,
    vendor: 'Tech Haven',
    status: 'Pending',
    rating: 4.5,
    votes: 30,
  ),
  Order(
    orderId: '#AD231',
    customerName: 'Alex Smith',
    customerImage: 'assets/images/avatar_1.jpg',
    product: 'Clothes',
    amount: 109.00,
    vendor: 'Zoetic Fashion',
    status: 'Paid',
    rating: 5.0,
    votes: 61,
  ),
];

// state revenue data mockup

final List<StateRevenue> stateRevenueData = [
  StateRevenue('California', 95500),
  StateRevenue('Texas', 82600),
  StateRevenue('Florida', 67500),
  StateRevenue('New York', 58600),
  StateRevenue('Illinois', 49500),
  StateRevenue('Washington', 45200),
  StateRevenue('Georgia', 43500),
  StateRevenue('North Carolina', 41700),
  StateRevenue('Ohio', 39500),
  StateRevenue('Arizona', 25400),
];

// visit by source data mockup

final List<VisitSourceData> visitData = [
  VisitSourceData('Direct', 28.5, kPrimaryColor),
  VisitSourceData('Social', 30.0, kSuccessColor),
  VisitSourceData('Email', 22.5, kWarningColor),
  VisitSourceData('Other', 10.0, kErrorColor),
  VisitSourceData('Referrals', 9.0, kInfoColor),
];

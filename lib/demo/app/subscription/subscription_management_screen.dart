// ignore_for_file: unused_field

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/animation/animation.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/base_ui/dropdown.dart';
import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';
import 'package:flutter_ademin/widgets/form/form_input_mask.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SubscriptionManagementScreen extends StatefulWidget {
  const SubscriptionManagementScreen({super.key});

  @override
  State<SubscriptionManagementScreen> createState() =>
      _SubscriptionManagementScreenState();
}

class _SubscriptionManagementScreenState
    extends State<SubscriptionManagementScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).subscriptionManagement;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.subscriptionManagement.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.apps(2), uri: ''),
                        BreadcrumbItem(
                          label: lang.subscriptionManagement,
                          uri: RouteUri.subscriptionManagement,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                /// METRICS
                SubscriptionsMetricsSection(),

                const SizedBox(height: kDefaultPadding),

                /// TABLE CARD
                SubscriptionsManagementTable(),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

// Subscription metrics helper

class SubscriptionMetrics {
  final int totalSubscriptions;
  final int activeSubscriptions;
  final int totalSubscribers;
  final double totalRevenue;
  final double avgRevenuePerSubscription;

  SubscriptionMetrics({
    required this.totalSubscriptions,
    required this.activeSubscriptions,
    required this.totalSubscribers,
    required this.totalRevenue,
    required this.avgRevenuePerSubscription,
  });

  factory SubscriptionMetrics.fromSubscriptions(
    List<SubscriptionModel> subscriptions,
  ) {
    final totalSubscriptions = subscriptions.length;

    final activeSubscriptions = subscriptions
        .where((p) => p.status == SubscriptionStatus.active)
        .length;

    final totalSubscribers = subscriptions.fold<int>(
      0,
      (sum, p) => sum + p.activeSubscriber,
    );

    final totalRevenue = subscriptions.fold<double>(
      0,
      (sum, p) => sum + p.totalRevenue,
    );

    final double avgRevenue = totalSubscriptions == 0
        ? 0.0
        : (totalRevenue / totalSubscriptions).toDouble();

    return SubscriptionMetrics(
      totalSubscriptions: totalSubscriptions,
      activeSubscriptions: activeSubscriptions,
      totalSubscribers: totalSubscribers,
      totalRevenue: totalRevenue,
      avgRevenuePerSubscription: avgRevenue,
    );
  }
}

// metric card

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final double delta;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.delta,
    required this.icon,
    required this.color,
  });

  bool get isPositive => delta >= 0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final trendColor = isPositive ? kSuccessColor : kErrorColor;
    final trendIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // card title
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: kDefaultPadding / 2),

                      // card value
                      Text(
                        value,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: kHeadlineSmall,
                        ),
                      ),
                    ],
                  ),

                  // icon
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(defaultRadius),
                      // shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                ],
              ),

              // TREND LINE
              Row(
                children: [
                  Icon(trendIcon, size: 14, color: trendColor),
                  const SizedBox(width: 4),
                  Text(
                    '${delta.abs().toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: trendColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(' vs previous month'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// metrics row

class SubscriptionsMetricsSection extends StatelessWidget {
  const SubscriptionsMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = SubscriptionMetrics.fromSubscriptions(mockSubscriptions);

    return AdaptiveWrap(
      breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2, kScreenWidthXl: 4},
      columnRatios: const [0.25, 0.25, 0.25, 0.25],
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      children: [
        MetricCard(
          title: 'Total Subscriptions',
          value: metrics.totalSubscriptions.toString(),
          delta: 13.3,
          icon: Icons.inventory_2_outlined,
          color: kInfoColor,
        ),
        MetricCard(
          title: 'Active Subscriptions',
          value: metrics.activeSubscriptions.toString(),
          delta: -6.2,
          icon: Icons.check_circle_outline,
          color: kSuccessColor,
        ),
        MetricCard(
          title: 'Active Subscribers',
          value: NumberFormat.decimalPattern().format(metrics.totalSubscribers),
          delta: 14.5,
          icon: Icons.pause_circle_outline,
          color: kSecondaryColor,
        ),
        MetricCard(
          title: 'Monthly revenue',
          value: NumberFormat.currency(
            symbol: "\$",
          ).format(metrics.totalRevenue),
          delta: -4.8,
          icon: Icons.attach_money,
          color: kErrorColor,
        ),
      ],
    );
  }
}

// Subscription feature data model

class SubscriptionFeature {
  final String name;
  final bool isAvailable;

  SubscriptionFeature({required this.name, required this.isAvailable});
}

// Pricing Option Model

enum BillingType { monthly, yearly, oneTime }

class SubscriptionPrice {
  final BillingType billingType;
  final double price;

  SubscriptionPrice({required this.billingType, required this.price});
}

// Subscription data model

enum SubscriptionStatus { active, inactive, archived }

class SubscriptionModel {
  final String id;
  final String name;
  final String description;
  final SubscriptionStatus status;

  final List<SubscriptionFeature> features;
  final List<SubscriptionPrice> prices;

  final bool isPopular;

  final DateTime createdAt;
  final DateTime updatedAt;

  final int activeSubscriber;
  final double totalRevenue;

  SubscriptionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.features,
    required this.prices,
    this.isPopular = false,
    required this.createdAt,
    required this.updatedAt,
    required this.activeSubscriber,
    required this.totalRevenue,
  });
}

// Subscriptions mockup data

final List<SubscriptionModel> mockSubscriptions = [
  SubscriptionModel(
    id: 'starter',
    name: 'Starter',
    description: 'Basic features for small teams',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 19),
      SubscriptionPrice(billingType: BillingType.yearly, price: 190),
    ],
    features: [
      SubscriptionFeature(name: '5 Projects', isAvailable: true),
      SubscriptionFeature(name: '399 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Scalable Bandwidth', isAvailable: true),
      SubscriptionFeature(name: '8 FTP Login', isAvailable: true),
      SubscriptionFeature(name: 'Email Support', isAvailable: true),
      SubscriptionFeature(name: 'Customizable Templates', isAvailable: true),
      SubscriptionFeature(name: '24/7 Support', isAvailable: false),
      SubscriptionFeature(name: 'Unlimited Storage', isAvailable: false),
      SubscriptionFeature(name: 'Advanced Analytics', isAvailable: false),
      SubscriptionFeature(name: 'Custom Branding', isAvailable: false),
    ],
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2026, 2, 1),
    activeSubscriber: 147,
    totalRevenue: 1250.50,
  ),

  SubscriptionModel(
    id: 'basic',
    name: 'Basic',
    description: 'Essential tools for individuals',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 9),
      SubscriptionPrice(billingType: BillingType.yearly, price: 90),
    ],
    features: [
      SubscriptionFeature(name: '3 Projects', isAvailable: true),
      SubscriptionFeature(name: '100 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Basic Analytics', isAvailable: true),
      SubscriptionFeature(name: 'Email Support', isAvailable: true),
      SubscriptionFeature(name: 'Custom Branding', isAvailable: false),
      SubscriptionFeature(name: '24/7 Support', isAvailable: false),
    ],
    createdAt: DateTime(2025, 1, 5),
    updatedAt: DateTime(2026, 1, 15),
    activeSubscriber: 317,
    totalRevenue: 1340.50,
  ),

  SubscriptionModel(
    id: 'pro',
    name: 'Pro',
    description: 'Advanced features for growing businesses',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 49),
      SubscriptionPrice(billingType: BillingType.yearly, price: 490),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Projects', isAvailable: true),
      SubscriptionFeature(name: '5,000 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Advanced Analytics', isAvailable: true),
      SubscriptionFeature(name: 'Priority Support', isAvailable: true),
      SubscriptionFeature(name: 'Custom Branding', isAvailable: true),
      SubscriptionFeature(name: 'Dedicated Manager', isAvailable: false),
    ],
    createdAt: DateTime(2025, 2, 1),
    updatedAt: DateTime(2026, 2, 1),
    activeSubscriber: 315,
    totalRevenue: 5450.50,
  ),

  SubscriptionModel(
    id: 'business',
    name: 'Business',
    description: 'All-in-one solution for mid-size companies',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 99),
      SubscriptionPrice(billingType: BillingType.yearly, price: 990),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Projects', isAvailable: true),
      SubscriptionFeature(name: 'Unlimited Customers', isAvailable: true),
      SubscriptionFeature(name: 'Team Collaboration', isAvailable: true),
      SubscriptionFeature(name: 'Advanced Reports', isAvailable: true),
      SubscriptionFeature(name: '24/7 Support', isAvailable: true),
      SubscriptionFeature(name: 'Custom Integrations', isAvailable: false),
    ],
    createdAt: DateTime(2025, 2, 15),
    updatedAt: DateTime(2026, 1, 25),
    activeSubscriber: 152,
    totalRevenue: 1980.90,
  ),

  SubscriptionModel(
    id: 'enterprise',
    name: 'Enterprise',
    description: 'Custom solution for large enterprises',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 199),
      SubscriptionPrice(billingType: BillingType.yearly, price: 1990),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Everything', isAvailable: true),
      SubscriptionFeature(name: 'Dedicated Support', isAvailable: true),
      SubscriptionFeature(name: 'Advanced Security', isAvailable: true),
      SubscriptionFeature(name: 'Custom Integrations', isAvailable: true),
      SubscriptionFeature(name: 'Onboarding Training', isAvailable: true),
    ],
    createdAt: DateTime(2025, 3, 1),
    updatedAt: DateTime(2026, 1, 10),
    activeSubscriber: 138,
    totalRevenue: 8210.70,
  ),

  SubscriptionModel(
    id: 'lifetime',
    name: 'Lifetime',
    description: 'One-time payment access',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.oneTime, price: 499)],
    features: [
      SubscriptionFeature(name: 'Unlimited Projects', isAvailable: true),
      SubscriptionFeature(name: 'Unlimited Customers', isAvailable: true),
      SubscriptionFeature(name: 'Lifetime Updates', isAvailable: true),
      SubscriptionFeature(name: 'Email Support', isAvailable: true),
    ],
    createdAt: DateTime(2025, 3, 10),
    updatedAt: DateTime(2026, 1, 20),
    activeSubscriber: 137,
    totalRevenue: 1857.80,
  ),

  SubscriptionModel(
    id: 'education',
    name: 'Education',
    description: 'Discounted plan for students',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 5),
      SubscriptionPrice(billingType: BillingType.yearly, price: 50),
    ],
    features: [
      SubscriptionFeature(name: '2 Projects', isAvailable: true),
      SubscriptionFeature(name: '50 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Basic Analytics', isAvailable: true),
      SubscriptionFeature(name: 'Community Support', isAvailable: true),
    ],
    createdAt: DateTime(2025, 4, 1),
    updatedAt: DateTime(2026, 1, 1),
    activeSubscriber: 152,
    totalRevenue: 8210.30,
  ),

  SubscriptionModel(
    id: 'agency',
    name: 'Agency',
    description: 'For agencies managing multiple clients',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 79),
      SubscriptionPrice(billingType: BillingType.yearly, price: 790),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Clients', isAvailable: true),
      SubscriptionFeature(name: 'Team Access', isAvailable: true),
      SubscriptionFeature(name: 'Advanced Analytics', isAvailable: true),
      SubscriptionFeature(name: 'White Label', isAvailable: true),
    ],
    createdAt: DateTime(2025, 4, 15),
    updatedAt: DateTime(2026, 2, 1),
    activeSubscriber: 188,
    totalRevenue: 1561.50,
  ),

  // -------- INACTIVE (4) --------
  SubscriptionModel(
    id: 'legacy-basic',
    name: 'Legacy Basic',
    description: 'Old basic plan (deprecated)',
    status: SubscriptionStatus.inactive,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.monthly, price: 15)],
    features: [
      SubscriptionFeature(name: '2 Projects', isAvailable: true),
      SubscriptionFeature(name: 'Email Support', isAvailable: true),
    ],
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2025, 6, 1),
    activeSubscriber: 431,
    totalRevenue: 1120.40,
  ),

  SubscriptionModel(
    id: 'legacy-pro',
    name: 'Legacy Pro',
    description: 'Old pro plan (archived)',
    status: SubscriptionStatus.inactive,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.monthly, price: 39)],
    features: [
      SubscriptionFeature(name: 'Unlimited Projects', isAvailable: true),
      SubscriptionFeature(name: 'Priority Support', isAvailable: true),
    ],
    createdAt: DateTime(2024, 2, 1),
    updatedAt: DateTime(2025, 5, 1),
    activeSubscriber: 147,
    totalRevenue: 1575.60,
  ),

  SubscriptionModel(
    id: 'trial',
    name: 'Trial',
    description: 'Free trial plan (disabled)',
    status: SubscriptionStatus.inactive,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.monthly, price: 0)],
    features: [
      SubscriptionFeature(name: '1 Project', isAvailable: true),
      SubscriptionFeature(name: 'Community Support', isAvailable: true),
    ],
    createdAt: DateTime(2024, 3, 1),
    updatedAt: DateTime(2025, 4, 1),
    activeSubscriber: 129,
    totalRevenue: 0.00,
  ),

  SubscriptionModel(
    id: 'promo-2024',
    name: 'Promo 2024',
    description: 'Limited promotional plan',
    status: SubscriptionStatus.inactive,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.oneTime, price: 99)],
    features: [
      SubscriptionFeature(name: '5 Projects', isAvailable: true),
      SubscriptionFeature(name: 'Basic Analytics', isAvailable: true),
    ],
    createdAt: DateTime(2024, 5, 1),
    updatedAt: DateTime(2025, 3, 1),
    activeSubscriber: 124,
    totalRevenue: 2250.50,
  ),

  SubscriptionModel(
    id: 'free',
    name: 'Free Forever',
    description: 'Perfect for individuals starting out',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 0),
      SubscriptionPrice(billingType: BillingType.yearly, price: 0),
    ],
    features: [
      SubscriptionFeature(name: '1 Project', isAvailable: true),
      SubscriptionFeature(name: '50 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Limited Bandwidth', isAvailable: true),
      SubscriptionFeature(name: 'Community Support', isAvailable: true),
      SubscriptionFeature(name: 'Custom Branding', isAvailable: false),
      SubscriptionFeature(name: 'Advanced Analytics', isAvailable: false),
    ],
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2026, 2, 1),
    activeSubscriber: 161,
    totalRevenue: 0.0,
  ),

  SubscriptionModel(
    id: 'pro',
    name: 'Professional',
    description: 'Advanced tools for growing businesses',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 49),
      SubscriptionPrice(billingType: BillingType.yearly, price: 490),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Projects', isAvailable: true),
      SubscriptionFeature(name: '5,000 Customers', isAvailable: true),
      SubscriptionFeature(name: 'Priority Email Support', isAvailable: true),
      SubscriptionFeature(name: 'Advanced Analytics', isAvailable: true),
      SubscriptionFeature(name: 'Custom Branding', isAvailable: true),
      SubscriptionFeature(name: 'Dedicated Manager', isAvailable: false),
    ],
    createdAt: DateTime(2025, 1, 10),
    updatedAt: DateTime(2026, 2, 5),
    activeSubscriber: 178,
    totalRevenue: 15420.75,
  ),

  SubscriptionModel(
    id: 'enterprise',
    name: 'Enterprise',
    description: 'Full power and security for large scale',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 199),
      SubscriptionPrice(billingType: BillingType.yearly, price: 1990),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Everything', isAvailable: true),
      SubscriptionFeature(name: '24/7 Phone Support', isAvailable: true),
      SubscriptionFeature(name: 'SSO & Advanced Security', isAvailable: true),
      SubscriptionFeature(name: 'Custom Contracts', isAvailable: true),
      SubscriptionFeature(name: 'Dedicated Account Manager', isAvailable: true),
      SubscriptionFeature(name: 'On-premise Deployment', isAvailable: true),
    ],
    createdAt: DateTime(2025, 2, 1),
    updatedAt: DateTime(2026, 1, 20),
    activeSubscriber: 172,
    totalRevenue: 45200.00,
  ),
  SubscriptionModel(
    id: 'dev-edition',
    name: 'Developer',
    description: 'API-first access for builders',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 29),
      SubscriptionPrice(billingType: BillingType.yearly, price: 290),
    ],
    features: [
      SubscriptionFeature(name: 'Beta API Access', isAvailable: true),
      SubscriptionFeature(name: '100k API Calls', isAvailable: true),
      SubscriptionFeature(name: 'Webhooks', isAvailable: true),
      SubscriptionFeature(name: 'Sandbox Environment', isAvailable: true),
      SubscriptionFeature(name: 'White-labeling', isAvailable: false),
    ],
    createdAt: DateTime(2025, 3, 15),
    updatedAt: DateTime(2026, 2, 8),
    activeSubscriber: 154,
    totalRevenue: 5600.25,
  ),
  SubscriptionModel(
    id: 'team-basic',
    name: 'Team Basic',
    description: 'Collaborate with your core squad',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 35),
      SubscriptionPrice(billingType: BillingType.yearly, price: 350),
    ],
    features: [
      SubscriptionFeature(name: '10 Team Members', isAvailable: true),
      SubscriptionFeature(name: 'Shared Workspace', isAvailable: true),
      SubscriptionFeature(name: 'Standard Reporting', isAvailable: true),
      SubscriptionFeature(name: 'Slack Integration', isAvailable: true),
      SubscriptionFeature(name: 'Custom Domain', isAvailable: false),
    ],
    createdAt: DateTime(2025, 4, 12),
    updatedAt: DateTime(2026, 2, 1),
    activeSubscriber: 174,
    totalRevenue: 3200.40,
  ),
  SubscriptionModel(
    id: 'old-starter',
    name: 'Legacy Starter',
    description: 'Old pricing plan (no longer for sale)',
    status: SubscriptionStatus.archived,
    isPopular: false,
    prices: [SubscriptionPrice(billingType: BillingType.monthly, price: 9)],
    features: [
      SubscriptionFeature(name: '2 Projects', isAvailable: true),
      SubscriptionFeature(name: 'Email Support', isAvailable: true),
    ],
    createdAt: DateTime(2024, 1, 1),
    updatedAt: DateTime(2024, 12, 31),
    activeSubscriber: 274,
    totalRevenue: 850.00,
  ),
  SubscriptionModel(
    id: 'edu-discount',
    name: 'Education',
    description: 'Special pricing for students and NGOs',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 12),
      SubscriptionPrice(billingType: BillingType.yearly, price: 120),
    ],
    features: [
      SubscriptionFeature(name: 'Full Pro Features', isAvailable: true),
      SubscriptionFeature(name: 'EDU Verification Required', isAvailable: true),
      SubscriptionFeature(name: 'Community Badges', isAvailable: true),
    ],
    createdAt: DateTime(2025, 5, 20),
    updatedAt: DateTime(2026, 1, 15),
    activeSubscriber: 192,
    totalRevenue: 2100.10,
  ),
  SubscriptionModel(
    id: 'agency',
    name: 'Agency Elite',
    description: 'Manage multiple clients from one dashboard',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 149),
      SubscriptionPrice(billingType: BillingType.yearly, price: 1490),
    ],
    features: [
      SubscriptionFeature(name: '50 Client Accounts', isAvailable: true),
      SubscriptionFeature(name: 'White-label Reports', isAvailable: true),
      SubscriptionFeature(name: 'Bulk Export', isAvailable: true),
      SubscriptionFeature(name: 'API Access', isAvailable: true),
      SubscriptionFeature(name: 'VIP Support', isAvailable: true),
    ],
    createdAt: DateTime(2025, 6, 01),
    updatedAt: DateTime(2026, 2, 09),
    activeSubscriber: 351,
    totalRevenue: 8900.55,
  ), // 2. Ultimate AI Plan
  SubscriptionModel(
    id: 'ultimate-ai',
    name: 'Ultimate AI',
    description: 'Powered by advanced machine learning models',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 89),
      SubscriptionPrice(billingType: BillingType.yearly, price: 890),
    ],
    features: [
      SubscriptionFeature(name: 'AI Content Generator', isAvailable: true),
      SubscriptionFeature(name: 'Predictive Analytics', isAvailable: true),
      SubscriptionFeature(name: 'Unlimited Smart Folders', isAvailable: true),
      SubscriptionFeature(name: 'Priority GPU Processing', isAvailable: true),
      SubscriptionFeature(name: 'Custom Model Training', isAvailable: false),
    ],
    createdAt: DateTime(2025, 5, 10),
    updatedAt: DateTime(2026, 2, 5),
    activeSubscriber: 361,
    totalRevenue: 25400.00,
  ),

  // 3. Solo Entrepreneur
  SubscriptionModel(
    id: 'solo-prener',
    name: 'Solo Preneur',
    description: 'Everything a freelancer needs',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 25),
      SubscriptionPrice(billingType: BillingType.yearly, price: 250),
    ],
    features: [
      SubscriptionFeature(name: 'Single User License', isAvailable: true),
      SubscriptionFeature(name: 'Invoicing System', isAvailable: true),
      SubscriptionFeature(name: 'Tax Assistant', isAvailable: true),
      SubscriptionFeature(name: 'Personal Branding Kit', isAvailable: true),
      SubscriptionFeature(name: 'Team Collaboration', isAvailable: false),
    ],
    createdAt: DateTime(2025, 2, 15),
    updatedAt: DateTime(2026, 1, 10),
    activeSubscriber: 318,
    totalRevenue: 8900.25,
  ),

  // 4. E-commerce Special
  SubscriptionModel(
    id: 'shop-master',
    name: 'Shop Master',
    description: 'Build your online empire effortlessly',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 59),
      SubscriptionPrice(billingType: BillingType.yearly, price: 590),
    ],
    features: [
      SubscriptionFeature(name: 'Unlimited Subscriptions', isAvailable: true),
      SubscriptionFeature(name: 'Inventory Sync', isAvailable: true),
      SubscriptionFeature(name: 'Payment Gateway Pro', isAvailable: true),
      SubscriptionFeature(name: 'Abandoned Cart Recovery', isAvailable: true),
      SubscriptionFeature(name: 'Global Shipping Rates', isAvailable: true),
    ],
    createdAt: DateTime(2025, 3, 20),
    updatedAt: DateTime(2026, 2, 8),
    activeSubscriber: 317,
    totalRevenue: 12300.75,
  ),

  // 5. Security First
  SubscriptionModel(
    id: 'secure-vault',
    name: 'Secure Vault',
    description: 'For industries requiring high compliance',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 129),
      SubscriptionPrice(billingType: BillingType.yearly, price: 1290),
    ],
    features: [
      SubscriptionFeature(name: 'End-to-End Encryption', isAvailable: true),
      SubscriptionFeature(name: 'Audit Logs', isAvailable: true),
      SubscriptionFeature(name: 'HIPAA Compliance', isAvailable: true),
      SubscriptionFeature(name: 'Dedicated Private Cloud', isAvailable: true),
      SubscriptionFeature(name: 'Public API Access', isAvailable: false),
    ],
    createdAt: DateTime(2025, 4, 01),
    updatedAt: DateTime(2025, 12, 25),
    activeSubscriber: 311,
    totalRevenue: 31000.50,
  ),

  // 6. Growth Hacker
  SubscriptionModel(
    id: 'growth-hacker',
    name: 'Growth Hacker',
    description: 'Scale your marketing and outreach',
    status: SubscriptionStatus.active,
    isPopular: true,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 45),
      SubscriptionPrice(billingType: BillingType.yearly, price: 450),
    ],
    features: [
      SubscriptionFeature(name: 'Automated Outreach', isAvailable: true),
      SubscriptionFeature(name: 'A/B Testing Tools', isAvailable: true),
      SubscriptionFeature(name: 'SEO Dashboard', isAvailable: true),
      SubscriptionFeature(name: 'Multi-channel Sync', isAvailable: true),
      SubscriptionFeature(name: 'White-labeling', isAvailable: false),
    ],
    createdAt: DateTime(2025, 6, 15),
    updatedAt: DateTime(2026, 2, 01),
    activeSubscriber: 517,
    totalRevenue: 18700.00,
  ),

  // 7. Video Creator
  SubscriptionModel(
    id: 'video-pro',
    name: 'Creator Studio',
    description: 'High performance video rendering',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 39),
      SubscriptionPrice(billingType: BillingType.yearly, price: 390),
    ],
    features: [
      SubscriptionFeature(name: '4K Rendering', isAvailable: true),
      SubscriptionFeature(name: 'Stock Media Library', isAvailable: true),
      SubscriptionFeature(name: 'Team Review Tools', isAvailable: true),
      SubscriptionFeature(name: 'Direct Social Export', isAvailable: true),
      SubscriptionFeature(name: 'Custom Fonts', isAvailable: true),
    ],
    createdAt: DateTime(2025, 7, 05),
    updatedAt: DateTime(2026, 1, 20),
    activeSubscriber: 416,
    totalRevenue: 6450.30,
  ),

  // 8. Lite Experience
  SubscriptionModel(
    id: 'lite',
    name: 'Lite',
    description: 'Essential tools for personal use',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 5),
      SubscriptionPrice(billingType: BillingType.yearly, price: 50),
    ],
    features: [
      SubscriptionFeature(name: '1 Project', isAvailable: true),
      SubscriptionFeature(name: '100MB Storage', isAvailable: true),
      SubscriptionFeature(name: 'Standard Support', isAvailable: true),
      SubscriptionFeature(name: 'Offline Access', isAvailable: false),
      SubscriptionFeature(name: 'Cloud Sync', isAvailable: false),
    ],
    createdAt: DateTime(2025, 1, 10),
    updatedAt: DateTime(2025, 11, 30),
    activeSubscriber: 511,
    totalRevenue: 450.00,
  ),

  // 9. Nonprofit Hero
  SubscriptionModel(
    id: 'ngo-plan',
    name: 'Nonprofit Hero',
    description: 'Special tools for social impact',
    status: SubscriptionStatus.active,
    isPopular: false,
    prices: [
      SubscriptionPrice(billingType: BillingType.monthly, price: 10),
      SubscriptionPrice(billingType: BillingType.yearly, price: 100),
    ],
    features: [
      SubscriptionFeature(name: 'Donor Management', isAvailable: true),
      SubscriptionFeature(name: 'Volunteer Tracker', isAvailable: true),
      SubscriptionFeature(name: 'Event Planner', isAvailable: true),
      SubscriptionFeature(name: 'Low Processing Fees', isAvailable: true),
      SubscriptionFeature(name: 'Corporate Dashboards', isAvailable: false),
    ],
    createdAt: DateTime(2025, 8, 12),
    updatedAt: DateTime(2026, 2, 09),
    activeSubscriber: 177,
    totalRevenue: 3200.00,
  ),
];

// Subscription TABLE //

class SubscriptionsManagementTable extends StatefulWidget {
  const SubscriptionsManagementTable({super.key});

  @override
  State<SubscriptionsManagementTable> createState() =>
      _SubscriptionsManagementTableState();
}

/// The number of rows displayed per page in the data grid.
int _rowsPerPage = 14;

class _SubscriptionsManagementTableState
    extends State<SubscriptionsManagementTable> {
  /// Data source for the DataGrid.
  late SubscriptionDataSource _subscriptionDataSource;

  /// Height of the DataPager widget.
  final double _dataPagerHeight = 60.0;

  /// List to store order data.
  List<SubscriptionModel> _subscriptions = <SubscriptionModel>[];

  // build rows per page selector
  List<int> buildAvailableRowsPerPage(int total, {int step = 14}) {
    final List<int> result = [];

    for (int i = step; i < total; i += step) {
      result.add(i);
    }

    if (!result.contains(total)) {
      result.add(total);
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _subscriptions = mockSubscriptions; // Fetch sample order data
    _subscriptionDataSource = SubscriptionDataSource(
      subscriptions: _subscriptions,
      context: context,
    ); // Initialize data source
  }

  final GlobalKey<FormState> _addSubscriptionFormKey = GlobalKey<FormState>();

  void _showAddSubscriptionDialog(BuildContext context) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "Add New Subscription",
      showCloseButton: true,
      width: 720,
      content: AddSubscriptionDialog(formKey: _addSubscriptionFormKey),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              kText: 'Cancel',
              outlineColor: themeData.colorScheme.primary,

              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: FlatButton(
              kText: 'Add Subscription',
              bgColor: kSecondaryColor,
              kTextColor: Colors.white,

              onPressed: () {
                if (_addSubscriptionFormKey.currentState!.validate()) {
                  // your submit function
                  // success toast
                  Toast.showToast(
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'Subscription Added!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true,
                    bottomBorder: true,
                  );

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraint) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // header
                Row(
                  children: [
                    // search bar
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.search,
                            tooltipMessage: 'Search',
                            iconColor: kTextColor,
                            buttonColor: themeData.colorScheme.surface,
                            isOutlined: true,
                            onTap: () {},
                          )
                        : SizedBox(
                            width: 240,
                            child: SoftSearchBar(hintText: 'Search...'),
                          ),

                    Spacer(),

                    // export button
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.download_outlined,
                            iconColor: themeData.colorScheme.primary,
                            buttonColor: themeData.colorScheme.primary
                                .withValues(alpha: 0.1),
                            tooltipMessage: 'Export',

                            onTap: () {},
                          )
                        : SoftButton(
                            kText: 'Export',
                            bgColor: themeData.colorScheme.primary,
                            onPressed: () {},
                            kLeadingIcon: Icons.download_outlined,
                          ),

                    SizedBox(width: kDefaultPadding),
                    // add Subscription button
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kSecondaryColor,
                            tooltipMessage: 'Add Subscription',
                            onTap: () {
                              _showAddSubscriptionDialog(context);
                            },
                          )
                        : FlatButton(
                            kText: 'Add Subscription',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              _showAddSubscriptionDialog(context);
                            },
                            kLeadingIcon: Icons.add_outlined,
                          ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),
                // DataGrid
                SizedBox(child: _buildDataGrid(constraint)),

                // Data pager for pagination
                SizedBox(
                  height: _dataPagerHeight,
                  child: SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                      itemBorderRadius: BorderRadius.circular(defaultRadius),
                      selectedItemColor: kSecondaryColor,
                      itemTextStyle: const TextStyle(
                        fontSize: kBodyMedium, // Customize font size
                      ),
                      selectedItemTextStyle: const TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w600, // Bold for active page
                        color: Colors.white, // Customize selected text color
                      ),
                    ),
                    child: SfDataPager(
                      delegate: _subscriptionDataSource,
                      itemHeight: 44,
                      itemWidth: 44,
                      navigationItemHeight: 44,
                      navigationItemWidth: 44,
                      pageCount: (_subscriptions.length / _rowsPerPage)
                          .ceil()
                          .toDouble(),
                      availableRowsPerPage: buildAvailableRowsPerPage(
                        _subscriptions.length,
                      ),
                      // Options for rows per page
                      onRowsPerPageChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _rowsPerPage = value;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the Syncfusion DataGrid.
  Widget _buildDataGrid(BoxConstraints constraint) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _subscriptionDataSource,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: <GridColumn>[
          GridColumn(
            columnName: 'SubscriptionName',
            allowFiltering: false,
            allowSorting: false,
            minimumWidth: 120,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Subscription Name',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'description',
            allowFiltering: false,
            allowSorting: false,
            minimumWidth: 220,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Description',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'status',
            allowFiltering: true,
            minimumWidth: 120,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Status',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'features',
            minimumWidth: 140,
            allowFiltering: false,
            allowSorting: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Features',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),

          GridColumn(
            columnName: 'prices',
            minimumWidth: 120,
            allowFiltering: false,
            allowSorting: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Pricing Scheme',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'activeSubscriber',
            minimumWidth: 150,
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Active Subscriber',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'totalRevenue',
            minimumWidth: 150,
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Total Revenue',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),

          GridColumn(
            columnName: 'action',
            allowFiltering: false,
            allowSorting: false,
            width: 100,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                'Action',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
        ],
        allowFiltering: true,
        allowSorting: true,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
        shrinkWrapRows: true,
      ),
    );
  }
}

/// Data source for Syncfusion DataGrid.
class SubscriptionDataSource extends DataGridSource {
  SubscriptionDataSource({required this.subscriptions, required this.context}) {
    _paginatedSubscriptions = subscriptions.take(15).toList(growable: false);
    _buildDataGridRows(_paginatedSubscriptions);
  }

  List<DataGridRow> dataGridRows = [];
  List<SubscriptionModel> _paginatedSubscriptions = [];
  List<SubscriptionModel> subscriptions;
  final BuildContext context;

  String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  final GlobalKey<FormState> _editSubscriptionFormKey = GlobalKey<FormState>();

  // show edit Subscription dialog
  void _showEditSubscriptionDialog(
    BuildContext context,
    SubscriptionModel subscription,
  ) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "Edit Subscription",
      showCloseButton: true,
      width: 720,
      content: EditSubscriptionDialog(
        subscription: subscription,
        formKey: _editSubscriptionFormKey,
      ),

      actions: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              kText: 'Cancel',
              outlineColor: themeData.colorScheme.primary,

              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(width: kDefaultPadding),
          Expanded(
            child: FlatButton(
              kText: 'Save Changes',
              bgColor: kSecondaryColor,
              kTextColor: Colors.white,

              onPressed: () {
                if (_editSubscriptionFormKey.currentState!.validate()) {
                  // your submit function
                  // success toast
                  Toast.showToast(
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'changes saved successfully!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true,
                    bottomBorder: true,
                  );

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the UI for each row in the DataGrid.
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        switch (cell.columnName) {
          // Subscription Name
          case 'SubscriptionName':
            final subscription = cell.value as SubscriptionModel;

            return Tooltip(
              message:
                  'Created: ${DateFormat('dd MMM yyyy').format(subscription.createdAt)}\n'
                  'Updated: ${DateFormat('dd MMM yyyy').format(subscription.updatedAt)}',
              waitDuration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.5 * kDefaultPadding,
                ),
                alignment: AlignmentDirectional.centerStart,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        subscription.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),

                    if (subscription.isPopular) ...[
                      const SizedBox(width: kDefaultPadding / 2),
                      Tooltip(
                        message: 'Popular Subscription',
                        child: Icon(
                          Icons.local_fire_department,
                          size: 16,
                          color: kErrorColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );

          // Description
          case 'description':
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                cell.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            );

          // STATUS BADGE
          case 'status':
            final status = cell.value as SubscriptionStatus;
            final color = _statusColor(status);
            return Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: CustomBadge(
                kText: status.name.toUpperCase(),
                kColor: color,
                isRounded: true,
                isOutlined: true,
              ),
            );

          // features
          case 'features':
            final subscription = cell.value as SubscriptionModel;

            final active = subscription.features
                .where((f) => f.isAvailable)
                .toList();
            final inactive = subscription.features
                .where((f) => !f.isAvailable)
                .toList();

            return Tooltip(
              decoration: BoxDecoration(
                color: themeData.colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              textStyle: TextStyle(
                color: themeData.colorScheme.onInverseSurface,
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              richMessage: TextSpan(
                children: [
                  const TextSpan(
                    text: "Available\n",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),

                  // ACTIVE FEATURES
                  ...active.map(
                    (f) => TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 16,
                            color: kSuccessColor,
                          ),
                        ),
                        TextSpan(text: " ${f.name}\n"),
                      ],
                    ),
                  ),

                  if (inactive.isNotEmpty)
                    const TextSpan(
                      text: "\nUnavailable\n",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                  // INACTIVE FEATURES
                  ...inactive.map(
                    (f) => TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.cancel_outlined,
                            size: 16,
                            color: kErrorColor,
                          ),
                        ),
                        TextSpan(text: " ${f.name}\n"),
                      ],
                    ),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.5 * kDefaultPadding,
                ),
                alignment: AlignmentDirectional.centerStart,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                    children: [
                      TextSpan(
                        text: "${active.length} available",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kSuccessColor,
                        ),
                      ),
                      const TextSpan(text: "\n"),
                      TextSpan(
                        text: "${inactive.length} unavailable",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kErrorColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

          // prices
          case 'prices':
            final prices = cell.value as List<SubscriptionPrice>;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: prices.map((p) {
                  return Text(
                    "\$${p.price.toStringAsFixed(2)} ${_billingLabel(p.billingType)}",
                  );
                }).toList(),
              ),
            );

          // active subscriber
          case 'activeSubscriber':
            final count = cell.value as int;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.center,
              child: Text(NumberFormat.decimalPattern().format(count)),
            );

          case 'totalRevenue':
            final revenue = cell.value as double;

            return Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              child: Text(
                NumberFormat.currency(symbol: '\$').format(revenue),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            );

          // ACTION BUTTONS
          case 'action':
            final subscription = cell.value as SubscriptionModel;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: Icons.edit,
                  shape: ButtonShape.circle,
                  onTap: () {
                    _showEditSubscriptionDialog(context, subscription);
                  },
                ),
                CustomIconButton(
                  icon: Icons.delete_outline,
                  iconColor: kErrorColor,
                  shape: ButtonShape.circle,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomDialog(content: DeleteWarningDialog()),
                    );
                  },
                ),
              ],
            );

          default:
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(cell.value.toString()),
            );
        }
      }).toList(),
    );
  }

  Color _statusColor(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.active:
        return kInfoColor;
      case SubscriptionStatus.inactive:
        return kWarningColor;
      case SubscriptionStatus.archived:
        return kTextColor;
    }
  }

  String _billingLabel(BillingType type) {
    switch (type) {
      case BillingType.monthly:
        return "monthly";
      case BillingType.yearly:
        return "yearly";
      case BillingType.oneTime:
        return "one-time";
    }
  }

  /// Handles pagination when a new page is selected.
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    if (endIndex > subscriptions.length) endIndex = subscriptions.length;
    _paginatedSubscriptions = subscriptions
        .getRange(startIndex, endIndex)
        .toList(growable: false);
    _buildDataGridRows(_paginatedSubscriptions);
    notifyListeners();
    return true;
  }

  /// Converts order data into DataGridRows.
  void _buildDataGridRows(List<SubscriptionModel> subscriptions) {
    dataGridRows = subscriptions.map<DataGridRow>((subscription) {
      return DataGridRow(
        cells: [
          /// Subscription name
          DataGridCell<SubscriptionModel>(
            columnName: 'SubscriptionName',
            value: subscription,
          ),

          /// Description
          DataGridCell<String>(
            columnName: 'description',
            value: subscription.description,
          ),

          /// Status (enum → badge)
          DataGridCell<SubscriptionStatus>(
            columnName: 'status',
            value: subscription.status,
          ),

          /// Features summary: "X active, Y inactive"
          DataGridCell<SubscriptionModel>(
            columnName: 'features',
            value: subscription,
          ),

          /// Price + billing type (handled in adapter)
          DataGridCell<List<SubscriptionPrice>>(
            columnName: 'prices',
            value: subscription.prices,
          ),

          /// active subscriber
          DataGridCell<int>(
            columnName: 'activeSubscriber',
            value: subscription.activeSubscriber,
          ),

          /// Total Revenue
          DataGridCell<double>(
            columnName: 'totalRevenue',
            value: subscription.totalRevenue,
          ),

          /// Action column
          DataGridCell<SubscriptionModel>(
            columnName: 'action',
            value: subscription,
          ),
        ],
      );
    }).toList();
  }
}

// Subscription delete warning dialog

class DeleteWarningDialog extends StatelessWidget {
  const DeleteWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: 520,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4 * kDefaultPadding),
          SizedBox(
            width: 120,
            height: 120,
            child: DotLottieLoader.fromAsset(
              "assets/animations/alert.lottie",
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            "Important Warning!",
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: kHeadlineSmall,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          const Center(
            child: Text(
              "This action is irreversible. Are you sure you want to proceed?",
              style: TextStyle(fontSize: kBodyLarge),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 2 * kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SoftButton(
                kText: 'Cancel',
                bgColor: kSuccessColor,
                kLeadingIcon: Icons.cancel_outlined,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: kDefaultPadding),
              CustomOutlinedButton(
                kText: 'Delete',
                outlineColor: kErrorColor,
                kLeadingIcon: Icons.arrow_circle_right_outlined,
                onPressed: () {
                  Navigator.of(context).pop();
                  // delete logic

                  // success toast
                  Toast.showToast(
                    context: context,
                    icon: Icons.check_circle_outline,
                    message: 'Subscription Deleted!',
                    color: kSuccessColor,
                    alignment: Alignment.topRight,
                    showProgress: true,
                    showCloseButton: true,
                    bottomBorder: true,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 4 * kDefaultPadding),
        ],
      ),
    );
  }
}

// add Subscription form

class AddSubscriptionDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const AddSubscriptionDialog({super.key, required this.formKey});

  @override
  State<AddSubscriptionDialog> createState() => _AddSubscriptionDialogState();
}

class _AddSubscriptionDialogState extends State<AddSubscriptionDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  SubscriptionStatus _status = SubscriptionStatus.active;

  final Map<BillingType, TextEditingController> _priceControllers = {
    BillingType.monthly: TextEditingController(),
    BillingType.yearly: TextEditingController(),
    BillingType.oneTime: TextEditingController(),
  };

  final List<SubscriptionFeature> _features = [];

  final _featureController = TextEditingController();
  bool _featureAvailable = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _featureController.dispose();
    for (final c in _priceControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _addFeature() {
    if (_featureController.text.isEmpty) return;
    setState(() {
      _features.add(
        SubscriptionFeature(
          name: _featureController.text,
          isAvailable: _featureAvailable,
        ),
      );
      _featureController.clear();
      _featureAvailable = true;
    });
  }

  String billingTypeLabel(BillingType type) {
    switch (type) {
      case BillingType.monthly:
        return "Monthly";
      case BillingType.yearly:
        return "Yearly";
      case BillingType.oneTime:
        return "One-time";
    }
  }

  String _statusLabel(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.active:
        return "Active";
      case SubscriptionStatus.inactive:
        return "Inactive";
      case SubscriptionStatus.archived:
        return "Archived";
    }
  }

  bool _isPopular = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NAME
            FormLabel(text: "Subscription name", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: _nameController,
              labelText: 'Subscription name',
              hintText: 'Ex: Starter, Pro, or Ultimate',
              suffixIcon: Icons.subscriptions_outlined,
              validator: FormBuilderValidators.required(),
              successMessage: 'Looks Good!', // show success message
            ),
            const SizedBox(height: kDefaultPadding),

            /// DESCRIPTION
            FormLabel(text: "Description", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: _descController,
              hintText: 'Short description of subscription.',
              minLines: 4,
              maxLines: 4,
              validator: FormBuilderValidators.required(),

              successMessage: 'Looks Good!', // show success message
            ),
            const SizedBox(height: kDefaultPadding),

            /// STATUS
            FormLabel(text: "Status", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomDropdownFormField<SubscriptionStatus>(
              initialValue: _status,
              hint: 'Select Status',
              items: SubscriptionStatus.values.map((status) {
                return DropdownMenuItem<SubscriptionStatus>(
                  value: status,
                  child: Text(_statusLabel(status)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              validator: FormBuilderValidators.required(),
              successMessage: 'Looks Good!',
            ),
            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Pricing Scheme", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            AdaptiveWrap(
              breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
              columnRatios: [1 / 3, 1 / 3, 1 / 3],
              children: [
                ...BillingType.values.map(
                  (type) => CustomTextFormField(
                    controller: _priceControllers[type],
                    labelText: "${billingTypeLabel(type)} price",
                    suffixIcon: Icons.attach_money,
                    inputFormatters: [
                      InputMask.currency(currencyCode: 'USD', showCent: true),
                    ],

                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Popular Product", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            Row(
              children: [
                Expanded(child: Text("Mark this product as popular")),
                CustomSwitch(
                  value: _isPopular,
                  activeColor: kSecondaryColor,
                  onChanged: (value) {
                    setState(() {
                      _isPopular = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Features", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            Row(
              children: [
                // features form
                Expanded(
                  child: CustomTextFormField(
                    controller: _featureController,
                    hintText: "Feature name",
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),

                // select availability
                CustomDropdownButton<bool>(
                  label: 'Availability',
                  color: themeData.colorScheme.onSurface,
                  outlineColor: themeData.colorScheme.outline,
                  type: DropdownType.outline,
                  value: _featureAvailable,
                  items: const [
                    DropdownMenuItem(value: true, child: Text("Available")),
                    DropdownMenuItem(value: false, child: Text("Unavailable")),
                  ],
                  onChanged: (v) => setState(() => _featureAvailable = v!),
                ),

                const SizedBox(width: kDefaultPadding / 2),

                // add features button
                CustomIconButton(
                  icon: Icons.add,
                  onTap: _addFeature,
                  iconColor: kSecondaryColor,
                  buttonColor: kSecondaryColor.withValues(alpha: 0.1),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: kDefaultPadding / 2,
              ),
              child: Column(
                spacing: kDefaultPadding / 2,
                children: _features
                    .map(
                      (f) => Container(
                        decoration: BoxDecoration(
                          color: f.isAvailable
                              ? kSuccessColor.withValues(alpha: 0.1)
                              : kErrorColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: kDefaultPadding,
                            top: kDefaultPadding / 2,
                            bottom: kDefaultPadding / 2,
                            end: kDefaultPadding / 2,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  f.name,
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Icon(Icons.close, size: 16),
                                onTap: () {
                                  setState(() => _features.remove(f));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Subscription Dialog

class EditSubscriptionDialog extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final SubscriptionModel subscription;

  const EditSubscriptionDialog({
    super.key,
    required this.subscription,
    required this.formKey,
  });

  @override
  State<EditSubscriptionDialog> createState() => _EditSubscriptionDialogState();
}

class _EditSubscriptionDialogState extends State<EditSubscriptionDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descController;

  late SubscriptionStatus _status;

  late Map<BillingType, TextEditingController> _priceControllers;

  late List<SubscriptionFeature> _features;

  final _featureController = TextEditingController();
  bool _featureAvailable = true;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.subscription.name);
    _descController = TextEditingController(
      text: widget.subscription.description,
    );
    _status = widget.subscription.status;

    _priceControllers = {
      BillingType.monthly: TextEditingController(),
      BillingType.yearly: TextEditingController(),
      BillingType.oneTime: TextEditingController(),
    };

    for (final p in widget.subscription.prices) {
      _priceControllers[p.billingType]?.text = p.price.toString();
    }

    _features = List.from(widget.subscription.features);
    _isPopular = widget.subscription.isPopular;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _featureController.dispose();
    for (final c in _priceControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _addFeature() {
    if (_featureController.text.isEmpty) return;
    setState(() {
      _features.add(
        SubscriptionFeature(
          name: _featureController.text,
          isAvailable: _featureAvailable,
        ),
      );
      _featureController.clear();
      _featureAvailable = true;
    });
  }

  String billingTypeLabel(BillingType type) {
    switch (type) {
      case BillingType.monthly:
        return "Monthly";
      case BillingType.yearly:
        return "Yearly";
      case BillingType.oneTime:
        return "One-time";
    }
  }

  String _statusLabel(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.active:
        return "Active";
      case SubscriptionStatus.inactive:
        return "Inactive";
      case SubscriptionStatus.archived:
        return "Archived";
    }
  }

  late bool _isPopular;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NAME
            FormLabel(text: "Subscription name", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              labelText: 'Subscription name',
              hintText: 'Ex: Starter, Pro, or Ultimate',
              suffixIcon: Icons.subscriptions_outlined,
              validator: FormBuilderValidators.required(),
              originalValue: widget.subscription.name,
              successMessage: 'Looks Good!', // show success message
            ),
            const SizedBox(height: kDefaultPadding),

            /// DESCRIPTION
            FormLabel(text: "Description", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomTextFormField(
              controller: _descController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: 'Short description of subscription.',
              minLines: 4,
              maxLines: 4,
              validator: FormBuilderValidators.required(),
              originalValue: widget.subscription.description,
              successMessage: 'Looks Good!', // show success message
            ),
            const SizedBox(height: kDefaultPadding),

            /// STATUS
            FormLabel(text: "Status", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            CustomDropdownFormField<SubscriptionStatus>(
              initialValue: _status,
              hint: 'Select Status',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              items: SubscriptionStatus.values.map((status) {
                return DropdownMenuItem<SubscriptionStatus>(
                  value: status,
                  child: Text(_statusLabel(status)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              validator: FormBuilderValidators.required(),
              successMessage: 'Looks Good!',
            ),
            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Pricing Scheme", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),
            AdaptiveWrap(
              breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
              columnRatios: [1 / 3, 1 / 3, 1 / 3],
              children: [
                ...BillingType.values.map(
                  (type) => CustomTextFormField(
                    controller: _priceControllers[type],
                    labelText: "${billingTypeLabel(type)} price",
                    suffixIcon: Icons.attach_money,
                    inputFormatters: [
                      InputMask.currency(currencyCode: 'USD', showCent: true),
                    ],

                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Popular Product", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            Row(
              children: [
                Expanded(child: Text("Mark this product as popular")),
                CustomSwitch(
                  value: _isPopular,
                  activeColor: kSecondaryColor,
                  onChanged: (value) {
                    setState(() {
                      _isPopular = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            FormLabel(text: "Features", showRequired: false),
            SizedBox(height: kDefaultPadding / 2),

            Row(
              children: [
                // features form
                Expanded(
                  child: CustomTextFormField(
                    controller: _featureController,
                    hintText: "Feature name",
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),

                // select availability
                CustomDropdownButton<bool>(
                  label: 'Availability',
                  color: themeData.colorScheme.onSurface,
                  outlineColor: themeData.colorScheme.outline,
                  type: DropdownType.outline,
                  value: _featureAvailable,
                  items: const [
                    DropdownMenuItem(value: true, child: Text("Available")),
                    DropdownMenuItem(value: false, child: Text("Unavailable")),
                  ],
                  onChanged: (v) => setState(() => _featureAvailable = v!),
                ),

                const SizedBox(width: kDefaultPadding / 2),

                // add features button
                CustomIconButton(
                  icon: Icons.add,
                  onTap: _addFeature,
                  iconColor: kSecondaryColor,
                  buttonColor: kSecondaryColor.withValues(alpha: 0.1),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: kDefaultPadding / 2,
              ),
              child: Column(
                spacing: kDefaultPadding / 2,
                children: _features
                    .map(
                      (f) => Container(
                        decoration: BoxDecoration(
                          color: f.isAvailable
                              ? kSuccessColor.withValues(alpha: 0.1)
                              : kErrorColor.withValues(alpha: 0.1),

                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: kDefaultPadding,
                            top: kDefaultPadding / 2,
                            bottom: kDefaultPadding / 2,
                            end: kDefaultPadding / 2,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  f.name,
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Icon(Icons.close, size: 16),
                                onTap: () {
                                  setState(() => _features.remove(f));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

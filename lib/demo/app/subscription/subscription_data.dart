// pricing plan data mock up

import 'package:flutter_ademin/demo/app/subscription/subscription_models.dart';

List<Map<String, dynamic>> plans = [
  {
    'title': 'Starter',
    'price': 19,
    'description': 'Perfect for individuals or freelancers starting out.',
    'activeFeatures': [
      '5 Projects',
      '399 Customers',
      'Scalable Bandwidth',
      '8 FTP Login',
      'Email Support',
      'Customizable Templates',
    ],
    'inactiveFeatures': [
      '24/7 Support',
      'Unlimited Storage',
      'Advanced Analytics',
      'Custom Branding',
    ],
    'isCurrent': true,
    'isPopular': false,
  },
  {
    'title': 'Professional',
    'price': 29,
    'description': 'Ideal for growing teams with more needs.',
    'activeFeatures': [
      '8 Projects',
      '549 Customers',
      'Scalable Bandwidth',
      '15 FTP Login',
      '24/7 Support',
      'Unlimited Integrations',
      'Priority Support',
      'Advanced Reporting',
    ],
    'inactiveFeatures': [
      'Unlimited Storage',
      'Domain',
      'Dedicated Account Manager',
    ],
    'isCurrent': false,
    'isPopular': false,
  },
  {
    'title': 'Enterprise',
    'price': 39,
    'description': 'Great for businesses that need performance and support.',
    'activeFeatures': [
      '15 Projects',
      'Unlimited Customers',
      'Scalable Bandwidth',
      '20 FTP Login',
      '24/7 Support',
      '35GB Storage',
      'Dedicated Account Manager',
      'Advanced Analytics',
      'API Access',
      'Custom Branding',
    ],
    'inactiveFeatures': ['Domain', 'SLA (Service Level Agreement)'],
    'isCurrent': false,
    'isPopular': true,
  },
  {
    'title': 'Unlimited',
    'price': 69,
    'description': 'For enterprises that need everything, without limits.',
    'activeFeatures': [
      'Unlimited Projects',
      'Unlimited Customers',
      'Scalable Bandwidth',
      'Unlimited FTP Login',
      '24/7 Support',
      'Unlimited Storage',
      'Domain',
      'Dedicated Server',
      'Custom Integrations',
      'VIP Support',
      'Advanced Security Features',
      'Unlimited API Access',
      'Enterprise-Level Reporting',
      'White-Labeling',
    ],
    'inactiveFeatures': [],
    'isCurrent': false,
    'isPopular': false,
  },
];

Map<String, dynamic> getCurrentPlan() {
  for (final plan in plans) {
    if (plan['isCurrent'] == true) {
      return plan;
    }
  }

  return plans.first;
}

// existing payment methods mockups

final List<PaymentMethod> existingPaymentMethods = [
  PaymentMethod(
    cardNumber: "4242 4242 4242 4242",
    holderName: "John Doe",
    brand: "Visa",
    expiry: "12/28",
    icon: "assets/images/visa.png",
    isDefault: true,
  ),
  PaymentMethod(
    cardNumber: "5555 4444 3333 4444",
    holderName: "Alex Morgan",
    brand: "Mastercard",
    expiry: "08/27",
    icon: "assets/images/mastercard.png",
  ),

  PaymentMethod(
    cardNumber: "4242 4242 4242 8892",
    holderName: "Meyers Hup",
    brand: "Visa",
    expiry: "10/30",
    icon: "assets/images/visa.png",
  ),
  PaymentMethod(
    cardNumber: "5782 8224 6310 005",
    holderName: "Umar Hamzah",
    brand: "Mastercard",
    expiry: "05/26",
    icon: "assets/images/mastercard.png",
  ),
];

// usage progress bar of curent plan
final List<UsageModel> usageItems = [
  UsageModel(title: "Projects", value: 4, max: 5, unit: "projects"),
  UsageModel(title: "Customer", value: 169, max: 399, unit: "customers"),
  UsageModel(title: "FTP login", value: 6, max: 8, unit: "seats"),
  UsageModel(title: "Email supports", value: 421, max: 500, unit: "emails"),
];

// billing history

final List<BillingModel> mockBillingData = [
  BillingModel(
    invoice: "#INV-1001",
    description: "Starter",
    date: DateTime(2025, 1, 5),
    amount: 19,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1002",
    description: "Professional",
    date: DateTime(2025, 1, 8),
    amount: 49,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1003",
    description: "Enterprise",
    date: DateTime(2025, 1, 12),
    amount: 99,
    status: BillingStatus.pending,
  ),
  BillingModel(
    invoice: "#INV-1004",
    description: "Unlimited",
    date: DateTime(2025, 1, 15),
    amount: 199,
    status: BillingStatus.failed,
  ),
  BillingModel(
    invoice: "#INV-1005",
    description: "Starter",
    date: DateTime(2025, 1, 18),
    amount: 19,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1006",
    description: "Professional",
    date: DateTime(2025, 1, 20),
    amount: 49,
    status: BillingStatus.pending,
  ),
  BillingModel(
    invoice: "#INV-1007",
    description: "Enterprise",
    date: DateTime(2025, 1, 22),
    amount: 99,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1008",
    description: "Unlimited",
    date: DateTime(2025, 1, 25),
    amount: 199,
    status: BillingStatus.failed,
  ),
  BillingModel(
    invoice: "#INV-1009",
    description: "Starter",
    date: DateTime(2025, 1, 27),
    amount: 19,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1010",
    description: "Professional",
    date: DateTime(2025, 2, 1),
    amount: 49,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1011",
    description: "Enterprise",
    date: DateTime(2025, 2, 3),
    amount: 99,
    status: BillingStatus.pending,
  ),
  BillingModel(
    invoice: "#INV-1012",
    description: "Unlimited",
    date: DateTime(2025, 2, 6),
    amount: 199,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1013",
    description: "Starter",
    date: DateTime(2025, 2, 10),
    amount: 19,
    status: BillingStatus.failed,
  ),
  BillingModel(
    invoice: "#INV-1014",
    description: "Professional",
    date: DateTime(2025, 2, 12),
    amount: 49,
    status: BillingStatus.paid,
  ),
  BillingModel(
    invoice: "#INV-1015",
    description: "Enterprise",
    date: DateTime(2025, 2, 15),
    amount: 99,
    status: BillingStatus.pending,
  ),
];

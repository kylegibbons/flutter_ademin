import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/dashboard_analytics_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/metric_card.dart';

// user by country data mockup
final List<CountryUserData> liveUserData = [
  CountryUserData('United States', 2450),
  CountryUserData('India', 1820),
  CountryUserData('Indonesia', 1325),
  CountryUserData('Brazil', 980),
  CountryUserData('Germany', 720),
  CountryUserData('Australia', 610),
  CountryUserData('Canada', 540),
  CountryUserData('France', 500),
  CountryUserData('China', 380),
  CountryUserData('Nigeria', 240),
];

final metrics = [
  StandardMetricCardData(
    title: 'Users',
    value: '56.05k',
    icon: Icons.person_outline,
    change: '+34.21%',
    isPositive: true,
    subtitle: 'vs. prev month',
  ),
  StandardMetricCardData(
    title: 'Sessions',
    value: '127.66k',
    icon: Icons.monitor_heart_outlined,
    change: '-7.76%',
    isPositive: false,
    subtitle: 'vs. prev month',
  ),
  StandardMetricCardData(
    title: 'Avg. Visit Duration',
    value: '8m 42sec',
    icon: Icons.access_time,
    change: '-0.28%',
    isPositive: false,
    subtitle: 'vs. prev month',
  ),
  StandardMetricCardData(
    title: 'Bounce Rate',
    value: '37.48%',
    icon: Icons.open_in_new,
    change: '+9.05%',
    isPositive: true,
    subtitle: 'vs. prev month',
  ),
];

// device user data mockup
final List<DeviceUserData> deviceUserData = [
  DeviceUserData('Desktop Users', 78560, 2.08, () => kPrimaryColor),
  DeviceUserData('Mobile Users', 105020, -8.52, () => kWarningColor),
  DeviceUserData('Tablet Users', 42890, -7.36, () => kInfoColor),
];

// top referal data mockup
final List<ReferralSource> topReferrals = [
  ReferralSource('www.google.com', 25.00, () => kInfoColor),
  ReferralSource('www.youtube.com', 18.00, () => kErrorColor),
  ReferralSource('www.meta.com', 22.00, () => kPrimaryColor),
  ReferralSource('www.medium.com', 12.50, () => kSuccessColor),
  ReferralSource('Other', 22.50, () => kWarningColor),
];

// page view data mockup
final List<PageViewData> topPages = [
  PageViewData('/dashboard/main', 150, 20.5),
  PageViewData('/products/list', 120, 25.1),
  PageViewData('/users/profile', 105, 18.9),
  PageViewData('/settings/account', 90, 15.3),
  PageViewData('/blog/article-1', 75, 28.7),
  PageViewData('/contact-us', 60, 30.2),
  PageViewData('/pricing', 55, 12.0),
  PageViewData('/about-us', 45, 21.5),
  PageViewData('/support/faq', 35, 19.8),
];

// audience metric data mockup generator

final Random _random = Random(); // Initialize Random once for efficiency

final List<AudienceData> audienceMetrics = List.generate(30, (index) {
  final date = DateTime(2025, 7, index + 1);

  // Users: Base value with random daily fluctuation and a slight overall trend
  final int users = 1000 + _random.nextInt(500) + (index * 15);
  // This will range roughly from 1000 to 1500 + (index * 15),
  // providing a gentle upward trend with daily variation.

  // Sessions: Typically higher than users, with its own fluctuation.
  // Sessions per user can vary (e.g., 1.2 to 2.5 sessions per user).
  final int sessions = (users * (1.1 + _random.nextDouble() * 1.0)).toInt();
  // This will ensure sessions are proportionally related to users but still varied.

  // Pageviews: Significantly higher than sessions, representing pages per session.
  // Pages per session can vary (e.g., 2 to 5 pages per session).
  final int pageviews = (sessions * (1.2 + _random.nextDouble() * 1.0)).toInt();
  // This links pageviews to sessions, but with a good range of variability.

  return AudienceData(date, users, pageviews, sessions);
});

// Audience Summary data mockup

final List<AudienceSummary> audienceSummaries = [
  AudienceSummary(value: '7,585', label: 'Users'),
  AudienceSummary(value: '15,585,', label: 'Page Views'),
  AudienceSummary(value: '7,451', label: 'Sesions'),
  AudienceSummary(
    value: '18.92%',
    label: 'Conversion Rate',
    valueColor: () => kSuccessColor,
  ),
];

// mini metric data mockup

final List<MiniMetricData> miniMetrics = [
  MiniMetricData.fromRawTrend(
    title: "Bounce Rate (Avg)",
    value: "47.74%",
    prevLabel: "vs 66.88% (prev.)",
    change: -28.60,
    rawTrend: [
      10.0,
      22.0,
      34.0,
      35.0,
      55.0,
      60.0,
      45.0,
      30.0,
      30.0,
      49.0,
      15.0,
      20.5,
      48.0,
      47.0,
      46.5,
      50.0,
      30.0,
      15.5,
      20.0,
      45.0,
      44.5,
      16.0,
      10.0,
      60.5,
      45.0,
      23.5,
      46.0,
      46.5,
      47.0,
      35.0,
    ],
    color: () => kInfoColor,
  ),
  MiniMetricData.fromRawTrend(
    title: "Pageviews (Avg)",
    value: "2.75",
    prevLabel: "vs 2.19 (prev.)",
    change: 25.57,
    rawTrend: [
      2.2,
      2.3,
      2.2,
      2.4,
      2.3,
      1.8,
      1.0,
      2.6,
      2.5,
      2.7,
      3.0,
      3.2,
      3.5,
      5.0,
      1.0,
      2.8,
      2.7,
      4.0,
      2.5,
      2.4,
      2.5,
      2.6,
      1.7,
      2.1,
      2.7,
      2.72,
      2.73,
      5.74,
      2.75,
      2.75,
    ],
    color: () => kSuccessColor,
  ),
  MiniMetricData.fromRawTrend(
    title: "New Sessions",
    value: "76.40%",
    prevLabel: "vs 74.80% (prev.)",
    change: 2.14,
    rawTrend: [
      65.0,
      77.0,
      76.0,
      75.0,
      74.0,
      53.0,
      62.0,
      71.5,
      80.0,
      53.5,
      70.0,
      70.5,
      51.0,
      60.5,
      70.0,
      70.5,
      51.0,
      51.5,
      72.0,
      44.5,
      20.0,
      43.5,
      54.0,
      64.5,
      75.0,
      54.5,
      60.0,
      40.2,
      32.3,
      20.40,
    ],
    color: () => kErrorColor,
  ),
  MiniMetricData.fromRawTrend(
    title: "Time on Site (Avg)",
    value: "2m:15s",
    prevLabel: "vs 1m:51s (prev.)",
    change: 21.62,
    rawTrend: [
      120.0,
      140.0,
      100.0,
      150.0,
      90.0,
      130.0,
      110.0,
      98.0,
      115.0,
      120.0,
      125.0,
      130.0,
      120.0,
      135.0,
      125.0,
      130.0,
      135.0,
      80.0,
      130.0,
      135.0,
      78.0,
      145.0,
      135.0,
      67.0,
      80.0,
      90.0,
      78.0,
      90.0,
      150.0,
      135.0,
    ],
    color: () => kSecondaryColor,
  ),
];

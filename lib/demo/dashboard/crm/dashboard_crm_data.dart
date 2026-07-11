import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/dashboard/crm/dashboard_crm_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/metric_card.dart';

// CRM Dashboard Metrics data mockup

final metricsStatsData = [
  CompactMetricCardData("TOTAL CONTACTS", "1,245", Icons.people_outline, true),
  CompactMetricCardData(
    "NEW LEADS",
    "89",
    Icons.person_add_alt_1_outlined,
    false,
  ),
  CompactMetricCardData("MEETINGS", "34", Icons.calendar_today, true),
  CompactMetricCardData(
    "MONTHLY REVENUE",
    "\$20,834",
    Icons.attach_money,
    true,
  ),
  CompactMetricCardData("CHURN RATE", "4.2%", Icons.trending_up, false),
];

// contact map Indonesia data mockup

final List<ProvinceContactData> provinceData = [
  ProvinceContactData('JAWA BARAT', 120),
  ProvinceContactData('JAWA TIMUR', 85),
  ProvinceContactData('DKI JAKARTA', 150),
  ProvinceContactData('BALI', 45),
  ProvinceContactData('SUMATERA UTARA', 90),
  ProvinceContactData('SULAWESI TENGGARA', 60),
  ProvinceContactData('PAPUA', 30),
  ProvinceContactData('ACEH', 75),
  ProvinceContactData('BANTEN', 110),
  ProvinceContactData('JAWA TENGAH', 95),
  ProvinceContactData('KALIMANTAN BARAT', 55),
  ProvinceContactData('SUMATERA SELATAN', 70),
  ProvinceContactData('LAMPUNG', 80),
  ProvinceContactData('RIAU', 65),
  ProvinceContactData('NUSA TENGGARA BARAT', 40),
  ProvinceContactData('SULAWESI SELATAN', 100),
  ProvinceContactData('MALUKU', 25),
  ProvinceContactData('KALIMANTAN TIMUR', 50),
  ProvinceContactData('DI YOGYAKARTA', 130),
  ProvinceContactData('BANGKA BELITUNG', 35),
  ProvinceContactData('IRIAN JAYA TIMUR', 14),
];

// sales by region data mockup

final List<RegionSales> regionSales = [
  RegionSales(region: 'East Coast', amount: 3700000, color: kPrimaryColor),
  RegionSales(region: 'Midwest', amount: 930000, color: kInfoColor),
  RegionSales(region: 'Southwest', amount: 460000, color: kWarningColor),
  RegionSales(region: 'West Coast', amount: 695000, color: kErrorColor),
];

// Sales by lead sources data mockup

final List<LeadSourceSales> leadSourceSalesData = [
  LeadSourceSales(source: 'Web', amount: 160000, color: kPrimaryColor),
  LeadSourceSales(
    source: 'Phone Inquiry',
    amount: 790000,
    color: kPrimaryColor,
  ),
  LeadSourceSales(
    source: 'Partner Referral',
    amount: 540000,
    color: kPrimaryColor,
  ),
  LeadSourceSales(
    source: 'Purchased List',
    amount: 75000,
    color: kPrimaryColor,
  ),
  LeadSourceSales(
    source: 'Employee Referral',
    amount: 350000,
    color: kPrimaryColor,
  ),
  LeadSourceSales(
    source: 'External Referral',
    amount: 200000,
    color: kPrimaryColor,
  ),
];

// Quarterly Sales data mockup

final List<QuarterlySales> quarterlySales = [
  QuarterlySales(
    quarter: 'Q1-2025',
    sales: 120000,
    target: 100000,
    color: kSecondaryColor,
  ),
  QuarterlySales(
    quarter: 'Q2-2025',
    sales: 95000,
    target: 110000,
    color: kSuccessColor,
  ),
  QuarterlySales(
    quarter: 'Q3-2025',
    sales: 80000,
    target: 90000,
    color: kWarningColor,
  ),
  QuarterlySales(
    quarter: 'Q4-2025',
    sales: 105000,
    target: 95000,
    color: kInfoColor,
  ),
];

// won & lost deals

final List<DealTrend> data2025 = [
  DealTrend(
    month: 'Jan',
    wonAmount: 2520000.0,
    lostAmount: -2330000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Feb',
    wonAmount: 2500000.0,
    lostAmount: -2560000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Mar',
    wonAmount: 2480000.0,
    lostAmount: -2790000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Apr',
    wonAmount: 3100000.0,
    lostAmount: -2200000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'May',
    wonAmount: 3450000.0,
    lostAmount: -1850000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Jun',
    wonAmount: 3200000.0,
    lostAmount: -1500000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Jul',
    wonAmount: 4600000.0,
    lostAmount: -1900000.0,
    forecastWon: 0.0,
    forecastLost: -0.0,
  ),
  DealTrend(
    month: 'Aug',
    wonAmount: 0.0,
    lostAmount: -0.0,
    forecastWon: 4500000.0,
    forecastLost: -6200000.0,
  ),
  DealTrend(
    month: 'Sep',
    wonAmount: 0.0,
    lostAmount: -0.0,
    forecastWon: 3600000.0,
    forecastLost: -3400000.0,
  ),
  DealTrend(
    month: 'Oct',
    wonAmount: 0.0,
    lostAmount: -0.0,
    forecastWon: 2700000.0,
    forecastLost: -4500000.0,
  ),
  DealTrend(
    month: 'Nov',
    wonAmount: 0.0,
    lostAmount: -0.0,
    forecastWon: 5800000.0,
    forecastLost: -3600000.0,
  ),
  DealTrend(
    month: 'Dec',
    wonAmount: 0.0,
    lostAmount: -0.0,
    forecastWon: 3900000.0,
    forecastLost: -4700000.0,
  ),
];

int forecastStartIndex = 7; // Agustus = index 7

// open pipe next month

final double openPipeAmount = 36000000;
final double maxValue = 40000000;

String formatMillionUSD(double value) {
  return 'USD ${(value / 1000000).toStringAsFixed(0)}M';
}

Color getGaugeColor(double value, double maxValue) {
  if (value < maxValue * 0.4) {
    return kErrorColor; // Red
  } else if (value < maxValue * 0.8) {
    return kWarningColor; // Orange
  } else {
    return kSuccessColor; // Green
  }
}

// sales stage data mockup

final List<SalesStageData> salesStageData = [
  SalesStageData('02 - Determining Problem', 53000000, kInfoColor),
  SalesStageData('03 - Validating Benefits', 69000000, kWarningColor),
  SalesStageData('04 - Confirming Value', 130000000, kSuccessColor),
  SalesStageData('05 - Negotiating', 51000000, kSecondaryColor),
  SalesStageData('06 - Finalizing Closure', 21000000, kErrorColor),
];

final int unCompletedForecastStartIndex =
    8; // mulai dari September (index ke-8)

final Map<String, Color> legendColors = {
  'Call': kPrimaryColor,
  'Call Forecast': kPrimaryColor.withValues(alpha: 0.4),
  'Email': kInfoColor,
  'Email Forecast': kInfoColor.withValues(alpha: 0.4),
  'Event': kSuccessColor,
  'Event Forecast': kSuccessColor.withValues(alpha: 0.4),
  'Meeting': kWarningColor,
  'Meeting Forecast': kWarningColor.withValues(alpha: 0.4),
  'To-do': kErrorColor,
  'To-do Forecast': kErrorColor.withValues(alpha: 0.4),
};

// data mockup

final List<ActivityData> activityData2025 = [
  ActivityData(
    month: 'Jan',
    call: 4,
    email: 3,
    event: 3,
    meeting: 3,
    todo: 4,
    callForecast: 3,
    emailForecast: 2,
    eventForecast: 2,
    meetingForecast: 2,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'Feb',
    call: 3,
    email: 3,
    event: 3,
    meeting: 3,
    todo: 4,
    callForecast: 4,
    emailForecast: 3,
    eventForecast: 2,
    meetingForecast: 2,
    todoForecast: 2,
  ),
  ActivityData(
    month: 'Mar',
    call: 4,
    email: 3,
    event: 4,
    meeting: 3,
    todo: 3,
    callForecast: 4,
    emailForecast: 3,
    eventForecast: 2,
    meetingForecast: 3,
    todoForecast: 2,
  ),
  ActivityData(
    month: 'Apr',
    call: 5,
    email: 4,
    event: 3,
    meeting: 3,
    todo: 3,
    callForecast: 5,
    emailForecast: 4,
    eventForecast: 3,
    meetingForecast: 3,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'May',
    call: 4,
    email: 3,
    event: 4,
    meeting: 3,
    todo: 4,
    callForecast: 5,
    emailForecast: 3,
    eventForecast: 2,
    meetingForecast: 3,
    todoForecast: 2,
  ),
  ActivityData(
    month: 'Jun',
    call: 5,
    email: 5,
    event: 3,
    meeting: 3,
    todo: 3,
    callForecast: 6,
    emailForecast: 5,
    eventForecast: 3,
    meetingForecast: 4,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'Jul',
    call: 6,
    email: 4,
    event: 3,
    meeting: 3,
    todo: 3,
    callForecast: 6,
    emailForecast: 4,
    eventForecast: 2,
    meetingForecast: 3,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'Aug',
    call: 7,
    email: 3,
    event: 3,
    meeting: 3,
    todo: 3,
    callForecast: 7,
    emailForecast: 4,
    eventForecast: 3,
    meetingForecast: 3,
    todoForecast: 2,
  ),

  // Forecast mulai dari sini (Sep–Des)
  ActivityData(
    month: 'Sep',
    call: 0,
    email: 0,
    event: 0,
    meeting: 0,
    todo: 0,
    callForecast: 5,
    emailForecast: 3,
    eventForecast: 4,
    meetingForecast: 3,
    todoForecast: 4,
  ),
  ActivityData(
    month: 'Oct',
    call: 0,
    email: 0,
    event: 0,
    meeting: 0,
    todo: 0,
    callForecast: 4,
    emailForecast: 3,
    eventForecast: 3,
    meetingForecast: 3,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'Nov',
    call: 0,
    email: 0,
    event: 0,
    meeting: 0,
    todo: 0,
    callForecast: 3,
    emailForecast: 3,
    eventForecast: 4,
    meetingForecast: 3,
    todoForecast: 3,
  ),
  ActivityData(
    month: 'Dec',
    call: 0,
    email: 0,
    event: 0,
    meeting: 0,
    todo: 0,
    callForecast: 4,
    emailForecast: 3,
    eventForecast: 4,
    meetingForecast: 3,
    todoForecast: 4,
  ),
];

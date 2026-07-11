import 'package:flutter/material.dart';

// Country user data model
class CountryUserData {
  final String country;
  final int users;

  CountryUserData(this.country, this.users);
}

// device user data model
class DeviceUserData {
  final String device;
  final double value;
  final double percentageChange;
  final Color Function() color;

  DeviceUserData(this.device, this.value, this.percentageChange, this.color);
}

// top referal data model
class ReferralSource {
  final String name;
  final double percentage;
  final Color Function() color;

  ReferralSource(this.name, this.percentage, this.color);
}

// page view data model
class PageViewData {
  final String path;
  final int active;
  final double users;

  PageViewData(this.path, this.active, this.users);
}

// audience metics data model
class AudienceData {
  final DateTime date;
  final int users;
  final int pageviews;
  final int sessions;

  AudienceData(this.date, this.users, this.pageviews, this.sessions);
}

// Audience Summary data model
class AudienceSummary {
  final String value;
  final String label;
  final Color Function()? valueColor;

  AudienceSummary({required this.value, required this.label, this.valueColor});
}

// mini metric data model

class MiniMetricData {
  final String title;
  final String value;
  final String prevLabel;
  final double change;
  final List<ChartData> trend;
  final Color Function() color;

  MiniMetricData({
    required this.title,
    required this.value,
    required this.prevLabel,
    required this.change,
    required this.trend,
    required this.color,
  });

  // Optional: helper from List<double>
  factory MiniMetricData.fromRawTrend({
    required String title,
    required String value,
    required String prevLabel,
    required double change,
    required List<double> rawTrend,
    required Color Function() color,
  }) {
    final chartData = List.generate(
      rawTrend.length,
      (i) => ChartData(i, rawTrend[i]),
    );
    return MiniMetricData(
      title: title,
      value: value,
      prevLabel: prevLabel,
      change: change,
      trend: chartData,
      color: color,
    );
  }
}

class ChartData {
  final int x;
  final double y;

  ChartData(this.x, this.y);
}

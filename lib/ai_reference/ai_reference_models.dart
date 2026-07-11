import 'package:flutter/material.dart';

class CountryUserData {
  final String country;
  final int users;

  CountryUserData(this.country, this.users);
}

class AudienceData {
  final DateTime date;
  final int users;
  final int pageviews;
  final int sessions;

  AudienceData(this.date, this.users, this.pageviews, this.sessions);
}

class AudienceSummary {
  final String value;
  final String label;
  final Color Function()? valueColor;

  AudienceSummary({required this.value, required this.label, this.valueColor});
}

class GoldChartData {
  final int x;
  final double y;

  GoldChartData(this.x, this.y);
}

class MiniMetricData {
  final String title;
  final String value;
  final String prevLabel;
  final double change;
  final List<GoldChartData> trend;
  final Color Function() color;

  MiniMetricData({
    required this.title,
    required this.value,
    required this.prevLabel,
    required this.change,
    required this.trend,
    required this.color,
  });

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
      (i) => GoldChartData(i, rawTrend[i]),
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

class UserModel {
  final String avatarUrl;
  final String fullName;
  final String email;
  final String username;
  final String status;
  final String role;
  final DateTime joinedDate;
  final DateTime lastActive;
  final String plan;

  const UserModel({
    required this.avatarUrl,
    required this.fullName,
    required this.email,
    required this.username,
    required this.status,
    required this.role,
    required this.joinedDate,
    required this.lastActive,
    required this.plan,
  });
}

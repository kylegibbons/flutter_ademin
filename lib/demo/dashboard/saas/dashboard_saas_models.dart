// Conversion funnel data model

import 'package:flutter/material.dart';

class FunnelData {
  final String month;
  final double impressions;
  final double sessions;
  final double downloads;
  final double newUsers;

  FunnelData({
    required this.month,
    required this.impressions,
    required this.sessions,
    required this.downloads,
    required this.newUsers,
  });
}

// product performance data model

enum TrendType { increase, decrease }

class SalesData {
  final String day;
  final double value;

  SalesData(this.day, this.value);
}

// Recent Invoices data model

class Order {
  Order(
    this.id,
    this.date,
    this.status,
    this.customer,
    this.purchased,
    this.revenue,
    this.avatar,
  );
  final String id;
  final String date;
  final String status;
  final String customer;
  final String purchased;
  final double revenue;
  final String avatar;
}

// activities data model

class Activity {
  final String title;
  final String description;
  final DateTime time;
  final IconData icon;
  final Color color;

  Activity({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}

import 'package:flutter/material.dart';

// revenue chart data model

class RevenueChartData {
  final String month;
  final double revenue;
  final double conversionRate;

  RevenueChartData({
    required this.month,
    required this.revenue,
    required this.conversionRate,
  });
}

// revenue summary data model

class RevenueSummary {
  final String value;
  final String label;
  final Color? valueColor;

  RevenueSummary({required this.value, required this.label, this.valueColor});
}

// top product revenue & conversion rate data model

class ProductData {
  final String name;
  final double revenue;
  final double conversionRate;

  ProductData({
    required this.name,
    required this.revenue,
    required this.conversionRate,
  });
}

// Order data models

class Order {
  final String orderId;
  final String customerName;
  final String customerImage;
  final String product;
  final double amount;
  final String vendor;
  final String status;
  final double rating;
  final int votes;

  Order({
    required this.orderId,
    required this.customerName,
    required this.customerImage,
    required this.product,
    required this.amount,
    required this.vendor,
    required this.status,
    required this.rating,
    required this.votes,
  });
}

// revenue by states data models

class StateRevenue {
  final String state;
  final double revenue;

  StateRevenue(this.state, this.revenue);
}

// visit by source data models

class VisitSourceData {
  final String source;
  final double percentage;
  final Color color;

  VisitSourceData(this.source, this.percentage, this.color);
}

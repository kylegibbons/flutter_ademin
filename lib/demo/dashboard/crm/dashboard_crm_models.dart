import 'package:flutter/material.dart';

// contact map data model
class ProvinceContactData {
  final String province;
  final int contacts;

  ProvinceContactData(this.province, this.contacts);
}

// sales by region

class RegionSales {
  final String region;
  final double amount;
  final Color color;

  RegionSales({
    required this.region,
    required this.amount,
    required this.color,
  });
}

// Sales by lead sources data model

class LeadSourceSales {
  final String source;
  final int amount;
  final Color color;

  LeadSourceSales({
    required this.source,
    required this.amount,
    required this.color,
  });
}

// Quarterly Sales model

class QuarterlySales {
  final String quarter;
  final int sales;
  final int target;
  final Color color;

  QuarterlySales({
    required this.quarter,
    required this.sales,
    required this.target,
    required this.color,
  });
}

// won & lost deals

class DealTrend {
  final String month;
  final double wonAmount;
  final double lostAmount;
  final double forecastWon;
  final double forecastLost;

  DealTrend({
    required this.month,
    required this.wonAmount,
    required this.lostAmount,
    required this.forecastWon,
    required this.forecastLost,
  });
}

// sales stage data model

class SalesStageData {
  final String stage;
  final double amount;
  final Color color;

  SalesStageData(this.stage, this.amount, this.color);
}

// activity data model

class ActivityData {
  final String month;
  final int call;
  final int email;
  final int event;
  final int meeting;
  final int todo;
  final int callForecast;
  final int emailForecast;
  final int eventForecast;
  final int meetingForecast;
  final int todoForecast;

  ActivityData({
    required this.month,
    required this.call,
    required this.email,
    required this.event,
    required this.meeting,
    required this.todo,
    required this.callForecast,
    required this.emailForecast,
    required this.eventForecast,
    required this.meetingForecast,
    required this.todoForecast,
  });
}

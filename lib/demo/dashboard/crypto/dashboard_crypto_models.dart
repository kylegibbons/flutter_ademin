import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// my portofolio crypto data model

class CryptoData {
  final String name;
  final String symbol;
  final double amount;
  final double value;
  final Color color;
  final FaIconData icon;
  bool? isProfit;

  CryptoData({
    required this.name,
    required this.symbol,
    required this.amount,
    required this.value,
    required this.color,
    required this.icon,
    this.isProfit,
  });
}

//  Candle Chart Data Model
class CandleData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData(this.time, this.open, this.high, this.low, this.close);
}

// carousel coin data model

class CoinData {
  final String name;
  final String symbol;
  final double price;
  final double changePercent;
  final Color color;
  final FaIconData icon;
  final List<double> chartData;

  CoinData({
    required this.name,
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.color,
    required this.icon,
    required this.chartData,
  });
}

// market data models (portofolio table)

class MarketData {
  MarketData(
    this.currencyCode,
    this.price,
    this.totalCoin,
    this.totalBalance,
    this.gainLoss,
  );

  final String currencyCode;
  final double price;

  final double totalCoin;
  final double totalBalance;
  final double gainLoss;
}

// market cap data model

class MarketChartData {
  final double x;
  final double y;

  MarketChartData(this.x, this.y);
}

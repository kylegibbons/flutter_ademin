import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TransactionType {
  sent,
  received,
  buy,
  sell,
  swap,
  miningReward,
  stakingReward,
  fee,
}

class CryptoTransaction {
  final DateTime timestamp; // Single field for date and time
  final String currency; // BTC, ETH, etc.
  final String from;
  final String to;
  final String details;
  final String transactionId;
  final TransactionType type;
  final double amount; // in crypto
  final double fiatValue; // equivalent in USD or preferred fiat currency
  final String fiatCurrencySymbol; // e.g., "$"

  CryptoTransaction({
    required this.timestamp,
    required this.currency,
    required this.from,
    required this.to,
    required this.details,
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.fiatValue,
    this.fiatCurrencySymbol = "\$",
  });
}

enum CryptoNetwork { bitcoin, ethereum, tron, bsc, solana }

class WalletAsset {
  final String symbol;
  final String name;
  final IconData icon;
  final Color color;
  final double balance;
  final double fiatBalance;

  const WalletAsset({
    required this.symbol,
    required this.name,
    required this.icon,
    required this.color,
    required this.balance,
    required this.fiatBalance,
  });
}

class WalletAddress {
  final String address;
  final CryptoNetwork network;
  final String qrData;
  final int confirmations;
  final double minimumDeposit;

  const WalletAddress({
    required this.address,
    required this.network,
    required this.qrData,
    required this.confirmations,
    required this.minimumDeposit,
  });
}

class WithdrawRequest {
  final WalletAsset asset;
  final CryptoNetwork network;
  final String recipientAddress;
  final double amount;
  final double fee;

  const WithdrawRequest({
    required this.asset,
    required this.network,
    required this.recipientAddress,
    required this.amount,
    required this.fee,
  });

  double get receiveAmount => amount - fee;
}

// Metrics Data Model
class CryptoBuySellMetric {
  final String title;
  final double value;
  final String unit;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor; // Color for the icon itself

  CryptoBuySellMetric({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
  });
}

// Data Model for Candle Chart
class CandleData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData(this.time, this.open, this.high, this.low, this.close);
}

// market table data model
class MarketData {
  MarketData(
    this.currencyCode,
    this.price,
    this.pairs,
    this.high24,
    this.low24,
    this.marketVolume,
    this.volumePercentage,
  );

  final String currencyCode;
  final double price;
  final String pairs;
  final double high24;
  final double low24;
  final double marketVolume;
  final double volumePercentage;
}

// My portofolio stats data model

class PortfolioStats {
  final DateTime date;
  final double value;
  PortfolioStats(this.date, this.value);
}

// watchlist coin data model

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

// Portfolio Item model data

class PortfolioItem {
  final String currencyCode;
  final double quantity;
  final double averagePrice;
  final double currentValue;
  final double returns;

  PortfolioItem({
    required this.currencyCode,
    required this.quantity,
    required this.averagePrice,
    required this.currentValue,
  }) : returns = (currentValue - (quantity * averagePrice));

  double get returnsPercentage {
    final invested = quantity * averagePrice;
    if (invested == 0) return 0;
    return (returns / invested) * 100;
  }
}

// Recent transaction data model

class TransactionItem {
  final String currencyCode;
  final String date;
  final double amount;

  TransactionItem({
    required this.currencyCode,
    required this.date,
    required this.amount,
  });
}

// curency meta model

class CurrencyMeta {
  final String name;
  final FaIconData icon;
  final Color color;

  CurrencyMeta(this.name, this.icon, this.color);
}

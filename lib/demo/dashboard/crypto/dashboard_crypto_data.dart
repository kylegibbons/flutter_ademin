import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/dashboard/crypto/dashboard_crypto_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/metric_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<CryptoData> cryptoList = [
  CryptoData(
    name: 'Bitcoin',
    symbol: 'BTC',
    amount: 0.00584875,
    value: 21405.12,
    color: kWarningColor,
    icon: FontAwesomeIcons.bitcoin,
    isProfit: true,
  ),
  CryptoData(
    name: 'Ethereum',
    symbol: 'ETH',
    amount: 2.25842108,
    value: 39552.18,
    color: kInfoColor,
    icon: FontAwesomeIcons.ethereum,
    isProfit: false,
  ),
  CryptoData(
    name: 'Litecoin',
    symbol: 'LTC',
    amount: 10.58963217,
    value: 17324.58,
    color: kPrimaryColor,
    icon: FontAwesomeIcons.litecoinSign,
    isProfit: false,
  ),
  CryptoData(
    name: 'Dash',
    symbol: 'DASH',
    amount: 204.28565885,
    value: 28635.80,
    color: kSuccessColor,
    icon: FontAwesomeIcons.dashcube,
    isProfit: true,
  ),
];

final List<IconicMetricData> cryptoMetrics = [
  IconicMetricData(
    title: 'Total Invested',
    icon: Icons.attach_money,
    value: 2390.68,
    change: 0.0624,
    isGain: true,
  ),
  IconicMetricData(
    title: 'Total Change',
    icon: Icons.trending_up,
    value: 19523.25,
    change: 0.0367,
    isGain: true,
  ),
  IconicMetricData(
    title: 'Day Change',
    icon: Icons.trending_down,
    value: 14799.44,
    change: -0.0480,
    isGain: false,
  ),
];

// Mockup Data for Candle Chart (simulated Bitcoin data)
List<CandleData> mockCandleData = generateMockCandleData(
  60,
); // Generate 60 data points

List<CandleData> generateMockCandleData(int count) {
  List<CandleData> data = [];
  DateTime currentTime = DateTime.now().subtract(Duration(minutes: count));
  Random random = Random();
  double initialPrice = 6600.0; // Base price for simulation

  for (int i = 0; i < count; i++) {
    double open = initialPrice + (random.nextDouble() - 0.5) * 20;
    double close = open + (random.nextDouble() - 0.5) * 40;
    double high = max(open, close) + random.nextDouble() * 10;
    double low = min(open, close) - random.nextDouble() * 10;

    data.add(CandleData(currentTime, open, high, low, close));
    currentTime = currentTime.add(Duration(minutes: 10)); // 10 minute intervals
    initialPrice = close; // Next candle starts near the previous close
  }
  return data;
}

// carousel coin data mockup

final List<CoinData> coins = [
  CoinData(
    name: 'Monero',
    symbol: 'XMR',
    price: 226.55,
    changePercent: -1.92,
    color: kWarningColor,
    icon: FontAwesomeIcons.monero, // Replace with appropriate icon
    chartData: [220, 225, 223, 226, 222, 224, 226],
  ),
  CoinData(
    name: 'Dash',
    symbol: 'DASH',
    price: 142.5,
    changePercent: 16.38,
    color: kInfoColor,
    icon: FontAwesomeIcons.dharmachakra, // Replace with appropriate icon
    chartData: [135, 140, 138, 142, 145, 144, 142],
  ),
  CoinData(
    name: 'Maker',
    symbol: 'MKR',
    price: 2390.75,
    changePercent: 0.36,
    color: kPrimaryColor,
    icon: FontAwesomeIcons.m, // Replace with appropriate icon
    chartData: [2300, 2320, 2340, 2380, 2395, 2385, 2390],
  ),
  CoinData(
    name: 'Litecoin',
    symbol: 'LTC',
    price: 75.12,
    changePercent: 2.15,
    color: Colors.blueGrey.shade400,
    icon: FontAwesomeIcons.litecoinSign, // Replace with appropriate icon
    chartData: [73, 74, 75, 74, 76, 75, 75],
  ),
  CoinData(
    name: 'Cardano',
    symbol: 'ADA',
    price: 0.45,
    changePercent: -0.80,
    color: Colors.blueAccent,
    icon: FontAwesomeIcons.a, // Replace with appropriate icon
    chartData: [0.46, 0.45, 0.46, 0.45, 0.44, 0.45, 0.45],
  ),
  CoinData(
    name: 'Solana',
    symbol: 'SOL',
    price: 150.30,
    changePercent: 5.75,
    color: Colors.purple.shade400,
    icon: FontAwesomeIcons.s, // Replace with appropriate icon
    chartData: [140, 145, 148, 152, 155, 153, 150],
  ),
  CoinData(
    name: 'Polkadot',
    symbol: 'DOT',
    price: 7.80,
    changePercent: 1.10,
    color: Colors.pink,
    icon: FontAwesomeIcons.d, // Replace with appropriate icon
    chartData: [7.70, 7.75, 7.85, 7.90, 7.80, 7.78, 7.80],
  ),
  CoinData(
    name: 'Chainlink',
    symbol: 'LINK',
    price: 18.25,
    changePercent: -0.55,
    color: Colors.indigo.shade500,
    icon: FontAwesomeIcons.link, // Replace with appropriate icon
    chartData: [18.50, 18.30, 18.40, 18.20, 18.10, 18.25, 18.25],
  ),
  CoinData(
    name: 'Cosmos',
    symbol: 'ATOM',
    price: 9.90,
    changePercent: 3.20,
    color: Colors.lightBlue,
    icon: FontAwesomeIcons.atom, // Replace with appropriate icon
    chartData: [9.50, 9.60, 9.75, 9.80, 10.00, 9.95, 9.90],
  ),
  CoinData(
    name: 'Tether',
    symbol: 'USDT',
    price: 19.19,
    changePercent: 6.20,
    color: Colors.redAccent,
    icon: FontAwesomeIcons.t, // Replace with appropriate icon
    chartData: [9.50, 6.60, 9.75, 9.80, 10.00, 9.95, 9.90],
  ),
];

// market data mockup (portofolio table)

List<MarketData> generateMockMarketData() {
  return <MarketData>[
    MarketData('BTC', 60712.45, 1.25634801, 762478.98, 2.35),
    MarketData('ETH', 3364.77, 2.85472161, 96017.88, -1.18),
    MarketData('LTC', 73.84, 1.45612347, 107.53, 0.92),
    MarketData('XMR', 148.56, 0.35734601, 53.09, 1.45),
    MarketData('SOL', 183.12, 3.62912570, 664.83, -0.85),
    MarketData('ANT', 6.81, 1.85412740, 12.63, 4.78),
    MarketData('FIL', 5.12, 1.87732061, 9.61, -0.57),
    MarketData('AAVE', 88.26, 0.95632087, 84.39, 3.11),
    MarketData('ADA', 0.4532, 1283.2, 581.67, 0.64),
    MarketData('DOGE', 0.1293, 3500.0, 452.55, -2.03),
  ];
}

// coin market cap data mockup

final mockCoinMarketCapData = [
  MarketChartData(0, 20),
  MarketChartData(1, 34),
  MarketChartData(2, 45),
  MarketChartData(3, 124),
  MarketChartData(4, 167),
  MarketChartData(5, 238),
  MarketChartData(6, 238.73),
  MarketChartData(7, 245),
  MarketChartData(8, 255),
  MarketChartData(9, 260),
  MarketChartData(10, 252),
  MarketChartData(11, 278),
  MarketChartData(12, 248),
  MarketChartData(13, 250),
  MarketChartData(14, 240),
  MarketChartData(15, 235),
  MarketChartData(16, 220),
  MarketChartData(17, 180),
  MarketChartData(18, 150),
  MarketChartData(19, 160),
  MarketChartData(20, 170),
  MarketChartData(21, 100),
  MarketChartData(22, 110),
  MarketChartData(23, 120),
  MarketChartData(24, 150),
  MarketChartData(25, 130),
  MarketChartData(26, 140),
  MarketChartData(27, 135),
  MarketChartData(28, 130),
  MarketChartData(29, 120),
  MarketChartData(30, 110),
  MarketChartData(31, 100),
  MarketChartData(32, 90),
  MarketChartData(33, 80),
  MarketChartData(34, 70),
  MarketChartData(35, 60),
  MarketChartData(36, 50),
  MarketChartData(37, 45),
  MarketChartData(38, 40),
  MarketChartData(39, 35),
  MarketChartData(40, 30),
  MarketChartData(41, 25),
  MarketChartData(42, 20),
  MarketChartData(43, 15),
  MarketChartData(44, 10),
  MarketChartData(45, 5),
  MarketChartData(46, 2),
  MarketChartData(47, 1),
  MarketChartData(48, 0),
];

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<Map<String, dynamic>> cryptoStats = [
  {
    'name': 'Bitcoin',
    'symbol': 'BTC',
    'amount': '\$21,593',
    'subAmount': '.15k',
    'icon': FontAwesomeIcons.bitcoinSign,
  },
  {
    'name': 'Ethereum',
    'symbol': 'ETH',
    'amount': '\$19,913',
    'subAmount': '.29k',
    'icon': FontAwesomeIcons.ethereum,
  },
  {
    'name': 'Monero',
    'symbol': 'XMR',
    'amount': '\$17,187',
    'subAmount': '.19k',
    'icon': FontAwesomeIcons.monero,
  },
  {
    'name': 'Litecoin',
    'symbol': 'LTC',
    'amount': '\$12,765',
    'subAmount': '.75k',
    'icon': FontAwesomeIcons.litecoinSign,
  },
];

final List<CryptoTransaction> mockTransactions = [
  // 1. Bitcoin Sent
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 8, 10, 30, 15),
    currency: 'BTC',
    from: 'bc1qxyzabc123',
    to: '1P5QGef2DMPTf',
    details: 'Sent Bitcoin to cold storage',
    transactionId: '0xabc123def4567890abcdef0123456789',
    type: TransactionType.sent,
    amount: 0.05,
    fiatValue: 3500.00,
  ),
  // 2. Ethereum Received
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 7, 14, 05, 45),
    currency: 'ETH',
    from: '0xabcd1234efgh5678',
    to: '0xmywalletaddress',
    details: 'Received Ethereum from exchange',
    transactionId: '0xdef4567890abcdef0123456789abcdef',
    type: TransactionType.received,
    amount: 1.2,
    fiatValue: 4500.00,
  ),
  // 3. USDT Buy
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 6, 9, 15, 0),
    currency: 'USDT',
    from: 'Bank Account',
    to: 'Crypto Exchange',
    details: 'Bought USDT with USD',
    transactionId: 'buytxid9876543210987654321098765432',
    type: TransactionType.buy,
    amount: 1000.00,
    fiatValue: 1000.00,
  ),
  // 4. ADA Sell
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 5, 18, 20, 30),
    currency: 'ADA',
    from: 'My Wallet',
    to: 'Exchange Sell Order',
    details: 'Sold Cardano for USD',
    transactionId: 'selltxid1122334455667788990011223344',
    type: TransactionType.sell,
    amount: 500.00,
    fiatValue: 200.00,
  ),
  // 5. DOT Staking Reward
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 4, 11, 40, 10),
    currency: 'DOT',
    from: 'My Polkadot Wallet',
    to: 'Staking Pool',
    details: 'Polkadot staking reward received',
    transactionId: 'staketx123abccdef1234567890abcdefff',
    type: TransactionType.stakingReward,
    amount: 0.5,
    fiatValue: 3.50,
  ),
  // 6. BNB Swap
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 3, 23, 55, 5),
    currency: 'BNB',
    from: 'My BSC Wallet',
    to: 'Decentralized Exchange',
    details: 'Swapped ETH for BNB',
    transactionId: 'swaptxid7890123456789012345678901234',
    type: TransactionType.swap,
    amount: 2.0,
    fiatValue: 1200.00,
  ),
  // 7. BTC Mining Reward
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 2, 7, 0, 0),
    currency: 'BTC',
    from: 'Mining Pool X',
    to: 'My BTC Wallet',
    details: 'Bitcoin mining reward payout',
    transactionId: 'miningrewardabc123def4567890abcdefg',
    type: TransactionType.miningReward,
    amount: 0.001,
    fiatValue: 70.00,
  ),
  // 8. ETH Fee
  CryptoTransaction(
    timestamp: DateTime(2024, 6, 1, 16, 0, 0),
    currency: 'ETH',
    from: 'My Wallet',
    to: 'Network',
    details: 'Transaction fee for sending ETH',
    transactionId: 'feetxidxyz98765432109876543210987654',
    type: TransactionType.fee,
    amount: 0.0005,
    fiatValue: 1.80,
  ),
  // 9. XRP Sent
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 31, 13, 10, 20),
    currency: 'XRP',
    from: 'rP4eP5QGefi2DMPTf',
    to: 'rA1zP1eP5QGefi2D',
    details: 'Sent XRP to another user',
    transactionId: 'xrp-tx-99887766554433221100aabbccddeeff',
    type: TransactionType.sent,
    amount: 100.0,
    fiatValue: 50.00,
  ),
  // 10. LTC Received
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 30, 17, 30, 0),
    currency: 'LTC',
    from: 'External Wallet',
    to: 'My Wallet',
    details: 'Received Litecoin donation',
    transactionId: 'ltc-tx-abcde1234567890abcdef12345678',
    type: TransactionType.received,
    amount: 5.0,
    fiatValue: 400.00,
  ),
  // 11. SOL Buy
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 29, 10, 0, 0),
    currency: 'SOL',
    from: 'Fiat On-ramp',
    to: 'Solana Wallet',
    details: 'Purchased Solana',
    transactionId: 'solana-buy-001234567890abcdef1234567',
    type: TransactionType.buy,
    amount: 10.0,
    fiatValue: 1500.00,
  ),
  // 12. DOGE Sell
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 28, 20, 45, 10),
    currency: 'DOGE',
    from: 'My Wallet',
    to: 'Exchange',
    details: 'Sold Dogecoin for profit',
    transactionId: 'doge-sell-xyz987654321098765432109876',
    type: TransactionType.sell,
    amount: 5000.0,
    fiatValue: 750.00,
  ),
  // 13. USDC Swap
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 27, 14, 25, 30),
    currency: 'USDC',
    from: 'Decentralized Exchange',
    to: 'My Wallet',
    details: 'Swapped ETH for USDC',
    transactionId: 'usdc-swap-1234567890abcdef123456789',
    type: TransactionType.swap,
    amount: 200.0,
    fiatValue: 200.00,
  ),
  // 14. ADA Staking Reward
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 26, 8, 10, 50),
    currency: 'ADA',
    from: 'Staking Pool B',
    to: 'My Cardano Wallet',
    details: 'Cardano staking reward',
    transactionId: 'ada-stake-reward09876543210987654321',
    type: TransactionType.stakingReward,
    amount: 1.5,
    fiatValue: 0.60,
  ),
  // 15. BTC Sent (internal transfer)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 25, 19, 0, 0),
    currency: 'BTC',
    from: 'My Exchange Account',
    to: 'Another Exchange Account',
    details: 'Internal transfer of BTC',
    transactionId: 'btctransfer777888999000111222333444',
    type: TransactionType.sent,
    amount: 0.1,
    fiatValue: 7000.00,
  ),
  // 16. ETH Received (Airdrop)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 24, 11, 0, 0),
    currency: 'ETH',
    from: 'Smart Contract',
    to: 'My Wallet',
    details: 'Airdrop of new token (ETH equivalent)',
    transactionId: 'airdrop-eth-xx-1234567890abcdef012',
    type: TransactionType.received,
    amount: 0.05,
    fiatValue: 180.00,
  ),
  // 17. BNB Buy (margin)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 23, 9, 30, 0),
    currency: 'BNB',
    from: 'Trading Platform',
    to: 'My Wallet',
    details: 'Bought BNB on margin',
    transactionId: 'bnb-margin-buy-abcdef1234567890123',
    type: TransactionType.buy,
    amount: 0.5,
    fiatValue: 300.00,
  ),
  // 18. XRP Sent (payment)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 22, 15, 0, 0),
    currency: 'XRP',
    from: 'My Wallet',
    to: 'Recipient XRP Address',
    details: 'Payment for services rendered',
    transactionId: 'xrp-payment-002345678901234567890123',
    type: TransactionType.sent,
    amount: 200.0,
    fiatValue: 100.00,
  ),
  // 19. SOL Received (Dapp reward)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 21, 22, 10, 0),
    currency: 'SOL',
    from: 'Gaming Dapp',
    to: 'My Solana Wallet',
    details: 'Received in-game rewards',
    transactionId: 'sol-game-reward-abcdefgfedcba98765',
    type: TransactionType.received,
    amount: 0.1,
    fiatValue: 15.00,
  ),
  // 20. LTC Sent (donation)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 20, 6, 45, 0),
    currency: 'LTC',
    from: 'My Wallet',
    to: 'Charity Address',
    details: 'Donation in Litecoin',
    transactionId: 'ltc-donation-2024abcdef12345678901',
    type: TransactionType.sent,
    amount: 0.2,
    fiatValue: 16.00,
  ),
  // 21. USDT Sell (withdrawal)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 19, 18, 0, 0),
    currency: 'USDT',
    from: 'Exchange',
    to: 'My Bank',
    details: 'Withdrew USDT to fiat',
    transactionId: 'usdt-withdrawal-001234567890abcdef',
    type: TransactionType.sell,
    amount: 500.0,
    fiatValue: 500.00,
  ),
  // 22. DOT Swap
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 18, 12, 0, 0),
    currency: 'DOT',
    from: 'My Wallet',
    to: 'Exchange',
    details: 'Swapped DOT for BTC',
    transactionId: 'dot-btc-swap-abcdef1234567890abcdef',
    type: TransactionType.swap,
    amount: 5.0,
    fiatValue: 35.00,
  ),
  // 23. ETH Staking Reward
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 17, 8, 0, 0),
    currency: 'ETH',
    from: 'Validator Node',
    to: 'My Wallet',
    details: 'Ethereum staking reward distribution',
    transactionId: 'eth-validator-reward1234567890abcdef',
    type: TransactionType.stakingReward,
    amount: 0.002,
    fiatValue: 7.20,
  ),
  // 24. BTC Fee
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 16, 10, 0, 0),
    currency: 'BTC',
    from: 'My Wallet',
    to: 'Network',
    details: 'Network fee for BTC transfer',
    transactionId: 'btc-fee-xxxyyyzzz12345678901234567',
    type: TransactionType.fee,
    amount: 0.00002,
    fiatValue: 1.40,
  ),
  // 25. ADA Received (from friend)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 15, 16, 30, 0),
    currency: 'ADA',
    from: 'External Source',
    to: 'My Wallet',
    details: 'Received ADA from a friend',
    transactionId: 'ada-friend-send-9876543210987654321',
    type: TransactionType.received,
    amount: 50.0,
    fiatValue: 20.00,
  ),
  // 26. DOGE Sent
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 14, 11, 0, 0),
    currency: 'DOGE',
    from: 'My Exchange',
    to: 'Doge Wallet',
    details: 'Sent DOGE to another wallet',
    transactionId: 'doge-send-1234567890abcdef12345678',
    type: TransactionType.sent,
    amount: 1000.0,
    fiatValue: 150.00,
  ),
  // 27. BNB Buy (bank transfer)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 13, 9, 0, 0),
    currency: 'BNB',
    from: 'Fiat Gateway',
    to: 'My Wallet',
    details: 'Bought BNB via bank transfer',
    transactionId: 'bnb-buy-bank-abcdef1234567890abcdef',
    type: TransactionType.buy,
    amount: 1.0,
    fiatValue: 600.00,
  ),
  // 28. XRP Sell (partial)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 12, 17, 0, 0),
    currency: 'XRP',
    from: 'My Wallet',
    to: 'Exchange',
    details: 'Sold some XRP for fiat',
    transactionId: 'xrp-partial-sell-9876543210987654321',
    type: TransactionType.sell,
    amount: 50.0,
    fiatValue: 25.00,
  ),
  // 29. USDC Sent (lending)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 11, 13, 0, 0),
    currency: 'USDC',
    from: 'My Wallet',
    to: 'Lending Protocol',
    details: 'Deposited USDC for yield',
    transactionId: 'usdc-deposit-lend-1234567890abcdef',
    type: TransactionType.sent,
    amount: 500.0,
    fiatValue: 500.00,
  ),
  // 30. SOL Staking Reward (claim)
  CryptoTransaction(
    timestamp: DateTime(2024, 5, 10, 10, 0, 0),
    currency: 'SOL',
    from: 'Staking Platform',
    to: 'My Wallet',
    details: 'Received staking rewards for SOL',
    transactionId: 'sol-staking-claim-abcdef1234567890',
    type: TransactionType.stakingReward,
    amount: 0.05,
    fiatValue: 7.50,
  ),
];

final List<WalletAsset> mockAssets = [
  WalletAsset(
    symbol: 'BTC',
    name: 'Bitcoin',
    icon: Icons.currency_bitcoin,
    color: Colors.orange,
    balance: 0.5234,
    fiatBalance: 32150,
  ),
  WalletAsset(
    symbol: 'ETH',
    name: 'Ethereum',
    icon: Icons.token,
    color: Colors.deepPurple,
    balance: 12.45,
    fiatBalance: 28450,
  ),
  WalletAsset(
    symbol: 'USDT',
    name: 'Tether',
    icon: Icons.attach_money,
    color: Colors.green,
    balance: 15000,
    fiatBalance: 15000,
  ),
  WalletAsset(
    symbol: 'SOL',
    name: 'Solana',
    icon: Icons.bolt,
    color: Colors.purpleAccent,
    balance: 85.3,
    fiatBalance: 12500,
  ),
];

const WalletAddress mockWalletAddress = WalletAddress(
  address: 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
  network: CryptoNetwork.bitcoin,
  qrData: 'bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
  confirmations: 1,
  minimumDeposit: 0.0001,
);

// Metrics Data
List<CryptoBuySellMetric> mockBuySellMetricData = [
  CryptoBuySellMetric(
    title: 'Total Buy',
    value: 233.12,
    unit: 'k',
    icon: Icons.paid_outlined,
    iconBackgroundColor: kErrorColor.withValues(alpha: 0.2),
    iconColor: kErrorColor,
  ),
  CryptoBuySellMetric(
    title: 'Total Sell',
    value: 678.14,
    unit: 'k',
    icon: Icons.attach_money_outlined,
    iconBackgroundColor: kWarningColor.withValues(alpha: 0.2),
    iconColor: kWarningColor,
  ),
  CryptoBuySellMetric(
    title: 'Today\'s Buy',
    value: 124.85,
    unit: 'k',
    icon: Icons.arrow_downward,
    iconBackgroundColor: kSuccessColor.withValues(alpha: 0.2),
    iconColor: kSuccessColor,
  ),
  CryptoBuySellMetric(
    title: 'Today\'s Sell',
    value: 97.35,
    unit: 'k',
    icon: Icons.arrow_upward_outlined,
    iconBackgroundColor: kInfoColor.withValues(alpha: 0.2),
    iconColor: kInfoColor,
  ),
];

// 5. Mockup Data for Candle Chart (simulated Bitcoin data)
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
    currentTime = currentTime.add(
      const Duration(minutes: 10),
    ); // 10 minute intervals
    initialPrice = close; // Next candle starts near the previous close
  }
  return data;
}

// market data table
List<MarketData> marketTableData() {
  return <MarketData>[
    MarketData('BTC', 47071.60, 'BTC/USD', 28722.76, 68789.63, 888411910, 1.50),
    MarketData('ETH', 3813.14, 'ETH/USDT', 4036.24, 3588.14, 314520675, -0.42),
    MarketData('LTC', 149.85, 'LTC/USDT', 412.96, 104.33, 314520675, 0.89),
    MarketData('XMR', 174.91, 'XRM/USDT', 31578.35, 8691.75, 9847327, 1.92),
    MarketData('SOL', 172.93, 'SOL/USD', 178.37, 172.3, 40559274, 2.87),
    MarketData('ANT', 13.31, 'ANT/USD', 13.85, 12.53, 156209195.18, 3.96),
    MarketData('FIL', 35.21, 'FIL/USDT', 36.41, 35.03, 374618945.51, -0.84),
    MarketData('AAVE', 275.47, 'AAVE/USDT', 277.11, 255.01, 156209195.18, 8.20),
    MarketData('ADA', 0.75, 'ADA/USD', 0.80, 0.70, 789123456, 2.15),
    MarketData('DOGE', 0.15, 'DOGE/USDT', 0.16, 0.14, 123456789, -1.10),
    MarketData('XRP', 0.50, 'XRP/USD', 0.52, 0.48, 456789123, 0.75),
    MarketData('DOT', 7.80, 'DOT/USDT', 8.00, 7.50, 987654321, 3.00),
    MarketData('LINK', 14.20, 'LINK/USD', 14.50, 13.90, 654321987, -0.90),
    MarketData('BNB', 600.00, 'BNB/USDT', 610.00, 590.00, 1122334455, 4.00),
    MarketData('LTC', 149.85, 'LTC/USD', 152.00, 148.00, 314520675, 1.20),
    MarketData('UNI', 10.50, 'UNI/USDT', 11.00, 10.00, 234567890, -0.60),
    MarketData('SOL', 172.93, 'SOL/USDT', 175.00, 170.00, 40559274, 1.80),
    MarketData('TRX', 0.10, 'TRX/USD', 0.11, 0.09, 876543210, 2.50),
    MarketData('XLM', 0.25, 'XLM/USDT', 0.26, 0.24, 543210987, -0.30),
    MarketData('VET', 0.05, 'VET/USD', 0.06, 0.04, 987654321, 1.00),
    MarketData('MIOTA', 0.30, 'MIOTA/USDT', 0.31, 0.29, 123456789, -0.70),
    MarketData('EOS', 2.00, 'EOS/USD', 2.10, 1.90, 765432109, 0.40),
    MarketData('NEO', 15.00, 'NEO/USDT', 15.50, 14.50, 210987654, 1.30),
    MarketData('DASH', 50.00, 'DASH/USD', 51.00, 49.00, 321098765, -0.80),
    MarketData('ZEC', 70.00, 'ZEC/USDT', 71.00, 69.00, 432109876, 2.00),
    MarketData('ETC', 30.00, 'ETC/USD', 31.00, 29.00, 543210987, -0.50),
    MarketData('ALGO', 0.20, 'ALGO/USDT', 0.21, 0.19, 654321098, 1.60),
    MarketData('ATOM', 9.00, 'ATOM/USD', 9.20, 8.80, 765432109, -0.95),
    MarketData('XTZ', 1.50, 'XTZ/USDT', 1.55, 1.45, 876543210, 2.20),
    MarketData('VET', 0.04, 'VET/USD', 0.05, 0.03, 987654321, -0.65),
  ];
}

// coint watchlist data

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
];

// mock datas
final List<PortfolioItem> mockPortfolioTable = [
  PortfolioItem(
    currencyCode: 'BTC',
    quantity: 0.25,
    averagePrice: 45000.0,
    currentValue: 68000.0,
  ),
  PortfolioItem(
    currencyCode: 'ETH',
    quantity: 1.5,
    averagePrice: 2800.0,
    currentValue: 3900.0,
  ),
  PortfolioItem(
    currencyCode: 'ADA',
    quantity: 5000.0,
    averagePrice: 0.45,
    currentValue: 0.62,
  ),
  PortfolioItem(
    currencyCode: 'XRP',
    quantity: 10000.0,
    averagePrice: 0.50,
    currentValue: 0.48, // Example of a loss
  ),
  PortfolioItem(
    currencyCode: 'DOT',
    quantity: 50.0,
    averagePrice: 8.0,
    currentValue: 9.5,
  ),
  PortfolioItem(
    currencyCode: 'LTC',
    quantity: 5.0,
    averagePrice: 85.0,
    currentValue: 78.0, // Another example of a loss
  ),
  PortfolioItem(
    currencyCode: 'SOL',
    quantity: 8.0,
    averagePrice: 120.0,
    currentValue: 180.0,
  ),
  PortfolioItem(
    currencyCode: 'USDT',
    quantity: 2000.0,
    averagePrice: 1.00,
    currentValue: 1.00, // Stablecoin, minimal change
  ),
  PortfolioItem(
    currencyCode: 'USDC',
    quantity: 1500.0,
    averagePrice: 1.00,
    currentValue: 1.00, // Stablecoin, minimal change
  ),
  PortfolioItem(
    currencyCode: 'BNB',
    quantity: 0.8,
    averagePrice: 350.0,
    currentValue: 410.0,
  ),
  PortfolioItem(
    currencyCode: 'DOGE',
    quantity: 25000.0,
    averagePrice: 0.12,
    currentValue: 0.15,
  ),
  PortfolioItem(
    currencyCode: 'XMR',
    quantity: 2.0,
    averagePrice: 180.0,
    currentValue: 195.0,
  ),
  PortfolioItem(
    currencyCode: 'ANT',
    quantity: 30.0,
    averagePrice: 5.0,
    currentValue: 4.8,
  ),
  PortfolioItem(
    currencyCode: 'FIL',
    quantity: 10.0,
    averagePrice: 7.5,
    currentValue: 8.2,
  ),
  PortfolioItem(
    currencyCode: 'AAVE',
    quantity: 0.7,
    averagePrice: 90.0,
    currentValue: 98.0,
  ),
  PortfolioItem(
    currencyCode: 'LINK',
    quantity: 6.0,
    averagePrice: 14.0,
    currentValue: 16.5,
  ),
  PortfolioItem(
    currencyCode: 'UNI',
    quantity: 12.0,
    averagePrice: 6.5,
    currentValue: 7.8,
  ),
  PortfolioItem(
    currencyCode: 'TRX',
    quantity: 8000.0,
    averagePrice: 0.08,
    currentValue: 0.085,
  ),
  PortfolioItem(
    currencyCode: 'XLM',
    quantity: 7000.0,
    averagePrice: 0.10,
    currentValue: 0.11,
  ),
  PortfolioItem(
    currencyCode: 'VET',
    quantity: 20000.0,
    averagePrice: 0.025,
    currentValue: 0.028,
  ),
  PortfolioItem(
    currencyCode: 'MIOTA',
    quantity: 500.0,
    averagePrice: 0.35,
    currentValue: 0.33,
  ),
  PortfolioItem(
    currencyCode: 'EOS',
    quantity: 150.0,
    averagePrice: 0.90,
    currentValue: 0.95,
  ),
  PortfolioItem(
    currencyCode: 'NEO',
    quantity: 4.0,
    averagePrice: 15.0,
    currentValue: 16.2,
  ),
  PortfolioItem(
    currencyCode: 'DASH',
    quantity: 1.5,
    averagePrice: 40.0,
    currentValue: 42.0,
  ),
  PortfolioItem(
    currencyCode: 'ZEC',
    quantity: 0.8,
    averagePrice: 60.0,
    currentValue: 65.0,
  ),
  PortfolioItem(
    currencyCode: 'ETC',
    quantity: 3.0,
    averagePrice: 25.0,
    currentValue: 27.5,
  ),
  PortfolioItem(
    currencyCode: 'ALGO',
    quantity: 1000.0,
    averagePrice: 0.22,
    currentValue: 0.25,
  ),
  PortfolioItem(
    currencyCode: 'ATOM',
    quantity: 20.0,
    averagePrice: 11.0,
    currentValue: 12.5,
  ),
  PortfolioItem(
    currencyCode: 'XTZ',
    quantity: 40.0,
    averagePrice: 2.5,
    currentValue: 2.8,
  ),
];

final List<TransactionItem> transactions = [
  TransactionItem(currencyCode: 'BTC', date: 'Today', amount: -122.29),
  TransactionItem(currencyCode: 'ETH', date: 'Yesterday', amount: 764.60),
  TransactionItem(currencyCode: 'XRP', date: '01 Jan, 2025', amount: -336.74),
  TransactionItem(currencyCode: 'DOT', date: '30 Dec, 2024', amount: 1447.20),
  TransactionItem(currencyCode: 'USDT', date: '27 Dec, 2024', amount: 5365.80),
  TransactionItem(currencyCode: 'SOL', date: '24 Dec, 2024', amount: 928.45),
  TransactionItem(currencyCode: 'ADA', date: '21 Dec, 2024', amount: -215.70),
  TransactionItem(currencyCode: 'XMR', date: '18 Dec, 2024', amount: 1840.00),
  TransactionItem(currencyCode: 'BNB', date: '15 Dec, 2024', amount: 672.35),
  TransactionItem(currencyCode: 'DOGE', date: '12 Dec, 2024', amount: -89.50),
  TransactionItem(currencyCode: 'LINK', date: '09 Dec, 2024', amount: 452.15),
  TransactionItem(currencyCode: 'ATOM', date: '06 Dec, 2024', amount: -725.40),
  TransactionItem(currencyCode: 'LTC', date: '03 Dec, 2024', amount: 1299.99),
];

CurrencyMeta getCurrencyMeta(String code) {
  switch (code) {
    case 'BTC':
      return CurrencyMeta('Bitcoin', FontAwesomeIcons.btc, Colors.amber);
    case 'ETH':
      return CurrencyMeta('Ethereum', FontAwesomeIcons.ethereum, kInfoColor);
    case 'ADA':
      return CurrencyMeta('Cardano', FontAwesomeIcons.coins, kPrimaryColor);
    case 'XRP':
      return CurrencyMeta(
        'Ripple',
        FontAwesomeIcons.dollarSign,
        Colors.blueGrey,
      );
    case 'DOT':
      return CurrencyMeta('Polkadot', FontAwesomeIcons.circleDot, kErrorColor);
    case 'LTC':
      return CurrencyMeta(
        'Litecoin',
        FontAwesomeIcons.litecoinSign,
        Colors.blueGrey.shade400,
      );
    case 'SOL':
      return CurrencyMeta(
        'Solana',
        FontAwesomeIcons.solidStar,
        Colors.deepPurple,
      );
    case 'USDT':
      return CurrencyMeta(
        'Tether USD',
        FontAwesomeIcons.dollarSign,
        kSuccessColor,
      );
    case 'USDC':
      return CurrencyMeta(
        'USD Coin',
        FontAwesomeIcons.dollarSign,
        kSuccessColor,
      );
    case 'BNB':
      return CurrencyMeta('Binance Coin', FontAwesomeIcons.b, kSecondaryColor);
    case 'DOGE':
      return CurrencyMeta('Dogecoin', FontAwesomeIcons.dog, Colors.orange);
    case 'XMR':
      return CurrencyMeta(
        'Monero',
        FontAwesomeIcons.monero,
        Colors.orangeAccent,
      );
    case 'ANT':
      return CurrencyMeta('Aragon', FontAwesomeIcons.spider, kPrimaryColor);
    case 'FIL':
      return CurrencyMeta('Filecoin', FontAwesomeIcons.file, Colors.blueGrey);
    case 'AAVE':
      return CurrencyMeta('Aave', FontAwesomeIcons.a, Colors.deepPurpleAccent);
    case 'LINK':
      return CurrencyMeta(
        'Chainlink',
        FontAwesomeIcons.link,
        Colors.blueAccent,
      );
    case 'UNI':
      return CurrencyMeta(
        'Uniswap',
        FontAwesomeIcons.retweet,
        Colors.pinkAccent,
      );
    case 'TRX':
      return CurrencyMeta(
        'TRON',
        FontAwesomeIcons.atom,
        kErrorColor.withValues(alpha: 0.5),
      );
    case 'XLM':
      return CurrencyMeta(
        'Stellar',
        FontAwesomeIcons.star,
        Colors.lightBlueAccent,
      );
    case 'VET':
      return CurrencyMeta('VeChain', FontAwesomeIcons.v, Colors.lightGreen);
    case 'MIOTA':
      return CurrencyMeta('IOTA', FontAwesomeIcons.i, Colors.grey);
    case 'EOS':
      return CurrencyMeta('EOS', FontAwesomeIcons.e, Colors.black);
    case 'NEO':
      return CurrencyMeta('Neo', FontAwesomeIcons.n, Colors.lightGreenAccent);
    case 'DASH':
      return CurrencyMeta('Dash', FontAwesomeIcons.dharmachakra, Colors.cyan);
    case 'ZEC':
      return CurrencyMeta('Zcash', FontAwesomeIcons.z, Colors.brown);
    case 'ETC':
      return CurrencyMeta(
        'Ethereum Classic',
        FontAwesomeIcons.ethereum,
        Colors.teal,
      );
    case 'ALGO':
      return CurrencyMeta('Algorand', FontAwesomeIcons.a, Colors.orangeAccent);
    case 'ATOM':
      return CurrencyMeta('Cosmos', FontAwesomeIcons.atom, Colors.deepOrange);
    case 'XTZ':
      return CurrencyMeta('Tezos', FontAwesomeIcons.x, Colors.lightBlue);
    default:
      return CurrencyMeta('Unknown', FontAwesomeIcons.coins, kSuccessColor);
  }
}

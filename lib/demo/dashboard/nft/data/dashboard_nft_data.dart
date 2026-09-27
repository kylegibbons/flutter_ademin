import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_dasboard/ai_action_card.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';

class DummyAiInsights {
  static AIInsight getNFTFloorPriceInsight() {
    return AIInsight(
      id: 'ins-001',
      title: 'Collection floor price dropped 32% this week',
      summary:
          'A sharp decrease in secondary market trading volume and whale wallet sell-offs caused a significant drop in floor prices.',
      severity: AIInsightSeverity.critical,
      category: AIInsightCategory.nft,
      status: AIInsightStatus.unread,
      generatedAt: DateTime.now().subtract(const Duration(minutes: 25)),
      confidence: const AIConfidence(level: AIConfidenceLevel.high, score: 94),
      impact: const AIImpact(
        level: AIImpactLevel.high,
        title: 'High',
        description:
            'Estimated unrealized portfolio valuation loss of approximately 45.2 ETH across listed assets.',
      ),
      why: const AIWhy(
        title: 'Why?',
        reasons: [
          "High ratio of active listings compared to daily bids",
          "Sudden liquidity crunch in secondary marketplace",
          "Whale wallet offloaded 15 items in 24 hours",
        ],
      ),
      actions: const [
        AIAction(
          id: 'act-001',
          label: 'View Collection',
          type: AIActionType.secondary,
        ),
        AIAction(
          id: 'act-002',
          label: 'Adjust Listing Strategy',
          type: AIActionType.primary,
        ),
      ],
      tags: ['nft', 'marketplace', 'floorprice'],
    );
  }
}

// dummy ai action for NFT dashboard

class DummyAIActionData {
  static List<RecommendedAction> get aiActions => [
    RecommendedAction(
      title: 'Adjust floor price listings',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Adjust floor price listings');
      },
    ),
    RecommendedAction(
      title: 'Sweep rare trait items',
      priority: ActionPriority.high,
      onExecute: () {
        debugPrint('Executing: Sweep rare trait items');
      },
    ),
    RecommendedAction(
      title: 'Launch community AMA session',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Launch community AMA session');
      },
    ),
    RecommendedAction(
      title: 'Review weekly mint volume',
      priority: ActionPriority.medium,
      onExecute: () {
        debugPrint('Executing: Review weekly mint volume');
      },
    ),
  ];
}

// trending nft data mockup
final now = DateTime.now();

final List<NftItem> nftItems = [
  NftItem(
    image: 'assets/images/shark_netify_planes.png',
    title: 'Shark Netify Planes',
    ownerName: 'Lobit',
    ownerAvatar: 'assets/images/avatar_1.jpg',
    bid: '73.320 ETH',
    endTime: now.add(const Duration(hours: 8, minutes: 10)),
  ),
  NftItem(
    image: 'assets/images/ape_genesis.png',
    title: 'Robo Ape Genesis',
    ownerName: 'ByteBender',
    ownerAvatar: 'assets/images/avatar_2.jpg',
    bid: '5.12 ETH',
    endTime: now.add(const Duration(hours: 2, minutes: 21)),
  ),
  NftItem(
    image: 'assets/images/abstract_dream.png',
    title: 'Abstract Dreamscape',
    ownerName: 'ArtisanX',
    ownerAvatar: 'assets/images/avatar_3.jpg',
    bid: '12.8 ETH',
    endTime: now.add(const Duration(hours: 1, minutes: 45)),
  ),
  NftItem(
    image: 'assets/images/cyber_cat.png',
    title: 'Cyberpunk Cat',
    ownerName: 'KittyCode',
    ownerAvatar: 'assets/images/avatar_4.jpg',
    bid: '8.05 ETH',
    endTime: now.add(const Duration(hours: 8, minutes: 56)),
  ),
  NftItem(
    image: 'assets/images/dragon_spirit.png',
    title: 'Dragon Spirit',
    ownerName: 'MythicMind',
    ownerAvatar: 'assets/images/avatar_5.jpg',
    bid: '25.6 ETH',
    endTime: now.add(const Duration(hours: 4, minutes: 39)),
  ),
  NftItem(
    image: 'assets/images/cosmic_flower.png',
    title: 'Cosmic Bloom',
    ownerName: 'StellarGardener',
    ownerAvatar: 'assets/images/avatar_6.jpg',
    bid: '3.99 ETH',
    endTime: now.add(const Duration(hours: 9, minutes: 45)),
  ),
  NftItem(
    image: 'assets/images/geometric_lion.png',
    title: 'Geometric Lion',
    ownerName: 'GeoPrints',
    ownerAvatar: 'assets/images/avatar_7.jpg',
    bid: '18.1 ETH',
    endTime: now.add(const Duration(hours: 3, minutes: 33)),
  ),
  NftItem(
    image: 'assets/images/ethereal_goddess.png',
    title: 'Ethereal Goddess',
    ownerName: 'Luminary',
    ownerAvatar: 'assets/images/avatar_8.jpg',
    bid: '30.0 ETH',
    endTime: now.add(const Duration(hours: 7, minutes: 21)),
  ),
  NftItem(
    image: 'assets/images/pixel_knight.png',
    title: 'Pixel Knight',
    ownerName: 'RetroRealm',
    ownerAvatar: 'assets/images/avatar_9.jpg',
    bid: '4.75 ETH',
    endTime: now.add(const Duration(hours: 5, minutes: 37)),
  ),
  NftItem(
    image: 'assets/images/ocean_guardian.png',
    title: 'Ocean Guardian',
    ownerName: 'DeepBlue',
    ownerAvatar: 'assets/images/avatar_10.jpg',
    bid: '9.2 ETH',
    endTime: now.add(const Duration(hours: 7, minutes: 21)),
  ),
  NftItem(
    image: 'assets/images/abstract_city.png',
    title: 'Abstract Cityscape',
    ownerName: 'UrbanCanvas',
    ownerAvatar: 'assets/images/avatar_11.jpg',
    bid: '15.5 ETH',
    endTime: now.add(const Duration(hours: 8, minutes: 35)),
  ),
  NftItem(
    image: 'assets/images/future_car.png',
    title: 'Future Ride',
    ownerName: 'VelocityVisions',
    ownerAvatar: 'assets/images/avatar_4.jpg',
    bid: '22.3 ETH',
    endTime: now.add(const Duration(hours: 5, minutes: 38)),
  ),
];

// nft sales data mockup

final List<NftSalesData> nftSales = [
  NftSalesData(DateTime(2025, 8, 1), 12.5),
  NftSalesData(DateTime(2025, 8, 2), 9.8),
  NftSalesData(DateTime(2025, 8, 3), 15.2),
  NftSalesData(DateTime(2025, 8, 4), 7.6),
  NftSalesData(DateTime(2025, 8, 5), 18.9),
  NftSalesData(DateTime(2025, 8, 6), 22.1),
  NftSalesData(DateTime(2025, 8, 7), 13.7),
  NftSalesData(DateTime(2025, 8, 8), 10.5),
  NftSalesData(DateTime(2025, 8, 9), 11.8),
  NftSalesData(DateTime(2025, 8, 10), 16.3),
  NftSalesData(DateTime(2025, 8, 11), 8.1),
  NftSalesData(DateTime(2025, 8, 12), 19.5),
  NftSalesData(DateTime(2025, 8, 13), 20.0),
  NftSalesData(DateTime(2025, 8, 14), 14.2),
  NftSalesData(DateTime(2025, 8, 15), 9.0),
  NftSalesData(DateTime(2025, 8, 16), 12.0),
  NftSalesData(DateTime(2025, 8, 17), 17.5),
  NftSalesData(DateTime(2025, 8, 18), 6.8),
  NftSalesData(DateTime(2025, 8, 19), 21.0),
  NftSalesData(DateTime(2025, 8, 20), 23.5),
  NftSalesData(DateTime(2025, 8, 21), 16.0),
  NftSalesData(DateTime(2025, 8, 22), 11.2),
  NftSalesData(DateTime(2025, 8, 23), 13.0),
  NftSalesData(DateTime(2025, 8, 24), 18.2),
  NftSalesData(DateTime(2025, 8, 25), 7.0),
  NftSalesData(DateTime(2025, 8, 26), 20.5),
  NftSalesData(DateTime(2025, 8, 27), 24.0),
  NftSalesData(DateTime(2025, 8, 28), 15.0),
  NftSalesData(DateTime(2025, 8, 29), 10.0),
  NftSalesData(DateTime(2025, 8, 30), 14.5),
];

// Top NFT Collections by Sales Volume pie chart mockup data

final List<CollectionSales> topCollections = [
  CollectionSales('CryptoPunks', 340.5, const Color(0xFF8E44AD)),
  CollectionSales('Bored Ape', 295.2, kWarningColor),
  CollectionSales('Azuki', 210.7, kInfoColor),
  CollectionSales('Doodles', 180.9, kSuccessColor),
  CollectionSales('CloneX', 140.3, kErrorColor),
];

// Top Bidders data mockup

final List<TopBidder> topBidders = [
  TopBidder(
    avatar: 'assets/images/avatar_1.jpg',
    username: '@ethwhale',
    totalBids: 45,
    totalVolume: 220.5,
    lastBid: DateTime(2025, 8, 5),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_2.jpg',
    username: '@nftcollector',
    totalBids: 33,
    totalVolume: 180.7,
    lastBid: DateTime(2025, 8, 4),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_3.jpg',
    username: '@bidorbuy',
    totalBids: 27,
    totalVolume: 156.3,
    lastBid: DateTime(2025, 8, 3),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_4.jpg',
    username: '@moonbagger',
    totalBids: 19,
    totalVolume: 130.0,
    lastBid: DateTime(2025, 8, 2),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_5.jpg',
    username: '@cryptoknight',
    totalBids: 52,
    totalVolume: 250.1,
    lastBid: DateTime(2025, 8, 5),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_6.jpg',
    username: '@digitaldreamer',
    totalBids: 40,
    totalVolume: 195.8,
    lastBid: DateTime(2025, 8, 4),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_7.jpg',
    username: '@tokenmaster',
    totalBids: 38,
    totalVolume: 170.2,
    lastBid: DateTime(2025, 8, 5),
  ),
  TopBidder(
    avatar: 'assets/images/avatar_8.jpg',
    username: '@artblockchain',
    totalBids: 25,
    totalVolume: 140.9,
    lastBid: DateTime(2025, 8, 3),
  ),
];

// Top Selling Artists Table mockup data

final List<TopArtist> topArtists = [
  TopArtist(
    avatar: 'assets/images/avatar_11.jpg',
    name: 'James Slimons',
    totalSales: 230,
    nftCount: 12,
    averagePrice: 19.2,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_10.jpg',
    name: 'Kenny Jay',
    totalSales: 195,
    nftCount: 10,
    averagePrice: 19.5,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_9.jpg',
    name: 'CryptoKira',
    totalSales: 160,
    nftCount: 8,
    averagePrice: 20.0,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_8.jpg',
    name: 'MetaMike',
    totalSales: 140,
    nftCount: 7,
    averagePrice: 20.0,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_7.jpg',
    name: 'ArtBlocker',
    totalSales: 210,
    nftCount: 11,
    averagePrice: 19.1,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_6.jpg',
    name: 'PixelPete',
    totalSales: 175,
    nftCount: 9,
    averagePrice: 19.4,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_5.jpg',
    name: 'DoodleDapp',
    totalSales: 150,
    nftCount: 8,
    averagePrice: 18.7,
  ),
  TopArtist(
    avatar: 'assets/images/avatar_4.jpg',
    name: 'TokenTitan',
    totalSales: 200,
    nftCount: 10,
    averagePrice: 20.0,
  ),
];

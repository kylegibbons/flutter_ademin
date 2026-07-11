// trending nft slider models

import 'package:flutter/material.dart';

class NftItem {
  final String image;
  final String title;
  final String ownerName;
  final String ownerAvatar;
  final String bid;
  final DateTime endTime;

  NftItem({
    required this.image,
    required this.title,
    required this.ownerName,
    required this.ownerAvatar,
    required this.bid,
    required this.endTime,
  });
}

// nft sales data

class NftSalesData {
  final DateTime date;
  final double salesEth;

  NftSalesData(this.date, this.salesEth);
}

// Top NFT Collections by Sales Volume pie chart data model

class CollectionSales {
  final String name;
  final double volumeEth;
  final Color color;

  CollectionSales(this.name, this.volumeEth, this.color);
}

// Top Bidders data model

class TopBidder {
  final String avatar;
  final String username;
  final int totalBids;
  final double totalVolume;
  final DateTime lastBid;

  TopBidder({
    required this.avatar,
    required this.username,
    required this.totalBids,
    required this.totalVolume,
    required this.lastBid,
  });
}

// Top Selling Artists Table data models

class TopArtist {
  final String avatar;
  final String name;
  final int totalSales;
  final int nftCount;
  final double averagePrice;

  TopArtist({
    required this.avatar,
    required this.name,
    required this.totalSales,
    required this.nftCount,
    required this.averagePrice,
  });
}

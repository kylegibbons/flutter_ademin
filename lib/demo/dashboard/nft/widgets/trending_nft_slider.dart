import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_data.dart';
import 'package:flutter_ademin/demo/dashboard/nft/dashboard_nft_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class TrendingNFTSlider extends StatefulWidget {
  const TrendingNFTSlider({super.key});

  @override
  State<TrendingNFTSlider> createState() => _TrendingNFTSliderState();
}

class _TrendingNFTSliderState extends State<TrendingNFTSlider> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToPrevious() {
    _scrollController.animateTo(
      _scrollController.offset - 240,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollToNext() {
    _scrollController.animateTo(
      _scrollController.offset + 240,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: mediumHeight / 2,
        backgroundColor: themeData.colorScheme.surfaceContainerHighest,
        child: Icon(icon, color: themeData.colorScheme.onSurface),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending NFTs',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: kBodyLarge,
              ),
            ),
            Row(
              children: [
                _buildNavButton(
                  icon: Icons.chevron_left,
                  onPressed: _scrollToPrevious,
                ),
                const SizedBox(width: kDefaultPadding),
                _buildNavButton(
                  icon: Icons.chevron_right,
                  onPressed: _scrollToNext,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        SizedBox(
          height: 345,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: nftItems.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: kDefaultPadding),
              itemBuilder: (context, index) {
                return NftCard(item: nftItems[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class NftCard extends StatefulWidget {
  final NftItem item;

  const NftCard({super.key, required this.item});

  @override
  State<NftCard> createState() => _NftCardState();
}

class _NftCardState extends State<NftCard> {
  late Duration remaining;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.item.endTime.difference(DateTime.now());
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final diff = widget.item.endTime.difference(now);
    if (diff.isNegative) {
      timer.cancel();
      setState(() => remaining = Duration.zero);
    } else {
      setState(() => remaining = diff);
    }
  }

  String formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    final dayStr = days > 0 ? '${days}d ' : '';
    return '$dayStr${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        width: 222,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              child: Image.asset(
                widget.item.image,
                height: 140,
                width: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: kDefaultPadding / 2),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: Text(
                widget.item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: kBodyLarge,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: kDefaultPadding / 4),

            // Owner info
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(widget.item.ownerAvatar),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Text(widget.item.ownerName),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),

            // Bid Info
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kTableHeaderColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Bid',
                          style: TextStyle(fontSize: kBodySmall),
                        ),
                        const SizedBox(height: kDefaultPadding / 4),
                        Text(
                          widget.item.bid,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kBodyMedium,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining Time',
                          style: TextStyle(fontSize: kBodySmall),
                        ),
                        SizedBox(height: kDefaultPadding / 4),
                        Text(
                          formatDuration(remaining),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kBodyMedium,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: FlatButton(
                kText: 'Place a Bid',
                bgColor: kSuccessColor,
                onPressed: () {},
                kTextColor: Colors.white,
                isFullWidth: true,
                isRounded: true,
              ),
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

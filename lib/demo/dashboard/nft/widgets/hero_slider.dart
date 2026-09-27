import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/carousel.dart';

class HeroSlider extends StatelessWidget {
  const HeroSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: themeData.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: ResponsiveWrap(
          breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
          columnRatios: [0.5, 0.5],
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [NftAuctionDetails(), NftAuctionSlider()],
        ),
      ),
    );
  }
}

// NFT Auction Header Slider

class NftAuctionSlider extends StatelessWidget {
  const NftAuctionSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 4,
            spreadRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: CustomCarousel(
        pages: [
          // slider image
          Image.asset('assets/images/nft_hero_1.png', fit: BoxFit.cover),
          Image.asset('assets/images/nft_hero_2.png', fit: BoxFit.cover),
          Image.asset('assets/images/nft_hero_3.png', fit: BoxFit.cover),
        ],
        showControls: true,
        showIndicator: true,
        autoSlideInterval: const Duration(seconds: 3),
        height: mediaQueryData.size.width > kScreenWidthSm ? 320 : (320 * 0.6),
      ),
    );
  }
}

// nft hero auction

class NftAuctionDetails extends StatefulWidget {
  const NftAuctionDetails({super.key});

  @override
  State<NftAuctionDetails> createState() => _NftAuctionDetailsState();
}

class _NftAuctionDetailsState extends State<NftAuctionDetails> {
  late Timer _timer;
  Duration _remaining = const Duration(
    days: 3,
    hours: 11,
    minutes: 21,
    seconds: 2,
  );

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        _timer.cancel();
      } else {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final days = _twoDigits(_remaining.inDays);
    final hours = _twoDigits(_remaining.inHours.remainder(24));
    final minutes = _twoDigits(_remaining.inMinutes.remainder(60));
    final seconds = _twoDigits(_remaining.inSeconds.remainder(60));
    final mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      height: 352,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & ID
          Row(
            children: [
              Text(
                'ShellShocked Turtle Nifty',
                style: TextStyle(
                  fontSize: mediaQueryData.size.width > kScreenWidthSm
                      ? kTitleLarge
                      : kTitleMedium,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: kDefaultPadding / 2),
              Icon(Icons.verified_outlined, color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 4),
          Text(
            'ID : 2520382',
            style: TextStyle(
              fontSize: mediaQueryData.size.width > kScreenWidthSm
                  ? kBodyLarge
                  : kBodyMedium,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          // Profile
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  'assets/images/avatar_3.jpg',
                ), // Ganti dengan gambar kamu
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'James Silanoeyah',
                    style: TextStyle(
                      fontSize: kBodyLarge,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '@james_silanoeyah',
                    style: TextStyle(
                      fontSize: kBodyMedium,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),

          // Bid Info
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Current Bid
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Bid',
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2,
                      ),
                      child: Text(
                        '75,320 ETH',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: mediaQueryData.size.width > kScreenWidthSm
                              ? kTitleLarge
                              : kTitleMedium,
                          color: Colors.white,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 4),
                    Text(
                      '773.69 USD',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: kBodySmall,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                // Remaining Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Remaining Time',
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeBox(label: "DAYS", value: days),
                        const SizedBox(width: 8),
                        _buildTimeBox(label: "HRS", value: hours),
                        const SizedBox(width: 8),
                        _buildTimeBox(label: "MINS", value: minutes),
                        const SizedBox(width: 8),
                        _buildTimeBox(label: "SECS", value: seconds),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),

          // Buttons
          Row(
            children: [
              // favorite button
              InkWell(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: mediumHeight / 2,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.pink : kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(width: kDefaultPadding),

              // place a bid
              Expanded(
                child: FlatButton(
                  kText: 'Place a Bid',
                  kTextColor: Colors.white,
                  bgColor: Colors.pinkAccent,
                  isFullWidth: true,
                  onPressed: () {},
                  isRounded: true,
                ),
              ),

              SizedBox(
                width: mediaQueryData.size.width > kScreenWidthSm
                    ? kDefaultPadding
                    : 0,
              ),

              // view art work
              mediaQueryData.size.width > kScreenWidthSm
                  ? TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View Art Work',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox({required String label, required String value}) {
    final mediaQueryData = MediaQuery.of(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2,
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: mediaQueryData.size.width > kScreenWidthSm
                  ? kTitleLarge
                  : kTitleMedium,
              fontWeight: FontWeight.w600,
              fontFamily: 'Courier',
            ),
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: kBodySmall,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

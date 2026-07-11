import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/animation/animated_icon.dart';
import 'package:flutter_ademin/widgets/animation/animation.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

class CryptoTransactionMetric extends StatelessWidget {
  const CryptoTransactionMetric({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2, kScreenWidthXl: 4},
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
      children: [
        CryptoSummaryCard(
          icon: Icons.work_outline,
          tags: ['BTC', 'ETH', 'USD', 'EUR'],
          amount: '\$71,893',
          subAmount: '.12k',
          type: SummaryType.balance,
        ),
        CryptoSummaryCard(
          icon: Icons.work_outline,
          tags: ['BTC', 'ETH', 'USD', 'EUR'],
          amount: '\$27,178',
          subAmount: '.19k',
          type: SummaryType.send,
        ),
        CryptoSummaryCard(
          icon: Icons.work_outline,
          tags: ['BTC', 'ETH', 'USD', 'EUR'],
          amount: '\$45,978',
          subAmount: '.15k',
          type: SummaryType.receive,
        ),

        // auto slider metric
        AutoSlidingCryptoSummaryCard(),
      ],
    );
  }
}

// crypto summary card

enum SummaryType { balance, send, receive }

class CryptoSummaryCard extends StatelessWidget {
  final IconData icon;
  final List<String> tags;
  final String amount;
  final String subAmount;

  final SummaryType type;
  // final Color? backgroundColor;

  const CryptoSummaryCard({
    super.key,
    required this.icon,
    required this.tags,
    required this.amount,
    required this.subAmount,
    required this.type,
    // this.backgroundColor,
  });

  Color _getTagColor(String tag, BuildContext context) {
    switch (tag.toUpperCase()) {
      case 'BTC':
        return kWarningColor;
      case 'ETH':
        return kInfoColor;
      case 'USD':
        return Theme.of(context).colorScheme.primary;
      case 'EUR':
        return kErrorColor;
      default:
        return Colors.grey.shade300;
    }
  }

  IconData _getIconForType(SummaryType type) {
    switch (type) {
      case SummaryType.balance:
        return Symbols.balance;
      case SummaryType.send:
        return Symbols.send_money;
      case SummaryType.receive:
        return Symbols.approval_delegation;
    }
  }

  String _getLabelForType(SummaryType type) {
    switch (type) {
      case SummaryType.balance:
        return 'Available Balance (USD)';
      case SummaryType.send:
        return 'Send (Previous Month)';
      case SummaryType.receive:
        return 'Receive (Previous Month)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return HoverAnimatedWidget(
      child: Card(
        child: SizedBox(
          height: 154,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // icon
                    CustomAnimatedIcon(
                      symbol: _getIconForType(type),
                      color: kSuccessColor,
                      size: 48,
                      duration: const Duration(seconds: 5),
                      animationType: LoopingAnimationType.scale,
                      weight: 250,
                    ),

                    const Spacer(),

                    // crypto currency tag
                    Wrap(
                      spacing: kDefaultPadding / 4,
                      children: tags
                          .map(
                            (tag) => CustomBadge(
                              kColor: _getTagColor(tag, context),
                              kText: tag,
                              kFontSize: kLabelSmall - 1,
                              isSoft: true,
                              leftBorder: true,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Spacer(),

                // ammount
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: amount,
                        style: TextStyle(
                          fontSize: kHeadlineSmall,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: subAmount,
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),

                // label
                Text(
                  _getLabelForType(type),
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// auto scrolling crypto summary card

class AutoSlidingCryptoSummaryCard extends StatefulWidget {
  const AutoSlidingCryptoSummaryCard({super.key});

  @override
  State<AutoSlidingCryptoSummaryCard> createState() =>
      _AutoSlidingCryptoSummaryCardState();
}

class _AutoSlidingCryptoSummaryCardState
    extends State<AutoSlidingCryptoSummaryCard> {
  final PageController _controller = PageController();
  final Duration _duration = const Duration(seconds: 4);

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_duration, (timer) {
      _currentIndex = (_currentIndex + 1) % cryptoStats.length;
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return HoverAnimatedWidget(
      child: Card(
        child: Container(
          height: 154,
          decoration: BoxDecoration(
            color: kWarningColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: PageView.builder(
              controller: _controller,
              itemCount: cryptoStats.length,
              itemBuilder: (_, index) {
                final item = cryptoStats[index];
                return Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kSuccessColor,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: FaIcon(
                                item['icon'],
                                color: kSuccessColor,
                                size: 18,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${item['name']}  (${item['symbol']})',
                            style: TextStyle(
                              color: themeData.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),

                      // ammount
                      RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: item['amount'],
                              style: TextStyle(
                                fontSize: kHeadlineSmall,
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: item['subAmount'],
                              style: TextStyle(
                                fontSize: kBodyLarge,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Text(
                        'Send - Receive (Previous Month)',
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

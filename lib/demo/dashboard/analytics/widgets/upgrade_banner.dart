// updgrade banner

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:lottie/lottie.dart';

class UpgradeBanner extends StatelessWidget {
  const UpgradeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxWidth < kScreenWidthSm ? 279 : 212,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top warning bar
                    Container(
                      height: cardHeaderHeight,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      decoration: BoxDecoration(
                        color: kWarningColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: kWarningColor.withRed(225),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: Text.rich(
                              style: TextStyle(
                                color: kWarningColor.withRed(225),
                              ),
                              TextSpan(
                                text: 'Your free trial expired in ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: kBodyMedium,
                                ),
                                children: [
                                  TextSpan(
                                    text: '19 days.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // handle upgrade tap
                            },
                            child: Text(
                              'Upgrade',
                              style: TextStyle(
                                color: kWarningColor.withRed(225),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // content
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                      fontSize: kBodyLarge,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Upgrade your plan from a ',
                                      ),
                                      TextSpan(
                                        text: 'Free trial',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(text: ', to ‘Premium Plan’'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Text(
                                  'Enjoy unlimited access, advanced analytics, priority support, and more powerful features tailored for your growing business.',
                                  style: TextStyle(
                                    fontSize: kBodyMedium,
                                    color: kTextColor,
                                  ),

                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          // Right Lottie animation
                          if (mediaQueryData.size.width >
                              (3 / 4 * kScreenWidthSm))
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: DotLottieLoader.fromAsset(
                                "assets/animations/developerskills.lottie",
                                frameBuilder:
                                    (BuildContext ctx, DotLottie? dotlottie) {
                                      if (dotlottie != null) {
                                        return Lottie.memory(
                                          dotlottie.animations.values.single,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                // upgrade button
                PositionedDirectional(
                  start: kDefaultPadding,
                  bottom: kDefaultPadding,
                  child: FlatButton(
                    kText: 'Upgrade Account!',
                    bgColor: kSuccessColor,
                    kTextColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

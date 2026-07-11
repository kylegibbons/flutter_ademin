import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

// nft call to action

class NftCTA extends StatelessWidget {
  const NftCTA({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < kScreenWidthMd;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: 1.5 * kDefaultPadding,
          ),
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            borderRadius: BorderRadius.circular(defaultRadius),
            border: Border(bottom: BorderSide(width: 2, color: kPrimaryColor)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: isMobile
              ? Column(
                  children: [
                    // Text section
                    builtText(themeData, isMobile),
                    SizedBox(height: kDefaultPadding),
                    // Button
                    builtButton(isMobile),
                  ],
                )
              : Row(
                  children: [
                    // Text section
                    Expanded(child: builtText(themeData, isMobile)),

                    // Button
                    builtButton(isMobile),
                  ],
                ),
        );
      },
    );
  }

  // button

  builtButton(bool isMobile) {
    return FlatButton(
      kText: 'Upload Products',
      bgColor: kSuccessColor,
      kTextColor: Colors.white,
      isRounded: true,
      isFullWidth: isMobile ? true : false,
      onPressed: () {},
    );
  }

  // text

  builtText(ThemeData themeData, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Craft your NFTs, and watch sales soar!",
          style: TextStyle(
            fontSize: kBodyLarge,
            fontWeight: FontWeight.w600,
            color: themeData.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: kDefaultPadding / 4),
        Text(
          "Discover, buy, and sell NFTs from premier global artists.",
          style: TextStyle(fontSize: kBodyMedium, color: kTextColor),
        ),
      ],
    );
  }
}

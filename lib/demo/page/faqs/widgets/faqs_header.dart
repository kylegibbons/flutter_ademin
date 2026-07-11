import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

class FaqsHeader extends StatelessWidget {
  const FaqsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

    return Container(
      decoration: BoxDecoration(color: kInfoColor.withValues(alpha: 0.2)),
      padding: EdgeInsets.symmetric(
        vertical: mediaQueryData.size.width > kScreenWidthSm
            ? 3 * kDefaultPadding
            : kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      alignment: Alignment.center,
      child: AdaptiveWrap(
        spacing: kDefaultPadding,
        runSpacing: kDefaultPadding,
        columnRatios: [0.7, 0.3],
        breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2},
        useScreenWidth: true,
        children: [
          // faqs contact
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Looking for help? Here are our most frequently asked questions.',
                style: TextStyle(
                  fontSize: kHeadlineSmall,
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Can't find the answer tou your question? No worries, just reach us.",
                style: TextStyle(fontSize: kBodyLarge),
              ),
              SizedBox(height: 1 * kDefaultPadding),
              Row(
                children: [
                  FancyIconButton(
                    kText: 'Email Us',
                    kTextColor: Colors.white,
                    bgColor: kPrimaryColor,
                    kLeadingIcon: Icons.email_outlined,
                    isRounded: true,
                    onPressed: () {},
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  FancyIconButton(
                    kText: 'Chat with us',
                    kTextColor: Colors.white,
                    bgColor: kInfoColor,
                    kLeadingIcon: Icons.chat_outlined,
                    isRounded: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          // faqs search
          OversizeSearchBar(),
        ],
      ),
    );
  }
}

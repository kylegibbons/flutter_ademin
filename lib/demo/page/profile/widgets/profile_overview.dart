// Overview Content

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_about.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_personal_information.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_popular_post.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_recent_activities.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_social_media.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_suggestion.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_overview_tech_stack.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_projects_slider.dart';

class OverviewContent extends StatelessWidget {
  const OverviewContent({
    super.key,
    required this.mediaQueryData,
    required this.themeData,
  });

  final MediaQueryData mediaQueryData;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - kDefaultPadding;
        return Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.3
                  : constraints.maxWidth * 1,
              child: Column(
                children: [
                  // Technology Stack Card
                  TechStack(),

                  SizedBox(height: kDefaultPadding),

                  // Personal Information Card
                  PersonalInformation(),

                  SizedBox(height: kDefaultPadding),

                  // Social Media Card
                  SocialMedia(),

                  SizedBox(height: kDefaultPadding),

                  // suggestions card
                  FriendSuggestion(),
                  SizedBox(height: kDefaultPadding),

                  // popular post card
                  PopularPost(),
                ],
              ),
            ),
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.7
                  : constraints.maxWidth * 1,
              child: Column(
                children: [
                  // about card
                  AboutCard(),
                  SizedBox(height: kDefaultPadding),

                  // recent activities card
                  RecentActivities(),

                  SizedBox(height: kDefaultPadding),

                  // recent projects card
                  ProjectSlider(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

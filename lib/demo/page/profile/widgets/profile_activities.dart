import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/popup_menu_button.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_user_activity_list.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

class ActivitiesContent extends StatelessWidget {
  const ActivitiesContent({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              kText: 'Activities',
              showDivider: false,
              kWidget: MorePopUpMenu(),
            ),

            // recent activity list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: UserActivityList(acivityCount: 10),
            ),

            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

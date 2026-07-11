import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/profile_user_activity_list.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          CardHeader(
            kText: 'Recent Activities',
            showDivider: false,
            kWidget: MorePopUpMenu(),
          ),

          // recent activity list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: UserActivityList(acivityCount: 5),
          ),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

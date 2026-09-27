// user activity list

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_data.dart';

class UserActivityList extends StatelessWidget {
  const UserActivityList({super.key, required this.acivityCount});

  final int acivityCount;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListView.builder(
      itemCount: acivityCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final activity = activities[index];
        final isLast = index == acivityCount - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : kDefaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(activity.avatarUrl),
              ),
              SizedBox(width: kDefaultPadding),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 4),
                    Text(
                      '${activity.subtitle} - ${activity.time}',
                      style: TextStyle(
                        fontSize: kBodySmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Text(activity.description, style: TextStyle()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';

class ActivitiesWidget extends StatelessWidget {
  final List<Activity> activities;

  const ActivitiesWidget({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            kText: 'Recent Activities',
            kWidget: CustomPopupMenu<String>(
              onSelected: (value) => debugPrint('Selected: $value'),
              items: [
                // details menu
                PopupMenuItemData(
                  value: 'more',
                  text: 'View more',
                  icon: Icons.visibility_outlined,
                ),

                // refresh menu
                PopupMenuItemData(
                  value: 'refresh',
                  text: 'Refresh',
                  icon: Icons.refresh,
                ),
              ],
              // icon button
              icon: Icons.more_vert,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),

            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              final themeData = Theme.of(context);
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: kDefaultPadding / 2,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding / 2,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: activity.color.withValues(alpha: 0.1),
                        child: Icon(
                          activity.icon,
                          color: activity.color,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding / 2),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                            Text(activity.description),
                          ],
                        ),
                      ),

                      const SizedBox(width: kDefaultPadding / 2),
                      Text(DateFormat('HH:mm').format(activity.time)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:intl/intl.dart';

class ProjectDetailActivityTimeline extends StatelessWidget {
  final List<ProjectActivity> activities;
  final Map<String, Member> memberMap; // key = memberId

  const ProjectDetailActivityTimeline({
    super.key,
    required this.activities,
    required this.memberMap,
  });

  @override
  Widget build(BuildContext context) {
    activities.sort(
      (a, b) => b.timestamp.compareTo(a.timestamp),
    ); // Newest first

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        separatorBuilder: (_, _) => SizedBox(height: 2),
        padding: EdgeInsets.all(kDefaultPadding),
        itemBuilder: (context, index) {
          final activity = activities[index];
          final member = memberMap[activity.memberId];
          final iconEntry = getActivityIconAndColor(activity.type);
          final time = DateFormat(
            'MMM d, yyyy - h:mm a',
          ).format(activity.timestamp);
          final themeData = Theme.of(context);

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline indicator
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: member != null
                        ? AssetImage(member.avatarUrl)
                        : null,
                    child: member == null ? Icon(Icons.person_outline) : null,
                  ),
                  SizedBox(height: 2),
                  if (index != activities.length - 1)
                    Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Distributes dashes
                      children: List.generate(
                        12, // Number of dashes
                        (index) => Container(
                          width: 0.8,
                          height: 3, // Height of each dash
                          color: Colors.grey.shade400,
                          margin: EdgeInsets.symmetric(
                            vertical: 2,
                          ), // Space between dashes
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: kDefaultPadding),
              // Content box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.primary.withValues(
                      alpha: 0.04,
                    ),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // time
                      Row(
                        children: [
                          Icon(iconEntry.key, size: 20, color: iconEntry.value),
                          SizedBox(width: kDefaultPadding / 2),
                          Text(time, style: TextStyle(fontSize: kBodySmall)),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Text(
                        activity.description,
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      if (activity.attachmentUrl != null) ...[
                        SizedBox(height: kDefaultPadding / 2),
                        GestureDetector(
                          onTap: () {
                            // handle download or open
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_file_outlined,
                                size: 20,
                                color: kInfoColor,
                              ),
                              SizedBox(width: kDefaultPadding / 2),
                              Expanded(
                                child: Text(
                                  activity.attachmentUrl!.split('/').last,
                                  style: TextStyle(color: kInfoColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  MapEntry<IconData, Color> getActivityIconAndColor(String type) {
    switch (type) {
      case 'comment':
        return MapEntry(Icons.comment_outlined, kInfoColor);
      case 'status_change':
        return MapEntry(Icons.update_outlined, kWarningColor);
      case 'file_upload':
        return MapEntry(Icons.file_upload_outlined, kErrorColor);
      case 'task_assignment':
        return MapEntry(Icons.assignment_ind_outlined, Colors.purple);
      case 'task_update':
        return MapEntry(Icons.edit_outlined, kPrimaryColor);
      case 'task_completion':
        return MapEntry(Icons.check_circle_outline, kSuccessColor);
      default:
        return MapEntry(Icons.info_outline, Colors.grey);
    }
  }
}

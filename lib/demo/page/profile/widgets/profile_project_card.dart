import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';

// project card

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, this.onTap});

  final Project project;
  final VoidCallback? onTap;

  // You can define status-to-color logic here

  Color get statusTextColor => _statusColorSet()['text']!;

  Map<String, Color> _statusColorSet() {
    switch (project.status.toLowerCase()) {
      case 'in progress':
        return {'text': kInfoColor};
      case 'completed':
        return {'text': kSuccessColor};
      case 'pending':
        return {'text': kWarningColor};
      case 'delayed':
        return {'text': kErrorColor};
      case 'testing':
        return {'text': Colors.blueGrey.shade800};
      default:
        return {'text': Colors.black};
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    double avatarSize = 32; // avatar diameter
    double overlap = 8; // how much each avatar overlaps
    final int avatarCount = project.members.length;
    final double totalWidth = avatarCount > 1
        ? avatarSize + (avatarCount - 1) * (avatarSize - overlap)
        : avatarSize;

    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: project.cardColor, width: 3)),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Container(
        width: 280,
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyMedium,
                      color: themeData.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomBadge(
                  kText: project.status,
                  kColor: statusTextColor,
                  isSoft: true,
                ),
              ],
            ),
            SizedBox(height: 8),

            // Last update
            Row(
              children: [
                Text('Last updated: '),
                Text(
                  project.time,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2 * kDefaultPadding),

            //Members
            Row(
              children: [
                Text('Members :'),
                SizedBox(width: kDefaultPadding / 2),
                SizedBox(
                  height: avatarSize,
                  width: totalWidth,
                  child: Stack(
                    children: [
                      ...project.members.asMap().entries.map((entry) {
                        final index = entry.key;
                        final avatar = entry.value;
                        return Positioned(
                          left: index * (avatarSize - overlap),
                          child: CircleAvatar(
                            radius: avatarSize / 2,
                            backgroundImage: AssetImage(avatar),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:intl/intl.dart';

class AttachmentOverview extends StatelessWidget {
  final List<ProjectAttachment> attachments;

  const AttachmentOverview({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final total = attachments.length;
    final latest = attachments.isNotEmpty
        ? attachments
              .map((a) => a.uploadedAt)
              .reduce((a, b) => a.isAfter(b) ? a : b)
        : null;

    final Map<String, int> fileTypeCounts = {};
    for (var attachment in attachments) {
      fileTypeCounts[attachment.fileType] =
          (fileTypeCounts[attachment.fileType] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Files:'),
                Text(
                  total.toString(),
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Last Uploaded:'),
                latest != null
                    ? Text(
                        DateFormat.yMMMd().format(latest),
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        'N/A',
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ],
            ),
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding / 2,
          children: fileTypeCounts.entries.map((e) {
            return Chip(
              label: Text(
                '${e.key.toUpperCase()}: ${e.value}',
                style: TextStyle(
                  color: themeData.colorScheme.primary,
                  fontSize: kBodySmall,
                ),
              ),
              avatar: Icon(
                Icons.insert_drive_file,
                size: 12,
                color: themeData.colorScheme.primary,
              ),
              backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
            );
          }).toList(),
        ),
      ],
    );
  }
}

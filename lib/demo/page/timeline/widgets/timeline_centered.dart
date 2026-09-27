import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/timeline/timeline_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:timeline_list/timeline_list.dart';

class CenteredTimeline extends StatelessWidget {
  final List<TimelineEvent> events;

  const CenteredTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Timeline.builder(
      context: context,
      markerCount: events.length,
      properties: TimelineProperties(
        timelinePosition: TimelinePosition.center,
        iconSize: 56,
        lineColor: Theme.of(context).colorScheme.surface,
      ),
      markerBuilder: (context, index) {
        final event = events[index];
        return Marker(
          child: _buildEventCard(event, context),
          position: index.isEven ? MarkerPosition.right : MarkerPosition.left,
          icon: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.group_outlined, size: 26, color: kSuccessColor),
          ),
        );
      },
    );
  }

  Widget _buildEventCard(TimelineEvent event, context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // profile image
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(event.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // username and time ago
                  Row(
                    children: [
                      Text(
                        event.username,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(' - ${event.timeAgo}'),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // content
                  Text(
                    event.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

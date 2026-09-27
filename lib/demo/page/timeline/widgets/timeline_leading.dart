import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/timeline/timeline_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:timelines_plus/timelines_plus.dart' as timelineplus;

class LeadingTimeline extends StatelessWidget {
  const LeadingTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return timelineplus.FixedTimeline.tileBuilder(
      theme: timelineplus.TimelineThemeData(
        nodePosition: 0,
        indicatorTheme: const timelineplus.IndicatorThemeData(size: 56),
        connectorTheme: const timelineplus.ConnectorThemeData(thickness: 3.0),
      ),
      builder: timelineplus.TimelineTileBuilder.connected(
        itemCount: projectSteps.length,
        contentsBuilder: (context, index) {
          final step = projectSteps[index];
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Due date
                  Container(
                    width: 148,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                      color: step.color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(defaultRadius),
                        bottomLeft: Radius.circular(defaultRadius),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      step.dueDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: kBodyLarge,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: SizedBox(
                      width: 560,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: TextStyle(
                              fontSize: kBodyLarge,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 3),
                          step.isCompleted
                              ? Text(
                                  'Completed at: ${step.date}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                )
                              : const Text('Not Completed'),
                          const SizedBox(height: kDefaultPadding / 2),
                          Text(step.description),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        indicatorBuilder: (context, index) {
          final step = projectSteps[index];
          return timelineplus.DotIndicator(
            color: step.isCompleted ? kSuccessColor : Colors.blueGrey.shade200,
            child: Icon(step.icon, color: Colors.white, size: 26),
          );
        },
        connectorBuilder: (context, index, type) {
          final step = projectSteps[index];
          return SizedBox(
            height: 52,
            child: timelineplus.SolidLineConnector(
              color: step.isCompleted
                  ? kSuccessColor
                  : Colors.blueGrey.shade100,
            ),
          );
        },
      ),
    );
  }
}

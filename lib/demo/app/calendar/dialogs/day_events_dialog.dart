import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:intl/intl.dart';

void showDayEventsDialog(
  BuildContext context, {
  required DateTime selectedDate,
  required List<Meeting> dayMeetings,
  required ValueChanged<Meeting> onEditEvent,
  required ValueChanged<DateTime> onAddEvent,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final themeData = Theme.of(context);
      final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

      return Dialog(
        constraints: const BoxConstraints(maxWidth: 560),
        insetPadding: isMobile
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kInfoColor.withValues(alpha: 0.1),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding,
                      ),
                      child: Text(
                        DateFormat('MMMM dd, yyyy').format(selectedDate),
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: kDefaultPadding / 4,
                    ),
                    child: CustomIconButton(
                      onTap: () => Navigator.of(context).pop(),
                      icon: Icons.close,
                      shape: ButtonShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kDefaultPadding),
            dayMeetings.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding * 2,
                    ),
                    child: Text('No Event'),
                  )
                : Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dayMeetings.length,
                      itemBuilder: (context, index) {
                        final meeting = dayMeetings[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            onEditEvent(meeting);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding * 0.75,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: meeting.background,
                                  radius: 6,
                                ),
                                const SizedBox(width: kDefaultPadding),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width >
                                          kScreenWidthSm
                                      ? 152
                                      : 76,
                                  child: Text(
                                    '${DateFormat('hh:mm a').format(meeting.from)} - ${DateFormat('hh:mm a').format(meeting.to)}',
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: kDefaultPadding),
                                Flexible(
                                  child: Text(
                                    meeting.eventName,
                                    style: TextStyle(
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: FlatButton(
                kText: 'Add New Event',
                bgColor: kSecondaryColor,
                isFullWidth: true,
                kTextColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                  onAddEvent(selectedDate);
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

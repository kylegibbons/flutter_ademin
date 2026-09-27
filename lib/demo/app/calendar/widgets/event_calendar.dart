import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_data.dart';
import 'package:flutkit_ademin/demo/app/calendar/calendar_models.dart';
import 'package:flutkit_ademin/demo/app/calendar/dialogs/add_event_dialog.dart';
import 'package:flutkit_ademin/demo/app/calendar/dialogs/day_events_dialog.dart';
import 'package:flutkit_ademin/demo/app/calendar/dialogs/edit_event_dialog.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  @override
  void initState() {
    super.initState();
  }

  // allowed views button
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    // CalendarView.workWeek,
    // CalendarView.timelineDay,
    // CalendarView.timelineWeek,
    // CalendarView.timelineWorkWeek,
    CalendarView.month,
    CalendarView.schedule,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        height: 800,
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(getDataSource()),
          // by default the month appointment display mode set as Indicator, we can
          // change the display mode as appointment using the appointment display
          // mode property
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
          showNavigationArrow: true,
          todayHighlightColor: kSecondaryColor,
          showDatePickerButton: true,
          showTodayButton: true,
          allowedViews: _allowedViews,
          onTap: (CalendarTapDetails details) {
            // Open edit dialog when event is selected
            if (details.targetElement == CalendarElement.appointment) {
              final Meeting meetingDetails = details.appointments![0];
              showEditDialog(context, meeting: meetingDetails);
            }
            // Open the Event list dialog when a date block is selected
            else if (details.targetElement == CalendarElement.calendarCell) {
              showDayEventsDialog(
                context,
                selectedDate: details.date!,
                dayMeetings: details.appointments?.cast<Meeting>() ?? [],
                onEditEvent: (meeting) =>
                    showEditDialog(context, meeting: meeting),
                onAddEvent: (date) =>
                    showAddEventDialog(context, initialDate: date),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/calendar/calendar_data.dart';
import 'package:flutter_ademin/demo/app/calendar/calendar_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// Schedule Calendar

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late List<Meeting> _meetings;
  final CalendarController _calendarController = CalendarController();
  // Meeting Data Model and Mockup Data imported from calendar_screen.dart
  late MeetingDataSource _dataSource;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _meetings = getDataSource();
    _dataSource = MeetingDataSource(_meetings);
  }

  List<Meeting> get _todayEvents {
    return _meetings.where((m) {
      return isSameDate(m.from, _selectedDate);
    }).toList()..sort((a, b) => a.from.compareTo(b.from));
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 800,
        child: Column(
          children: [
            /// HEADER
            CardHeader(
              kText: "SCHEDULES",
              kWidget: CustomIconButton(
                icon: Icons.info_outline,
                shape: ButtonShape.circle,
                iconColor: themeData.colorScheme.onSurface,
                tooltipMessage: 'Overview of events for this month.',
                onTap: () {},
              ),
              showDivider: false,
            ),

            /// CALENDAR
            SfCalendar(
              controller: _calendarController,
              view: CalendarView.month,
              dataSource: _dataSource,
              showNavigationArrow: true,
              todayHighlightColor: kSecondaryColor,
              showDatePickerButton: true,
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: kBodyMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selectionDecoration: BoxDecoration(
                color: kInfoColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              monthViewSettings: const MonthViewSettings(
                showAgenda: false,
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              ),
              onSelectionChanged: (details) {
                setState(() {
                  _selectedDate = details.date!;
                });
              },
            ),

            /// EVENTS TITLE
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${DateFormat('dd MMMM').format(_selectedDate)} Events",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                    fontSize: kBodyMedium,
                  ),
                ),
              ),
            ),

            /// TODAY EVENTS
            Expanded(
              child: _todayEvents.isEmpty
                  ? Center(
                      child: Text(
                        "No events today",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      itemCount: _todayEvents.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: kDefaultPadding / 2),
                      itemBuilder: (context, index) {
                        final e = _todayEvents[index];
                        return _EventTile(meeting: e);
                      },
                    ),
            ),

            //  view all event button
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: FlatButton(
                kText: 'View All Events',
                bgColor: kSecondaryColor,
                kTextColor: Colors.white,
                kTrailingIcon: Icons.arrow_forward,
                isFullWidth: true,
                onPressed: () {
                  context.go(RouteUri.calendar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final Meeting meeting;
  const _EventTile({required this.meeting});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      children: [
        /// TIME CIRCLE
        CircleAvatar(
          radius: 22,
          backgroundColor: meeting.background.withValues(alpha: 0.09),
          child: Text(
            DateFormat('hh:mm a').format(meeting.from),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: meeting.background,
              fontWeight: FontWeight.w600,
              fontSize: kBodySmall,
            ),
          ),
        ),
        const SizedBox(width: kDefaultPadding),

        /// TITLE + DESC
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meeting.eventName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: kDefaultPadding / 4),
              Text(meeting.description, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

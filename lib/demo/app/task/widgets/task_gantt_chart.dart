import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/demo/app/task/widgets/task_gantt_toolbar.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_gantt/flutter_gantt.dart';

class TaskGanttChart extends StatelessWidget {
  final GanttController controller;
  final List<GanttActivity> activities;
  final List<ProjectMilestone> milestones;
  final GanttTimelineView selectedView;
  final Color? monthBorderColor;
  final Color? weekBorderColor;
  final void Function(GanttActivity activity, DateTime? start, DateTime? end)
  onTaskChanged;

  const TaskGanttChart({
    super.key,
    required this.controller,
    required this.activities,
    required this.milestones,
    required this.selectedView,
    this.monthBorderColor,
    this.weekBorderColor,
    required this.onTaskChanged,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final chartHeight = mediaQueryData.size.width < kScreenWidthMd
        ? 620.0
        : 720.0;
    final ganttTheme = _buildGanttTheme(
      context,
      isMobile: mediaQueryData.size.width < kScreenWidthMd,
      selectedView: selectedView,
    );
    final showIsoWeek = selectedView != GanttTimelineView.year;
    final showDates =
        selectedView != GanttTimelineView.quarter &&
        selectedView != GanttTimelineView.year;
    final highlightedDates = milestones
        .map((milestone) => DateUtils.dateOnly(milestone.dueDate))
        .toList();

    return SizedBox(
      height: chartHeight,
      child: Column(
        children: [
          Expanded(
            child: Gantt(
              theme: ganttTheme,
              controller: controller,
              showIsoWeek: showIsoWeek,
              showDates: showDates,
              monthBorderColor:
                  monthBorderColor ??
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.9),
              weekBorderColor:
                  weekBorderColor ??
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.9),

              activitiesListFlex: mediaQueryData.size.width < kScreenWidthMd
                  ? 2
                  : 1,
              gridAreaFlex: mediaQueryData.size.width < kScreenWidthMd ? 3 : 4,
              activitiesAsync: (startDate, endDate, activity) async =>
                  activities,
              holidaysAsync: (startDate, endDate, holidays) async => milestones
                  .map(
                    (milestone) => GantDateHoliday(
                      date: DateUtils.dateOnly(milestone.dueDate),
                      holiday: milestone.title,
                    ),
                  )
                  .toList(),
              highlightedDates: highlightedDates,
              onActivityChanged: onTaskChanged,
            ),
          ),
        ],
      ),
    );
  }

  GanttTheme _buildGanttTheme(
    BuildContext context, {
    required bool isMobile,
    required GanttTimelineView selectedView,
  }) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final isDark = themeData.brightness == Brightness.dark;

    final headerHeight = switch (selectedView) {
      GanttTimelineView.quarter => isMobile ? 34.0 : 38.0,
      GanttTimelineView.year => isMobile ? 22.0 : 26.0,
      _ => isMobile ? 58.0 : 66.0,
    };

    return GanttTheme.of(
      context,
      backgroundColor: colorScheme.surface,
      defaultCellColor: Colors.white,
      weekendColor: colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.05),
      holidayColor: kWarningColor.withValues(alpha: isDark ? 0.24 : 0.14),
      todayBackgroundColor: kInfoColor,
      todayTextColor: Colors.white,
      dateBorderColor: colorScheme.outline.withValues(
        alpha: isDark ? 0.02 : 0.01,
      ),

      cellHeight: isMobile ? 26.0 : 30.0,
      rowPadding: 6.0,
      rowsGroupPadding: 10.0,
      headerHeight: headerHeight,
      dayMinWidth: isMobile ? 34.0 : 42.0,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutter_gantt/flutter_gantt.dart';

enum GanttTimelineView {
  day('Day', 1),
  week('Week', 7),
  month('Month', 30),
  quarter('Quarter', 90),
  year('Year', 365);

  final String label;
  final int days;

  const GanttTimelineView(this.label, this.days);
}

class GanttToolbar extends StatelessWidget {
  final GanttTimelineView selectedView;
  final int taskCount;
  final VoidCallback onAutoFit;
  final ValueChanged<GanttTimelineView> onViewChanged;
  final GanttController controller;

  const GanttToolbar({
    super.key,
    required this.selectedView,
    required this.taskCount,
    required this.onAutoFit,
    required this.onViewChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Wrap(
      spacing: kDefaultPadding / 2,
      runSpacing: kDefaultPadding / 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          height: smallHeight,
          child: OutlinedButton.icon(
            onPressed: onAutoFit,
            icon: const Icon(Icons.fit_screen_outlined, size: 16),
            label: const Text('Auto Fit'),
            style: OutlinedButton.styleFrom(
              foregroundColor: themeData.colorScheme.primary,
              side: BorderSide(color: themeData.colorScheme.outline),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              textStyle: const TextStyle(
                fontSize: kBodySmall,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        Container(
          height: smallHeight,
          padding: const EdgeInsetsDirectional.only(
            start: kDefaultPadding / 2,
            end: kDefaultPadding / 3,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: themeData.colorScheme.outline),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<GanttTimelineView>(
              value: selectedView,
              isDense: true,
              iconSize: 18,
              borderRadius: BorderRadius.circular(defaultRadius),
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontSize: kBodySmall,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {
                if (value != null) onViewChanged(value);
              },
              items: GanttTimelineView.values
                  .map(
                    (view) =>
                        DropdownMenuItem(value: view, child: Text(view.label)),
                  )
                  .toList(),
            ),
          ),
        ),

        CustomGanttRangeSelector(controller: controller),
      ],
    );
  }
}

class CustomGanttRangeSelector extends StatelessWidget {
  final GanttController controller;

  const CustomGanttRangeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconButton(
          icon: Icons.navigate_before,
          size: ButtonSize.small,
          iconColor: themeData.colorScheme.onSurface,
          buttonColor: themeData.colorScheme.surface,
          tooltipMessage: 'Previous range',
          isOutlined: true,
          onTap: controller.prev,
        ),
        const SizedBox(width: kDefaultPadding / 4),
        CustomIconButton(
          icon: Icons.navigate_next,
          size: ButtonSize.small,
          iconColor: themeData.colorScheme.onSurface,
          buttonColor: themeData.colorScheme.surface,
          tooltipMessage: 'Next range',
          isOutlined: true,
          onTap: controller.next,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/metric_card.dart';

class TicketMetrics extends StatelessWidget {
  const TicketMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      breakpoints: {kScreenWidthSm: 1, kScreenWidthLg: 2, kScreenWidthXl: 4},
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
      children: mockTicketOverviewData.map((item) {
        return AnimatedIconMetricCard(
          title: item.title,
          value: formatNumberShort(item.value),
          changes: item.changes,
          icon: item.icon,
          iconColor: item.iconColor,
          iconBackgroundColor: item.iconBackgroundColor,
        );
      }).toList(),
    );
  }
}

String formatNumberShort(num value) {
  if (value >= 1000000000) {
    return '${(value / 1000000000).toStringAsFixed(1)}B';
  } else if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(0)}K';
  } else {
    return value.toString();
  }
}

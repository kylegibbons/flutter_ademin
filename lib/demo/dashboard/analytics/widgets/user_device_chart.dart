import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/dashboard_analytics_data.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/dashboard_analytics_models.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UsersByDeviceChart extends StatelessWidget {
  const UsersByDeviceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.compact();

    return Card(
      child: SizedBox(
        height: 438,
        child: Column(
          children: [
            // Title
            CardHeader(kText: 'Users by Device', kWidget: PeriodPopUpMenu()),
            Spacer(),

            // Donut Chart
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              height: 240,
              child: SfCircularChart(
                margin: EdgeInsets.zero,
                legend: Legend(isVisible: false),
                series: <DoughnutSeries<DeviceUserData, String>>[
                  DoughnutSeries<DeviceUserData, String>(
                    dataSource: deviceUserData,
                    pointColorMapper: (datum, _) => datum.color(),
                    xValueMapper: (datum, _) => datum.device,
                    yValueMapper: (datum, _) => datum.value,
                    radius: '100%',
                    innerRadius: '70%',
                    dataLabelSettings: DataLabelSettings(isVisible: false),
                  ),
                ],
              ),
            ),
            Spacer(),

            // Device Breakdown
            Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: Column(
                children: deviceUserData.map((device) {
                  final isPositive = device.percentageChange >= 0;
                  final themeData = Theme.of(context);
                  final color = device.color();
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding / 2,
                    ),
                    child: Row(
                      children: [
                        // Color Indicator
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: kDefaultPadding / 2),

                        // Device Name
                        Expanded(
                          child: Text(
                            device.device,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                          ),
                        ),

                        Icon(Icons.group_outlined, size: 18, color: kTextColor),

                        SizedBox(width: kDefaultPadding / 2),

                        // User Count
                        Text(
                          formatter.format(device.value),
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            color: kTextColor,
                          ),
                        ),

                        SizedBox(width: kDefaultPadding * 1.5),

                        // Percentage Change
                        Row(
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 14,
                              color: isPositive ? kSuccessColor : kErrorColor,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${device.percentageChange.abs().toStringAsFixed(2)}%',
                              style: TextStyle(
                                color: isPositive ? kSuccessColor : kErrorColor,
                                fontWeight: FontWeight.w600,
                                fontSize: kBodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

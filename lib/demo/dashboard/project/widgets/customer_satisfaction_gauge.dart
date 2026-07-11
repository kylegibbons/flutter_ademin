import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/project/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Customer Satisfaction gauge

class CustomerSatisfactionGauge extends StatelessWidget {
  final double value;

  const CustomerSatisfactionGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 388,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Customer Satisfaction',
              kWidget: MorePopUpMenu(),
            ),

            SizedBox(height: kDefaultPadding),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: true,
                    showTicks: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 33,
                        color: kErrorColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 33,
                        endValue: 66,
                        color: kWarningColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 66,
                        endValue: 100,
                        color: kSuccessColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: value,
                        needleLength: 0.6,
                        needleColor: themeData.colorScheme.onSurface,
                        knobStyle: KnobStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '${value.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.7,
                      ),
                    ],
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

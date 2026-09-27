import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OpenPipeNextMonthChart extends StatelessWidget {
  const OpenPipeNextMonthChart({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'AMER ECS - Open Pipe Next Month',
              kWidget: Padding(
                padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
                child: SoftButton(
                  kText: 'View Report',
                  bgColor: kSecondaryColor,
                  size: ButtonSize.small,
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: maxValue,
                      showLabels: true,
                      showTicks: true,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.20,
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      onLabelCreated: (args) {
                        final double value = double.tryParse(args.text) ?? 0;
                        args.text = formatMillionUSD(value);
                      },
                      labelsPosition: ElementsPosition.inside,
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text(
                            formatMillionUSD(openPipeAmount),
                            style: TextStyle(
                              fontSize: kHeadlineSmall,
                              fontWeight: FontWeight.bold,
                              color: getGaugeColor(openPipeAmount, maxValue),
                            ),
                          ),
                          positionFactor: 0.5,
                          angle: 90,
                        ),
                      ],
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: maxValue * 0.4, // red
                          color: kErrorColor,
                          startWidth: 0.15,
                          endWidth: 0.15,
                          sizeUnit: GaugeSizeUnit.factor,
                        ),
                        GaugeRange(
                          startValue: maxValue * 0.4,
                          endValue: maxValue * 0.8, // orange
                          color: kWarningColor,
                          startWidth: 0.15,
                          endWidth: 0.15,
                          sizeUnit: GaugeSizeUnit.factor,
                        ),
                        GaugeRange(
                          startValue: maxValue * 0.8,
                          endValue: maxValue, // green
                          color: kSuccessColor,
                          startWidth: 0.15,
                          endWidth: 0.15,
                          sizeUnit: GaugeSizeUnit.factor,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: openPipeAmount,
                          needleColor: themeData.colorScheme.onSurface,
                          knobStyle: KnobStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

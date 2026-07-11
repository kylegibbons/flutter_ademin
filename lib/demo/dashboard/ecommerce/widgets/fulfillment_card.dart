import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FulfillmentCard extends StatelessWidget {
  const FulfillmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 391,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            CardHeader(
              kText: 'Orders Fulfillment',
              kWidget: Padding(
                padding: EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
                child: CustomIconButton(
                  icon: Icons.info_outline,
                  onTap: () {},
                  iconColor: themeData.colorScheme.onSurface,
                  shape: ButtonShape.circle,
                  tooltipMessage:
                      'This metric measures the mean duration required to move\n orders from an unfulfilled to a fulfilled status.',
                ),
              ),
            ),

            SizedBox(height: kDefaultPadding),

            // avg fulfillment time gauge
            Center(
              child: Text(
                "Avg fulfilment time (past 7d)",
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 10,
                    showLabels: true,
                    showTicks: true,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: 4.51,
                        needleLength: 0.6,
                        needleColor: themeData.colorScheme.onSurface,
                        knobStyle: KnobStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ],
                    labelsPosition: ElementsPosition.inside,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 3,
                        color: kSuccessColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 3,
                        endValue: 6,
                        color: kWarningColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                      GaugeRange(
                        startValue: 6,
                        endValue: 10,
                        color: kErrorColor,
                        startWidth: 0.1,
                        endWidth: 0.1,
                        sizeUnit: GaugeSizeUnit.factor,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '4hr 32 min',
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.8,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // unfulfilled orders stats
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "43",
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Unfulfilled Orders",
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: kErrorColor,
                            size: 12,
                          ),
                          SizedBox(width: kDefaultPadding / 4),
                          Text(
                            "5.12%",
                            style: TextStyle(
                              fontSize: kBodyLarge - 1,
                              color: kErrorColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "vs. Previous Week",
                        style: TextStyle(color: kTextColor),
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

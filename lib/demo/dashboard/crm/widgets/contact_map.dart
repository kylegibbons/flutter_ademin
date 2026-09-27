import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ContactMap extends StatelessWidget {
  const ContactMap({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: SizedBox(
        height: 420,
        child: Column(
          children: [
            CardHeader(
              kText: 'Contacts Distribution',
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
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SfMaps(
                layers: [
                  MapShapeLayer(
                    source: MapShapeSource.asset(
                      'assets/maps/indonesia-province-simple.json',
                      shapeDataField: 'Propinsi',
                      dataCount: provinceData.length,
                      primaryValueMapper: (int index) =>
                          provinceData[index].province,
                      bubbleSizeMapper: (int index) =>
                          provinceData[index].contacts.toDouble(),
                    ),
                    bubbleTooltipBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(kDefaultPadding / 2),
                        child: Text(
                          'Province : ${provinceData[index].province}\nTotal contacts : ${provinceData[index].contacts.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: themeData.colorScheme.onInverseSurface,
                          ),
                        ),
                      );
                    },
                    tooltipSettings: MapTooltipSettings(
                      color: themeData.colorScheme.inverseSurface,
                    ),
                    bubbleSettings: MapBubbleSettings(
                      maxRadius: 20,
                      minRadius: 4,
                      color: kSuccessColor.withValues(alpha: 0.6),
                      strokeWidth: 0.8,
                      strokeColor: kSuccessColor,
                    ),
                    zoomPanBehavior: MapZoomPanBehavior(
                      toolbarSettings: MapToolbarSettings(
                        direction: Axis.vertical,
                        iconColor: kTextColor,
                        itemBackgroundColor:
                            themeData.colorScheme.surfaceContainerHighest,
                      ),
                    ),
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

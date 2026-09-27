import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/ai_reference/ai_reference_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LiveUsersHeatMap extends StatefulWidget {
  const LiveUsersHeatMap({super.key});

  @override
  State<LiveUsersHeatMap> createState() => _LiveUsersHeatMapState();
}

class _LiveUsersHeatMapState extends State<LiveUsersHeatMap> {
  MapShapeSource _buildMapSource() {
    return MapShapeSource.asset(
      'assets/maps/world_map.json',
      shapeDataField: 'name',
      dataCount: liveUserData.length,
      primaryValueMapper: (index) => liveUserData[index].country,
      shapeColorValueMapper: (index) => liveUserData[index].users,
      shapeColorMappers: [
        MapColorMapper(
          from: 0,
          to: 300,
          color: kSecondaryColor.withValues(alpha: 0.4),
          text: '<300',
        ),
        MapColorMapper(
          from: 301,
          to: 700,
          color: kSecondaryColor.withValues(alpha: 0.6),
          text: '300-700',
        ),
        MapColorMapper(
          from: 701,
          to: 1500,
          color: kSecondaryColor.withValues(alpha: 0.8),
          text: '700-1500',
        ),
        MapColorMapper(
          from: 1501,
          to: 3000,
          color: kSecondaryColor,
          text: '>1500',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mapSource = _buildMapSource();

    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Live Users',
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: kDefaultPadding / 2,
              ),
              child: CustomIconButton(
                icon: Icons.info_outline,
                onTap: () {},
                iconColor: themeData.colorScheme.onSurface,
                shape: ButtonShape.circle,
                tooltipMessage:
                    'Displays the locations of users who are currently \nconnected and interacting live, worldwide.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: SizedBox(
              height: 480,
              child: SfMaps(
                layers: [
                  MapShapeLayer(
                    source: mapSource,
                    legend: MapLegend.bar(
                      MapElement.shape,
                      position: MapLegendPosition.bottom,
                      segmentSize: const Size(60, 12),
                      labelsPlacement: MapLegendLabelsPlacement.betweenItems,
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                    ),
                    tooltipSettings: MapTooltipSettings(
                      strokeColor: themeData.colorScheme.outline,
                      color: themeData.colorScheme.inverseSurface,
                      strokeWidth: 0.4,
                    ),
                    shapeTooltipBuilder: (BuildContext context, int index) {
                      final data = liveUserData[index];
                      final formattedUsers = NumberFormat.decimalPattern()
                          .format(data.users);
                      return Container(
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.inverseSurface,
                        ),
                        child: Text(
                          '${data.country}\n$formattedUsers live users',
                          style: TextStyle(
                            color: themeData.colorScheme.onInverseSurface,
                            fontSize: kBodySmall,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

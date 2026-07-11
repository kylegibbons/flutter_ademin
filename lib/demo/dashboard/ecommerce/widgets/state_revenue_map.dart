import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_data.dart';
import 'package:flutter_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class RevenueByStateMap extends StatefulWidget {
  const RevenueByStateMap({super.key});

  @override
  State<RevenueByStateMap> createState() => _RevenueByStateMapState();
}

class _RevenueByStateMapState extends State<RevenueByStateMap> {
  late MapShapeSource _mapSource;

  final List<StateRevenue> data = stateRevenueData;

  @override
  void initState() {
    super.initState();

    _mapSource = MapShapeSource.asset(
      'assets/maps/us-states.json', // GeoJSON file
      shapeDataField: 'name',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].state,
      shapeColorValueMapper: (int index) => data[index].revenue,
      shapeColorMappers: [
        MapColorMapper(
          from: 0,
          to: 30000,
          color: kSecondaryColor.withValues(alpha: 0.3),
          text: '\$30K',
        ),
        MapColorMapper(
          from: 30001,
          to: 60000,
          color: kSecondaryColor.withValues(alpha: 0.6),
          text: '\$60K',
        ),
        MapColorMapper(
          from: 60001,
          to: 100000,
          color: kSecondaryColor,
          text: '\$100K',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 520,
        child: Column(
          children: [
            // header
            CardHeader(
              kText: 'Revenue by States',
              kWidget: Padding(
                padding: EdgeInsetsDirectional.only(end: kDefaultPadding / 2),
                child: CustomIconButton(
                  icon: Icons.info_outline,
                  onTap: () {},
                  iconColor: themeData.colorScheme.onSurface,
                  shape: ButtonShape.circle,
                  tooltipMessage:
                      'Displays the aggregated sales or income generated within\n each state across the United States.',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: kDefaultPadding,
                  right: kDefaultPadding,
                  left: 2 * kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: SfMaps(
                  layers: [
                    MapShapeLayer(
                      source: _mapSource,
                      legend: MapLegend.bar(
                        MapElement.shape,
                        position: MapLegendPosition.bottom,
                        segmentSize: Size(80, 12),
                        labelsPlacement: MapLegendLabelsPlacement.betweenItems,
                        padding: EdgeInsets.only(top: kDefaultPadding),
                      ),
                      showDataLabels: false,
                      strokeColor: Colors.white,
                      strokeWidth: 1,
                      tooltipSettings: MapTooltipSettings(
                        color: Colors.black87,
                      ),
                      shapeTooltipBuilder: (BuildContext context, int index) {
                        final revenue = data[index].revenue;
                        final formatted = NumberFormat.compact(
                          locale: 'id_ID',
                        ).format(revenue).replaceAll(' rb', 'K');
                        return Padding(
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Text(
                            '${data[index].state}\n\$$formatted',
                            style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}

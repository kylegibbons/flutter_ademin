import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_data.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TooltipBehavior tooltipBehavior = TooltipBehavior(
      enable: true,
      // Customize tooltip behaviour
      builder:
          (
            dynamic data,
            dynamic point,
            dynamic series,
            int pointIndex,
            int seriesIndex,
          ) {
            final StorageCategory item = data;
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: themeData.colorScheme.onInverseSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "File Count: ${item.fileCount}",
                    style: TextStyle(
                      color: themeData.colorScheme.onInverseSurface,
                    ),
                  ),
                  Text(
                    "Size: ${item.sizeGB} GB",
                    style: TextStyle(
                      color: themeData.colorScheme.onInverseSurface,
                    ),
                  ),
                  Text(
                    "Usage: ${item.usagePercentage}%",
                    style: TextStyle(
                      color: themeData.colorScheme.onInverseSurface,
                    ),
                  ),
                ],
              ),
            );
          },
    );
    return SizedBox(
      height: 513.6,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            CardHeader(
              kText: 'Storage Details',
              kWidget: CustomIconButton(
                icon: Icons.more_vert,
                tooltipMessage: 'Options',
                onTap: () {},
                hoverColor: Colors.transparent,
              ),
              showDivider: true,
            ),

            SizedBox(height: kDefaultPadding),

            // Chart Section
            SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total 235 GB',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: kBodyLarge,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '239 files',
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              tooltipBehavior: tooltipBehavior,
              series: <CircularSeries>[
                DoughnutSeries<StorageCategory, String>(
                  dataSource: MockData.categories,
                  xValueMapper: (StorageCategory data, _) => data.title,
                  yValueMapper: (StorageCategory data, _) =>
                      data.usagePercentage,
                  pointColorMapper: (StorageCategory data, _) => data.color,
                  innerRadius: '70%',
                  radius: '100%',
                  cornerStyle: CornerStyle.bothFlat,
                  startAngle: 0,
                  endAngle: 360,
                  enableTooltip: true,
                ),
              ],
            ),

            SizedBox(height: kDefaultPadding / 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Center(
                child: Text(
                  "615 GB Free space left",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
            ),

            // Custom Legend
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Center(
                child: Wrap(
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  alignment: WrapAlignment.center,
                  children: MockData.categories
                      .map((cat) => _buildLegendItem(cat))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(StorageCategory cat) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: cat.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: kDefaultPadding / 2),
        Text(cat.title),
      ],
    );
  }
}

// data source

class FileDataSource extends DataGridSource {
  final BuildContext context;
  FileDataSource({required this.context, required List<FileModel> files}) {
    _fileData = files
        .map<DataGridRow>(
          (file) => DataGridRow(
            cells: [
              DataGridCell<FileModel>(columnName: 'file', value: file),
              DataGridCell<String>(
                columnName: 'category',
                value: file.category,
              ),
              DataGridCell<String>(columnName: 'size', value: file.size),
              DataGridCell<String>(
                columnName: 'date',
                value: file.dateModified,
              ),
              DataGridCell<Widget>(
                columnName: 'action',
                value: const SizedBox.shrink(),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _fileData = [];

  @override
  List<DataGridRow> get rows => _fileData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final FileModel file = row.getCells()[0].value;
    final themeData = Theme.of(context);

    return DataGridRowAdapter(
      cells: [
        // File Name with Icon
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              Icon(file.icon, size: 22, color: themeData.colorScheme.onSurface),
              const SizedBox(width: kDefaultPadding / 2),
              Flexible(
                child: Text(
                  file.name,
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Category
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            row.getCells()[1].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),
        //  Size
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            row.getCells()[2].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),
        //  Date
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            row.getCells()[3].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        //  Action (Delete & View)
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconButton(
                icon: Icons.visibility_outlined,
                // iconColor: themeData.colorScheme.onSurface,
                onTap: () {},
              ),

              CustomIconButton(
                icon: Icons.share,
                // iconColor: themeData.colorScheme.onSurface,
                onTap: () {},
              ),

              CustomIconButton(
                icon: Icons.delete_outline,
                iconColor: kErrorColor,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

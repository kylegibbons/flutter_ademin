import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_data.dart';
import 'package:flutkit_ademin/demo/app/file_manager/widgets/storage_details.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RecentFilesTable extends StatefulWidget {
  const RecentFilesTable({super.key});

  @override
  State<RecentFilesTable> createState() => _RecentFilesTableState();
}

class _RecentFilesTableState extends State<RecentFilesTable> {
  late FileDataSource _fileDataSource;

  @override
  void initState() {
    super.initState();
    _fileDataSource = FileDataSource(
      context: context,
      files: MockData.recentFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          CardHeader(
            kText: 'Recent Files',
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: SoftButton(
                kText: 'View All',
                bgColor: kSecondaryColor,
                size: ButtonSize.small,
                kTrailingIcon: Icons.chevron_right,
                onPressed: () {},
              ),
            ),
            showDivider: true,
          ),

          // Tabel Syncfusion
          SfDataGrid(
            source: _fileDataSource,
            columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
                ? ColumnWidthMode.none
                : ColumnWidthMode.fill,
            gridLinesVisibility: GridLinesVisibility.none,
            headerGridLinesVisibility: GridLinesVisibility.none,
            rowHeight: rowHeight,
            headerRowHeight: headerRowHeight,
            shrinkWrapRows: true,
            verticalScrollPhysics: NeverScrollableScrollPhysics(),
            columns: <GridColumn>[
              GridColumn(
                columnName: 'file',
                label: buildHeader('File Name', context),
                minimumWidth: 360,
              ),
              GridColumn(
                columnName: 'category',
                label: buildHeader('Category', context),
                // maximumWidth: 220,
              ),
              GridColumn(
                columnName: 'size',
                label: buildHeader('Size', context),
                // maximumWidth: 220,
              ),
              GridColumn(
                columnName: 'date',
                label: buildHeader('Date Modified', context),
                // maximumWidth: 220,
              ),
              GridColumn(
                columnName: 'action',
                label: buildHeader(
                  'Action',
                  context,
                  alignment: AlignmentDirectional.center,
                ),
                width: 164,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeader(String text, context, {AlignmentGeometry? alignment}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: alignment ?? AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: TableStyle.tableHeaderTextStyle(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

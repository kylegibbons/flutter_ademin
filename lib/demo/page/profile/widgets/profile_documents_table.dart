// create data source for table

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/profile_data.dart';
import 'package:flutter_ademin/demo/page/profile/profile_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DocumentDataSource extends DataGridSource {
  final BuildContext context; // Add context here
  List<DataGridRow> _dataGridRows = [];

  DocumentDataSource(List<DocumentData> customers, this.context) {
    _dataGridRows = customers.map<DataGridRow>((doc) {
      return DataGridRow(
        cells: [
          DataGridCell<DocumentData>(columnName: 'fileName', value: doc),
          DataGridCell<String>(columnName: 'fileType', value: doc.fileType),
          DataGridCell<double>(
            columnName: 'fileSize',
            value: doc.fileSize / 1024,
          ), // in MB
          DataGridCell<DateTime>(
            columnName: 'uploadDate',
            value: doc.uploadDate,
          ),
          DataGridCell<DocumentData>(columnName: 'actions', value: doc),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  // get file icon based on file type

  Widget _getFileIcon(String fileType) {
    switch (fileType) {
      case 'pdf':
        return Container(
          padding: EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.picture_as_pdf, color: kPrimaryColor, size: 22),
        );
      case 'docx':
        return Container(
          padding: EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kSecondaryColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.description, color: kSecondaryColor, size: 22),
        );
      case 'pptx':
        return Container(
          padding: EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kErrorColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.slideshow, color: kErrorColor, size: 22),
        );
      case 'zip':
        return Container(
          padding: EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kWarningColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.archive, color: kWarningColor, size: 22),
        );
      case 'xslx':
        return Container(
          padding: EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kSuccessColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.dataset_outlined, color: kSuccessColor, size: 22),
        );
      default:
        return Icon(Icons.insert_drive_file);
    }
  }

  // customize the appearance of table rows
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final doc =
        row.getCells().firstWhere((cell) => cell.columnName == 'fileName').value
            as DocumentData;
    return DataGridRowAdapter(
      cells: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
          child: Row(
            children: [
              _getFileIcon(doc.fileType),
              SizedBox(width: 0.5 * kDefaultPadding),
              Expanded(
                child: Text(
                  doc.fileName,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              doc.fileType.toUpperCase(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${(doc.fileSize / 1024).toStringAsFixed(2)} MB',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${doc.uploadDate.year}-${doc.uploadDate.month.toString().padLeft(2, '0')}-${doc.uploadDate.day.toString().padLeft(2, '0')}',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildActionsDropdown(doc),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsDropdown(DocumentData doc) {
    return PopupMenuButton<String>(
      child: Container(
        padding: EdgeInsets.all(0.5 * kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kTableHeaderColor,
        ),
        child: Icon(
          Icons.tune_rounded,
          color: Theme.of(context).colorScheme.onSurface,
          size: 22,
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'view',
          child: Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: 0.5 * kDefaultPadding),
              Text('View'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'download',
          child: Row(
            children: [
              Icon(
                Icons.download,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              SizedBox(width: 0.5 * kDefaultPadding),
              Text('Download'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 16),
              SizedBox(width: 0.5 * kDefaultPadding),
              Text('Delete'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        // Handle actions
        debugPrint('$value selected on ${doc.fileName}');
      },
    );
  }
}

// create document table widget

class DocumentsTable extends StatefulWidget {
  const DocumentsTable({super.key});

  @override
  State<DocumentsTable> createState() => _DocumentsTableState();
}

class _DocumentsTableState extends State<DocumentsTable> {
  late DocumentDataSource documentDataSource;

  @override
  void initState() {
    super.initState();
    documentDataSource = DocumentDataSource(documents, context);
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 66.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: documentDataSource,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: [
          // customize the appearance of the table columns
          GridColumn(
            columnName: 'fileName',
            width: 360,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'File Name',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'fileType',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'Type',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'fileSize',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'Size',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          GridColumn(
            columnName: 'uploadDate',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'Upload Date',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'actions',
            width: 154,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                'Actions',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
        allowSorting: true,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
      ),
    );
  }
}

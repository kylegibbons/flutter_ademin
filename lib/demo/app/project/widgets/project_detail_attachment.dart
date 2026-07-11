import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/project/project_data.dart';
import 'package:flutter_ademin/demo/app/project/project_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProjectDetailAttachment extends StatelessWidget {
  const ProjectDetailAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CardHeader(
            kText: 'Attachments',

            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: FancyIconButton(
                kText: 'Upload File',
                bgColor: kErrorColor,
                kTextColor: Colors.white,
                onPressed: () {},
                kLeadingIcon: Icons.cloud_upload_outlined,
              ),
            ),
          ),

          // attachment table
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: AttachmentTable(attachments: mockProjectDatas.attachments),
          ),
        ],
      ),
    );
  }
}

// create Attachment table widget

class AttachmentTable extends StatefulWidget {
  final List<ProjectAttachment> attachments;

  const AttachmentTable({super.key, required this.attachments});

  @override
  State<AttachmentTable> createState() => _AttachmentTableState();
}

class _AttachmentTableState extends State<AttachmentTable> {
  late AttachmentDataSource dataSource;
  int rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    dataSource = AttachmentDataSource(
      widget.attachments,
      context,
      rowsPerPage: rowsPerPage,
    );
  }

  @override
  void didUpdateWidget(covariant AttachmentTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.attachments != widget.attachments ||
        dataSource.rowsPerPage != rowsPerPage) {
      dataSource = AttachmentDataSource(
        widget.attachments,
        context,
        rowsPerPage: rowsPerPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dataSource = AttachmentDataSource();
    double rowHeight = 66.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return Column(
      children: [
        SfDataGridTheme(
          data: TableStyle.dataGridTheme,
          child: SfDataGrid(
            source: dataSource,
            allowSorting: true,
            verticalScrollPhysics: NeverScrollableScrollPhysics(),
            columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
                ? ColumnWidthMode.none
                : ColumnWidthMode.fill,
            gridLinesVisibility: GridLinesVisibility.none,
            headerGridLinesVisibility: GridLinesVisibility.none,
            rowHeight: rowHeight,
            headerRowHeight: headerRowHeight,
            shrinkWrapRows: true,
            columns: [
              GridColumn(
                columnName: 'name',
                label: buildHeader('File Name', context),
                minimumWidth: 240,
              ),
              GridColumn(
                columnName: 'fileType',
                label: buildHeader('Type', context),
                width: 120,
              ),
              GridColumn(
                columnName: 'fileSize',
                label: buildHeader('Size', context),
                width: 120,
              ),
              GridColumn(
                columnName: 'uploadedAt',
                label: buildHeader('Uploaded Date', context),
                width: 180,
              ),
              GridColumn(
                columnName: 'actions',
                width: 84,
                label: buildHeader('Actions', context),
                allowSorting: false,
              ),
            ],
          ),
        ),

        // pager
        SizedBox(
          height: dataPagerHeight,
          child: SfDataPagerTheme(
            data: SfDataPagerThemeData(
              itemTextStyle: const TextStyle(
                fontSize: kBodyMedium, // Customize font size
              ),
              selectedItemTextStyle: const TextStyle(
                fontSize: kBodyMedium,
                fontWeight: FontWeight.w600, // Bold for active page
                color: Colors.white, // Customize selected text color
              ),
              selectedItemColor: kPrimaryColor, // Active page background
              itemBorderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: SfDataPager(
              delegate: dataSource,
              itemHeight: 44,
              itemWidth: 44,
              navigationItemHeight: 44,
              navigationItemWidth: 44,
              pageCount: (widget.attachments.length / rowsPerPage)
                  .ceilToDouble(),
              availableRowsPerPage: const [10, 20, 50],
              onRowsPerPageChanged: (value) {
                if (value != null) {
                  setState(() {
                    rowsPerPage = value;
                    dataSource = AttachmentDataSource(
                      widget.attachments,
                      context,
                      rowsPerPage: rowsPerPage,
                    );
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeader(String text, context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: TableStyle.tableHeaderTextStyle(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// attachment datasource

class AttachmentDataSource extends DataGridSource {
  final BuildContext context;
  final int rowsPerPage;
  List<DataGridRow> _rows = [];
  final List<ProjectAttachment> _allAttachments;

  AttachmentDataSource(
    List<ProjectAttachment> attachments,
    this.context, {
    this.rowsPerPage = 10,
  }) : _allAttachments = attachments {
    _updateRows(0);
  }

  void _updateRows(int pageIndex) {
    final startIndex = pageIndex * rowsPerPage;
    final endIndex = (startIndex + rowsPerPage).clamp(
      0,
      _allAttachments.length,
    );
    final currentAttachments = _allAttachments.sublist(startIndex, endIndex);
    _rows = currentAttachments.map<DataGridRow>((attachment) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'name', value: attachment.name),
          DataGridCell<String>(
            columnName: 'fileType',
            value: attachment.fileType,
          ),
          DataGridCell<double>(
            columnName: 'fileSize',
            value: attachment.fileSize / 1024,
          ),
          DataGridCell<DateTime>(
            columnName: 'uploadedAt',
            value: attachment.uploadedAt,
          ),
          DataGridCell<ProjectAttachment>(
            columnName: 'actions',
            value: attachment,
          ),
        ],
      );
    }).toList();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updateRows(newPageIndex);
    return true;
  }

  Widget _getFileIcon(String fileType) {
    switch (fileType) {
      case 'pdf':
        return Container(
          padding: const EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kPrimaryColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.picture_as_pdf, color: kPrimaryColor, size: 22),
        );
      case 'docx':
        return Container(
          padding: const EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kSecondaryColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.description, color: kSecondaryColor, size: 22),
        );
      case 'pptx':
        return Container(
          padding: const EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kErrorColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.slideshow, color: kErrorColor, size: 22),
        );
      case 'zip':
        return Container(
          padding: const EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kWarningColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.archive, color: kWarningColor, size: 22),
        );
      case 'xlsx':
        return Container(
          padding: const EdgeInsets.all(0.7 * kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius),
            color: kSuccessColor.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.dataset_outlined, color: kSuccessColor, size: 22),
        );
      default:
        return const Icon(Icons.insert_drive_file);
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final attachment =
        row.getCells().firstWhere((cell) => cell.columnName == 'actions').value
            as ProjectAttachment;
    return DataGridRowAdapter(
      cells: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Row(
            children: [
              _getFileIcon(attachment.fileType),
              const SizedBox(width: 0.5 * kDefaultPadding),
              Expanded(
                child: Text(
                  attachment.name,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              attachment.fileType.toUpperCase(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${(attachment.fileSize / 1024).toStringAsFixed(2)} MB',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${attachment.uploadedAt.year}-${attachment.uploadedAt.month.toString().padLeft(2, '0')}-${attachment.uploadedAt.day.toString().padLeft(2, '0')}',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: _buildActionsDropdown(attachment),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsDropdown(ProjectAttachment attachment) {
    return PopupMenuButton<String>(
      child: Container(
        padding: const EdgeInsets.all(0.5 * kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
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
              const SizedBox(width: 0.5 * kDefaultPadding),
              const Text('View'),
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
              const SizedBox(width: 0.5 * kDefaultPadding),
              const Text('Download'),
            ],
          ),
        ),
        const PopupMenuItem(
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
        // print('$value selected on ${attachment.name}');
      },
    );
  }
}

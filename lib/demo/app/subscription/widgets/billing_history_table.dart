import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_data.dart';
import 'package:flutkit_ademin/demo/app/subscription/subscription_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BillingHistoryTable extends StatefulWidget {
  const BillingHistoryTable({super.key});

  @override
  State<BillingHistoryTable> createState() => _BillingHistoryTableState();
}

class _BillingHistoryTableState extends State<BillingHistoryTable> {
  late BillingDataSource _dataSource;

  final int _rowsPerPage = 8;

  @override
  void initState() {
    super.initState();

    _dataSource = BillingDataSource(
      data: mockBillingData,
      rowsPerPage: _rowsPerPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding),

          /// Title section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              "Billing History",
              style: TextStyle(
                fontSize: kBodyLarge,
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: kDefaultPadding / 4),

          /// Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text("Your recent invoices and payments"),
          ),

          const SizedBox(height: kDefaultPadding),

          ///  DataGrid
          SfDataGridTheme(
            data: TableStyle.dataGridTheme,
            child: SfDataGrid(
              source: _dataSource,
              shrinkWrapRows: true,
              verticalScrollPhysics: NeverScrollableScrollPhysics(),
              columnWidthMode:
                  MediaQuery.of(context).size.width < kScreenWidthMd
                  ? ColumnWidthMode.none
                  : ColumnWidthMode.fill,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              rowHeight: rowHeight,
              headerRowHeight: headerRowHeight,
              columns: [
                GridColumn(
                  columnName: 'invoice',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Invoice',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'description',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Description',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'date',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Date',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'amount',
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Amount',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'status',
                  width: 140,
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Status',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'action',
                  width: 120,
                  label: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Action',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: kDefaultPadding),

          /// Pagination
          SfDataPagerTheme(
            data: SfDataPagerThemeData(
              itemBorderRadius: BorderRadius.circular(defaultRadius),
              selectedItemColor: kSecondaryColor,
            ),
            child: SfDataPager(
              delegate: _dataSource,
              itemHeight: headerRowHeight,
              itemWidth: headerRowHeight,
              navigationItemHeight: headerRowHeight,
              navigationItemWidth: headerRowHeight,
              pageCount: (mockBillingData.length / _rowsPerPage)
                  .ceil()
                  .toDouble(),
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
        ],
      ),
    );
  }
}

// data source

class BillingDataSource extends DataGridSource {
  BillingDataSource({required this._data, required this._rowsPerPage}) {
    _updatePaginatedData(0);
  }

  final List<BillingModel> _data;
  final int _rowsPerPage;

  List<BillingModel> _paginatedData = [];
  List<DataGridRow> _rows = [];

  void _updatePaginatedData(int startIndex) {
    final endIndex = startIndex + _rowsPerPage;

    _paginatedData = _data.sublist(
      startIndex,
      endIndex > _data.length ? _data.length : endIndex,
    );

    _rows = _paginatedData.map((item) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'invoice', value: item.invoice),
          DataGridCell<String>(
            columnName: 'description',
            value: item.description,
          ),
          DataGridCell<DateTime>(columnName: 'date', value: item.date),
          DataGridCell<double>(columnName: 'amount', value: item.amount),
          DataGridCell<BillingStatus>(columnName: 'status', value: item.status),
          DataGridCell<String>(columnName: 'action', value: item.invoice),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  /// Called by SfDataPager
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    final startIndex = newPageIndex * _rowsPerPage;
    _updatePaginatedData(startIndex);
    notifyListeners(); // refresh grid
    return true;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        Widget child;

        switch (cell.columnName) {
          case 'description':
            child = Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                cell.value.toString(),
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
            break;

          case 'date':
            final date = cell.value as DateTime;
            child = Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(DateFormat('dd MMM yyyy').format(date)),
            );
            break;

          case 'amount':
            final amount = cell.value as double;
            child = Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(
                "\$${amount.toStringAsFixed(amount % 1 == 0 ? 0 : 2)}",
              ),
            );
            break;

          case 'status':
            final status = cell.value as BillingStatus;
            child = Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: _buildStatusChip(status),
            );
            break;

          case 'action':
            child = Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: _buildDownloadButton(cell.value),
            );
            break;

          default:
            child = Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(cell.value.toString()),
            );
        }

        return child;
      }).toList(),
    );
  }

  /// Status chip

  Widget _buildStatusChip(BillingStatus status) {
    return CustomBadge(
      kText: status.label,
      kColor: status.color,
      isRounded: true,
      isOutlined: true,
    );
  }

  // build download button
  Widget _buildDownloadButton(String invoice) {
    return Tooltip(
      message: "Download Invoice",
      child: CustomIconButton(
        icon: Icons.download_rounded,
        shape: ButtonShape.circle,
        onTap: () {
          /// Replace with your actual download logic
          debugPrint("Download invoice: $invoice");
        },
      ),
    );
  }
}

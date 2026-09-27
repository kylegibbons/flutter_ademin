import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/dashboard_saas_models.dart';
import 'package:flutkit_ademin/demo/dashboard/saas/data/dashboard_saas_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RecentInvoicesTable extends StatefulWidget {
  const RecentInvoicesTable({super.key});

  @override
  State<RecentInvoicesTable> createState() => _RecentInvoicesTableState();
}

class _RecentInvoicesTableState extends State<RecentInvoicesTable> {
  late OrderDataSource orderDataSource;
  List<Order> orders = <Order>[];

  @override
  void initState() {
    super.initState();
    orders = getOrderData();
    orderDataSource = OrderDataSource(orders, setState, context);
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return Card(
      child: Column(
        children: [
          // header
          CardHeader(
            kText: 'Recent Invoices',
            kWidget: CustomPopupMenu<String>(
              onSelected: (value) => debugPrint('Selected: $value'),
              items: [
                // details menu
                PopupMenuItemData(
                  value: 'more',
                  text: 'View more',
                  icon: Icons.visibility_outlined,
                ),

                // refresh menu
                PopupMenuItemData(
                  value: 'refresh',
                  text: 'Refresh',
                  icon: Icons.refresh,
                ),
              ],
              // icon button
              icon: Icons.more_vert,
            ),
          ),

          // table
          SfDataGridTheme(
            data: TableStyle.dataGridTheme,
            child: SfDataGrid(
              source: orderDataSource,
              shrinkWrapRows: true,
              verticalScrollPhysics: NeverScrollableScrollPhysics(),
              columns: [
                GridColumn(
                  columnName: 'ID',
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsetsDirectional.only(
                      start: kDefaultPadding,
                      end: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'ID',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Date',
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Date',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Status',
                  minimumWidth: 100,
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Status',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Customer',
                  minimumWidth: 160,
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Customer',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Purchased',
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Purchased',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Revenue',
                  label: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsetsDirectional.only(
                      end: kDefaultPadding,
                      start: kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Revenue',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
              allowSorting: true,
              columnWidthMode:
                  MediaQuery.of(context).size.width < kScreenWidthSm
                  ? ColumnWidthMode.none
                  : ColumnWidthMode.fill,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              rowHeight: rowHeight,
              headerRowHeight: headerRowHeight,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  OrderDataSource(this.orders, this.setState, this.context) {
    _buildDataGridRows();
  }

  final List<Order> orders;
  final Function setState;
  final BuildContext context;
  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows = orders.map<DataGridRow>((order) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'ID', value: order.id),
          DataGridCell<String>(columnName: 'Date', value: order.date),
          DataGridCell<String>(columnName: 'Status', value: order.status),
          DataGridCell<String>(columnName: 'Customer', value: order.customer),
          DataGridCell<String>(columnName: 'Purchased', value: order.purchased),
          DataGridCell<double>(columnName: 'Revenue', value: order.revenue),
        ],
      );
    }).toList();
  }

  void updateDataGrid() {
    _buildDataGridRows();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
        // ID cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsetsDirectional.only(
            start: kDefaultPadding,
            end: kDefaultPadding / 2,
          ),
          child: Text(
            row.getCells()[0].value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),

        // date cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            DateFormat(
              'MMMM d, yyyy',
            ).format(DateTime.parse(row.getCells()[1].value.toString())),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),

        // status cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: CustomBadge(
            kText: row.getCells()[2].value.toString(), // Status text
            kColor: _getStatusColor(
              row.getCells()[2].value.toString(),
            ), // Dynamic color
            isOutlined: true,
            isRounded: true,
          ),
        ),

        // customer cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(
                  orders
                      .firstWhere(
                        (e) => e.id == row.getCells()[0].value,
                        orElse: () => Order('', '', '', '', '', 0.0, ''),
                      )
                      .avatar,
                ),
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Text(
                row.getCells()[3].value.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        // purchased cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            row.getCells()[4].value.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),

        // revenue cell
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsetsDirectional.only(
            end: kDefaultPadding,
            start: kDefaultPadding / 2,
          ),
          child: Text(
            NumberFormat.currency(
              symbol: '\$',
              decimalDigits: 2,
            ).format(row.getCells()[5].value),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

// Returns a color based on the status

Color _getStatusColor(String status) {
  switch (status) {
    case 'Completed':
      return kSuccessColor;
    case 'Pending':
      return kWarningColor;
    case 'Cancelled':
      return kErrorColor;
    default:
      return Colors.grey;
  }
}

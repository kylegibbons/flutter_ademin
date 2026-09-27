import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/data/dashboard_ecommerce_data.dart';
import 'package:flutkit_ademin/demo/dashboard/ecommerce/dashboard_ecommerce_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RecentOrdersTable extends StatefulWidget {
  const RecentOrdersTable({super.key});

  @override
  State<RecentOrdersTable> createState() => _RecentOrdersTableState();
}

class _RecentOrdersTableState extends State<RecentOrdersTable> {
  late final OrderDataSource dataSource;

  @override
  void initState() {
    super.initState();
    dataSource = OrderDataSource(orders, context); // full data
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
            kText: 'Recent Orders',
            kWidget: Padding(
              padding: EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: SoftButton(
                kText: 'View Details',
                bgColor: kSuccessColor,
                size: ButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),

          // table
          SfDataGridTheme(
            data: TableStyle.dataGridTheme,
            child: SfDataGrid(
              source: dataSource,
              shrinkWrapRows: true,
              allowSorting: false,
              verticalScrollPhysics: NeverScrollableScrollPhysics(),
              columnWidthMode:
                  MediaQuery.of(context).size.width < kScreenWidthMd
                  ? ColumnWidthMode.none
                  : ColumnWidthMode.fill,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              showCheckboxColumn: false,
              rowHeight: rowHeight,
              headerRowHeight: headerRowHeight,
              allowFiltering: false,
              columns: [
                GridColumn(
                  columnName: 'Order ID',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Order ID',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  width: 86,
                ),
                GridColumn(
                  columnName: 'Customer',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Customer',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  minimumWidth: 152,
                ),
                GridColumn(
                  columnName: 'Product',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Product',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Amount',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Amount',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  width: 86,
                ),
                GridColumn(
                  columnName: 'Vendor',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Vendor',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'Status',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Status',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  width: 92,
                ),
                GridColumn(
                  columnName: 'Rating',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Rating',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  width: 114,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDataSource extends DataGridSource {
  final BuildContext context;
  final List<Order> orders;
  List<DataGridRow> _rows = [];

  OrderDataSource(this.orders, this.context) {
    _buildRows();
  }

  void _buildRows() {
    _rows = orders.map((order) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'Order ID', value: order.orderId),
          DataGridCell<String>(
            columnName: 'Customer',
            value: order.customerName,
          ),
          DataGridCell<String>(columnName: 'Product', value: order.product),
          DataGridCell<double>(columnName: 'Amount', value: order.amount),
          DataGridCell<String>(columnName: 'Vendor', value: order.vendor),
          DataGridCell<String>(columnName: 'Status', value: order.status),
          DataGridCell<String>(
            columnName: 'Rating',
            value: '${order.rating} (${order.votes} votes)',
          ),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: [
        // ID
        _buildID(row, themeData),

        // customer
        _buildCustomerCell(row),

        // product
        _buildText(row, 'Product'),

        // ammount
        _buildAmountCell(row),

        // vendor
        _buildText(row, 'Vendor'),

        // status
        _buildStatusCell(row),

        // status
        _buildText(row, 'Rating'),
      ],
    );
  }

  Widget _buildID(DataGridRow row, ThemeData themeData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        row.getCells()[0].value.toString(),
        style: TextStyle(
          color: themeData.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildText(DataGridRow row, String col) {
    final themeData = Theme.of(context);
    final val = row.getCells().firstWhere((e) => e.columnName == col).value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        val.toString(),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: themeData.colorScheme.onSurface),
      ),
    );
  }

  Widget _buildCustomerCell(DataGridRow row) {
    final name = row.getCells()[1].value;
    final image = orders
        .firstWhere((o) => o.customerName == name)
        .customerImage;
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: [
          CircleAvatar(radius: 16, backgroundImage: AssetImage(image)),
          SizedBox(width: kDefaultPadding / 2),
          Expanded(
            child: Text(
              name,
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCell(DataGridRow row) {
    final value = row.getCells()[3].value;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        '\$${value.toStringAsFixed(2)}',
        style: TextStyle(color: kSuccessColor),
      ),
    );
  }

  Widget _buildStatusCell(DataGridRow row) {
    final status = row.getCells()[5].value;
    final color = switch (status) {
      'Paid' => kSuccessColor,
      'Pending' => kWarningColor,
      'Unpaid' => kErrorColor,
      _ => kTextColor,
    };

    return Container(
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: CustomBadge(kColor: color, kText: status, isOutlined: true),
    );
  }
}

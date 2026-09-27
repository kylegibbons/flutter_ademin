import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StackedHeaderTableScreen extends StatefulWidget {
  const StackedHeaderTableScreen({super.key});

  @override
  State<StackedHeaderTableScreen> createState() =>
      _StackedHeaderTableScreenState();
}

class _StackedHeaderTableScreenState extends State<StackedHeaderTableScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).stackedHeaderTable; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.stackedHeaderTable.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.tables, uri: ''),
                        BreadcrumbItem(
                          label: lang.stackedHeaderTable,
                          uri: RouteUri.chartBubble,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ShowCodeCard(
                  cardTitle: 'Stacked Header Table',
                  description:
                      'Table with with stacked header, also known as multi-column headers or unbound header rows. This feature allows you to create a hierarchical header structure where one or more columns are grouped under a single, larger header cell.',
                  uiView: StackedHeaderTable(),
                  codeView:
                      '''StackedHeaderTable() source code can be found in the lib/demo/table/table_stacked_header_screen.dart file.''',
                ),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

// Stacked Header Table

class StackedHeaderTable extends StatelessWidget {
  /// Sample order data with 30 entries
  final List<Order> orders = [
    Order(
      "John Doe",
      "New York",
      "1001",
      DateTime(2024, 2, 20),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Jane Smith",
      "Los Angeles",
      "1002",
      DateTime(2024, 2, 21),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Sam Wilson",
      "Chicago",
      "1003",
      DateTime(2024, 2, 22),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Alice Brown",
      "Houston",
      "1004",
      DateTime(2024, 2, 23),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "Bob Johnson",
      "Miami",
      "1005",
      DateTime(2024, 2, 24),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
    Order(
      "Charlie Davis",
      "New York",
      "1006",
      DateTime(2024, 2, 25),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Diane Evans",
      "Los Angeles",
      "1007",
      DateTime(2024, 2, 26),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Evan Scott",
      "Chicago",
      "1008",
      DateTime(2024, 2, 27),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Fiona Green",
      "Houston",
      "1009",
      DateTime(2024, 2, 28),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "George White",
      "Miami",
      "1010",
      DateTime(2024, 2, 1),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
    Order(
      "Helen Carter",
      "New York",
      "1011",
      DateTime(2024, 2, 2),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Ian Brooks",
      "Los Angeles",
      "1012",
      DateTime(2024, 2, 3),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Jackie Adams",
      "Chicago",
      "1013",
      DateTime(2024, 2, 4),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Kevin Roberts",
      "Houston",
      "1014",
      DateTime(2024, 2, 5),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "Laura Morris",
      "Miami",
      "1015",
      DateTime(2024, 2, 6),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
    Order(
      "Michael Perry",
      "New York",
      "1016",
      DateTime(2024, 2, 7),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Nancy Hughes",
      "Los Angeles",
      "1017",
      DateTime(2024, 2, 8),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Oscar Reed",
      "Chicago",
      "1018",
      DateTime(2024, 2, 9),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Patricia Foster",
      "Houston",
      "1019",
      DateTime(2024, 2, 10),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "Quincy Bell",
      "Miami",
      "1020",
      DateTime(2024, 2, 11),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
    Order(
      "Rachel Turner",
      "New York",
      "1021",
      DateTime(2024, 2, 12),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Steve Collins",
      "Los Angeles",
      "1022",
      DateTime(2024, 2, 13),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Tracy Martin",
      "Chicago",
      "1023",
      DateTime(2024, 2, 14),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Ursula Scott",
      "Houston",
      "1024",
      DateTime(2024, 2, 15),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "Victor Lewis",
      "Miami",
      "1025",
      DateTime(2024, 2, 16),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
    Order(
      "Wendy Baker",
      "New York",
      "1026",
      DateTime(2024, 2, 17),
      "Laptop",
      "P001",
      2,
      1200.0,
    ),
    Order(
      "Xavier Young",
      "Los Angeles",
      "1027",
      DateTime(2024, 2, 18),
      "Phone",
      "P002",
      1,
      800.0,
    ),
    Order(
      "Yvonne Clark",
      "Chicago",
      "1028",
      DateTime(2024, 2, 19),
      "Tablet",
      "P003",
      3,
      500.0,
    ),
    Order(
      "Zachary Hall",
      "Houston",
      "1029",
      DateTime(2024, 2, 20),
      "Headphones",
      "P004",
      4,
      200.0,
    ),
    Order(
      "Aaron King",
      "Miami",
      "1030",
      DateTime(2024, 2, 21),
      "Monitor",
      "P005",
      1,
      300.0,
    ),
  ];

  /// Formatter for date
  final DateFormat dateFormatter = DateFormat('MMMM d, yyyy');

  /// Formatter for currency
  final NumberFormat currencyFormatter = NumberFormat.currency(symbol: '\$');

  StackedHeaderTable({super.key});

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SizedBox(
      width: double.infinity,
      height: 800,
      child: SfDataGridTheme(
        data: TableStyle.dataGridTheme,
        child: SfDataGrid(
          source: OrderDataSource(
            orders,
            context,
            dateFormatter,
            currencyFormatter,
          ),
          verticalScrollPhysics: NeverScrollableScrollPhysics(),
          columns: [
            GridColumn(
              columnName: 'customerName',
              label: Center(
                child: Text(
                  'Customer Name',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'city',
              label: Center(
                child: Text(
                  'City',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'orderId',
              label: Center(
                child: Text(
                  'Order ID',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'orderDate',
              label: Center(
                child: Text(
                  'Order Date',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'productName',
              label: Center(
                child: Text(
                  'Product Name',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'productId',
              label: Center(
                child: Text(
                  'Product ID',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'quantity',
              label: Center(
                child: Text(
                  'Quantity',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'price',
              label: Center(
                child: Text(
                  'Price',
                  style: TableStyle.tableHeaderTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
          stackedHeaderRows: [
            StackedHeaderRow(
              cells: [
                StackedHeaderCell(
                  columnNames: ['customerName', 'city'],
                  child: Center(
                    child: Text(
                      'Customer Details',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                StackedHeaderCell(
                  columnNames: ['orderId', 'orderDate'],
                  child: Center(
                    child: Text(
                      'Order Details',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                StackedHeaderCell(
                  columnNames: [
                    'productName',
                    'productId',
                    'quantity',
                    'price',
                  ],
                  child: Center(
                    child: Text(
                      'Product Details',
                      style: TableStyle.tableHeaderTextStyle(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
          allowSorting: true,
          columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
              ? ColumnWidthMode.none
              : ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          rowHeight: rowHeight,
          headerRowHeight: headerRowHeight,
        ),
      ),
    );
  }
}

/// Model representing an order
class Order {
  final String customerName;
  final String city;
  final String orderId;
  final DateTime orderDate;
  final String productName;
  final String productId;
  final int quantity;
  final double price;

  Order(
    this.customerName,
    this.city,
    this.orderId,
    this.orderDate,
    this.productName,
    this.productId,
    this.quantity,
    this.price,
  );
}

/// Data source for the Syncfusion DataGrid
class OrderDataSource extends DataGridSource {
  /// List of data grid rows
  List<DataGridRow> _orders = [];
  final DateFormat dateFormatter;
  final NumberFormat currencyFormatter;

  final BuildContext context; // Add context here

  /// Initializes the data source with a list of orders
  OrderDataSource(
    List<Order> orders,
    this.context,
    this.dateFormatter,
    this.currencyFormatter,
  ) {
    _orders = orders
        .map<DataGridRow>(
          (order) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'customerName',
                value: order.customerName,
              ),
              DataGridCell<String>(columnName: 'city', value: order.city),
              DataGridCell<String>(columnName: 'orderId', value: order.orderId),
              DataGridCell<String>(
                columnName: 'orderDate',
                value: dateFormatter.format(order.orderDate),
              ),
              DataGridCell<String>(
                columnName: 'productName',
                value: order.productName,
              ),
              DataGridCell<String>(
                columnName: 'productId',
                value: order.productId,
              ),
              DataGridCell<int>(columnName: 'quantity', value: order.quantity),
              DataGridCell<String>(
                columnName: 'price',
                value: currencyFormatter.format(order.price),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => _orders;

  /// Builds a row for the Syncfusion DataGrid
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment:
              (cell.columnName == 'orderId' ||
                  cell.columnName == 'quantity' ||
                  cell.columnName == 'productId')
              ? Alignment.center
              : AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Text(
            cell.value.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        );
      }).toList(),
    );
  }
}

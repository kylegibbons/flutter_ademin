import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BasicTableScreen extends StatefulWidget {
  const BasicTableScreen({super.key});

  @override
  State<BasicTableScreen> createState() => _BasicTableScreenState();
}

class _BasicTableScreenState extends State<BasicTableScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).basicTable; //update your page tittle here
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
                      lang.basicTable.toUpperCase(),
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
                          label: lang.basicTable,
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
          const Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                ShowCodeCard(
                  cardTitle: 'Basic Table',
                  description: 'Basic table showing all datas.',
                  uiView: CustomerTable(),
                  codeView:
                      '''CustomerTable() source code can be found in the lib/demo/table/table_basic_screen.dart file.''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Paginated Table',
                  description:
                      'Table with pagination, table height is responsive based on the selected number of rows.',
                  uiView: SizedBox(child: PaginatedTable()),
                  codeView:
                      '''PaginatedTable() source code can be found in the lib/demo/table/table_basic_screen.dart file.''',
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

// BASIC TABLE //

// data model for basic table

class CustomerData {
  final String id; // Invoice Number
  final String customer;
  final String email;
  final String company;
  final String date; // Stored as 'yyyy-MM-dd'
  final double invoice; // Invoice amount in USD

  CustomerData({
    required this.id,
    required this.customer,
    required this.email,
    required this.company,
    required this.date,
    required this.invoice,
  });

  /// Format date to "October 15, 2021"
  String get formattedDate {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMMM d, yyyy').format(parsedDate);
  }
}

// data mockup

final List<CustomerData> _customers = [
  CustomerData(
    id: 'INV-001',
    customer: 'John Doe',
    email: 'john.doe@example.com',
    company: 'TechCorp',
    date: '2025-02-13',
    invoice: 1500.0,
  ),
  CustomerData(
    id: 'INV-002',
    customer: 'Jane Smith',
    email: 'jane.smith@example.com',
    company: 'InnovateX',
    date: '2025-02-12',
    invoice: 1800.0,
  ),
  CustomerData(
    id: 'INV-003',
    customer: 'Michael Brown',
    email: 'michael.brown@example.com',
    company: 'WebWorks',
    date: '2025-02-11',
    invoice: 2100.0,
  ),
  CustomerData(
    id: 'INV-004',
    customer: 'Emily Johnson',
    email: 'emily.johnson@example.com',
    company: 'CloudNet',
    date: '2025-02-10',
    invoice: 2300.0,
  ),
  CustomerData(
    id: 'INV-005',
    customer: 'Robert Wilson',
    email: 'robert.wilson@example.com',
    company: 'SoftSolutions',
    date: '2025-02-09',
    invoice: 1750.0,
  ),
  CustomerData(
    id: 'INV-006',
    customer: 'Sophia Davis',
    email: 'sophia.davis@example.com',
    company: 'NextGen Inc.',
    date: '2025-02-08',
    invoice: 1950.0,
  ),
  CustomerData(
    id: 'INV-007',
    customer: 'Daniel Martinez',
    email: 'daniel.martinez@example.com',
    company: 'FutureTech',
    date: '2025-02-07',
    invoice: 2200.0,
  ),
  CustomerData(
    id: 'INV-008',
    customer: 'Olivia Taylor',
    email: 'olivia.taylor@example.com',
    company: 'Visionary Labs',
    date: '2025-02-06',
    invoice: 2500.0,
  ),
  CustomerData(
    id: 'INV-009',
    customer: 'William Anderson',
    email: 'william.anderson@example.com',
    company: 'SynergyCorp',
    date: '2025-02-05',
    invoice: 1900.0,
  ),
  CustomerData(
    id: 'INV-010',
    customer: 'Emma Thompson',
    email: 'emma.thompson@example.com',
    company: 'BrightFuture',
    date: '2025-02-04',
    invoice: 2400.0,
  ),
];

// create data source for table

class CustomerDataSource extends DataGridSource {
  final BuildContext context; // Add context here
  List<DataGridRow> _dataGridRows = [];

  CustomerDataSource(List<CustomerData> customers, this.context) {
    _dataGridRows = customers.map<DataGridRow>((data) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'id', value: data.id),
          DataGridCell<String>(columnName: 'customer', value: data.customer),
          DataGridCell<String>(columnName: 'email', value: data.email),
          DataGridCell<String>(columnName: 'company', value: data.company),
          DataGridCell<String>(
            columnName: 'date',
            value: data.formattedDate,
          ), // Formatted Date
          DataGridCell<double>(columnName: 'invoice', value: data.invoice),
          DataGridCell<String>(
            columnName: 'action',
            value: data.id,
          ), // Action Column
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  // customize the appearance of table rows
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        // customize the appearance of 'invoice' cells
        if (cell.columnName == 'invoice') {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                NumberFormat.currency(
                  symbol: '\$',
                  decimalDigits: 2,
                ).format(cell.value),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          );

          // customize the appearance of 'action' cells
        } else if (cell.columnName == 'action') {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'View More',
                    style: TextStyle(
                      color: kSuccessColor,
                      fontSize: kBodyMedium,
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 3),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: kSuccessColor,
                    size: 14,
                  ),
                ],
              ),
            ),
          );

          // customize the appearance of 'id' cells
        } else if (cell.columnName == 'id') {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                cell.value.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        } else {
          // customize the appearance of other cells
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0.5 * kDefaultPadding,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                cell.value.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          );
        }
      }).toList(),
    );
  }
}

// create table widget

class CustomerTable extends StatefulWidget {
  const CustomerTable({super.key});

  @override
  State<CustomerTable> createState() => _CustomerTableState();
}

class _CustomerTableState extends State<CustomerTable> {
  late CustomerDataSource customerDataSource;

  @override
  void initState() {
    super.initState();
    customerDataSource = CustomerDataSource(_customers, context);
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: customerDataSource,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: [
          // customize the appearance of the table columns
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Invoice ID',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'customer',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Customer',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'email',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Email',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'company',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Company',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'date',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
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
            columnName: 'invoice',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Invoice (\$)',
                style: TableStyle.tableHeaderTextStyle(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'action',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Action',
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
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
      ),
    );
  }
}

// PAGINATED TABLE //

class PaginatedTable extends StatefulWidget {
  const PaginatedTable({super.key});

  @override
  State<PaginatedTable> createState() => _PaginatedTableState();
}

/// The number of rows displayed per page in the data grid.
int _rowsPerPage = 10;

class _PaginatedTableState extends State<PaginatedTable> {
  /// Data source for the DataGrid.
  late OrderDataSource _orderDataSource;

  /// Height of the DataPager widget.
  final double _dataPagerHeight = 60.0;

  /// List to store order data.
  List<Order> _orders = <Order>[];

  @override
  void initState() {
    super.initState();
    _orders = _fetchOrders(); // Fetch sample order data
    _orderDataSource = OrderDataSource(
      orders: _orders,
      context: context,
    ); // Initialize data source
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: [
            // DataGrid with dynamic height adjustment
            SizedBox(
              // height: constraint.maxHeight - _dataPagerHeight,
              // width: constraint.maxWidth,
              child: _buildDataGrid(constraint),
            ),

            // Data pager for pagination
            SizedBox(
              height: _dataPagerHeight,
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
                  delegate: _orderDataSource,
                  itemHeight: 44,
                  itemWidth: 44,
                  navigationItemHeight: 44,
                  navigationItemWidth: 44,
                  pageCount: (_orders.length / _rowsPerPage).ceil().toDouble(),
                  availableRowsPerPage: [
                    10,
                    20,
                    30,
                    _orders.length,
                  ], // Options for rows per page
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _rowsPerPage = value;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds the Syncfusion DataGrid.
  Widget _buildDataGrid(BoxConstraints constraint) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _orderDataSource,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: <GridColumn>[
          // Order ID Column
          GridColumn(
            columnName: 'orderId',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Order ID',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // Customer ID Column
          GridColumn(
            columnName: 'customerId',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Customer ID',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // Product Column
          GridColumn(
            columnName: 'product',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Product',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // Price Column
          GridColumn(
            columnName: 'price',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Price',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // City Column
          GridColumn(
            columnName: 'city',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'City',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // Shipment Price Column
          GridColumn(
            columnName: 'shippementPrice',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Shipment Price',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          // Total Price Column
          GridColumn(
            columnName: 'totalPrice',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Total Price',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
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
        shrinkWrapRows: true,
      ),
    );
  }

  /// Generates a list of sample order data.
  List<Order> _fetchOrders() {
    List<Order> orderData = [];
    final Random random = Random();

    // List of city names from Asia.
    List<String> city = [
      'Tokyo',
      'Seoul',
      'Bangkok',
      'Jakarta',
      'Manila',
      'Kuala Lumpur',
      'Ho Chi Minh City',
      'Singapore',
      'Mumbai',
      'Shanghai',
      'Beijing',
      'Delhi',
      'Taipei',
      'Istanbul',
      'Dhaka',
      'Hanoi',
      'Chengdu',
      'Riyadh',
      'Kolkata',
      'Karachi',
    ];

    // Product list with corresponding prices.
    Map<String, double> productPrices = {
      'Acrylic Paint Set': 50.0,
      'Watercolor Paints': 40.0,
      'Oil Paint Set': 80.0,
      'Brush Set': 25.0,
      'Canvas Pack': 30.0,
      'Sketchbook': 15.0,
      'Charcoal Pencils': 20.0,
      'Graphite Pencil Set': 18.0,
      'Easel': 100.0,
      'Palette Knives': 12.0,
      'Calligraphy Pen Set': 35.0,
      'Digital Drawing Tablet': 250.0,
      'Sculpting Clay': 40.0,
      'Resin Art Kit': 60.0,
      'Airbrush Kit': 150.0,
      'Pastel Color Set': 45.0,
      'Fabric Paints': 35.0,
      'Wood Carving Tools': 70.0,
      'DIY Printmaking Kit': 55.0,
      'Lightbox for Tracing': 90.0,
    };

    List<String> products = productPrices.keys.toList();

    // Generate exactly 100 records.
    for (int i = 0; i < 100; i++) {
      String product = products[i % products.length]; // Get product name
      double price = productPrices[product]!; // Get product price
      double shipmentPrice =
          random.nextInt(100) + random.nextDouble(); // Random shipment price

      // Create an Order object
      orderData.add(
        Order(
          orderId: 1000 + i,
          customerId: 1700 + i,
          product: product,
          orderPrice: price,
          city: city[i % city.length],
          shippementPrice: shipmentPrice,
          totalPrice: price + shipmentPrice,
        ),
      );
    }
    return orderData;
  }
}

/// Order model class representing a single order entry.
class Order {
  Order({
    required this.orderId,
    required this.customerId,
    required this.product,
    required this.orderPrice,
    required this.city,
    required this.shippementPrice,
    required this.totalPrice,
  });

  final int orderId;
  final int customerId;
  final String product;
  final String city;
  final double orderPrice;
  final double shippementPrice;
  final double totalPrice;
}

/// Data source for Syncfusion DataGrid.
class OrderDataSource extends DataGridSource {
  OrderDataSource({required this.orders, required this.context}) {
    _paginatedOrders = orders.getRange(0, 19).toList(growable: false);
    _buildDataGridRows(_paginatedOrders);
  }

  List<DataGridRow> dataGridRows = [];
  List<Order> _paginatedOrders = [];
  List<Order> orders;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => dataGridRows;

  /// Builds the UI for each row in the DataGrid.
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: Text(
            (e.columnName == 'price' ||
                    e.columnName == 'shippementPrice' ||
                    e.columnName == 'totalPrice')
                ? NumberFormat.currency(
                    locale: 'en_US',
                    symbol: '\$',
                    decimalDigits: 2,
                  ).format(e.value)
                : e.value.toString(),
            style: TextStyle(
              // fontSize: kBodyMedium,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: e.columnName == 'totalPrice'
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Handles pagination when a new page is selected.
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    if (endIndex > orders.length) endIndex = orders.length;
    _paginatedOrders = orders
        .getRange(startIndex, endIndex)
        .toList(growable: false);
    _buildDataGridRows(_paginatedOrders);
    notifyListeners();
    return true;
  }

  /// Converts order data into DataGridRows.
  void _buildDataGridRows(List<Order> orders) {
    dataGridRows = orders
        .map<DataGridRow>(
          (order) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'orderId', value: order.orderId),
              DataGridCell<int>(
                columnName: 'customerId',
                value: order.customerId,
              ),
              DataGridCell<String>(columnName: 'product', value: order.product),
              DataGridCell<double>(
                columnName: 'price',
                value: order.orderPrice,
              ),
              DataGridCell<String>(columnName: 'city', value: order.city),
              DataGridCell<double>(
                columnName: 'shippementPrice',
                value: order.shippementPrice,
              ),
              DataGridCell<double>(
                columnName: 'totalPrice',
                value: order.totalPrice,
              ),
            ],
          ),
        )
        .toList();
  }
}

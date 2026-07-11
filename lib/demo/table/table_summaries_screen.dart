import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'dart:math';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableSummariesScreen extends StatefulWidget {
  const TableSummariesScreen({super.key});

  @override
  State<TableSummariesScreen> createState() => _TableSummariesScreenState();
}

class _TableSummariesScreenState extends State<TableSummariesScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).summariesTable; //update your page tittle here
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //page title and breadcrumb
          Container(
            width: double.infinity,
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
                      lang.summariesTable.toUpperCase(),
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
                          label: lang.summariesTable,
                          uri: RouteUri.tableFiltering,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // content
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: CardDescription(
              content:
                  "Displaying summary information in a table, often referred to as a summary table or table summary rows. <code>SummariesTable()</code> source code can be found in the <code>lib/demo/table/table_summaries_screen.dart</code> file.",
            ),
          ),

          Expanded(child: const SummariesTable()),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

class SummariesTable extends StatefulWidget {
  const SummariesTable({super.key});

  @override
  State<SummariesTable> createState() => _SummariesTableState();
}

class _SummariesTableState extends State<SummariesTable> {
  late OrderDataSource orderDataSource;

  // generate mock up data
  final List<Order> orders = List.generate(50, (index) {
    final random = Random();
    final products = [
      'Laptop',
      'Smartphone',
      'Tablet',
      'Monitor',
      'Keyboard',
      'Mouse',
      'Headphones',
      'Printer',
    ];
    final cities = [
      'New York',
      'Los Angeles',
      'Chicago',
      'Houston',
      'Miami',
      'Dallas',
      'Seattle',
      'San Francisco',
    ];

    String invoiceId = 'INV-${1000 + index}';
    String product = products[random.nextInt(products.length)];
    double price = (random.nextDouble() * 1000 + 100).roundToDouble();
    String city = cities[random.nextInt(cities.length)];
    double freight = (random.nextDouble() * 50).roundToDouble();

    return Order(invoiceId, product, price, city, freight);
  });

  @override
  void initState() {
    super.initState();
    orderDataSource = OrderDataSource(orders, context);
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      margin: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12), // Default Card shadow
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SfDataGridTheme(
        data: TableStyle.dataGridTheme,
        child: SfDataGrid(
          source: orderDataSource,
          allowSorting: true,
          verticalScrollPhysics: NeverScrollableScrollPhysics(),
          columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
              ? ColumnWidthMode.none
              : ColumnWidthMode.fill,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          rowHeight: rowHeight,
          headerRowHeight: headerRowHeight,
          columns: [
            GridColumn(
              columnName: 'invoiceId',
              label: _buildHeader('Invoice ID', 'invoiceId'),
            ),
            GridColumn(
              columnName: 'product',
              label: _buildHeader('Product', 'product'),
            ),
            GridColumn(
              columnName: 'price',
              label: _buildHeader('Price', 'price'),
            ),
            GridColumn(columnName: 'city', label: _buildHeader('City', 'city')),
            GridColumn(
              columnName: 'freight',
              label: _buildHeader('Freight', 'freight'),
            ),
            GridColumn(
              columnName: 'totalPrice',
              label: _buildHeader('Total Price', 'totalPrice'),
            ),
          ],
          tableSummaryRows: [
            GridTableSummaryRow(
              showSummaryInRow: false,
              color: kTableHeaderColor,
              columns: [
                const GridSummaryColumn(
                  name: 'price',
                  columnName: 'price',
                  summaryType: GridSummaryType.sum,
                ),
                const GridSummaryColumn(
                  name: 'freight',
                  columnName: 'freight',
                  summaryType: GridSummaryType.sum,
                ),
                const GridSummaryColumn(
                  name: 'totalPrice',
                  columnName: 'totalPrice',
                  summaryType: GridSummaryType.sum,
                ),
              ],
              position: GridTableSummaryRowPosition.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text, String columnName) {
    // Check if the column name belongs to a currency column
    bool isCurrencyColumn = [
      'price',
      'freight',
      'totalPrice',
    ].contains(columnName);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
      alignment: isCurrencyColumn
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart, // Align accordingly
      child: Text(
        text,
        style: TableStyle.tableHeaderTextStyle(context),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class Order {
  final String invoiceId;
  final String product;
  final double price;
  final String city;
  final double freight;

  Order(this.invoiceId, this.product, this.price, this.city, this.freight);

  double get totalPrice => price + freight;
}

class OrderDataSource extends DataGridSource {
  final BuildContext context; // Add context here
  OrderDataSource(List<Order> orders, this.context) {
    dataGridRows = orders.map<DataGridRow>((order) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'invoiceId', value: order.invoiceId),
          DataGridCell<String>(columnName: 'product', value: order.product),
          DataGridCell<double>(columnName: 'price', value: order.price),
          DataGridCell<String>(columnName: 'city', value: order.city),
          DataGridCell<double>(columnName: 'freight', value: order.freight),
          DataGridCell<double>(
            columnName: 'totalPrice',
            value: order.totalPrice,
          ),
        ],
      );
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        String formattedValue;
        bool isCurrencyColumn = [
          'price',
          'freight',
          'totalPrice',
        ].contains(dataGridCell.columnName);

        // Format currency values
        if (isCurrencyColumn && dataGridCell.value is num) {
          formattedValue = currencyFormat.format(dataGridCell.value);
        } else {
          formattedValue = dataGridCell.value.toString();
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          alignment: isCurrencyColumn
              ? AlignmentDirectional.centerEnd
              : AlignmentDirectional
                    .centerStart, // Align currency columns to right
          child: Text(
            formattedValue,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        );
      }).toList(),
    );
  }

  /// **Builds the table summary row**
  @override
  Widget? buildTableSummaryCellWidget(
    GridTableSummaryRow summaryRow,
    GridSummaryColumn? summaryColumn,
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    double value = double.tryParse(summaryValue) ?? 0.0;

    // Format only the numeric columns
    if (summaryColumn != null &&
        (summaryColumn.columnName == 'price' ||
            summaryColumn.columnName == 'freight' ||
            summaryColumn.columnName == 'totalPrice')) {
      final currencyFormat = NumberFormat.currency(
        locale: 'en_US',
        symbol: '\$',
      );
      summaryValue = currencyFormat.format(value);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
      height: 44.0, // Define the height directly
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        summaryValue,
        style: TableStyle.tableHeaderTextStyle(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_data.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// A custom DataGridSource for MarketData.
class InvoiceDataSource extends DataGridSource {
  final BuildContext context;
  InvoiceDataSource(
    this.context, {
    required List<InvoiceData> allPortofioItem,
  }) {
    _allInvoiceData = allPortofioItem;

    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];
  List<InvoiceData> _allInvoiceData = []; // Holds the complete list of data

  @override
  List<DataGridRow> get rows => _dataGridRows;

  final _currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  void _buildDataGridRows() {
    _dataGridRows = _allInvoiceData
        .map<DataGridRow>(
          (invoice) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'id', value: invoice.id),
              DataGridCell<InvoiceData>(columnName: 'customer', value: invoice),
              DataGridCell<String>(columnName: 'email', value: invoice.email),
              DataGridCell<String>(
                columnName: 'country',
                value: invoice.country,
              ),
              DataGridCell<DateTime>(columnName: 'date', value: invoice.date),
              DataGridCell<double>(columnName: 'amount', value: invoice.amount),
              DataGridCell<PaymentStatus>(
                columnName: 'status',
                value: invoice.status,
              ),
              DataGridCell<InvoiceData>(columnName: 'action', value: invoice),
            ],
          ),
        )
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final themeData = Theme.of(context);

    final invoice =
        row.getCells().firstWhere((cell) => cell.columnName == 'customer').value
            as InvoiceData;
    final status =
        row.getCells().firstWhere((cell) => cell.columnName == 'status').value
            as PaymentStatus;

    return DataGridRowAdapter(
      cells: [
        // ID
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[0].value.toString(),
            style: TextStyle(
              color: themeData.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Customer: avatar & name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(invoice.avatarUrl),
                radius: 16,
              ),
              SizedBox(width: kDefaultPadding / 2),
              Flexible(
                child: Text(
                  invoice.customerName,
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),

        // email
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[2].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // country
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[3].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            DateFormat('d MMM, yyyy').format(row.getCells()[4].value),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // ammount
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            _currencyFormat.format(row.getCells()[5].value),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // Payment Status
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: CustomBadge(
            kText: status.uppercaseLabel,
            kColor: getStatusColor(status),
            isRounded: true,
            isOutlined: true,
          ),
        ),

        // Action Dropdown
        Container(
          alignment: Alignment.center,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu selection
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'view', child: Text('View')),
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'download', child: Text('Download')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
            tooltip: 'Action',
            child: Container(
              padding: const EdgeInsets.all(0.5 * kDefaultPadding),
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
          ),
        ),
      ],
    );
  }
}

// Invoice table

class InvoiceTable extends StatefulWidget {
  const InvoiceTable({super.key});

  @override
  State<InvoiceTable> createState() => _InvoiceTableState();
}

class _InvoiceTableState extends State<InvoiceTable> {
  late InvoiceDataSource _invoiceDataSource;
  List<InvoiceData> _allInvoiceData = [];
  final int _rowsPerPage = 15; // Number of rows to display per page
  final double dataPagerHeight = 60.0; // Height for the pager

  @override
  void initState() {
    super.initState();
    _allInvoiceData = mockInvoices; // Get all 30 mock data entries
    _invoiceDataSource = InvoiceDataSource(
      allPortofioItem: _allInvoiceData,
      context,
    );
  }

  void _openCreateInvoiceScreen() {
    GoRouter.of(context).go(RouteUri.invoiceCreate);
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;
    final GlobalKey<PopupMenuButtonState> popupSearchbar =
        GlobalKey<PopupMenuButtonState>();
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Text(
                  'Portfolio Status'.toUpperCase(),
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Spacer(),

                // search bar
                isMobile
                    ? PopupMenuButton(
                        key: popupSearchbar,
                        splashRadius: 0.0,
                        tooltip: '',
                        position: PopupMenuPosition.under,
                        color: themeData.colorScheme.surface,
                        constraints: BoxConstraints(
                          maxWidth: mediaQueryData.size.width <= kScreenWidthMd
                              ? mediaQueryData.size.width
                              : 360,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            enabled: false,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: OutlineSearchBar(
                                hintText: 'Search invoice',
                                autofocus: true,
                              ),
                            ),
                          ),
                        ],
                        child: CustomIconButton(
                          icon: Icons.search,
                          iconColor: kTextColor,
                          buttonColor: themeData.colorScheme.surface,
                          onTap: () {
                            popupSearchbar.currentState?.showButtonMenu();
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(
                        width: 240,
                        child: OutlineSearchBar(hintText: 'Search invoice'),
                      ),

                SizedBox(
                  width: isMobile ? kDefaultPadding / 2 : kDefaultPadding,
                ),

                // create button
                isMobile
                    ? CustomIconButton(
                        icon: Icons.add,
                        iconColor: Colors.white,
                        buttonColor: kErrorColor,
                        onTap: _openCreateInvoiceScreen,
                      )
                    : FlatButton(
                        kText: 'Create invoice',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: _openCreateInvoiceScreen,
                        kLeadingIcon: Icons.add,
                      ),
              ],
            ),
          ),
          SizedBox(
            child: SfDataGridTheme(
              data: TableStyle.dataGridTheme,
              child: ClipRect(
                clipper: CustomLeftClipper(),
                child: SfDataGrid(
                  source: _invoiceDataSource,
                  shrinkWrapRows: true,
                  verticalScrollPhysics: NeverScrollableScrollPhysics(),
                  allowSorting: isMobile ? false : true,
                  columnWidthMode:
                      MediaQuery.of(context).size.width < kScreenWidthMd
                      ? ColumnWidthMode.none
                      : ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.horizontal,
                  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                  showCheckboxColumn: false,
                  rowHeight: rowHeight,
                  headerRowHeight: headerRowHeight,
                  allowFiltering: false,
                  selectionMode: SelectionMode.multiple,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'id',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ID',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 120,
                    ),
                    GridColumn(
                      columnName: 'customer',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Customer',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 180,
                    ),
                    GridColumn(
                      columnName: 'email',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 240,
                    ),
                    GridColumn(
                      columnName: 'country',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Country',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 140,
                    ),
                    GridColumn(
                      columnName: 'date',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
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
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Amount',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 120,
                    ),
                    GridColumn(
                      columnName: 'status',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Payment Status',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),
                    GridColumn(
                      columnName: 'action',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Action',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 100,
                      allowSorting: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Paginator
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
                delegate: _invoiceDataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,
                pageCount: (_allInvoiceData.isEmpty)
                    ? 1
                    : (_allInvoiceData.length / _rowsPerPage).ceilToDouble(),
                visibleItemsCount:
                    _rowsPerPage, // Correctly use _rowsPerPage here
                direction: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

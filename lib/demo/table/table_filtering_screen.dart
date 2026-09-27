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
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableFilteringScreen extends StatefulWidget {
  const TableFilteringScreen({super.key});

  @override
  State<TableFilteringScreen> createState() => _TableFilteringScreenState();
}

class _TableFilteringScreenState extends State<TableFilteringScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).filteringTable; //update your page tittle here
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
                      lang.filteringTable.toUpperCase(),
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
                          label: lang.filteringTable,
                          uri: RouteUri.tableFiltering,
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
                  cardTitle: 'Filtering Table',
                  description:
                      'Table that provide comprehensive filtering capabilities, including Excel-like filtering support. This allows users to filter rows based on various criteria directly within the DataGrid.',
                  uiView: FilteringTable(),
                  codeView:
                      '''FilteringTable() source code can be found in the lib/demo/table/table_filtering_screen.dart file.''',
                ),
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

class FilteringTable extends StatefulWidget {
  const FilteringTable({super.key});

  @override
  State<FilteringTable> createState() => _FilteringTableState();
}

class _FilteringTableState extends State<FilteringTable> {
  late OrderDataSource orderDataSource;
  List<Order> orders = <Order>[];

  @override
  void initState() {
    super.initState();
    orders = getOrderData();
    orderDataSource = OrderDataSource(orders, setState, context);
  }

  List<Order> getOrderData() {
    return [
      // Five sales on the same date (2024-02-25)
      Order(
        '#AD025',
        '2024-02-25',
        'Completed',
        'Liam Watson',
        'Product A',
        120.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD026',
        '2024-02-25',
        'Pending',
        'Sophia Martinez',
        'Product B',
        80.5,
        'assets/images/avatar_2.jpg',
      ),
      Order(
        '#AD027',
        '2024-02-25',
        'Cancelled',
        'Oliver King',
        'Product C',
        50.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD028',
        '2024-02-25',
        'Completed',
        'Amelia White',
        'Product D',
        200.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD029',
        '2024-02-25',
        'Pending',
        'Lucas Brown',
        'Product E',
        150.0,
        'assets/images/avatar_5.jpg',
      ),

      // Five completed sales
      Order(
        '#AD030',
        '2024-02-24',
        'Completed',
        'Ethan Hall',
        'Product F',
        90.0,
        'assets/images/avatar_6.jpg',
      ),
      Order(
        '#AD031',
        '2024-02-23',
        'Completed',
        'Emily Adams',
        'Product G',
        60.0,
        'assets/images/avatar_7.jpg',
      ),
      Order(
        '#AD032',
        '2024-02-22',
        'Completed',
        'William Carter',
        'Product H',
        220.0,
        'assets/images/avatar_8.jpg',
      ),
      Order(
        '#AD033',
        '2024-02-21',
        'Completed',
        'Grace Thompson',
        'Product I',
        175.0,
        'assets/images/avatar_9.jpg',
      ),
      Order(
        '#AD034',
        '2024-02-20',
        'Completed',
        'Olivia Nelson',
        'Product J',
        110.0,
        'assets/images/avatar_10.jpg',
      ),

      // Five pending sales
      Order(
        '#AD035',
        '2024-02-19',
        'Pending',
        'James Roberts',
        'Product K',
        70.0,
        'assets/images/avatar_11.jpg',
      ),
      Order(
        '#AD036',
        '2024-02-18',
        'Pending',
        'Henry Turner',
        'Product L',
        140.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD037',
        '2024-02-17',
        'Pending',
        'Sophia Harris',
        'Product G',
        95.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD038',
        '2024-02-16',
        'Pending',
        'Lucas Scott',
        'Product C',
        55.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD039',
        '2024-02-15',
        'Pending',
        'Benjamin Walker',
        'Product F',
        190.0,
        'assets/images/avatar_5.jpg',
      ),

      // Five cancelled sales
      Order(
        '#AD040',
        '2024-02-14',
        'Cancelled',
        'Noah Turner',
        'Product D',
        130.0,
        'assets/images/avatar_6.jpg',
      ),
      Order(
        '#AD041',
        '2024-02-13',
        'Cancelled',
        'Lily Campbell',
        'Product F',
        85.0,
        'assets/images/avatar_7.jpg',
      ),
      Order(
        '#AD042',
        '2024-02-12',
        'Cancelled',
        'Mason Ramirez',
        'Product A',
        45.0,
        'assets/images/avatar_8.jpg',
      ),
      Order(
        '#AD043',
        '2024-02-11',
        'Cancelled',
        'Emma Wright',
        'Product B',
        210.0,
        'assets/images/avatar_9.jpg',
      ),
      Order(
        '#AD044',
        '2024-02-10',
        'Cancelled',
        'Aiden Harris',
        'Product A',
        165.0,
        'assets/images/avatar_10.jpg',
      ),

      // Five sales of each product
      Order(
        '#AD045',
        '2024-02-09',
        'Completed',
        'Jack Mitchell',
        'Product A',
        120.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD046',
        '2024-02-08',
        'Pending',
        'Sophie Reed',
        'Product B',
        80.5,
        'assets/images/avatar_2.jpg',
      ),
      Order(
        '#AD047',
        '2024-02-07',
        'Cancelled',
        'Ethan Foster',
        'Product C',
        50.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD048',
        '2024-02-06',
        'Completed',
        'Ava Richardson',
        'Product D',
        200.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD049',
        '2024-02-05',
        'Pending',
        'Daniel King',
        'Product E',
        150.0,
        'assets/images/avatar_5.jpg',
      ),

      // Additional 10 orders to reach 40
      Order(
        '#AD050',
        '2024-02-04',
        'Completed',
        'Isabella White',
        'Product F',
        90.0,
        'assets/images/avatar_6.jpg',
      ),
      Order(
        '#AD051',
        '2024-02-03',
        'Pending',
        'Liam Anderson',
        'Product G',
        60.0,
        'assets/images/avatar_7.jpg',
      ),
      Order(
        '#AD052',
        '2024-02-02',
        'Cancelled',
        'Ava Carter',
        'Product H',
        220.0,
        'assets/images/avatar_8.jpg',
      ),
      Order(
        '#AD053',
        '2024-02-01',
        'Completed',
        'Noah Smith',
        'Product I',
        175.0,
        'assets/images/avatar_9.jpg',
      ),
      Order(
        '#AD054',
        '2024-01-31',
        'Pending',
        'Sophia Johnson',
        'Product J',
        110.0,
        'assets/images/avatar_10.jpg',
      ),
      Order(
        '#AD055',
        '2024-01-30',
        'Cancelled',
        'Oliver Williams',
        'Product K',
        70.0,
        'assets/images/avatar_11.jpg',
      ),
      Order(
        '#AD056',
        '2024-01-29',
        'Completed',
        'Amelia Brown',
        'Product L',
        140.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD057',
        '2024-01-28',
        'Pending',
        'Lucas Miller',
        'Product F',
        95.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD058',
        '2024-01-27',
        'Cancelled',
        'Benjamin Davis',
        'Product C',
        55.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD059',
        '2024-01-26',
        'Completed',
        'Mia Wilson',
        'Product D',
        190.0,
        'assets/images/avatar_5.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: orderDataSource,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: [
          GridColumn(
            columnName: 'ID',
            label: Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
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
              alignment: AlignmentDirectional.centerStart,
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
            label: Container(
              alignment: AlignmentDirectional.centerStart,
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
              alignment: AlignmentDirectional.centerStart,
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
              alignment: AlignmentDirectional.centerStart,
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
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
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
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
        allowFiltering: true, // allow filtering
      ),
    );
  }
}

class Order {
  Order(
    this.id,
    this.date,
    this.status,
    this.customer,
    this.purchased,
    this.revenue,
    this.avatar,
  );
  final String id;
  final String date;
  final String status;
  final String customer;
  final String purchased;
  final double revenue;
  final String avatar;
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
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
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
          alignment: AlignmentDirectional.centerStart,
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
          alignment: AlignmentDirectional.centerStart,
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
          alignment: AlignmentDirectional.centerStart,
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // purchased cell
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            row.getCells()[4].value.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),

        // revenue cell
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
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

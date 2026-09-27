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

class TableCheckboxColumnScreen extends StatefulWidget {
  const TableCheckboxColumnScreen({super.key});

  @override
  State<TableCheckboxColumnScreen> createState() =>
      _TableCheckboxColumnScreenState();
}

class _TableCheckboxColumnScreenState extends State<TableCheckboxColumnScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).checkboxColumbTable; //update your page tittle here
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
                      lang.checkboxColumbTable.toUpperCase(),
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
                          label: lang.checkboxColumbTable,
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
                  cardTitle: 'Checkbox Column Table',
                  description:
                      'A table designed with interactive checkboxes in each row, primarily for user selection of one or more rows.',
                  uiView: CheckboxColumnTable(),
                  codeView:
                      '''CheckboxColumnTable() source code can be found in the lib/demo/table/table_checkbox_column_screen.dart file.''',
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

class CheckboxColumnTable extends StatefulWidget {
  const CheckboxColumnTable({super.key});

  @override
  State<CheckboxColumnTable> createState() => _CheckboxColumnTableState();
}

class _CheckboxColumnTableState extends State<CheckboxColumnTable> {
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
      Order(
        '#AD001',
        '2024-02-25',
        'Completed',
        'John Doe',
        'Product A',
        120.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD002',
        '2024-02-24',
        'Pending',
        'Jane Smith',
        'Product B',
        80.5,
        'assets/images/avatar_2.jpg',
      ),
      Order(
        '#AD003',
        '2024-02-23',
        'Cancelled',
        'Alice Brown',
        'Product C',
        50.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD004',
        '2024-02-22',
        'Completed',
        'Bob Johnson',
        'Product D',
        200.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD005',
        '2024-02-21',
        'Completed',
        'Charlie Wilson',
        'Product E',
        150.0,
        'assets/images/avatar_5.jpg',
      ),
      Order(
        '#AD006',
        '2024-02-20',
        'Pending',
        'Diana Evans',
        'Product F',
        90.0,
        'assets/images/avatar_6.jpg',
      ),
      Order(
        '#AD007',
        '2024-02-19',
        'Cancelled',
        'Ethan Carter',
        'Product G',
        60.0,
        'assets/images/avatar_7.jpg',
      ),
      Order(
        '#AD008',
        '2024-02-18',
        'Completed',
        'Fiona Green',
        'Product H',
        220.0,
        'assets/images/avatar_8.jpg',
      ),
      Order(
        '#AD009',
        '2024-02-17',
        'Completed',
        'George Hall',
        'Product I',
        175.0,
        'assets/images/avatar_9.jpg',
      ),
      Order(
        '#AD010',
        '2024-02-16',
        'Pending',
        'Hannah Lewis',
        'Product J',
        110.0,
        'assets/images/avatar_10.jpg',
      ),
      Order(
        '#AD011',
        '2024-02-15',
        'Cancelled',
        'Ian Martin',
        'Product K',
        70.0,
        'assets/images/avatar_11.jpg',
      ),
      Order(
        '#AD012',
        '2024-02-14',
        'Completed',
        'Jack Nelson',
        'Product L',
        140.0,
        'assets/images/avatar_1.jpg',
      ),
      Order(
        '#AD013',
        '2024-02-13',
        'Pending',
        'Karen Owens',
        'Product M',
        95.0,
        'assets/images/avatar_3.jpg',
      ),
      Order(
        '#AD014',
        '2024-02-12',
        'Cancelled',
        'Liam Parker',
        'Product N',
        55.0,
        'assets/images/avatar_4.jpg',
      ),
      Order(
        '#AD015',
        '2024-02-11',
        'Completed',
        'Mia Quinn',
        'Product O',
        190.0,
        'assets/images/avatar_5.jpg',
      ),
      Order(
        '#AD016',
        '2024-02-10',
        'Completed',
        'Nathan Reed',
        'Product P',
        130.0,
        'assets/images/avatar_6.jpg',
      ),
      Order(
        '#AD017',
        '2024-02-09',
        'Pending',
        'Olivia Scott',
        'Product Q',
        85.0,
        'assets/images/avatar_7.jpg',
      ),
      Order(
        '#AD018',
        '2024-02-08',
        'Cancelled',
        'Paul Turner',
        'Product R',
        45.0,
        'assets/images/avatar_8.jpg',
      ),
      Order(
        '#AD019',
        '2024-02-07',
        'Completed',
        'Quinn Underwood',
        'Product S',
        210.0,
        'assets/images/avatar_9.jpg',
      ),
      Order(
        '#AD020',
        '2024-02-06',
        'Completed',
        'Rachel Vaughn',
        'Product T',
        165.0,
        'assets/images/avatar_10.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: CheckboxTheme(
        data: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Border radius
          ),
          side: BorderSide(
            width: 1, // Border width
            color: Theme.of(context).colorScheme.outline, // Border color
          ),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return kPrimaryColor; // Checked color
            }
            return Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest; // Default color
          }),
          checkColor: WidgetStateProperty.all(Colors.white), // Checkmark color
        ),
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
          showCheckboxColumn: true,
          selectionMode: SelectionMode.multiple,
        ),
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

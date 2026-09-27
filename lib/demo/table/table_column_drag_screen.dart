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
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ColumnDragTableScreen extends StatefulWidget {
  const ColumnDragTableScreen({super.key});

  @override
  State<ColumnDragTableScreen> createState() => _ColumnDragTableScreenState();
}

class _ColumnDragTableScreenState extends State<ColumnDragTableScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).dragColumnTable; //update your page tittle here
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
                      lang.dragColumnTable.toUpperCase(),
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
                          label: lang.dragColumnTable,
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
                  cardTitle: 'Drag Drop Column Table',
                  description:
                      'Table with drag and drop column feature. Please drag and drop the column header to reorder.',
                  uiView: TableColumnDragging(),
                  codeView:
                      '''TableColumnDragging() source code can be found in the lib/demo/table/table_column_drag_screen.dart file.''',
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

class TableColumnDragging extends StatefulWidget {
  const TableColumnDragging({super.key});

  @override
  State<TableColumnDragging> createState() => _TableColumnDraggingState();
}

class _TableColumnDraggingState extends State<TableColumnDragging> {
  late CustomerDataSource customerDataSource;
  late List<GridColumn> columns;

  @override
  void initState() {
    super.initState();
    columns = getColumns();
    customerDataSource = CustomerDataSource(
      customers: getCustomers(),
      columns: columns,
    );
  }

  List<GridColumn> getColumns() {
    return [
      GridColumn(
        columnName: 'Customer',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Customer',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'Email',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'Phone',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Phone',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'Order Date',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Order Date',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'Delivery Status',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Delivery Status',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'Action',
        label: Container(
          alignment: Alignment.center,
          child: const Text(
            'Action',
            style: TextStyle(fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  List<Map<String, dynamic>> getCustomers() {
    return [
      {
        'Customer': 'John Doe',
        'Email': 'john@example.com',
        'Phone': '123-456-7890',
        'Order Date': '2023-01-15',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Jane Smith',
        'Email': 'jane@example.com',
        'Phone': '987-654-3210',
        'Order Date': '2022-11-20',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Michael Brown',
        'Email': 'michael@example.com',
        'Phone': '456-789-1234',
        'Order Date': '2021-09-10',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Emily Davis',
        'Email': 'emily@example.com',
        'Phone': '321-654-9870',
        'Order Date': '2023-02-05',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Chris Wilson',
        'Email': 'chris@example.com',
        'Phone': '741-852-9630',
        'Order Date': '2023-03-22',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Sarah Johnson',
        'Email': 'sarah@example.com',
        'Phone': '963-852-7410',
        'Order Date': '2023-04-10',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'David Martinez',
        'Email': 'david@example.com',
        'Phone': '852-963-1470',
        'Order Date': '2022-12-30',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Sophia Lopez',
        'Email': 'sophia@example.com',
        'Phone': '159-357-4860',
        'Order Date': '2023-05-15',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Daniel White',
        'Email': 'daniel@example.com',
        'Phone': '789-654-1230',
        'Order Date': '2022-10-20',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Olivia Anderson',
        'Email': 'olivia@example.com',
        'Phone': '456-321-9870',
        'Order Date': '2021-08-10',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Ethan Thomas',
        'Email': 'ethan@example.com',
        'Phone': '852-147-9630',
        'Order Date': '2023-07-18',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Ava Hernandez',
        'Email': 'ava@example.com',
        'Phone': '357-159-4860',
        'Order Date': '2022-11-05',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Liam King',
        'Email': 'liam@example.com',
        'Phone': '951-753-2580',
        'Order Date': '2023-06-22',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Isabella Wright',
        'Email': 'isabella@example.com',
        'Phone': '159-852-3570',
        'Order Date': '2022-09-30',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Mason Scott',
        'Email': 'mason@example.com',
        'Phone': '357-951-7530',
        'Order Date': '2023-08-14',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Mia Green',
        'Email': 'mia@example.com',
        'Phone': '456-852-1590',
        'Order Date': '2021-07-25',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'James Hall',
        'Email': 'james@example.com',
        'Phone': '753-951-3570',
        'Order Date': '2023-09-10',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Charlotte Baker',
        'Email': 'charlotte@example.com',
        'Phone': '159-753-8520',
        'Order Date': '2022-08-19',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Benjamin Adams',
        'Email': 'benjamin@example.com',
        'Phone': '852-159-7530',
        'Order Date': '2023-10-05',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Amelia Nelson',
        'Email': 'amelia@example.com',
        'Phone': '357-258-1470',
        'Order Date': '2022-07-12',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Alexander Cooper',
        'Email': 'alex@example.com',
        'Phone': '963-753-2580',
        'Order Date': '2023-11-15',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Emma Reed',
        'Email': 'emma@example.com',
        'Phone': '147-258-3690',
        'Order Date': '2022-05-25',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Henry Carter',
        'Email': 'henry@example.com',
        'Phone': '357-159-7530',
        'Order Date': '2021-04-20',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Ella Phillips',
        'Email': 'ella@example.com',
        'Phone': '753-258-1470',
        'Order Date': '2023-03-10',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Lucas Young',
        'Email': 'lucas@example.com',
        'Phone': '951-753-3570',
        'Order Date': '2022-06-18',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Harper Collins',
        'Email': 'harper@example.com',
        'Phone': '258-369-1470',
        'Order Date': '2021-12-08',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
      {
        'Customer': 'Matthew Turner',
        'Email': 'matthew@example.com',
        'Phone': '753-159-8520',
        'Order Date': '2023-05-05',
        'Delivery Status': 'Shipped',
        'Action': 'Edit',
      },
      {
        'Customer': 'Sophie Bennett',
        'Email': 'sophie@example.com',
        'Phone': '147-753-2580',
        'Order Date': '2022-09-22',
        'Delivery Status': 'Delivered',
        'Action': 'Edit',
      },
      {
        'Customer': 'Ryan Hughes',
        'Email': 'ryan@example.com',
        'Phone': '357-852-1590',
        'Order Date': '2023-01-30',
        'Delivery Status': 'Pending',
        'Action': 'Edit',
      },
    ];
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
        allowColumnsDragging: true, // Enables column dragging
        columns: columns,
        onColumnDragging: (DataGridColumnDragDetails details) {
          if (details.action == DataGridColumnDragAction.dropped &&
              details.to != null) {
            final GridColumn movedColumn = columns[details.from];
            columns.removeAt(details.from);
            columns.insert(details.to!, movedColumn);
            customerDataSource
                .buildDataGridRows(); // Rebuild rows after reorder
            customerDataSource.refreshDataGrid(); // Refresh UI
          }
          return true;
        },

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

class CustomerDataSource extends DataGridSource {
  CustomerDataSource({required this.customers, required this.columns}) {
    buildDataGridRows();
  }

  List<Map<String, dynamic>> customers;
  List<GridColumn> columns;
  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = customers.map<DataGridRow>((customer) {
      return DataGridRow(
        cells: columns.map<DataGridCell>((column) {
          return DataGridCell(
            columnName: column.columnName,
            value: customer[column.columnName],
          );
        }).toList(),
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((dataGridCell) {
        Widget cellContent;

        if (dataGridCell.columnName == 'Delivery Status') {
          // Show label for delivery status
          cellContent = buildDeliveryStatusLabel(dataGridCell.value.toString());
        } else if (dataGridCell.columnName == 'Action') {
          // Show an action button
          cellContent = FlatButton(
            kText: 'Edit',
            kTextColor: kTextColor,
            bgColor: kTableHeaderColor,
            size: ButtonSize.small,
            onPressed: () {
              debugPrint(
                "Edit button clicked for ${row.getCells().first.value}",
              );
            },
          );
        } else {
          // Default text content
          cellContent = Text(dataGridCell.value.toString());
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: cellContent,
        );
      }).toList(),
    );
  }

  Widget buildDeliveryStatusLabel(String status) {
    Color bgColor;
    switch (status) {
      case 'Delivered':
        bgColor = kSuccessColor;
        break;
      case 'Pending':
        bgColor = kErrorColor;
        break;
      case 'Shipped':
        bgColor = kInfoColor;
        break;
      default:
        bgColor = Colors.grey;
    }

    return CustomBadge(kText: status, kColor: bgColor, isRounded: true);
  }

  void refreshDataGrid() {
    notifyListeners();
  }
}

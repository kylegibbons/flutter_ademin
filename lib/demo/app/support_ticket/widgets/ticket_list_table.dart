import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutkit_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// ticket table

class TicketListTable extends StatefulWidget {
  const TicketListTable({super.key});

  @override
  State<TicketListTable> createState() => _TicketListTableState();
}

class _TicketListTableState extends State<TicketListTable> {
  late TicketDataSource _ticketDataSource;
  List<TicketData> _allTicketData = [];
  final int _rowsPerPage = 15; // Number of rows to display per page
  final double dataPagerHeight = 60.0; // Height for the pager

  @override
  void initState() {
    super.initState();
    _allTicketData = mockTickets; // Get all 30 mock data entries
    _ticketDataSource = TicketDataSource(
      allTicketItem: _allTicketData,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    final isMobile = mediaQueryData.size.width < kScreenWidthSm;
    final GlobalKey<PopupMenuButtonState> popupTicketSearchbar =
        GlobalKey<PopupMenuButtonState>();
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Row(
              children: [
                Text(
                  'Tickets'.toUpperCase(),
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
                        key: popupTicketSearchbar,
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
                                hintText: 'Search tickets',
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
                            popupTicketSearchbar.currentState?.showButtonMenu();
                          },
                          isOutlined: true,
                        ),
                      )
                    : SizedBox(
                        width: 240,
                        child: OutlineSearchBar(hintText: 'Search tickets'),
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
                        onTap: () {},
                      )
                    : FlatButton(
                        kText: 'Create ticket',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {},
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
                  source: _ticketDataSource,
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
                    // ticket id
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
                      width: 100,
                    ),

                    // title
                    GridColumn(
                      columnName: 'title',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      width: 220,
                    ),

                    // client
                    GridColumn(
                      columnName: 'client',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Client',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 160,
                    ),

                    // assignee
                    GridColumn(
                      columnName: 'assignee',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Assign to',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 160,
                    ),

                    // Created Date
                    GridColumn(
                      columnName: 'createdDate',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Created Date',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),

                    // Due Date
                    GridColumn(
                      columnName: 'dueDate',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Due Date',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),

                    // Status
                    GridColumn(
                      columnName: 'status',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Status',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),

                    // Status
                    GridColumn(
                      columnName: 'priority',
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Priority',
                          style: TableStyle.tableHeaderTextStyle(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      minimumWidth: 120,
                    ),

                    // Action
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
                delegate: _ticketDataSource,
                itemHeight: 44,
                itemWidth: 44,
                navigationItemHeight: 44,
                navigationItemWidth: 44,
                pageCount: (_allTicketData.isEmpty)
                    ? 1
                    : (_allTicketData.length / _rowsPerPage).ceilToDouble(),
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

/// A custom DataGridSource for MarketData.
class TicketDataSource extends DataGridSource {
  final BuildContext context;
  TicketDataSource(this.context, {required List<TicketData> allTicketItem}) {
    _allTicketData = allTicketItem;

    _buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = [];
  List<TicketData> _allTicketData = []; // Holds the complete list of data

  @override
  List<DataGridRow> get rows => _dataGridRows;

  // final _currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  void _buildDataGridRows() {
    _dataGridRows = _allTicketData
        .map<DataGridRow>(
          (ticket) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'id', value: ticket.id),
              DataGridCell<String>(columnName: 'title', value: ticket.title),
              DataGridCell<TicketData>(columnName: 'client', value: ticket),
              DataGridCell<TicketData>(columnName: 'assignee', value: ticket),
              DataGridCell<DateTime>(
                columnName: 'createdDate',
                value: ticket.createdDate,
              ),
              DataGridCell<DateTime>(
                columnName: 'dueDate',
                value: ticket.dueDate,
              ),
              DataGridCell<TicketStatus>(
                columnName: 'status',
                value: ticket.status,
              ),
              DataGridCell<TicketPriority>(
                columnName: 'priority',
                value: ticket.priority,
              ),
              DataGridCell<TicketData>(columnName: 'action', value: ticket),
            ],
          ),
        )
        .toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final themeData = Theme.of(context);

    final client =
        row.getCells().firstWhere((cell) => cell.columnName == 'client').value
            as TicketData;
    final assignee =
        row.getCells().firstWhere((cell) => cell.columnName == 'assignee').value
            as TicketData;
    final status =
        row.getCells().firstWhere((cell) => cell.columnName == 'status').value
            as TicketStatus;
    final priority =
        row.getCells().firstWhere((cell) => cell.columnName == 'priority').value
            as TicketPriority;

    return DataGridRowAdapter(
      cells: [
        // ID
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[0].value.toString(),
            style: TextStyle(color: themeData.colorScheme.primary),
          ),
        ),

        // title
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            row.getCells()[1].value.toString(),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // client: avatar & name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(client.client.avatarUrl),
                radius: 16,
              ),
              SizedBox(width: kDefaultPadding / 2),
              Flexible(
                child: Text(
                  client.client.name,
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),

        // assignee: avatar & name
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: buildAssigneeAvatars(assignee.assignedTo),
        ),

        // created date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            DateFormat('d MMM, yyyy').format(row.getCells()[4].value),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // due date
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            DateFormat('d MMM, yyyy').format(row.getCells()[5].value),
            style: TextStyle(color: themeData.colorScheme.onSurface),
          ),
        ),

        // ticket Status
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: CustomBadge(
            kText: getStatusInfo(status).label.toUpperCase(),
            kColor: getStatusInfo(status).color,
            isOutlined: true,
          ),
        ),

        // ticket priority
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: CustomBadge(
            kText: priority.name.toUpperCase(),
            kColor: getPriorityColor(priority),
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
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
            tooltip: 'Action',
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding / 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kInfoColor.withValues(alpha: 0.1),
              ),
              child: Icon(Icons.more_horiz, color: kInfoColor, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAssigneeAvatars(List<UserInfo> users) {
    const maxVisible = 3;
    final visibleUsers = users.take(maxVisible).toList();
    final remaining = users.length - maxVisible;

    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          ...visibleUsers.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;

            return Positioned(
              left: index * 24,
              child: Tooltip(
                message: user.name,
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(user.avatarUrl),
                ),
              ),
            );
          }),

          // +x overflow circle if needed
          if (remaining > 0)
            Positioned(
              left: visibleUsers.length * 24,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey.shade200,
                child: Text(
                  '+$remaining',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/user_management/dialogs/add_user_form.dart';
import 'package:flutkit_ademin/demo/app/user_management/dialogs/delete_warning.dart';
import 'package:flutkit_ademin/demo/app/user_management/dialogs/edit_user_form.dart';
import 'package:flutkit_ademin/demo/app/user_management/user_management_data.dart';
import 'package:flutkit_ademin/demo/app/user_management/user_management_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/dialog.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// USER MANAGEMENT TABLE //

class UserManagementTable extends StatefulWidget {
  const UserManagementTable({super.key});

  @override
  State<UserManagementTable> createState() => _UserManagementTableState();
}

/// The number of rows displayed per page in the data grid.
int _rowsPerPage = 15;

class _UserManagementTableState extends State<UserManagementTable> {
  /// Data source for the DataGrid.
  late UserDataSource _userDataSource;

  /// Height of the DataPager widget.
  final double _dataPagerHeight = 60.0;

  /// List to store order data.
  List<UserModel> _users = <UserModel>[];

  // build rows per page selector
  List<int> buildAvailableRowsPerPage(int total, {int step = 15}) {
    final List<int> result = [];

    for (int i = step; i < total; i += step) {
      result.add(i);
    }

    if (!result.contains(total)) {
      result.add(total);
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    _users = mockUsers; // Fetch sample order data
    _userDataSource = UserDataSource(
      users: _users,
      context: context,
    ); // Initialize data source
  }

  void _showAddUserDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: "Add New User",
      showCloseButton: true,
      content: AddUserForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraint) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // header
                Row(
                  children: [
                    // search bar
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.search,
                            tooltipMessage: 'Search',
                            iconColor: kTextColor,
                            buttonColor: themeData.colorScheme.surface,
                            isOutlined: true,
                            onTap: () {},
                          )
                        : SizedBox(
                            width: 240,
                            child: SoftSearchBar(hintText: 'Search...'),
                          ),

                    Spacer(),

                    // export button
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.download_outlined,
                            iconColor: themeData.colorScheme.primary,
                            buttonColor: themeData.colorScheme.primary
                                .withValues(alpha: 0.1),
                            tooltipMessage: 'Export',

                            onTap: () {},
                          )
                        : SoftButton(
                            kText: 'Export',
                            bgColor: themeData.colorScheme.primary,
                            onPressed: () {},
                            kLeadingIcon: Icons.download_outlined,
                          ),

                    SizedBox(width: kDefaultPadding),
                    // add user button
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kSecondaryColor,
                            tooltipMessage: 'Add User',
                            onTap: () {
                              _showAddUserDialog(context);
                            },
                          )
                        : FlatButton(
                            kText: 'Add User',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              _showAddUserDialog(context);
                            },
                            kLeadingIcon: Icons.add_outlined,
                          ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),
                // DataGrid
                SizedBox(child: _buildDataGrid(constraint)),

                // Data pager for pagination
                SizedBox(
                  height: _dataPagerHeight,
                  child: SfDataPagerTheme(
                    data: SfDataPagerThemeData(
                      itemBorderRadius: BorderRadius.circular(defaultRadius),
                      selectedItemColor: kSecondaryColor,
                      itemTextStyle: const TextStyle(
                        fontSize: kBodyMedium, // Customize font size
                      ),
                      selectedItemTextStyle: const TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w600, // Bold for active page
                        color: Colors.white, // Customize selected text color
                      ),
                    ),
                    child: SfDataPager(
                      delegate: _userDataSource,
                      itemHeight: 44,
                      itemWidth: 44,
                      navigationItemHeight: 44,
                      navigationItemWidth: 44,
                      pageCount: (_users.length / _rowsPerPage)
                          .ceil()
                          .toDouble(),
                      availableRowsPerPage: buildAvailableRowsPerPage(
                        _users.length,
                      ),
                      // Options for rows per page
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
            ),
          ),
        );
      },
    );
  }

  /// Builds the Syncfusion DataGrid.
  Widget _buildDataGrid(BoxConstraints constraint) {
    double rowHeight = 48.0; // Height per row
    double headerRowHeight = 48.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _userDataSource,
        allowFiltering: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: <GridColumn>[
          GridColumn(
            columnName: 'fullName',
            allowFiltering: false,
            minimumWidth: 180,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Full Name',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'email',
            allowFiltering: false,
            minimumWidth: 220,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Email',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'username',
            allowFiltering: false,
            minimumWidth: 120,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Username',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'status',
            minimumWidth: 120,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Status',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),

          GridColumn(
            columnName: 'plan',
            minimumWidth: 120,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Plan',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'joinedDate',
            minimumWidth: 150,
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Joined',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'lastActive',
            minimumWidth: 150,
            allowFiltering: false,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Last Active',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),

          GridColumn(
            columnName: 'action',
            allowFiltering: false,
            allowSorting: false,
            width: 100,
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                'Action',
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
}

/// Data source for Syncfusion DataGrid.
class UserDataSource extends DataGridSource {
  UserDataSource({required this.users, required this.context}) {
    _paginatedusers = users.take(15).toList(growable: false);
    _buildDataGridRows(_paginatedusers);
  }

  List<DataGridRow> dataGridRows = [];
  List<UserModel> _paginatedusers = [];
  List<UserModel> users;
  final BuildContext context;

  String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  // show edit user dialog
  void _showEditUserDialog(BuildContext context, UserModel user) {
    showCustomDialog(
      context: context,
      title: "Edit User",
      showCloseButton: true,
      content: EditUserForm(user: user),
    );
  }

  /// Builds the UI for each row in the DataGrid.
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        switch (cell.columnName) {
          // FULL NAME = Avatar + Name
          case 'fullName':
            final user = cell.value as UserModel;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(user.avatarUrl),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Expanded(
                    child: Text(
                      user.fullName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );

          // STATUS BADGE
          case 'status':
            return Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: CustomBadge(
                kText: capitalizeFirst(cell.value),
                kColor: _statusColor(cell.value),
                isRounded: true,
              ),
            );

          // PLAN BADGE
          case 'plan':
            return Container(
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: CustomBadge(
                kText: capitalizeFirst(cell.value),
                kColor: _planColor(cell.value),
                isRounded: true,
                isOutlined: true,
              ),
            );

          // DATE FORMAT
          case 'joinedDate':
          case 'lastActive':
            final date = cell.value as DateTime;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(DateFormat('MMMM dd, yyyy').format(date)),
            );

          // ACTION BUTTONS
          case 'action':
            final user =
                row
                        .getCells()
                        .firstWhere((e) => e.columnName == 'fullName')
                        .value
                    as UserModel;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // edit button
                CustomIconButton(
                  icon: Icons.edit,
                  shape: ButtonShape.circle,
                  onTap: () {
                    // edit logic
                    _showEditUserDialog(context, user);
                  },
                ),

                // delete button
                CustomIconButton(
                  icon: Icons.delete_outline,
                  iconColor: kErrorColor,
                  shape: ButtonShape.circle,
                  onTap: () {
                    // Warning Dialog
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomDialog(content: DeleteWarningDialog()),
                    );
                  },
                ),
              ],
            );

          default:
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(cell.value.toString()),
            );
        }
      }).toList(),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'active':
        return kSuccessColor;
      case 'inactive':
        return kTextColor;
      case 'suspended':
        return kWarningColor;
      case 'banned':
        return kErrorColor;
      default:
        return kTextColor;
    }
  }

  Color _planColor(String plan) {
    switch (plan) {
      case 'free':
        return kTextColor;
      case 'starter':
        return kInfoColor;
      case 'pro':
        return kSuccessColor;
      case 'enterprise':
        return kWarningColor;
      default:
        return kTextColor;
    }
  }

  /// Handles pagination when a new page is selected.
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    if (endIndex > users.length) endIndex = users.length;
    _paginatedusers = users
        .getRange(startIndex, endIndex)
        .toList(growable: false);
    _buildDataGridRows(_paginatedusers);
    notifyListeners();
    return true;
  }

  /// Converts order data into DataGridRows.
  void _buildDataGridRows(List<UserModel> users) {
    dataGridRows = users
        .map<DataGridRow>(
          (user) => DataGridRow(
            cells: [
              DataGridCell<UserModel>(columnName: 'fullName', value: user),
              DataGridCell<String>(columnName: 'email', value: user.email),
              DataGridCell<String>(
                columnName: 'username',
                value: user.username,
              ),
              DataGridCell<String>(columnName: 'status', value: user.status),
              // DataGridCell<String>(columnName: 'role', value: user.role),
              DataGridCell<String>(columnName: 'plan', value: user.plan),
              DataGridCell<DateTime>(
                columnName: 'joinedDate',
                value: user.joinedDate,
              ),
              DataGridCell<DateTime>(
                columnName: 'lastActive',
                value: user.lastActive,
              ),
              const DataGridCell<String>(columnName: 'action', value: ''),
            ],
          ),
        )
        .toList();
  }
}

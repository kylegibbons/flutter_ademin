import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/ai_reference/dialogs/user_management_dialogs.dart';
import 'package:flutter_ademin/ai_reference/ai_reference_data.dart';
import 'package:flutter_ademin/ai_reference/ai_reference_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserManagementTable extends StatefulWidget {
  const UserManagementTable({super.key});

  @override
  State<UserManagementTable> createState() => _UserManagementTableState();
}

int _rowsPerPage = 15;

class _UserManagementTableState extends State<UserManagementTable> {
  late UserDataSource _userDataSource;
  final double _dataPagerHeight = 60.0;
  List<UserModel> _users = <UserModel>[];

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
    _users = mockUsers;
    _userDataSource = UserDataSource(users: _users, context: context);
  }

  void _showAddUserDialog(BuildContext context) {
    showCustomDialog(
      context: context,
      title: 'Add New User',
      showCloseButton: true,
      content: const AddUserForm(),
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
                Row(
                  children: [
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.search,
                            tooltipMessage: 'Search',
                            iconColor: kTextColor,
                            buttonColor: themeData.colorScheme.surface,
                            isOutlined: true,
                            onTap: () {},
                          )
                        : const SizedBox(
                            width: 240,
                            child: SoftSearchBar(hintText: 'Search...'),
                          ),
                    const Spacer(),
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
                    const SizedBox(width: kDefaultPadding),
                    isMobile
                        ? CustomIconButton(
                            icon: Icons.add,
                            iconColor: Colors.white,
                            buttonColor: kSecondaryColor,
                            tooltipMessage: 'Add User',
                            onTap: () => _showAddUserDialog(context),
                          )
                        : FlatButton(
                            kText: 'Add User',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () => _showAddUserDialog(context),
                            kLeadingIcon: Icons.add_outlined,
                          ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                _buildDataGrid(constraint),
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

  Widget _buildDataGrid(BoxConstraints constraint) {
    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _userDataSource,
        allowFiltering: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        columns: <GridColumn>[
          _buildColumn(
            'fullName',
            'Full Name',
            minimumWidth: 180,
            filter: false,
          ),
          _buildColumn('email', 'Email', minimumWidth: 220, filter: false),
          _buildColumn(
            'username',
            'Username',
            minimumWidth: 120,
            filter: false,
          ),
          _buildColumn('status', 'Status', minimumWidth: 120),
          _buildColumn('plan', 'Plan', minimumWidth: 120),
          _buildColumn(
            'joinedDate',
            'Joined',
            minimumWidth: 150,
            filter: false,
          ),
          _buildColumn(
            'lastActive',
            'Last Active',
            minimumWidth: 150,
            filter: false,
          ),
          _buildColumn(
            'action',
            'Action',
            width: 100,
            filter: false,
            sorting: false,
            centered: true,
          ),
        ],
        allowSorting: true,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: 48,
        headerRowHeight: 48,
        shrinkWrapRows: true,
      ),
    );
  }

  GridColumn _buildColumn(
    String columnName,
    String label, {
    double? minimumWidth,
    double? width,
    bool filter = true,
    bool sorting = true,
    bool centered = false,
  }) {
    return GridColumn(
      columnName: columnName,
      allowFiltering: filter,
      allowSorting: sorting,
      minimumWidth: minimumWidth ?? 0,
      width: width ?? double.nan,
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
        alignment: centered
            ? AlignmentDirectional.center
            : AlignmentDirectional.centerStart,
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TableStyle.tableHeaderTextStyle(context),
        ),
      ),
    );
  }
}

class UserDataSource extends DataGridSource {
  UserDataSource({required this.users, required this.context}) {
    _paginatedUsers = users.take(15).toList(growable: false);
    _buildDataGridRows(_paginatedUsers);
  }

  List<DataGridRow> dataGridRows = [];
  List<UserModel> _paginatedUsers = [];
  List<UserModel> users;
  final BuildContext context;

  String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void _showEditUserDialog(BuildContext context, UserModel user) {
    showCustomDialog(
      context: context,
      title: 'Edit User',
      showCloseButton: true,
      content: EditUserForm(user: user),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        switch (cell.columnName) {
          case 'fullName':
            final user = cell.value as UserModel;
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              child: Row(
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
          case 'status':
            return _buildCenteredBadge(
              capitalizeFirst(cell.value),
              _statusColor(cell.value),
              false,
            );
          case 'plan':
            return _buildCenteredBadge(
              capitalizeFirst(cell.value),
              _planColor(cell.value),
              true,
            );
          case 'joinedDate':
          case 'lastActive':
            final date = cell.value as DateTime;
            return _buildCell(Text(DateFormat('MMMM dd, yyyy').format(date)));
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
                CustomIconButton(
                  icon: Icons.edit,
                  shape: ButtonShape.circle,
                  onTap: () => _showEditUserDialog(context, user),
                ),
                CustomIconButton(
                  icon: Icons.delete_outline,
                  iconColor: kErrorColor,
                  shape: ButtonShape.circle,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          CustomDialog(content: const DeleteWarningDialog()),
                    );
                  },
                ),
              ],
            );
          default:
            return _buildCell(Text(cell.value.toString()));
        }
      }).toList(),
    );
  }

  Widget _buildCell(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.5 * kDefaultPadding),
      alignment: AlignmentDirectional.centerStart,
      child: child,
    );
  }

  Widget _buildCenteredBadge(String text, Color color, bool outlined) {
    return Container(
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: CustomBadge(
        kText: text,
        kColor: color,
        isRounded: true,
        isOutlined: outlined,
      ),
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

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    if (endIndex > users.length) endIndex = users.length;
    _paginatedUsers = users
        .getRange(startIndex, endIndex)
        .toList(growable: false);
    _buildDataGridRows(_paginatedUsers);
    notifyListeners();
    return true;
  }

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

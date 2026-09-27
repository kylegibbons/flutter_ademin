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
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';

class TableEditableScreen extends StatefulWidget {
  const TableEditableScreen({super.key});

  @override
  State<TableEditableScreen> createState() => _TableEditableScreenState();
}

class _TableEditableScreenState extends State<TableEditableScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).editableTable; //update your page tittle here
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
                      lang.editableTable.toUpperCase(),
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
                          label: lang.editableTable,
                          uri: RouteUri.tableEditable,
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
                  cardTitle: 'Editable Table',
                  description:
                      'Editable cells are integrated into the data table. Tap a cell to begin editing its content directly.',
                  uiView: TableEditable(),
                  codeView:
                      '''TableEditable() source code can be found in the lib/demo/table/table_editable_screen.dart file.''',
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

class TableEditable extends StatefulWidget {
  const TableEditable({super.key});

  @override
  State<TableEditable> createState() => _TableEditableState();
}

class _TableEditableState extends State<TableEditable> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees, context);
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    double rowHeight = 44.0; // Height per row
    double headerRowHeight = 44.0; // Height of the header row

    return SfDataGridTheme(
      data: TableStyle.dataGridTheme,
      child: SfDataGrid(
        source: _employeeDataSource,
        shrinkWrapRows: true,
        verticalScrollPhysics: NeverScrollableScrollPhysics(),
        allowEditing: true,
        allowSorting: true,
        selectionMode: SelectionMode.single,
        editingGestureType: EditingGestureType.tap,
        navigationMode: GridNavigationMode.cell,
        columnWidthMode: MediaQuery.of(context).size.width < kScreenWidthMd
            ? ColumnWidthMode.none
            : ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        rowHeight: rowHeight,
        headerRowHeight: headerRowHeight,
        controller: _dataGridController,
        columns: [
          GridColumn(
            columnName: 'id',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'ID',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Name',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'designation',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Designation',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'department',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Department',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'joiningDate',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Joining Date',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
          GridColumn(
            columnName: 'salary',
            label: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 0.5 * kDefaultPadding,
              ),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Salary',
                overflow: TextOverflow.ellipsis,
                style: TableStyle.tableHeaderTextStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 'IT', '2020-05-20', 20000),
      Employee(10002, 'Kathryn', 'Manager', 'HR', '2018-07-15', 30000),
      Employee(10003, 'Lara', 'Developer', 'IT', '2021-03-10', 15000),
      Employee(10004, 'Michael', 'Designer', 'Marketing', '2019-11-05', 15000),
      Employee(10005, 'Martin', 'Developer', 'IT', '2022-02-01', 15000),
      Employee(
        10018,
        'Olivia',
        'Product Manager',
        'Product',
        '2018-01-20',
        25000,
      ),
      Employee(10006, 'Newberry', 'Developer', 'IT', '2021-09-18', 15000),
      Employee(10013, 'Isabella', 'Accountant', 'Finance', '2018-05-28', 20000),
      Employee(10008, 'Perry', 'Developer', 'IT', '2022-01-30', 15000),
      Employee(10011, 'Sophia', 'HR Specialist', 'HR', '2022-08-14', 18000),
      Employee(10012, 'William', 'QA Engineer', 'IT', '2021-12-22', 17000),
      Employee(
        10014,
        'Ethan',
        'Marketing Lead',
        'Marketing',
        '2019-09-10',
        22000,
      ),
      Employee(10009, 'Gable', 'Developer', 'IT', '2020-10-12', 15000),
      Employee(10015, 'Ava', 'Software Engineer', 'IT', '2022-06-05', 16000),
      Employee(10010, 'Grimes', 'Developer', 'IT', '2019-04-07', 15000),
      Employee(
        10016,
        'Noah',
        'Business Analyst',
        'Operations',
        '2020-03-15',
        19000,
      ),
      Employee(
        10017,
        'Liam',
        'Support Engineer',
        'Support',
        '2021-11-03',
        14000,
      ),
      Employee(10019, 'Mason', 'Cyber Security', 'IT', '2020-07-27', 23000),
      Employee(10020, 'Emily', 'Legal Advisor', 'Legal', '2017-02-14', 26000),
      Employee(10007, 'Blanc', 'Developer', 'IT', '2020-06-25', 15000),
    ];
  }
}

class Employee {
  Employee(
    this.id,
    this.name,
    this.designation,
    this.department,
    this.joiningDate,
    this.salary,
  );

  int id;
  String name;
  String designation;
  String department;
  String joiningDate;
  double salary;

  DataGridRow getDataGridRow() {
    return DataGridRow(
      cells: <DataGridCell>[
        DataGridCell<int>(columnName: 'id', value: id),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'designation', value: designation),
        DataGridCell<String>(columnName: 'department', value: department),
        DataGridCell<String>(columnName: 'joiningDate', value: joiningDate),
        DataGridCell<double>(columnName: 'salary', value: salary),
      ],
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  final List<Employee> _employees;
  final BuildContext context;
  late List<DataGridRow> dataGridRows;
  EmployeeDataSource(this._employees, this.context) {
    dataGridRows = _employees
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        Widget cellWidget;

        if (dataGridCell.columnName == 'joiningDate') {
          // Format date to 'MMMM d, yyyy'
          try {
            DateTime parsedDate = DateTime.parse(dataGridCell.value.toString());
            cellWidget = Text(DateFormat('MMMM d, yyyy').format(parsedDate));
          } catch (e) {
            cellWidget = Text(dataGridCell.value.toString());
          }
        } else if (dataGridCell.columnName == 'salary') {
          // Format salary as currency with thousand separator
          double? salary = double.tryParse(dataGridCell.value.toString());
          String formattedSalary = salary != null
              ? NumberFormat.currency(
                  symbol: '\$',
                  decimalDigits: 2,
                ).format(salary)
              : dataGridCell.value.toString();

          cellWidget = Text(formattedSalary);
        } else if (dataGridCell.columnName == 'department') {
          // Get department name
          String departmentName = dataGridCell.value.toString();

          // Assign dynamic color based on department
          Color departmentColor = getDepartmentColor(departmentName);

          // Show department as a label-style badge
          cellWidget = CustomBadge(
            kText: departmentName,
            kColor: departmentColor,
            isOutlined: true,
            isRounded: true,
          );
        } else if (dataGridCell.columnName == 'designation') {
          // Get designation name
          String designationName = dataGridCell.value.toString();

          // Assign dynamic color based on designation
          Color designationColor = getDesignationColor(designationName);

          // Show designation as a label-style badge
          cellWidget = CustomBadge(
            kText: designationName,
            kColor: designationColor,
            isRounded: true,
          );
        } else {
          // Default text for other columns
          cellWidget = Text(dataGridCell.value.toString());
        }

        return Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(
            horizontal: 0.5 * kDefaultPadding,
          ),
          child: cellWidget,
        );
      }).toList(),
    );
  }

  // Function to return a color based on department name
  Color getDepartmentColor(String department) {
    switch (department.toLowerCase()) {
      case 'it':
        return kPrimaryColor;
      case 'hr':
        return kSuccessColor;
      case 'marketing':
        return kWarningColor;
      case 'finance':
        return kSecondaryColor;

      case 'operations':
        return kErrorColor;
      case 'support':
        return Colors.purple;
      case 'product':
        return Colors.cyan;
      case 'legal':
        return Colors.pink;
      default:
        return Colors.grey; // Default color for unknown departments
    }
  }

  // Function to return a color based on department name
  Color getDesignationColor(String department) {
    switch (department.toLowerCase()) {
      case 'legal advisor':
        return kPrimaryColor;
      case 'cyber security':
        return kSuccessColor;
      case 'product manager':
        return kWarningColor;
      case 'support engineer':
        return kSecondaryColor;
      case 'business analyst':
        return kErrorColor;
      case 'software engineer':
        return Colors.purple;
      case 'marketing lead':
        return Colors.cyan;
      case 'project lead':
        return Colors.pink;
      case 'manager':
        return Colors.teal;
      case 'developer':
        return Colors.deepPurple;
      case 'designer':
        return Colors.orange;
      case 'hr specialist':
        return Colors.brown;
      case 'qa engineer':
        return Colors.indigo;
      case 'accountant':
        return Colors.lime;
      default:
        return Colors.grey; // Default color for unknown departments
    }
  }

  @override
  Future<void> onCellSubmit(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
  ) async {
    final dynamic oldValue =
        dataGridRow
            .getCells()
            .firstWhereOrNull(
              (DataGridCell dataGridCell) =>
                  dataGridCell.columnName == column.columnName,
            )
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'id') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'id', value: newCellValue);
      _employees[dataRowIndex].id = newCellValue as int;
    } else if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name', value: newCellValue);
      _employees[dataRowIndex].name = newCellValue.toString();
    } else if (column.columnName == 'designation') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'designation', value: newCellValue);
      _employees[dataRowIndex].designation = newCellValue.toString();
    } else if (column.columnName == 'department') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'department', value: newCellValue);
      _employees[dataRowIndex].department = newCellValue.toString();
    } else if (column.columnName == 'joiningDate') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'joiningDate', value: newCellValue);
      _employees[dataRowIndex].joiningDate = newCellValue.toString();
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'salary', value: newCellValue);
      _employees[dataRowIndex].salary = newCellValue as double;
    }
  }

  @override
  Future<bool> canSubmitCell(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
  ) async {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
    CellSubmit submitCell,
  ) {
    // Get current cell value
    final String displayText =
        dataGridRow
            .getCells()
            .firstWhereOrNull(
              (DataGridCell dataGridCell) =>
                  dataGridCell.columnName == column.columnName,
            )
            ?.value
            ?.toString() ??
        '';

    // Reset new cell value
    newCellValue = null;

    // Check if column is numeric
    final bool isNumericType =
        column.columnName == 'id' || column.columnName == 'salary';

    // Get regular expression for validation
    final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    // If column is 'designation', show dropdown
    if (column.columnName == 'designation') {
      List<String> designations =
          getUniqueDesignations(); // Get unique designations

      return Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
        child: DropdownButtonFormField<String>(
          initialValue: displayText.isNotEmpty ? displayText : null,
          dropdownColor: Theme.of(context).colorScheme.surface,
          onChanged: (String? newValue) {
            if (newValue != null) {
              newCellValue = newValue;
              submitCell(); // Auto-submit when selection is changed
            }
          },
          items: designations
              .map(
                (designation) => DropdownMenuItem<String>(
                  value: designation,
                  child: Text(designation),
                ),
              )
              .toList(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            // fontSize: kBodyMedium,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.onSurface,
            size: 18,
          ),
        ),
      );
    }

    // If column is 'department', show dropdown
    if (column.columnName == 'department') {
      List<String> departments =
          getUniqueDepartments(); // Get unique designations

      return Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
        child: DropdownButtonFormField<String>(
          initialValue: displayText.isNotEmpty ? displayText : null,
          onChanged: (String? newValue) {
            if (newValue != null) {
              newCellValue = newValue;
              submitCell(); // Auto-submit when selection is changed
            }
          },
          dropdownColor: Theme.of(context).colorScheme.surface,
          items: departments
              .map(
                (department) => DropdownMenuItem<String>(
                  value: department,
                  child: Text(department),
                ),
              )
              .toList(),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            // fontSize: kBodyMedium,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.onSurface,
            size: 18,
          ),
        ),
      );
    }

    // If column is 'joiningDate', show date picker

    if (column.columnName == 'joiningDate') {
      DateTime? selectedDate = displayText.isNotEmpty
          ? DateTime.tryParse(displayText)
          : DateTime.now();

      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              newCellValue = DateFormat('yyyy-MM-dd').format(pickedDate);
              submitCell();
            }
          },
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText.isNotEmpty
                        ? DateFormat(
                            'MMMM d, yyyy',
                          ).format(DateTime.parse(displayText))
                        : 'Select Date',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ),
        ),
      );
    }

    // Default TextField for other columns
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
        child: TextField(
          autofocus: true,
          controller: editingController..text = displayText,
          textAlign: TextAlign.left,
          autocorrect: false,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
              vertical: kDefaultPadding,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(regExp),
          ],
          keyboardType: isNumericType
              ? TextInputType.number
              : TextInputType.text,
          onChanged: (String value) {
            if (value.isNotEmpty) {
              newCellValue = isNumericType ? int.parse(value) : value;
            } else {
              newCellValue = null;
            }
          },
          onSubmitted: (String value) {
            submitCell();
          },
        ),
      ),
    );
  }

  // Function to extract unique designations
  List<String> getUniqueDesignations() {
    List<Employee> employees = _employees;
    return employees.map((e) => e.designation).toSet().toList();
  }

  // Function to extract unique departements
  List<String> getUniqueDepartments() {
    List<Employee> employees = _employees;
    return employees.map((e) => e.department).toSet().toList();
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
  }
}

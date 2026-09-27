import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_filter_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_logs_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

import 'package:flutkit_ademin/widgets/table/table_style.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AILogsTab extends StatefulWidget {
  final List<dynamic>? logs;

  const AILogsTab({super.key, this.logs});

  @override
  State<AILogsTab> createState() => _AILogsTabState();
}

class _AILogsTabState extends State<AILogsTab> {
  late final List<AILogItem> _allLogs;
  final String _searchQuery = '';
  AILogLevel? _selectedLevel;
  AILogSource? _selectedSource;
  AILogType? _selectedType;

  @override
  void initState() {
    super.initState();
    _allLogs = _convertToLogs(widget.logs);
  }

  List<AILogItem> _convertToLogs(List<dynamic>? data) {
    if (data == null) return [];
    return data
        .map((item) {
          if (item is AILogItem) return item;
          if (item is Map<String, dynamic>) {
            return AILogItem(
              id: item['id'] as String? ?? '',
              title: item['title'] as String? ?? 'Untitled log',
              message: item['message'] as String? ?? '',
              level: _parseLevel(item['level']),
              source: _parseSource(item['source']),
              type: _parseType(item['type']),
              sourceName: item['sourceName'] as String? ?? 'System',
              createdAt: _parseDateTime(item['createdAt']),
              user: item['user'] as String?,
              details: item['details'] as String?,
            );
          }
          return null;
        })
        .whereType<AILogItem>()
        .toList();
  }

  AILogLevel _parseLevel(dynamic value) {
    if (value is AILogLevel) return value;
    if (value is String) {
      return AILogLevel.values.firstWhere(
        (element) => element.toString().split('.').last == value,
        orElse: () => AILogLevel.info,
      );
    }
    return AILogLevel.info;
  }

  AILogSource _parseSource(dynamic value) {
    if (value is AILogSource) return value;
    if (value is String) {
      return AILogSource.values.firstWhere(
        (element) => element.toString().split('.').last == value,
        orElse: () => AILogSource.system,
      );
    }
    return AILogSource.system;
  }

  AILogType _parseType(dynamic value) {
    if (value is AILogType) return value;
    if (value is String) {
      return AILogType.values.firstWhere(
        (element) => element.toString().split('.').last == value,
        orElse: () => AILogType.analysis,
      );
    }
    return AILogType.analysis;
  }

  DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  List<AILogItem> get _filteredLogs {
    return _allLogs.where((log) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          log.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          log.message.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          log.sourceName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLevel =
          _selectedLevel == null || log.level == _selectedLevel;
      final matchesSource =
          _selectedSource == null || log.source == _selectedSource;
      final matchesType = _selectedType == null || log.type == _selectedType;
      return matchesSearch && matchesLevel && matchesSource && matchesType;
    }).toList();
  }

  int _countByLevel(AILogLevel level) {
    return _allLogs.where((log) => log.level == level).length;
  }

  String _formatTime(DateTime createdAt) {
    final date =
        '${_monthLabel(createdAt.month)} ${createdAt.day}, ${createdAt.year}';
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$date · $hour:$minute';
  }

  String _monthLabel(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _levelText(AILogLevel level) {
    switch (level) {
      case AILogLevel.success:
        return 'Success';
      case AILogLevel.warning:
        return 'Warning';
      case AILogLevel.error:
        return 'Error';
      case AILogLevel.info:
        return 'Info';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final filteredLogs = _filteredLogs;
    final logsSource = _AILogsDataSource(
      filteredLogs,
      formatTime: _formatTime,
      formatLevel: _levelText,
      formatType: (type) => type.toString().split('.').last,
      context: context,
    );

    final bool isDesktop = MediaQuery.of(context).size.width >= kScreenWidthMd;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      'Logs',
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyLarge,
                      ),
                    ),

                    SizedBox(height: kDefaultPadding / 4),

                    // Subtitle
                    Text('System activity logs and audit trail.'),
                  ],
                ),
                CustomIconButton(
                  icon: Icons.tune_outlined,
                  tooltipMessage: 'Filter',
                  shape: ButtonShape.circle,
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: kDefaultPadding / 2),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  FilterTab(
                    label: 'All',
                    // badge: _allLogs.length,
                    isSelected: _selectedLevel == null,
                    onTap: () => setState(() => _selectedLevel = null),
                    themeData: themeData,
                    color: themeData.colorScheme.primary,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  FilterTab(
                    label: 'Info',
                    badge: _countByLevel(AILogLevel.info),
                    isSelected: _selectedLevel == AILogLevel.info,
                    onTap: () =>
                        setState(() => _selectedLevel = AILogLevel.info),
                    themeData: themeData,
                    color: kInfoColor,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  FilterTab(
                    label: 'Success',
                    badge: _countByLevel(AILogLevel.success),
                    isSelected: _selectedLevel == AILogLevel.success,
                    onTap: () =>
                        setState(() => _selectedLevel = AILogLevel.success),
                    themeData: themeData,
                    color: kSuccessColor,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  FilterTab(
                    label: 'Warning',
                    badge: _countByLevel(AILogLevel.warning),
                    isSelected: _selectedLevel == AILogLevel.warning,
                    onTap: () =>
                        setState(() => _selectedLevel = AILogLevel.warning),
                    themeData: themeData,
                    color: kWarningColor,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  FilterTab(
                    label: 'Error',
                    badge: _countByLevel(AILogLevel.error),
                    isSelected: _selectedLevel == AILogLevel.error,
                    onTap: () =>
                        setState(() => _selectedLevel = AILogLevel.error),
                    themeData: themeData,
                    color: kErrorColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          filteredLogs.isEmpty
              ? Center(
                  child: Text(
                    'No logs found.',
                    style: TextStyle(
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  child: SfDataGridTheme(
                    data: TableStyle.dataGridTheme,
                    child: SfDataGrid(
                      source: logsSource,
                      shrinkWrapRows: true,
                      verticalScrollPhysics: NeverScrollableScrollPhysics(),
                      headerRowHeight: 44,
                      rowHeight: 44,

                      columnWidthMode: isDesktop
                          ? ColumnWidthMode.fill
                          : ColumnWidthMode.none,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,

                      columns: [
                        GridColumn(
                          columnName: 'time',
                          label: _header('Time', themeData, context),
                          maximumWidth: 140,
                        ),
                        GridColumn(
                          columnName: 'level',
                          label: _header('Level', themeData, context),
                          maximumWidth: 120,
                        ),
                        GridColumn(
                          columnName: 'source',
                          label: _header('Source', themeData, context),
                          maximumWidth: 180,
                        ),
                        GridColumn(
                          columnName: 'type',
                          label: _header('Type', themeData, context),
                          maximumWidth: 120,
                        ),
                        GridColumn(
                          columnName: 'title',
                          label: _header('Title', themeData, context),
                          maximumWidth: 280,
                        ),
                        GridColumn(
                          columnName: 'message',
                          label: _header('Message', themeData, context),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

Widget _header(String text, ThemeData theme, context) {
  return Container(
    alignment: AlignmentDirectional.center,
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
    child: Text(
      text,
      style: TableStyle.tableHeaderTextStyle(context),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

class _AILogsDataSource extends DataGridSource {
  final BuildContext context;
  _AILogsDataSource(
    List<AILogItem> logs, {
    required String Function(DateTime) formatTime,
    required String Function(AILogLevel) formatLevel,
    required String Function(AILogType) formatType,
    required this.context,
  }) : rows = logs
           .map(
             (log) => DataGridRow(
               cells: <DataGridCell>[
                 DataGridCell<String>(
                   columnName: 'time',
                   value: formatTime(log.createdAt),
                 ),
                 DataGridCell<String>(
                   columnName: 'level',
                   value: formatLevel(log.level),
                 ),
                 DataGridCell<String>(
                   columnName: 'source',
                   value: log.sourceName,
                 ),
                 DataGridCell<String>(
                   columnName: 'type',
                   value: formatType(log.type),
                 ),
                 DataGridCell<String>(columnName: 'title', value: log.title),
                 DataGridCell<String>(
                   columnName: 'message',
                   value: log.message,
                 ),
               ],
             ),
           )
           .toList();

  @override
  final List<DataGridRow> rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final themeData = Theme.of(context);
    return DataGridRowAdapter(
      cells: row.getCells().map((dataCell) {
        final String value = dataCell.value?.toString() ?? '';

        if (dataCell.columnName == 'level') {
          Color color;
          switch (value.toLowerCase()) {
            case 'success':
              color = kSuccessColor;
              break;
            case 'warning':
              color = kWarningColor;
              break;
            case 'error':
              color = kErrorColor;
              break;
            case 'info':
            default:
              color = kInfoColor;
              break;
          }
          return Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: CustomBadge(
              kText: value,
              kColor: color,
              isSoft: true,
              isRounded: true,
            ),
          );
        }

        if (dataCell.columnName == 'type') {
          return Container(
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: CustomBadge(
              kText: value,
              kColor: themeData.colorScheme.onSurface,
              isOutlined: true,
              isRounded: true,
            ),
          );
        }

        return Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: dataCell.columnName == 'message' ? 2 : 1,
          ),
        );
      }).toList(),
    );
  }
}

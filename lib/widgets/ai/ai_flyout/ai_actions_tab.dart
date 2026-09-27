import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_filter_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_action_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class AIActionsTab extends StatefulWidget {
  final List<dynamic>? actions; // Accepts List<AIActionItem> or List<Map>

  const AIActionsTab({super.key, this.actions});

  @override
  State<AIActionsTab> createState() => _AIActionsTabState();
}

class _AIActionsTabState extends State<AIActionsTab> {
  late List<AIActionItem> _allActions;
  AIActionStatus? _selectedStatusFilter;

  @override
  void initState() {
    super.initState();
    _allActions = _convertToActions(widget.actions) ?? [];
    _selectedStatusFilter = null; // null means show all
  }

  /// Converts Listdynamic to ListAIActionItem

  List<AIActionItem>? _convertToActions(List<dynamic>? data) {
    if (data == null) return null;
    try {
      return data
          .map((item) {
            if (item is AIActionItem) return item;
            if (item is Map<String, dynamic>) {
              return AIActionItem(
                id: item['id'] as String? ?? '',
                title: item['title'] as String? ?? '',
                description: item['description'] as String? ?? '',
                status: _parseStatus(item['status']),
                priority: _parsePriority(item['priority']),
                createdAt: _parseDateTime(item['createdAt']),
                completedAt: _parseDateTime(item['completedAt']),
                progress: item['progress'] as int?,
                icon: _parseIcon(item['icon']),
              );
            }
            return null;
          })
          .whereType<AIActionItem>()
          .toList();
    } catch (e) {
      debugPrint('Error converting actions: $e');
      return null;
    }
  }

  AIActionStatus _parseStatus(dynamic value) {
    if (value is AIActionStatus) return value;
    if (value is String) {
      return AIActionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => AIActionStatus.pending,
      );
    }
    return AIActionStatus.pending;
  }

  AIActionPriority _parsePriority(dynamic value) {
    if (value is AIActionPriority) return value;
    if (value is String) {
      return AIActionPriority.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => AIActionPriority.medium,
      );
    }
    return AIActionPriority.medium;
  }

  DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  IconData? _parseIcon(dynamic value) {
    if (value is IconData) return value;
    // If icon is passed as a string, we could map it to IconData here
    return null;
  }

  int _getCountByStatus(AIActionStatus status) {
    return _allActions.where((action) => action.status == status).length;
  }

  List<AIActionItem> _getActionsByStatus(AIActionStatus status) {
    return _allActions.where((action) => action.status == status).toList();
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return 'Started ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return 'Started ${difference.inHours}h ago';
    } else {
      return 'Yesterday ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  String _getCompletionTime(DateTime dateTime) {
    return 'Today ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final runningCount = _getCountByStatus(AIActionStatus.running);
    final pendingCount = _getCountByStatus(AIActionStatus.pending);
    final completedCount = _getCountByStatus(AIActionStatus.completed);
    final failedCount = _getCountByStatus(AIActionStatus.failed);

    // Filter actions based on selected status
    final filteredActions = _selectedStatusFilter == null
        ? _allActions
        : _allActions
              .where((action) => action.status == _selectedStatusFilter)
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header with Title and Filter
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
                    'Actions',
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 4),
                  // Subtitle
                  Text('Track and manage tasks executed by AI.'),
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

        // Filter Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                FilterTab(
                  label: 'All',
                  isSelected: _selectedStatusFilter == null,
                  onTap: () => setState(() => _selectedStatusFilter = null),
                  themeData: themeData,
                ),
                const SizedBox(width: kDefaultPadding / 2),

                FilterTab(
                  label: 'Running',
                  badge: runningCount,
                  isSelected: _selectedStatusFilter == AIActionStatus.running,
                  onTap: () => setState(() {
                    _selectedStatusFilter = AIActionStatus.running;
                  }),
                  themeData: themeData,
                  color: kInfoColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),

                FilterTab(
                  label: 'Pending',
                  badge: pendingCount,
                  isSelected: _selectedStatusFilter == AIActionStatus.pending,
                  onTap: () => setState(() {
                    _selectedStatusFilter = AIActionStatus.pending;
                  }),
                  themeData: themeData,
                  color: kWarningColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Completed',
                  badge: completedCount,
                  isSelected: _selectedStatusFilter == AIActionStatus.completed,
                  onTap: () => setState(() {
                    _selectedStatusFilter = AIActionStatus.completed;
                  }),
                  themeData: themeData,
                  color: kSuccessColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Failed',
                  badge: failedCount,
                  isSelected: _selectedStatusFilter == AIActionStatus.failed,
                  onTap: () => setState(() {
                    _selectedStatusFilter = AIActionStatus.failed;
                  }),
                  themeData: themeData,
                  color: kErrorColor,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: kDefaultPadding),

        // Actions List
        Expanded(
          child: filteredActions.isEmpty
              ? Center(
                  child: Text(
                    _selectedStatusFilter == null
                        ? 'No actions yet'
                        : 'No ${_getStatusLabel(_selectedStatusFilter!).toLowerCase()} actions',
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2,
                    ),
                    child: Column(
                      children: [
                        // Running Section
                        if (runningCount > 0 &&
                            (_selectedStatusFilter == null ||
                                _selectedStatusFilter ==
                                    AIActionStatus.running)) ...[
                          ..._getActionsByStatus(AIActionStatus.running).map(
                            (action) => _ActionItemCard(
                              action: action,
                              timeInfo: _getTimeAgo(action.createdAt),
                            ),
                          ),
                        ],

                        // Pending Section
                        if (pendingCount > 0 &&
                            (_selectedStatusFilter == null ||
                                _selectedStatusFilter ==
                                    AIActionStatus.pending)) ...[
                          ..._getActionsByStatus(AIActionStatus.pending).map(
                            (action) => _ActionItemCard(
                              action: action,
                              timeInfo: _getTimeAgo(action.createdAt),
                            ),
                          ),
                        ],

                        // Completed Section
                        if (completedCount > 0 &&
                            (_selectedStatusFilter == null ||
                                _selectedStatusFilter ==
                                    AIActionStatus.completed)) ...[
                          ..._getActionsByStatus(AIActionStatus.completed).map(
                            (action) => _ActionItemCard(
                              action: action,
                              timeInfo: _getCompletionTime(
                                action.completedAt ?? action.createdAt,
                              ),
                            ),
                          ),
                        ],

                        // Failed Section
                        if (failedCount > 0 &&
                            (_selectedStatusFilter == null ||
                                _selectedStatusFilter ==
                                    AIActionStatus.failed)) ...[
                          ..._getActionsByStatus(AIActionStatus.failed).map(
                            (action) => _ActionItemCard(
                              action: action,
                              timeInfo: _getTimeAgo(action.createdAt),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  String _getStatusLabel(AIActionStatus status) {
    switch (status) {
      case AIActionStatus.pending:
        return 'Pending';
      case AIActionStatus.running:
        return 'Running';
      case AIActionStatus.completed:
        return 'Completed';
      case AIActionStatus.failed:
        return 'Failed';
      case AIActionStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class _ActionItemCard extends StatelessWidget {
  final AIActionItem action;
  final String timeInfo;

  const _ActionItemCard({required this.action, required this.timeInfo});

  Color _getStatusColor(AIActionStatus status) {
    switch (status) {
      case AIActionStatus.pending:
        return kWarningColor;
      case AIActionStatus.running:
        return kInfoColor;
      case AIActionStatus.completed:
        return kSuccessColor;
      case AIActionStatus.failed:
        return kErrorColor;
      case AIActionStatus.cancelled:
        return kTextColor;
    }
  }

  String _getStatusLabel(AIActionStatus status) {
    switch (status) {
      case AIActionStatus.pending:
        return 'Pending';
      case AIActionStatus.running:
        return 'Running';
      case AIActionStatus.completed:
        return 'Completed';
      case AIActionStatus.failed:
        return 'Failed';
      case AIActionStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final statusColor = _getStatusColor(action.status);

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(color: themeData.colorScheme.outline, width: 0.6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon, title, and menu
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Icon(
                    action.icon ?? Icons.flash_on_outlined,
                    color: statusColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        action.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // description
                      Text(
                        action.description,
                        style: TextStyle(fontSize: kBodySmall),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // status
                    CustomBadge(
                      kText: _getStatusLabel(action.status),
                      kColor: statusColor,
                      isSoft: true,
                    ),
                    const SizedBox(height: kDefaultPadding / 4),
                    // time info
                    Text(timeInfo, style: TextStyle(fontSize: kBodySmall)),
                  ],
                ),
                const SizedBox(width: kDefaultPadding / 2),

                CustomIconButton(
                  onTap: () {},
                  shape: ButtonShape.circle,
                  icon: Icons.more_vert,
                ),
              ],
            ),

            // Progress bar (only for running actions)
            if (action.status == AIActionStatus.running &&
                action.progress != null) ...[
              const SizedBox(height: kDefaultPadding / 2),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    child: LinearProgressIndicator(
                      value: (action.progress ?? 0) / 100,
                      minHeight: 6,
                      backgroundColor: themeData.colorScheme.primary.withValues(
                        alpha: 0.12,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${action.progress}%',
                      style: TextStyle(
                        color: themeData.colorScheme.primary,
                        fontSize: kBodySmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

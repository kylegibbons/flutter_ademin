import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_agent_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class AIAgentsTab extends StatelessWidget {
  final List<dynamic>? agents;

  const AIAgentsTab({super.key, this.agents});

  List<AIAgent> _convertToAgents(List<dynamic>? data) {
    if (data == null) return [];

    return data
        .map((item) {
          if (item is AIAgent) return item;
          if (item is Map<String, dynamic>) {
            return AIAgent(
              id: item['id'] as String? ?? '',
              name: item['name'] as String? ?? 'Agent',
              description: item['description'] as String? ?? '',
              category: _parseCategory(item['category']),
              status: _parseHealthStatus(item['status']),
              state: _parseState(item['state']),
              tasksCompleted: item['tasksCompleted'] as int? ?? 0,
              successRate: item['successRate'] as int? ?? 0,
              lastUsed: _parseDateTime(item['lastUsed']),
              icon: _parseIcon(item['icon']) ?? Icons.smart_toy_outlined,
              enabled: item['enabled'] as bool? ?? true,
            );
          }
          return null;
        })
        .whereType<AIAgent>()
        .toList();
  }

  AIAgentHealthStatus _parseHealthStatus(dynamic value) {
    if (value is AIAgentHealthStatus) return value;
    if (value is String) {
      return AIAgentHealthStatus.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
        orElse: () => AIAgentHealthStatus.healthy,
      );
    }
    return AIAgentHealthStatus.healthy;
  }

  AIAgentState _parseState(dynamic value) {
    if (value is AIAgentState) return value;
    if (value is String) {
      return AIAgentState.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
        orElse: () => AIAgentState.running,
      );
    }
    return AIAgentState.running;
  }

  AIAgentCategory _parseCategory(dynamic value) {
    if (value is AIAgentCategory) return value;
    if (value is String) {
      return AIAgentCategory.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => AIAgentCategory.productivity,
      );
    }
    return AIAgentCategory.productivity;
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

  IconData? _parseIcon(dynamic value) {
    if (value is IconData) return value;
    return null;
  }

  String _getRelativeTime(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }
    return '${difference.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final agentList = _convertToAgents(agents);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Agents',
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyLarge,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 4),
                    Text(
                      'Specialized AI agents that understand your business and help you get work done.',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kDefaultPadding),

              FlatButton(
                kText: "New Agent",
                bgColor: kSecondaryColor,
                kTextColor: Colors.white,
                kLeadingIcon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
        ),

        const SizedBox(height: kDefaultPadding),

        // agent grid
        Expanded(
          child: agentList.isEmpty
              ? Center(child: Text('No agents available.'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: ResponsiveWrap(
                      breakpoints: {
                        kScreenWidthSm: 1,
                        kScreenWidthMd: 2,
                        kScreenWidthLg: 4,
                      },
                      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        ...agentList.map((agent) {
                          return _AgentCard(
                            themeData: themeData,
                            agent: agent,
                            relativeTime: _getRelativeTime(agent.lastUsed),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}

class _AgentCard extends StatefulWidget {
  final ThemeData themeData;
  final AIAgent agent;
  final String relativeTime;

  const _AgentCard({
    required this.themeData,
    required this.agent,
    required this.relativeTime,
  });

  @override
  State<_AgentCard> createState() => _AgentCardState();
}

class _AgentCardState extends State<_AgentCard> {
  late AIAgentState _localState;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _localState = widget.agent.state;
  }

  Future<void> _simulateRunPause() async {
    if (_isBusy) return;

    // ignore while transitional
    if (_localState == AIAgentState.starting ||
        _localState == AIAgentState.stopping) {
      return;
    }

    setState(() {
      _isBusy = true;

      // running -> pause (stopping -> paused)
      if (_localState == AIAgentState.running) {
        _localState = AIAgentState.stopping;
      } else {
        // paused/stopped -> run (starting -> running)
        _localState = AIAgentState.starting;
      }
    });

    await Future.delayed(const Duration(milliseconds: 1200));

    setState(() {
      if (_localState == AIAgentState.stopping) {
        _localState = AIAgentState.paused;
      } else if (_localState == AIAgentState.starting) {
        _localState = AIAgentState.running;
      }
      _isBusy = false;
    });
  }

  Color _statusColor(AIAgentHealthStatus status) {
    switch (status) {
      case AIAgentHealthStatus.healthy:
        return kSuccessColor;
      case AIAgentHealthStatus.warning:
        return kWarningColor;
      case AIAgentHealthStatus.degraded:
        return kErrorColor;
      case AIAgentHealthStatus.unhealthy:
        return kErrorColor;
      case AIAgentHealthStatus.offline:
        return kTextColor;
    }
  }

  String _statusLabel(AIAgentHealthStatus status) {
    switch (status) {
      case AIAgentHealthStatus.healthy:
        return 'Healthy';
      case AIAgentHealthStatus.warning:
        return 'Warning';
      case AIAgentHealthStatus.degraded:
        return 'Degraded';
      case AIAgentHealthStatus.unhealthy:
        return 'Unhealthy';
      case AIAgentHealthStatus.offline:
        return 'Offline';
    }
  }

  String _stateLabel(AIAgentState state) {
    switch (state) {
      case AIAgentState.running:
        return 'Running';
      case AIAgentState.paused:
        return 'Paused';
      case AIAgentState.starting:
        return 'Starting';
      case AIAgentState.stopping:
        return 'Stopping';
      case AIAgentState.stopped:
        return 'Stopped';
    }
  }

  Color _stateColor(AIAgentState state) {
    switch (state) {
      case AIAgentState.running:
        return kSuccessColor;
      case AIAgentState.paused:
        return kErrorColor;
      case AIAgentState.starting:
        return kInfoColor;
      case AIAgentState.stopping:
        return kSecondaryColor;
      case AIAgentState.stopped:
        return kTextColor;
    }
  }

  IconData _stateIcon(AIAgentState state) {
    switch (state) {
      case AIAgentState.running:
        return Icons.pause;
      case AIAgentState.paused:
        return Icons.play_arrow;
      case AIAgentState.starting:
        return Icons.hourglass_top;
      case AIAgentState.stopping:
        return Icons.hourglass_bottom;
      case AIAgentState.stopped:
        return Icons.play_arrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = widget.themeData;

    final String loadingText;
    if (_localState == AIAgentState.stopping) {
      loadingText = 'Pausing';
    } else if (_localState == AIAgentState.starting) {
      loadingText = 'Running';
    } else {
      loadingText = 'Loading';
    }

    return Material(
      color: themeData.colorScheme.surface,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: themeData.colorScheme.outline, width: 0.6),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: kInfoColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Icon(widget.agent.icon, color: kInfoColor, size: 24),
                ),

                // status badge
                CustomBadge(
                  kText: _statusLabel(widget.agent.status),
                  kColor: _statusColor(widget.agent.status),
                  isSoft: true,
                  isRounded: true,
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            // agent name
            Text(
              widget.agent.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: kDefaultPadding / 3),

            // agent description
            Text(widget.agent.description),
            const SizedBox(height: kDefaultPadding),

            // metrics
            Wrap(
              runSpacing: kDefaultPadding / 2,
              spacing: kDefaultPadding / 2,
              children: [
                _AgentMetric(
                  icon: Icons.task_outlined,
                  iconColor: kInfoColor,
                  label: '${widget.agent.tasksCompleted} Tasks',
                  theme: themeData,
                ),

                _AgentMetric(
                  icon: Icons.show_chart_outlined,
                  iconColor: kSuccessColor,
                  label: '${widget.agent.successRate}% Success',
                  theme: themeData,
                ),

                _AgentMetric(
                  icon: Icons.access_time_outlined,
                  iconColor: kSecondaryColor,
                  label: widget.relativeTime,
                  theme: themeData,
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            Row(
              children: [
                // agent state button
                Expanded(
                  child: SoftButton(
                    kText: _stateLabel(_localState),
                    bgColor: _stateColor(_localState),
                    kLeadingIcon: _stateIcon(_localState),
                    isLoading: _isBusy,
                    loadingText: loadingText,
                    onPressed: _simulateRunPause,
                  ),
                ),

                SizedBox(width: kDefaultPadding),

                // open agent button
                Expanded(
                  child: CustomOutlinedButton(
                    kText: 'Open',
                    outlineColor: kSecondaryColor,
                    kTrailingIcon: Icons.arrow_forward,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AgentMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  final Color iconColor;

  const _AgentMetric({
    required this.icon,
    required this.label,
    required this.theme,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          radius: 14,
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: kDefaultPadding / 4),
        Text(
          label,
          style: TextStyle(fontSize: kBodySmall),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

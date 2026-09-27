import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_filter_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_insight_helpers.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/demo/dashboard/crm/data/dashboard_crm_ai_operator_data.dart';
import 'package:flutkit_ademin/widgets/base_ui/badge.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class AIInsightsTab extends StatefulWidget {
  final List<dynamic>? insights; // Accepts List<AIInsight> or List<Map>

  const AIInsightsTab({super.key, this.insights});

  @override
  State<AIInsightsTab> createState() => _AIInsightsTabState();
}

class _AIInsightsTabState extends State<AIInsightsTab> {
  late List<AIInsight> allInsights;
  String selectedFilter = 'All';
  String selectedSort = 'Most Relevant';

  @override
  void initState() {
    super.initState();
    allInsights = _convertToInsights(widget.insights) ?? _getMockInsights();
  }

  /// Converts List dynamic to List AIInsight
  /// Handles both List AIInsight and List MapString, dynamic
  List<AIInsight>? _convertToInsights(List<dynamic>? data) {
    if (data == null) return null;

    try {
      return data
          .map((item) {
            if (item is AIInsight) {
              return item;
            } else if (item is Map<String, dynamic>) {
              return _mapToInsight(item);
            }
            return null;
          })
          .whereType<AIInsight>()
          .toList();
    } catch (e) {
      debugPrint('Error converting insights: $e');
      return null;
    }
  }

  /// Converts Map String, dynamic to AIInsight
  AIInsight _mapToInsight(Map<String, dynamic> map) {
    final severityStr = (map['severity'] as String? ?? 'Information')
        .toLowerCase();
    final severity = _parseSeverity(severityStr);

    final categoryStr = (map['category'] as String? ?? 'analytics')
        .toLowerCase();
    final category = _parseCategory(categoryStr);

    final statusStr = (map['status'] as String? ?? 'unread').toLowerCase();
    final status = _parseStatus(statusStr);
    final impactMap = map['impact'] is Map<String, dynamic>
        ? map['impact'] as Map<String, dynamic>
        : null;
    final impactTitle = impactMap?['title'] as String?;

    return AIInsight(
      id:
          map['id'] as String? ??
          'unknown_${DateTime.now().millisecondsSinceEpoch}',
      title: map['title'] as String? ?? 'Untitled Insight',
      summary: map['summary'] as String? ?? '',
      description: map['description'] as String?,
      severity: severity,
      category: category,
      status: status,
      generatedAt: map['generatedAt'] is DateTime
          ? map['generatedAt'] as DateTime
          : DateTime.now(),
      confidence: AIConfidence(
        level: AIConfidenceLevel.medium,
        score: (map['confidence'] as int?) ?? 75,
      ),
      impact: impactMap != null
          ? AIImpact(
              level: _parseImpactLevel(impactTitle),
              title: impactTitle,
              description: impactMap['description'] as String?,
            )
          : null,
      why: map['why'] != null && map['why'] is Map<String, dynamic>
          ? AIWhy(
              title: (map['why'] as Map)['title'] as String? ?? 'Why',
              reasons:
                  ((map['why'] as Map)['reasons'] as List?)
                      ?.cast<String>()
                      .toList() ??
                  [],
            )
          : null,
      relatedResources: const [],
      suggestions: const [],
      actions: const [],
      tags: (map['tags'] as List?)?.cast<String>().toList() ?? [],
    );
  }

  AIInsightSeverity _parseSeverity(String value) {
    switch (value) {
      case 'critical':
        return AIInsightSeverity.critical;
      case 'warning':
        return AIInsightSeverity.warning;
      case 'opportunity':
        return AIInsightSeverity.opportunity;
      default:
        return AIInsightSeverity.information;
    }
  }

  AIInsightCategory _parseCategory(String value) {
    switch (value) {
      case 'analytics':
        return AIInsightCategory.analytics;
      case 'sales':
        return AIInsightCategory.sales;
      case 'finance':
        return AIInsightCategory.finance;
      case 'marketing':
        return AIInsightCategory.marketing;
      case 'crm':
        return AIInsightCategory.crm;
      case 'inventory':
        return AIInsightCategory.inventory;
      case 'support':
        return AIInsightCategory.support;
      case 'security':
        return AIInsightCategory.security;
      case 'workflow':
        return AIInsightCategory.workflow;
      case 'system':
        return AIInsightCategory.system;
      default:
        return AIInsightCategory.analytics;
    }
  }

  AIInsightStatus _parseStatus(String value) {
    switch (value) {
      case 'unread':
        return AIInsightStatus.unread;
      case 'viewed':
        return AIInsightStatus.viewed;
      case 'acknowledged':
        return AIInsightStatus.acknowledged;
      case 'dismissed':
        return AIInsightStatus.dismissed;
      case 'archived':
        return AIInsightStatus.archived;
      default:
        return AIInsightStatus.unread;
    }
  }

  AIImpactLevel _parseImpactLevel(String? value) {
    switch ((value ?? '').trim().toLowerCase()) {
      case 'critical':
        return AIImpactLevel.critical;
      case 'high':
        return AIImpactLevel.high;
      case 'medium':
        return AIImpactLevel.medium;
      case 'low':
        return AIImpactLevel.low;
      case 'positive':
        return AIImpactLevel.positive;
      default:
        return AIImpactLevel.medium;
    }
  }

  List<AIInsight> get filteredInsights {
    if (selectedFilter == 'All') return allInsights;

    if (selectedFilter == 'Critical') {
      return allInsights
          .where((i) => i.severity == AIInsightSeverity.critical)
          .toList();
    } else if (selectedFilter == 'Warning') {
      return allInsights
          .where((i) => i.severity == AIInsightSeverity.warning)
          .toList();
    } else if (selectedFilter == 'Opportunity') {
      return allInsights
          .where((i) => i.severity == AIInsightSeverity.opportunity)
          .toList();
    } else if (selectedFilter == 'Information') {
      return allInsights
          .where((i) => i.severity == AIInsightSeverity.information)
          .toList();
    } else if (selectedFilter == 'Unread') {
      return allInsights
          .where((i) => i.status == AIInsightStatus.unread)
          .toList();
    }
    return allInsights;
  }

  Map<AIInsightSeverity, int> get severityCounts {
    return {
      for (final severity in AIInsightSeverity.values)
        severity: allInsights.where((i) => i.severity == severity).length,
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final insights = filteredInsights;

    return Column(
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
                    'Insights',
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                    ),
                  ),

                  SizedBox(height: kDefaultPadding / 4),

                  // Subtitle
                  Text(
                    'AI-powered insights and recommendations for your business.',
                  ),
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
                  isSelected: selectedFilter == 'All',
                  onTap: () => setState(() => selectedFilter = 'All'),
                  themeData: themeData,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Critical',
                  badge: severityCounts[AIInsightSeverity.critical] ?? 0,
                  isSelected: selectedFilter == 'Critical',
                  onTap: () => setState(() => selectedFilter = 'Critical'),
                  themeData: themeData,
                  color: kErrorColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Warning',
                  badge: severityCounts[AIInsightSeverity.warning] ?? 0,
                  isSelected: selectedFilter == 'Warning',
                  onTap: () => setState(() => selectedFilter = 'Warning'),
                  themeData: themeData,
                  color: themeData.colorScheme.secondary,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Opportunity',
                  badge: severityCounts[AIInsightSeverity.opportunity] ?? 0,
                  isSelected: selectedFilter == 'Opportunity',
                  onTap: () => setState(() => selectedFilter = 'Opportunity'),
                  themeData: themeData,
                  color: kSuccessColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Information',
                  badge: severityCounts[AIInsightSeverity.information] ?? 0,
                  isSelected: selectedFilter == 'Information',
                  onTap: () => setState(() => selectedFilter = 'Information'),
                  themeData: themeData,
                  color: kInfoColor,
                ),
                const SizedBox(width: kDefaultPadding / 2),
                FilterTab(
                  label: 'Unread',
                  isSelected: selectedFilter == 'Unread',
                  onTap: () => setState(() => selectedFilter = 'Unread'),
                  themeData: themeData,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: kDefaultPadding),

        // Insights List
        Expanded(
          child: insights.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.insights_outlined,
                        size: 48,
                        color: themeData.colorScheme.onSurface.withValues(
                          alpha: .3,
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Text(
                        'No insights available',
                        style: themeData.textTheme.titleMedium?.copyWith(
                          color: themeData.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      Text(
                        'Open a page with AI context to surface targeted insights.',
                        style: themeData.textTheme.bodySmall?.copyWith(
                          color: themeData.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  itemCount: insights.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: kDefaultPadding),
                  itemBuilder: (context, index) {
                    return _InsightCard(
                      themeData: themeData,
                      insight: insights[index],
                    );
                  },
                ),
        ),
      ],
    );
  }

  List<AIInsight> _getMockInsights() {
    return getCrmInsights();
  }
}

class _InsightCard extends StatelessWidget {
  final ThemeData themeData;
  final AIInsight insight;

  const _InsightCard({required this.themeData, required this.insight});

  @override
  Widget build(BuildContext context) {
    final color = getSeverityColor(insight.severity, themeData);
    final timeString = formatRelativeTime(insight.generatedAt);

    return Material(
      color: themeData.colorScheme.surface,
      borderRadius: BorderRadius.circular(defaultRadius),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: themeData.colorScheme.outline, width: 0.6),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with severity and time
            Row(
              children: [
                // Severity badge
                IconBadge(
                  icon: getSeverityIcon(insight.severity),
                  label: getSeverityLabel(insight.severity),
                  color: color,
                ),
                const Spacer(),
                // Time
                Text(
                  timeString,
                  style: TextStyle(color: kTextColor, fontSize: kBodySmall),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                // Status indicator
                CircleAvatar(
                  radius: 4,
                  backgroundColor: insight.status == AIInsightStatus.unread
                      ? kErrorColor
                      : Colors.transparent,
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            ResponsiveWrap(
              breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
              columnRatios: const [0.5, 0.5],
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding,
              children: [
                // Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                        fontSize: kBodyMedium,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: kDefaultPadding / 2),

                    // Summary
                    Text(
                      insight.summary,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: kDefaultPadding),

                    // Impact, Confidence
                    Row(
                      children: [
                        // Impact
                        if (insight.impact != null) ...[
                          Tooltip(
                            message: insight.impact?.description,
                            constraints: BoxConstraints(
                              maxWidth: kScreenWidthSm,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Impact'),
                                    SizedBox(width: kDefaultPadding / 4),
                                    Icon(Icons.info_outline_rounded, size: 12),
                                  ],
                                ),
                                const SizedBox(height: kDefaultPadding / 4),
                                Text(
                                  getImpactLabel(insight.impact),
                                  style: TextStyle(
                                    color: getImpactColor(
                                      insight.impact?.level,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding),
                        ],

                        // Confidence Badge
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Confidence'),
                            Text(
                              '${insight.confidence.score}%',
                              style: TextStyle(
                                color: getConfidenceColor(
                                  insight.confidence.level,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: kDefaultPadding / 2),
                      ],
                    ),
                  ],
                ),

                // Why
                if (insight.why != null && insight.why!.reasons.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Why?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                          fontSize: kBodyMedium,
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      ...insight.why!.reasons.map((reason) {
                        final style = getWhyItemStyle(reason);
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: kDefaultPadding / 3,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(style.icon, size: 16, color: style.color),
                              const SizedBox(width: 6),
                              Expanded(child: Text(reason)),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ],
            ),

            const SizedBox(height: kDefaultPadding),

            // Actions and menu
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: kDefaultPadding / 2,
                    children: insight.actions.take(2).map((action) {
                      if (action.type == AIActionType.primary) {
                        return FlatButton(
                          onPressed: () {},
                          kText: action.label,
                          bgColor: kSecondaryColor,
                          kTextColor: Colors.white,
                        );
                      } else {
                        return CustomOutlinedButton(
                          onPressed: () {},
                          kText: action.label,
                          outlineColor: kSecondaryColor,
                        );
                      }
                    }).toList(),
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),

                // Bookmark
                CustomIconButton(
                  onTap: () {},
                  tooltipMessage: 'Bookmark',
                  shape: ButtonShape.circle,
                  icon: Icons.bookmark_outline,
                ),
                // More menu
                CustomIconButton(
                  onTap: () {},
                  tooltipMessage: 'More options',
                  shape: ButtonShape.circle,
                  icon: Icons.more_vert,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';

/// Returns the color associated with the given [severity].
Color getSeverityColor(AIInsightSeverity severity, ThemeData themeData) {
  switch (severity) {
    case AIInsightSeverity.critical:
      return kErrorColor;
    case AIInsightSeverity.warning:
      return themeData.colorScheme.secondary;
    case AIInsightSeverity.opportunity:
      return kSuccessColor;
    case AIInsightSeverity.information:
      return themeData.colorScheme.primary;
  }
}

/// Returns the label string for the given [severity].
String getSeverityLabel(AIInsightSeverity severity) {
  switch (severity) {
    case AIInsightSeverity.critical:
      return 'Critical';
    case AIInsightSeverity.warning:
      return 'Warning';
    case AIInsightSeverity.opportunity:
      return 'Opportunity';
    case AIInsightSeverity.information:
      return 'Information';
  }
}

/// Returns the icon data for the given [severity].
IconData getSeverityIcon(AIInsightSeverity severity) {
  switch (severity) {
    case AIInsightSeverity.critical:
      return Icons.error_outline;
    case AIInsightSeverity.warning:
      return Icons.warning_amber_outlined;
    case AIInsightSeverity.opportunity:
      return Icons.lightbulb_outline;
    case AIInsightSeverity.information:
      return Icons.info_outline;
  }
}

/// Formats a [dateTime] as a relative time string (e.g. "3m ago", "2h ago").
String formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d ago';
  } else {
    return 'Last week';
  }
}

/// Returns a human-readable label for the given [impact].
///
/// Falls back to the impact level name or 'Impact' if null.
String getImpactLabel(AIImpact? impact) {
  final title = impact?.title?.trim();

  if (title != null && title.isNotEmpty) return title;

  switch (impact?.level) {
    case AIImpactLevel.critical:
      return 'Critical';
    case AIImpactLevel.high:
      return 'High';
    case AIImpactLevel.medium:
      return 'Medium';
    case AIImpactLevel.low:
      return 'Low';
    case AIImpactLevel.positive:
      return 'Positive';
    case null:
      return 'Impact';
  }
}

/// Returns the color representing the given [level].
Color getImpactColor(AIImpactLevel? level) {
  switch (level) {
    case AIImpactLevel.critical:
    case AIImpactLevel.high:
      return kErrorColor;
    case AIImpactLevel.medium:
    case AIImpactLevel.positive:
      return kSuccessColor;
    case AIImpactLevel.low:
    case null:
      return kInfoColor;
  }
}

/// Returns the color representing the given confidence [level].
Color getConfidenceColor(AIConfidenceLevel level) {
  switch (level) {
    case AIConfidenceLevel.high:
      return kSuccessColor;
    case AIConfidenceLevel.medium:
      return kWarningColor;
    case AIConfidenceLevel.low:
      return kErrorColor;
  }
}

/// Returns an appropriate icon and color based on the [reason] text content.
///
/// Detects negative, decreasing, or positive keywords to choose a style.
({IconData icon, Color color}) getWhyItemStyle(String reason) {
  final normalized = reason.toLowerCase();

  // Explicit negative statement
  if (normalized.contains(' no ') ||
      normalized.startsWith('no ') ||
      normalized.endsWith(' no') ||
      normalized.contains(' not ') ||
      normalized.startsWith('not ') ||
      normalized.endsWith(' not')) {
    return (icon: Icons.warning_amber_rounded, color: kErrorColor);
  }

  if (normalized.contains('decrease') ||
      normalized.contains('decreased') ||
      normalized.contains('down') ||
      normalized.contains('drop') ||
      normalized.contains('overdue') ||
      normalized.contains('delay') ||
      (normalized.contains('increase') && normalized.contains('workload')) ||
      (normalized.contains('increase') && normalized.contains('not'))) {
    return (icon: Icons.arrow_downward, color: kErrorColor);
  }

  if (normalized.contains('increase') ||
      normalized.contains('improve') ||
      normalized.contains('up') ||
      normalized.contains('growth') ||
      normalized.contains('high') ||
      normalized.contains('surge')) {
    return (icon: Icons.arrow_upward, color: kSuccessColor);
  }

  return (icon: Icons.info_outline, color: kInfoColor);
}

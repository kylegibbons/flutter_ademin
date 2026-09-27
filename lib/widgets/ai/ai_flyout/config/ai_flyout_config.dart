import 'package:flutkit_ademin/widgets/ai/ai_flyout/data_sources/ai_flyout_data_source.dart';

/// Per-screen configuration for the AI Flyout.
class AIFlyoutConfig {
  /// Whether the flyout is enabled on this screen.
  final bool enabled;

  /// Optional data source providing page-specific context.
  final AIFlyoutDataSource? dataSource;

  /// Optional initial agent id to select when opening.
  final String? initialAgent;

  /// Optional list of capability ids to surface for this screen.
  final List<String>? capabilities;

  /// Optional override for drawer width.
  final double? drawerWidth;

  /// Optional badge count shown on the AI flyout button.
  final int badgeCount;

  const AIFlyoutConfig({
    this.enabled = false,
    this.dataSource,
    this.initialAgent,
    this.capabilities,
    this.drawerWidth,
    this.badgeCount = 0,
  });
}

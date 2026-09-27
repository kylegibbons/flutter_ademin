import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_actions_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_agents_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_chat_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_logs_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_insights_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_settings_tab.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_flyout_button.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_insight_model.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/config/ai_flyout_config.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

const double _kAIFlyoutMargin = kDefaultPadding;
const Duration _kDrawerAnimationDuration = Duration(milliseconds: 250);
const Curve _kDrawerAnimationCurve = Curves.easeOutCubic;

class AIFlyoutHost extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final AIFlyoutConfig? config;

  const AIFlyoutHost({
    super.key,
    required this.child,
    this.enabled = false,
    this.config,
  });

  @override
  State<AIFlyoutHost> createState() => _AIFlyoutHostState();
}

class _AIFlyoutHostState extends State<AIFlyoutHost>
    with TickerProviderStateMixin {
  bool _isOpen = false;
  late final TabController _tabController;
  final FocusNode _focusNode = FocusNode(debugLabel: 'AIFlyoutHostFocus');
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  List<AIChatMessage>? _chatMessages;
  AIHome? _home;
  List<AIConversation>? _conversations;
  List<dynamic>? _insights;
  List<Map<String, dynamic>>? _actions;
  List<Map<String, dynamic>>? _agents;
  List<Map<String, dynamic>>? _logs;
  AISettings? _settings;
  bool _isFetching = false;
  bool _isFullWidth = false;

  static List<AIChatMessage>? _asChatMessages(dynamic value) {
    if (value is List<AIChatMessage>) return value;
    if (value is List) {
      return value.whereType<AIChatMessage>().toList();
    }
    return null;
  }

  static AISettings? _asSettings(dynamic value) {
    if (value is AISettings) return value;
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      final behavior = map['behavior'];
      final memory = map['memory'];
      final reports = map['reports'];
      if (behavior is Map && memory is Map && reports is Map) {
        return AISettings(
          behavior: AIBehaviorSettings(
            autoSaveConversations:
                behavior['autoSaveConversations'] as bool? ?? true,
            autoOpenInsights: behavior['autoOpenInsights'] as bool? ?? false,
            confirmBeforeAction:
                behavior['confirmBeforeAction'] as bool? ?? true,
            showAIReasoning: behavior['showAIReasoning'] as bool? ?? true,
          ),
          memory: AIMemorySettings(
            memoryRetention: AIMemoryRetention.values.firstWhere(
              (element) =>
                  element.toString().split('.').last ==
                  (memory['memoryRetention']?.toString() ?? ''),
              orElse: () => AIMemoryRetention.days30,
            ),
            conversationHistory: AIMemoryRetention.values.firstWhere(
              (element) =>
                  element.toString().split('.').last ==
                  (memory['conversationHistory']?.toString() ?? ''),
              orElse: () => AIMemoryRetention.days90,
            ),
          ),
          reports: AIReportSettings(
            exportFormat: AIExportFormat.values.firstWhere(
              (element) =>
                  element.toString().split('.').last ==
                  (reports['exportFormat']?.toString() ?? ''),
              orElse: () => AIExportFormat.pdf,
            ),
            includeVisualizations:
                reports['includeVisualizations'] as bool? ?? true,
            pageSize: AIPageSize.values.firstWhere(
              (element) =>
                  element.toString().split('.').last ==
                  (reports['pageSize']?.toString() ?? ''),
              orElse: () => AIPageSize.a4,
            ),
          ),
        );
      }
    }
    return null;
  }

  static List<Map<String, dynamic>>? _asListOfMap(dynamic value) {
    if (value is List) {
      return value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return null;
  }

  static AIHome? _asHome(dynamic value) {
    if (value is AIHome) return value;
    return null;
  }

  static List<AIConversation>? _asConversations(dynamic value) {
    if (value is List) {
      return value.whereType<AIConversation>().toList();
    }
    return null;
  }

  static List<Map<String, dynamic>>? _asListOfMapOrActions(dynamic value) {
    if (value is List) {
      // Convert both Map and AIActionItem to Map<String, dynamic>
      return value
          .map((item) {
            if (item is Map) {
              return Map<String, dynamic>.from(item);
            }
            return null;
          })
          .whereType<Map<String, dynamic>>()
          .toList();
    }
    return null;
  }

  static List<dynamic>? _asInsightsList(dynamic value) {
    if (value is List<AIInsight>) return value;
    if (value is List) {
      // Handle both AIInsight objects and Map items
      return value.where((item) => item is AIInsight || item is Map).toList();
    }
    return null;
  }

  void _resetFetchedData() {
    _chatMessages = null;
    _home = null;
    _conversations = null;
    _insights = null;
    _actions = null;
    _agents = null;
    _logs = null;
    _settings = null;
  }

  // tab header

  static const List<Widget> _drawerTabs = <Widget>[
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline),
          SizedBox(width: kDefaultPadding / 2),
          Text('Chat'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lightbulb_outline),
          SizedBox(width: kDefaultPadding / 2),
          Text('Insights'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flash_on_outlined),
          SizedBox(width: kDefaultPadding / 2),
          Text('Actions'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.group_outlined),
          SizedBox(width: kDefaultPadding / 2),
          Text('Agents'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history),
          SizedBox(width: kDefaultPadding / 2),
          Text('Logs'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings),
          SizedBox(width: kDefaultPadding / 2),
          Text('Settings'),
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _tabController = TabController(length: _drawerTabs.length, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: _kDrawerAnimationDuration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isOpen = true;
        });
        _onOpened();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          _isOpen = false;
          _resetFetchedData();
          _isFetching = false;
        });
      }
    });
  }

  Future<void> _onOpened() async {
    final dataSource = widget.config?.dataSource;
    if (dataSource == null) return;
    setState(() {
      _isFetching = true;
    });
    try {
      final data = await dataSource.fetch();
      if (!mounted) return;
      final fetched = data.map((k, v) => MapEntry(k.toString(), v));
      setState(() {
        _chatMessages = _asChatMessages(fetched['chat']);
        _home = _asHome(fetched['home']);
        _conversations = _asConversations(fetched['conversations']);
        _insights = _asInsightsList(fetched['insights']);
        _actions = _asListOfMapOrActions(fetched['actions']);
        _agents = _asListOfMap(fetched['agents']);
        _logs = _asListOfMap(fetched['logs']);
        _settings = _asSettings(fetched['settings']);
      });
    } catch (e) {
      // swallow for now; could log or surface via provider
      debugPrint('AIFlyoutHost dataSource.fetch error: $e');
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return;
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleFlyout() {
    final isEnabled = widget.config?.enabled ?? widget.enabled;
    if (!isEnabled) return;
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else if (_animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  void _closeFlyout() {
    if (_animationController.isDismissed) return;
    _animationController.reverse();
  }

  void _toggleFullWidth() {
    setState(() {
      _isFullWidth = !_isFullWidth;
    });
  }

  int get _badgeCount {
    final configBadgeCount = widget.config?.badgeCount;
    if (configBadgeCount != null) {
      return configBadgeCount;
    }

    if (_conversations != null) {
      return _conversations!.fold<int>(
        0,
        (sum, conversation) => sum + conversation.unreadCount,
      );
    }

    return 0;
  }

  double _drawerWidth(double screenWidth) {
    if (_isFullWidth) {
      return screenWidth;
    }

    if (screenWidth <= kScreenWidthMd) {
      return screenWidth;
    }

    final configuredWidth = widget.config?.drawerWidth;
    if (configuredWidth != null && configuredWidth > 0) {
      return min(configuredWidth, screenWidth);
    }

    if (screenWidth <= kScreenWidthLg) {
      return min(420.0, screenWidth * 0.8);
    }

    return min(560.0, max(420.0, screenWidth * 0.35));
  }

  Animation<Offset> _slideAnimationFor(TextDirection textDirection) {
    final beginOffset = textDirection == TextDirection.rtl
        ? const Offset(-1.0, 0.0)
        : const Offset(1.0, 0.0);

    return Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _kDrawerAnimationCurve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final drawerWidth = _drawerWidth(screenSize.width);
    final hasDrawer = !_animationController.isDismissed || _isOpen;

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.escape): const AIFlyoutCloseIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.period):
            const AIFlyoutToggleIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          AIFlyoutCloseIntent: CallbackAction<AIFlyoutCloseIntent>(
            onInvoke: (intent) {
              _closeFlyout();
              return null;
            },
          ),
          AIFlyoutToggleIntent: CallbackAction<AIFlyoutToggleIntent>(
            onInvoke: (intent) {
              _toggleFlyout();
              return null;
            },
          ),
        },
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          child: Stack(
            children: [
              widget.child,
              if (hasDrawer) _buildBackdrop(themeData),
              _buildDrawer(themeData, drawerWidth, screenSize),
              if (_animationController.isDismissed &&
                  (widget.config?.enabled ?? widget.enabled))
                _buildFloatingActionButton(themeData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackdrop(ThemeData themeData) {
    return IgnorePointer(
      ignoring: _animationController.isDismissed,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _closeFlyout,
          child: Container(
            color: themeData.colorScheme.onSurface.withValues(alpha: 0.1),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(ThemeData themeData, double width, Size screenSize) {
    final bool isMobile = screenSize.width <= kScreenWidthMd;
    final textDirection = Directionality.of(context);
    final borderRadius = BorderRadiusDirectional.only(
      topStart: Radius.circular((isMobile || _isFullWidth) ? 0 : defaultRadius),
      bottomStart: Radius.circular(
        (isMobile || _isFullWidth) ? 0 : defaultRadius,
      ),
    );

    return PositionedDirectional(
      end: 0,
      top: 0,
      bottom: 0,
      width: width,
      child: SlideTransition(
        position: _slideAnimationFor(textDirection),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Material(
            // color: themeData.colorScheme.surface.withValues(alpha: 0.96),
            elevation: 8,
            shadowColor: themeData.shadowColor.withValues(alpha: 0.14),
            borderRadius: borderRadius,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Column(
                children: [
                  _AIFlyoutDrawerHeader(
                    isFullWidth: _isFullWidth,
                    onToggleFullWidth: _toggleFullWidth,
                  ),
                  _buildDrawerTabBar(themeData),
                  Divider(
                    height: 1,
                    thickness: 0.6,
                    color: themeData.colorScheme.outline,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AIChatTab(
                          home: _home,
                          conversations: _conversations,
                          chatMessages: _chatMessages,
                          isFetching: _isFetching,
                        ),
                        AIInsightsTab(insights: _insights),
                        AIActionsTab(actions: _actions),
                        AIAgentsTab(agents: _agents),
                        AILogsTab(logs: _logs),
                        AISettingsTab(settings: _settings),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerTabBar(ThemeData themeData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      // color: themeData.colorScheme.surface,
      child: TabBar(
        controller: _tabController,
        tabs: _drawerTabs,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: themeData.colorScheme.primary,
            width: 2.4,
          ),
          // insets: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        ),
        labelColor: themeData.colorScheme.onSurface,
        // unselectedLabelColor: themeData.colorScheme.onSurface.withValues(
        //   alpha: 0.7,
        // ),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),

        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildFloatingActionButton(ThemeData themeData) {
    final isEnabled = widget.config?.enabled ?? widget.enabled;
    return PositionedDirectional(
      end: _kAIFlyoutMargin,
      bottom: _kAIFlyoutMargin,
      child: AIFlyoutButton(
        onTap: _toggleFlyout,
        isActive: _isOpen,
        badgeCount: _badgeCount,
        hasInsight: true,
        disabled: !isEnabled,
      ),
    );
  }
}

class _AIFlyoutDrawerHeader extends StatelessWidget {
  final bool isFullWidth;
  final VoidCallback onToggleFullWidth;

  const _AIFlyoutDrawerHeader({
    required this.isFullWidth,
    required this.onToggleFullWidth,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Icon
              Container(
                width: mediumHeight,
                height: mediumHeight,
                decoration: BoxDecoration(
                  gradient: kPurpleGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, color: Colors.white),
              ),
              const SizedBox(width: kDefaultPadding / 2),
              Expanded(
                child: Text(
                  'AI Operator',
                  style: TextStyle(
                    fontSize: kBodyLarge,
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
              ),

              // full width button
              CustomIconButton(
                icon: isFullWidth ? Icons.fullscreen_exit : Icons.fullscreen,
                shape: ButtonShape.circle,
                tooltipMessage: isFullWidth ? 'Normal width' : 'Full width',
                onTap: onToggleFullWidth,
              ),

              // close button
              CustomIconButton(
                icon: Icons.close,
                shape: ButtonShape.circle,
                tooltipMessage: 'Close AI panel',
                onTap: () {
                  final state = context
                      .findAncestorStateOfType<_AIFlyoutHostState>();
                  state?._closeFlyout();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AIFlyoutCloseIntent extends Intent {
  const AIFlyoutCloseIntent();
}

class AIFlyoutToggleIntent extends Intent {
  const AIFlyoutToggleIntent();
}

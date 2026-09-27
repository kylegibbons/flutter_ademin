import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_settings_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';

class AISettingsTab extends StatefulWidget {
  final AISettings? settings;

  const AISettingsTab({super.key, this.settings});

  @override
  State<AISettingsTab> createState() => _AISettingsTabState();
}

class _AISettingsTabState extends State<AISettingsTab> {
  late bool autoSaveConversations;
  late bool autoOpenInsights;
  late bool confirmBeforeAction;
  late bool showAIReasoning;
  late AIMemoryRetention memoryRetention;
  late AIMemoryRetention conversationHistory;
  late AIExportFormat exportFormat;
  late bool includeVisualizations;
  late AIPageSize pageSize;

  @override
  void initState() {
    super.initState();
    final settings = widget.settings ?? _defaultSettings;
    autoSaveConversations = settings.behavior.autoSaveConversations;
    autoOpenInsights = settings.behavior.autoOpenInsights;
    confirmBeforeAction = settings.behavior.confirmBeforeAction;
    showAIReasoning = settings.behavior.showAIReasoning;
    memoryRetention = settings.memory.memoryRetention;
    conversationHistory = settings.memory.conversationHistory;
    exportFormat = settings.reports.exportFormat;
    includeVisualizations = settings.reports.includeVisualizations;
    pageSize = settings.reports.pageSize;
  }

  AISettings get _defaultSettings => const AISettings(
    behavior: AIBehaviorSettings(
      autoSaveConversations: true,
      autoOpenInsights: false,
      confirmBeforeAction: true,
      showAIReasoning: true,
    ),
    memory: AIMemorySettings(
      memoryRetention: AIMemoryRetention.days30,
      conversationHistory: AIMemoryRetention.days90,
    ),
    reports: AIReportSettings(
      exportFormat: AIExportFormat.pdf,
      includeVisualizations: true,
      pageSize: AIPageSize.a4,
    ),
  );

  String _memoryLabel(AIMemoryRetention retention) {
    switch (retention) {
      case AIMemoryRetention.days7:
        return '7 days';
      case AIMemoryRetention.days30:
        return '30 days';
      case AIMemoryRetention.days90:
        return '90 days';
      case AIMemoryRetention.days180:
        return '180 days';
      case AIMemoryRetention.forever:
        return 'Forever';
    }
  }

  String _exportFormatLabel(AIExportFormat format) {
    switch (format) {
      case AIExportFormat.pdf:
        return 'PDF';
      case AIExportFormat.excel:
        return 'Excel';
      case AIExportFormat.csv:
        return 'CSV';
      case AIExportFormat.word:
        return 'Word';
    }
  }

  String _pageSizeLabel(AIPageSize pageSize) {
    switch (pageSize) {
      case AIPageSize.a4:
        return 'A4';
      case AIPageSize.letter:
        return 'Letter';
      case AIPageSize.legal:
        return 'Legal';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: kBodyLarge,
              ),
            ),
            SizedBox(height: kDefaultPadding),

            _SettingsSection(
              title: 'Behavior',
              children: [
                _SettingToggle(
                  label: 'Auto-save Conversations',
                  description: 'Automatically save conversations and context.',
                  value: autoSaveConversations,
                  onChanged: (value) => setState(() {
                    autoSaveConversations = value;
                  }),
                ),
                _SettingToggle(
                  label: 'Auto-open Insights',
                  description:
                      'Open the Insights tab when new insights are generated.',
                  value: autoOpenInsights,
                  onChanged: (value) => setState(() {
                    autoOpenInsights = value;
                  }),
                ),
                _SettingToggle(
                  label: 'Confirm Before Action',
                  description:
                      'Ask for confirmation before AI executes important actions.',
                  value: confirmBeforeAction,
                  onChanged: (value) => setState(() {
                    confirmBeforeAction = value;
                  }),
                ),
                _SettingToggle(
                  label: 'Show AI Reasoning',
                  description:
                      'Display AI reasoning and explanation in results.',
                  value: showAIReasoning,
                  onChanged: (value) => setState(() {
                    showAIReasoning = value;
                  }),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            _SettingsSection(
              title: 'Data & Memory',
              children: [
                _SettingDropdown<AIMemoryRetention>(
                  label: 'Memory Retention',
                  description: 'How long AI can remember context and history.',
                  value: memoryRetention,
                  items: AIMemoryRetention.values,
                  labelBuilder: _memoryLabel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        memoryRetention = value;
                      });
                    }
                  },
                ),
                _SettingDropdown<AIMemoryRetention>(
                  label: 'Conversation History',
                  description: 'Manage how long chat history is stored.',
                  value: conversationHistory,
                  items: AIMemoryRetention.values,
                  labelBuilder: _memoryLabel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        conversationHistory = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                Tooltip(
                  message: 'This will clear all stored context and history.',
                  child: CustomOutlinedButton(
                    kText: 'Clear AI Memory & Context',
                    outlineColor: kErrorColor,
                    isFullWidth: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
            _SettingsSection(
              title: 'Files & Reports',
              children: [
                _SettingDropdown<AIExportFormat>(
                  label: 'Default Export Format',
                  description:
                      'Choose the default format for exported reports.',
                  value: exportFormat,
                  items: AIExportFormat.values,
                  labelBuilder: _exportFormatLabel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        exportFormat = value;
                      });
                    }
                  },
                ),
                _SettingToggle(
                  label: 'Include Visualizations',
                  description: 'Include charts and graphs in exported reports.',
                  value: includeVisualizations,
                  onChanged: (value) => setState(() {
                    includeVisualizations = value;
                  }),
                ),
                SizedBox(height: kDefaultPadding),
                _SettingDropdown<AIPageSize>(
                  label: 'Default Page Size',
                  description: 'Select the default page size for reports.',
                  value: pageSize,
                  items: AIPageSize.values,
                  labelBuilder: _pageSizeLabel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        pageSize = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),

            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    kText: 'Reset to Default',
                    outlineColor: kPrimaryColor,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                  child: FlatButton(
                    kText: 'Save Changes',
                    bgColor: kSecondaryColor,
                    kTextColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(color: themeData.colorScheme.outline, width: 0.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: themeData.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          ...children,
        ],
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final String label;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final bool enabled;

  const _SettingToggle({
    required this.label,
    required this.description,
    required this.value,
    required this.onChanged,
  }) : enabled = true,
       activeColor = null;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 4),
                Text(description),
              ],
            ),
          ),

          const SizedBox(width: kDefaultPadding),

          CustomSwitch(
            label: '',
            value: value,
            activeColor: kSecondaryColor,
            onChanged: enabled
                ? onChanged
                : (newValue) {
                    if (!enabled) return;
                    onChanged(newValue);
                  },
          ),
        ],
      ),
    );
  }
}

class _SettingDropdown<T> extends StatelessWidget {
  final String label;
  final String description;
  final T value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const _SettingDropdown({
    required this.label,
    required this.description,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: themeData.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),

          CustomDropdownFormField<T>(
            items: items
                .map(
                  (item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(labelBuilder(item)),
                  ),
                )
                .toList(),
            initialValue: value,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(description, style: TextStyle(fontSize: kBodySmall)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/ai_chat_input_bar.dart';
import 'package:flutkit_ademin/widgets/ai/ai_flyout/models/ai_chat_model.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';

class AIChatTab extends StatefulWidget {
  final AIHome? home;
  final List<AIConversation>? conversations;
  final List<AIChatMessage>? chatMessages;
  final bool isFetching;

  const AIChatTab({
    super.key,
    this.home,
    this.conversations,
    this.chatMessages,
    this.isFetching = false,
  });

  @override
  State<AIChatTab> createState() => _AIChatTabState();
}

enum _ChatTabView { home, history, search, detail }

class _AIChatTabState extends State<AIChatTab> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _detailScrollController = ScrollController();
  _ChatTabView _view = _ChatTabView.home;
  AIConversation? _selectedConversation;
  String _searchQuery = '';

  void _scrollToBottom({bool animated = false}) {
    if (!_detailScrollController.hasClients) return;

    final target = _detailScrollController.position.maxScrollExtent;
    if (target <= 0) return;

    if (animated) {
      _detailScrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOut,
      );
    } else {
      _detailScrollController.jumpTo(target);
    }
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = AIChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      role: ChatRole.user,
      type: ChatMessageType.text,
      text: text,
    );

    final assistantMessage = AIChatMessage(
      id: 'assistant_${DateTime.now().millisecondsSinceEpoch}',
      role: ChatRole.assistant,
      type: ChatMessageType.text,
      text: 'I am processing your request: "$text". How else can I help?',
    );

    final existingConversation = _selectedConversation;
    final chatMessages = existingConversation == null
        ? <AIChatMessage>[userMessage, assistantMessage]
        : [...existingConversation.chat, userMessage, assistantMessage];

    setState(() {
      _selectedConversation = AIConversation(
        id:
            existingConversation?.id ??
            'new_${DateTime.now().millisecondsSinceEpoch}',
        title: existingConversation?.title ?? text,
        preview: text,
        updatedAt: DateTime.now(),
        pinned: existingConversation?.pinned ?? false,
        favorite: existingConversation?.favorite ?? false,
        unreadCount: existingConversation?.unreadCount ?? 0,
        chat: chatMessages,
      );
      _view = _ChatTabView.detail;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animated: true);
    });
  }

  void _handleActionTap(AIQuickAction action) {
    final userMessage = AIChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      role: ChatRole.user,
      type: ChatMessageType.text,
      text: action.prompt ?? action.title,
    );

    final assistantMessage = AIChatMessage(
      id: 'assistant_${DateTime.now().millisecondsSinceEpoch}',
      role: ChatRole.assistant,
      type: ChatMessageType.text,
      text:
          'I can help with "${action.title}". I will analyze the relevant CRM data and suggest the next step.',
    );

    final existingConversation = _selectedConversation;
    final chatMessages = existingConversation == null
        ? <AIChatMessage>[userMessage, assistantMessage]
        : [...existingConversation.chat, userMessage, assistantMessage];

    setState(() {
      _selectedConversation = AIConversation(
        id:
            existingConversation?.id ??
            'new_${DateTime.now().millisecondsSinceEpoch}',
        title: existingConversation?.title ?? action.title,
        preview: action.title,
        updatedAt: DateTime.now(),
        pinned: existingConversation?.pinned ?? false,
        favorite: existingConversation?.favorite ?? false,
        unreadCount: existingConversation?.unreadCount ?? 0,
        chat: chatMessages,
      );
      _view = _ChatTabView.detail;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animated: true);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _detailScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    if (widget.isFetching && _view == _ChatTabView.home) {
      return _buildShell(
        theme: themeData,
        title: 'AI Chat',
        showBack: false,
        actions: [
          CustomIconButton(
            icon: Icons.history_outlined,
            tooltipMessage: 'History',
            shape: ButtonShape.circle,
            onTap: () => setState(() => _view = _ChatTabView.history),
          ),
        ],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(strokeWidth: 2),
                const SizedBox(height: kDefaultPadding),
                Text('Loading page context...', style: TextStyle()),
              ],
            ),
          ),
        ),
      );
    }

    switch (_view) {
      case _ChatTabView.home:
        return _buildHomeView(themeData);
      case _ChatTabView.history:
        return _buildHistoryView(themeData);
      case _ChatTabView.search:
        return _buildSearchView(themeData);
      case _ChatTabView.detail:
        return _buildDetailView(themeData);
    }
  }

  // Home view

  Widget _buildHomeView(ThemeData themeData) {
    final home = widget.home;
    final quickActions = home?.quickActions ?? const <AIQuickAction>[];

    return _buildShell(
      theme: themeData,
      title: 'New Chat',
      showBack: false,
      actions: [
        CustomIconButton(
          icon: Icons.history_outlined,
          tooltipMessage: 'Open history',
          shape: ButtonShape.circle,
          onTap: () => setState(() => _view = _ChatTabView.history),
        ),
      ],
      showInputBar: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: kDefaultPadding / 2,
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                home?.greeting ?? 'Hi there 👋',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                home?.subtitle ??
                    'I can help analyze your data and guide next actions.',
              ),

              const SizedBox(height: kDefaultPadding),

              if (quickActions.isEmpty)
                Text('No quick actions available yet.')
              else
                Wrap(
                  spacing: kDefaultPadding / 2,
                  runSpacing: kDefaultPadding / 2,
                  children: quickActions
                      .map(
                        (action) => CustomOutlinedButton(
                          kText: action.title,
                          outlineColor: kSecondaryColor,
                          isRounded: true,
                          kLeadingIcon:
                              action.icon ?? Icons.auto_awesome_outlined,
                          onPressed: () => _handleActionTap(action),
                        ),
                      )
                      .toList(),
                ),

              // const SizedBox(height: kDefaultPadding * 2),
              // Text(
              //   'Open history to continue previous conversations.',
              //   style: TextStyle(fontSize: kBodySmall),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryView(ThemeData themeData) {
    final conversations = widget.conversations ?? const <AIConversation>[];
    final pinned = conversations.where((item) => item.pinned).toList();
    final history = conversations.where((item) => !item.pinned).toList();

    return _buildShell(
      theme: themeData,
      title: 'History',
      showBack: true,
      onBack: () => setState(() => _view = _ChatTabView.home),
      actions: [
        CustomIconButton(
          onTap: () => setState(() => _view = _ChatTabView.search),
          icon: Icons.search_outlined,
          tooltipMessage: 'Search chats',
          shape: ButtonShape.circle,
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
          Row(
            children: [
              // new chat button
              Expanded(
                child: FlatButton(
                  kText: 'New chat',
                  bgColor: kSecondaryColor,
                  kTextColor: Colors.white,
                  kLeadingIcon: Icons.add_comment_outlined,
                  isRounded: true,
                  onPressed: () => setState(() => _view = _ChatTabView.home),
                ),
              ),
              const SizedBox(width: kDefaultPadding / 2),

              // search chat button
              Expanded(
                child: CustomOutlinedButton(
                  kText: 'Search chat',
                  outlineColor: kPrimaryColor,
                  kLeadingIcon: Icons.search_outlined,
                  isRounded: true,
                  onPressed: () => setState(() => _view = _ChatTabView.search),
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding),
          if (pinned.isNotEmpty) ...[
            Text(
              'Pinned chat',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            ...pinned.map(
              (conversation) => _ConversationTile(
                conversation: conversation,
                onTap: () {
                  _selectedConversation = conversation;
                  setState(() => _view = _ChatTabView.detail);
                },
              ),
            ),
            const SizedBox(height: kDefaultPadding),
          ],
          Text(
            'Chat history',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: themeData.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          if (history.isEmpty)
            Text('No previous chats yet.')
          else
            ...history.map(
              (conversation) => _ConversationTile(
                conversation: conversation,
                onTap: () {
                  _selectedConversation = conversation;
                  setState(() => _view = _ChatTabView.detail);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchView(ThemeData theme) {
    final conversations = widget.conversations ?? const <AIConversation>[];
    final query = _searchQuery.trim().toLowerCase();
    final filtered = conversations.where((item) {
      final haystack = '${item.title} ${item.preview}'.toLowerCase();
      return query.isEmpty || haystack.contains(query);
    }).toList();

    return _buildShell(
      theme: theme,
      title: 'Search',
      showBack: true,
      onBack: () => setState(() => _view = _ChatTabView.history),
      child: Column(
        children: [
          // search bar
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: kDefaultPadding,
              start: kDefaultPadding,
              end: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: OutlineSearchBar(
              controller: _searchController,
              hintText: 'Search chat history',
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      query.isEmpty
                          ? 'Type to find a chat.'
                          : 'No matching conversations found.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      kDefaultPadding,
                      0,
                      kDefaultPadding,
                      kDefaultPadding,
                    ),
                    itemCount: filtered.length,

                    itemBuilder: (context, index) {
                      final conversation = filtered[index];
                      return _ConversationTile(
                        conversation: conversation,
                        onTap: () {
                          _selectedConversation = conversation;
                          setState(() => _view = _ChatTabView.detail);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailView(ThemeData themeData) {
    final conversation = _selectedConversation;
    if (conversation == null) {
      return _buildShell(
        theme: themeData,
        title: 'Conversation',
        showBack: true,
        onBack: () => setState(() => _view = _ChatTabView.history),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Text(
              'Select a conversation to view details.',
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return _buildShell(
      theme: themeData,
      title: conversation.title,
      showBack: true,
      onBack: () => setState(() => _view = _ChatTabView.history),
      showInputBar: true,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _detailScrollController,
              padding: const EdgeInsets.fromLTRB(
                kDefaultPadding,
                0,
                kDefaultPadding,
                0,
              ),
              itemCount: conversation.chat.length,
              // separatorBuilder: (_, __) =>
              //     const SizedBox(height: kDefaultPadding),
              itemBuilder: (context, index) {
                final message = conversation.chat[index];
                return _ChatMessageBubble(
                  message: message,
                  themeData: themeData,
                  onActionTap: _handleActionTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShell({
    required ThemeData theme,
    required String title,
    required Widget child,
    required bool showBack,
    VoidCallback? onBack,
    List<Widget> actions = const [],
    bool showInputBar = false,
  }) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsetsDirectional.fromSTEB(
            kDefaultPadding / 2,
            kDefaultPadding / 2,
            kDefaultPadding / 2,
            0,
          ),
          child: Row(
            children: [
              if (showBack)
                CustomIconButton(
                  onTap: onBack,
                  tooltipMessage: 'Back',
                  shape: ButtonShape.circle,
                  icon: Icons.arrow_back_ios_new_rounded,
                ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: kDefaultPadding / 2,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: kBodyLarge,
                    ),
                  ),
                ),
              ),
              ...actions,
            ],
          ),
        ),
        Expanded(child: child),
        if (showInputBar)
          AIChatInputBar(
            onSend: _handleSendMessage,
            onMic: () {},
            onUploadFiles: () {},
            onAddFromDrive: () {},
            onDeepResearch: () {},
          ),
      ],
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final AIConversation conversation;
  final VoidCallback onTap;

  const _ConversationTile({required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 2,
          horizontal: kDefaultPadding / 2,
        ),
        child: Row(
          children: [
            Container(
              width: mediumHeight,
              height: mediumHeight,
              decoration: BoxDecoration(
                // color: theme.colorScheme.primaryContainer,
                border: Border.all(
                  color: themeData.colorScheme.onSurface,
                  width: 0.6,
                ),
                shape: BoxShape.circle,
              ),

              child: Icon(
                conversation.pinned
                    ? Icons.push_pin_outlined
                    : Icons.chat_bubble_outline,
                color: themeData.colorScheme.onSurface,
                size: 18,
              ),
            ),

            const SizedBox(width: kDefaultPadding / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),

                  Text(
                    conversation.preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (conversation.unreadCount > 0)
              Badge(
                label: Text('${conversation.unreadCount}'),
                backgroundColor: kSecondaryColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  final AIChatMessage message;
  final ThemeData themeData;
  final ValueChanged<AIQuickAction>? onActionTap;

  const _ChatMessageBubble({
    required this.message,
    required this.themeData,
    this.onActionTap,
  });

  bool get _isUser => message.role == ChatRole.user;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final backgroundColor = _isUser
            ? themeData.colorScheme.primary.withValues(alpha: 0.1)
            : Colors.transparent;
        final foregroundColor = themeData.colorScheme.onSurface;
        final parentWidth = constraints.maxWidth;
        final maxBubbleWidth = _isUser ? (parentWidth * 0.6) : parentWidth;

        return Row(
          mainAxisAlignment: _isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                margin: EdgeInsets.only(
                  top:
                      (message.type == ChatMessageType.suggestions ||
                          message.type == ChatMessageType.actions)
                      ? kDefaultPadding / 2
                      : kDefaultPadding,
                ),
                padding: EdgeInsets.symmetric(
                  vertical:
                      (message.type == ChatMessageType.suggestions ||
                          message.type == ChatMessageType.actions)
                      ? 0
                      : kDefaultPadding / 2,
                  horizontal: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_isUser ? 18 : defaultRadius),
                    topRight: Radius.circular(_isUser ? defaultRadius : 18),
                    bottomLeft: const Radius.circular(18),
                    bottomRight: const Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.type == ChatMessageType.text)
                      Text(
                        message.text ?? '',
                        style: TextStyle(color: foregroundColor),
                      )
                    else if (message.type == ChatMessageType.suggestions)
                      Wrap(
                        spacing: kDefaultPadding / 2,
                        runSpacing: kDefaultPadding / 2,
                        children:
                            (message.actions.isNotEmpty
                                    ? message.actions
                                    : message.suggestions)
                                .map(
                                  (suggestion) => CustomOutlinedButton(
                                    kText: suggestion.title,
                                    outlineColor: kSecondaryColor,
                                    isRounded: true,
                                    kLeadingIcon:
                                        suggestion.icon ??
                                        Icons.auto_awesome_outlined,
                                    onPressed: () =>
                                        onActionTap?.call(suggestion),
                                  ),
                                )
                                .toList(),
                      )
                    else if (message.type == ChatMessageType.actions)
                      Wrap(
                        spacing: kDefaultPadding / 2,
                        runSpacing: kDefaultPadding / 2,
                        children: message.actions
                            .map(
                              (action) => CustomOutlinedButton(
                                kText: action.title,
                                outlineColor: kSecondaryColor,
                                isRounded: true,
                                kLeadingIcon:
                                    action.icon ?? Icons.auto_awesome_outlined,
                                onPressed: () => onActionTap?.call(action),
                              ),
                            )
                            .toList(),
                      )
                    else
                      Text(
                        message.text ?? '',
                        style: TextStyle(color: foregroundColor),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

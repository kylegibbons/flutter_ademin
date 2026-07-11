import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/chat/chat_data.dart';
import 'package:flutter_ademin/demo/app/chat/chat_model.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class ChatContentScreen extends StatefulWidget {
  final ChatSelection chatSelection;
  final bool isMobile;
  final VoidCallback? onMessagesUpdated;

  const ChatContentScreen({
    super.key,
    required this.chatSelection,
    required this.isMobile,
    this.onMessagesUpdated,
  });

  @override
  State<ChatContentScreen> createState() => _ChatContentScreenState();
}

class _ChatContentScreenState extends State<ChatContentScreen> {
  late final FocusNode _focusNode;
  late final TextEditingController _messageController;
  bool _isAutoReplyQueued = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _messageController = TextEditingController();
    _markIncomingMessagesAsRead();
  }

  // emoji picker function
  bool _showEmojiPicker = false;

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });

    if (_showEmojiPicker) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  List<ChatMessage> get _messages => widget.chatSelection.isPersonal
      ? widget.chatSelection.personalChat!.messages
      : widget.chatSelection.channel!.messages;

  void _markIncomingMessagesAsRead() {
    bool hasChanges = false;

    for (var i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      if (message.sender.id != MockData.currentUser.id &&
          message.status == MessageStatus.unread) {
        _messages[i] = message.copyWith(status: MessageStatus.read);
        hasChanges = true;
      }
    }

    if (hasChanges) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _notifyMessagesUpdated();
        }
      });
    }
  }

  void _notifyMessagesUpdated() {
    widget.onMessagesUpdated?.call();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }

    final sentMessage = ChatMessage(
      content: text,
      time: DateTime.now(),
      sender: MockData.currentUser,
      status: MessageStatus.sent,
    );

    setState(() {
      _messages.add(sentMessage);
      _messageController.clear();
      _showEmojiPicker = false;
    });
    _notifyMessagesUpdated();
    _scheduleAutoReply(text, sentMessage);
  }

  void _scheduleAutoReply(String originalMessage, ChatMessage sentMessage) {
    if (_isAutoReplyQueued) {
      return;
    }

    _isAutoReplyQueued = true;

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) {
        return;
      }

      setState(() {
        final sentMessageIndex = _messages.lastIndexOf(sentMessage);
        if (sentMessageIndex != -1) {
          _messages[sentMessageIndex] = _messages[sentMessageIndex].copyWith(
            status: MessageStatus.read,
          );
        }
        _messages.add(
          ChatMessage(
            content: _buildAutoReply(originalMessage),
            time: DateTime.now(),
            sender: _getAutoReplySender(),
            status: MessageStatus.read,
          ),
        );
        _isAutoReplyQueued = false;
      });
      _notifyMessagesUpdated();
    });
  }

  User _getAutoReplySender() {
    if (widget.chatSelection.isPersonal) {
      return widget.chatSelection.personalChat!.user;
    }

    return widget.chatSelection.channel!.members.firstWhere(
      (member) => member.id != MockData.currentUser.id,
      orElse: () => MockData.alice,
    );
  }

  String _buildAutoReply(String originalMessage) {
    final normalized = originalMessage.toLowerCase();

    if (normalized.contains('?')) {
      return 'Thanks for the question. I will check and get back to you shortly.';
    }
    if (normalized.contains('hello') || normalized.contains('hi')) {
      return 'Hi there! Good to hear from you.';
    }
    if (normalized.contains('thanks') || normalized.contains('thank you')) {
      return 'You are welcome. Happy to help.';
    }
    if (normalized.contains('meeting')) {
      return 'Sounds good. I can make time for that meeting.';
    }
    if (normalized.contains('update') || normalized.contains('progress')) {
      return 'Quick update noted. I will review it and reply with details soon.';
    }

    return 'Got it. Thanks for the message.';
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatContentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chatSelection.id != widget.chatSelection.id) {
      _markIncomingMessagesAsRead();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine data based on selection type
    final String title = widget.chatSelection.isPersonal
        ? widget.chatSelection.personalChat!.user.name
        : widget.chatSelection.channel!.channelName;

    final String subtitle = widget.chatSelection.isPersonal
        ? (widget.chatSelection.personalChat!.user.isOnline
              ? "Online"
              : "Offline")
        : "${widget.chatSelection.channel!.members.length} members";

    final Widget image = widget.chatSelection.isPersonal
        ? CircleAvatar(
            backgroundImage: AssetImage(
              widget
                  .chatSelection
                  .personalChat!
                  .user
                  .avatarUrl, // replace NetworkImage in production
            ),
            radius: 20,
          )
        : CircleAvatar(
            backgroundColor: kSuccessColor.withValues(alpha: 0.1),
            radius: 20,
            child: Icon(
              widget.chatSelection.channel!.icon,
              color: kSuccessColor,
              size: 20,
            ),
          );

    final List<ChatMessage> messages = _messages;

    final themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(color: themeData.scaffoldBackgroundColor),
      child: Column(
        children: [
          // chat content header
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: kDefaultPadding / 4,
              bottom: kDefaultPadding / 4,
              end: kDefaultPadding / 4,
              start: widget.isMobile ? kDefaultPadding / 4 : 0,
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                padding: EdgeInsetsDirectional.only(
                  start: widget.isMobile ? 0 : kDefaultPadding,
                  top: kDefaultPadding,
                  end: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                color: themeData.colorScheme.surface,
                child: Row(
                  children: [
                    // back button to chat list
                    if (widget.isMobile)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 2,
                        ),
                        child: CustomIconButton(
                          icon: Icons.arrow_back,
                          shape: ButtonShape.circle,
                          size: ButtonSize.large,
                          onTap: () {
                            Navigator.of(context).maybePop();
                          },
                        ),
                      ),

                    // avatar
                    image,
                    const SizedBox(width: kDefaultPadding),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title : username / channel name
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),

                        // subtitle
                        Text(subtitle),
                      ],
                    ),
                    const Spacer(),

                    Row(
                      children: [
                        // search button
                        CustomIconButton(
                          onTap: () {},
                          icon: Icons.search_outlined,
                        ),

                        // info button
                        CustomIconButton(
                          onTap: () {},
                          icon: Icons.info_outline,
                        ),

                        // more button
                        CustomIconButton(onTap: () {}, icon: Icons.more_vert),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // chat content
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(kDefaultPadding),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];

                final isMe = msg.sender.id == MockData.currentUser.id;
                return _buildMessageBubble(context, msg, isMe);
              },
            ),
          ),

          // input area
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage msg, bool isMe) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Show sender avatar if Group Chat and not me
              if (!isMe && !widget.chatSelection.isPersonal) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(msg.sender.avatarUrl),
                  backgroundColor: kTableHeaderColor,
                ),
              ],

              SizedBox(width: kDefaultPadding / 2),

              // chat bubble
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 320),
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 2,
                      vertical: kDefaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? kSuccessColor.withValues(alpha: 0.1)
                          : themeData.colorScheme.surface,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: isMe
                            ? const Radius.circular(defaultRadius * 2)
                            : const Radius.circular(0),
                        topEnd: isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(defaultRadius * 2),
                        bottomStart: const Radius.circular(defaultRadius * 2),
                        bottomEnd: const Radius.circular(defaultRadius * 2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Show sender name if Group Chat and not me
                        if (!isMe && !widget.chatSelection.isPersonal) ...[
                          Text(
                            msg.sender.name,
                            style: const TextStyle(
                              fontSize: kBodySmall,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],

                        // chat content
                        Text(
                          msg.content,
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: kDefaultPadding / 4),
                  // message status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        "${msg.time.hour}:${msg.time.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 10),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: kDefaultPadding / 4),
                        _buildStatusIcon(msg.status),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.sent:
        return Icon(Icons.check, size: 14, color: kTextColor);
      case MessageStatus.delivered:
        return Icon(Icons.done_all, size: 14, color: kTextColor);
      case MessageStatus.read:
        return Icon(Icons.done_all, size: 14, color: kSuccessColor);
      case MessageStatus.unread:
        return const SizedBox();
    }
  }

  Widget _buildInputArea(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthLg;
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: kDefaultPadding / 4,
            bottom: kDefaultPadding / 4,
            end: kDefaultPadding / 4,
            start: widget.isMobile ? kDefaultPadding / 4 : 0,
          ),
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              ),
              child: Row(
                children: [
                  // emoji button
                  CustomIconButton(
                    onTap: _toggleEmojiPicker,
                    icon: Icons.emoji_emotions_outlined,
                  ),

                  // attachment button
                  PopupMenuButton<int>(
                    tooltip: 'Attachment',
                    color: themeData.colorScheme.surface,
                    offset: const Offset(0, 32),
                    splashRadius: defaultRadius,
                    borderRadius: BorderRadius.circular(defaultRadius),
                    onSelected: (value) {},
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Photos & videos"),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Camera"),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.file_open_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Document"),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(
                              Icons.contact_mail_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Contact"),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 4,
                        child: Row(
                          children: [
                            Icon(
                              Icons.poll_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Poll"),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 5,
                        child: Row(
                          children: [
                            Icon(
                              Icons.draw_outlined,
                              size: 16,
                              color: themeData.colorScheme.onSurface,
                            ),
                            const SizedBox(width: kDefaultPadding),
                            const Text("Drawing"),
                          ],
                        ),
                      ),
                    ],
                    child: CustomIconButton(
                      onTap: null,
                      icon: Icons.attach_file,
                    ),
                  ),

                  const SizedBox(width: kDefaultPadding / 2),

                  // textfield input
                  Expanded(
                    child: SizedBox(
                      height: mediumHeight,
                      child: TextField(
                        controller: _messageController,
                        focusNode: _focusNode,
                        autofocus: true,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        cursorColor: themeData.colorScheme.onSurface,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontSize: kBodyMedium,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultRadius),
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          fillColor: themeData.scaffoldBackgroundColor,
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding),

                  // send button
                  CustomIconButton(
                    onTap: _sendMessage,
                    icon: Icons.send_outlined,
                    buttonColor: kSuccessColor,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),

        // emoji picker below input
        if (_showEmojiPicker)
          Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: kDefaultPadding / 4,
              end: kDefaultPadding / 4,
              start: isMobile ? kDefaultPadding / 4 : 0,
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 240,
                decoration: BoxDecoration(color: themeData.colorScheme.surface),
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    _messageController
                      ..text += emoji.emoji
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: _messageController.text.length),
                      );
                  },
                  config: Config(
                    height: 240,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 20,
                      backgroundColor: themeData.colorScheme.surface,
                      columns: 16,
                    ),
                    viewOrderConfig: const ViewOrderConfig(
                      top: EmojiPickerItem.categoryBar,
                      middle: EmojiPickerItem.emojiView,
                      bottom: EmojiPickerItem.searchBar,
                    ),
                    skinToneConfig: const SkinToneConfig(),
                    categoryViewConfig: CategoryViewConfig(
                      tabBarHeight: 1.2 * mediumHeight,
                      backgroundColor: kTableHeaderColor,
                      indicatorColor: kSuccessColor,
                      iconColorSelected: kSuccessColor,
                      iconColor: kTextColor,
                    ),
                    bottomActionBarConfig: const BottomActionBarConfig(
                      enabled: false,
                    ),
                    searchViewConfig: const SearchViewConfig(),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

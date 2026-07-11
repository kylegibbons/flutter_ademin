import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/chat/chat_data.dart';
import 'package:flutter_ademin/demo/app/chat/chat_model.dart';
import 'package:flutter_ademin/demo/app/chat/dialogs/create_channel_dialog.dart';
import 'package:flutter_ademin/demo/app/chat/dialogs/new_chat_dialog.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

class ChatListSidebar extends StatelessWidget {
  final Function(ChatSelection) onChatSelected;
  final String? selectedChatId;

  const ChatListSidebar({
    super.key,
    required this.onChatSelected,
    this.selectedChatId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 4),
      child: Card(
        child: Column(
          children: [
            // sidebar header
            _buildSidebarHeader(context),

            // chats list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2,
                ),
                children: [
                  // SECTION: PERSONAL CHATS
                  _buildSectionHeader(context, "Personal Chats", () {}),
                  ...MockData.personalChats.map((chat) {
                    return _buildPersonalChatItem(chat, context);
                  }),

                  const SizedBox(height: kDefaultPadding),

                  // SECTION: CHANNELS
                  _buildSectionHeader(context, "Channels", () {}),
                  ...MockData.groupChats.map((channel) {
                    return _buildChannelItem(channel, context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalChatItem(Chat chat, BuildContext context) {
    // get last message
    final lastMsg = chat.messages.isNotEmpty ? chat.messages.last : null;
    final unreadCount = chat.messages
        .where(
          (m) =>
              m.status == MessageStatus.unread &&
              m.sender.id != MockData.currentUser.id,
        )
        .length;
    final bool isSelected = selectedChatId == chat.user.id;

    return _buildGenericListItem(
      context: context,
      onTap: () => onChatSelected(ChatSelection.personal(chat)),
      isSelected: isSelected,
      avatarOrIcon: CircleAvatar(
        backgroundImage: AssetImage(
          chat.user.avatarUrl,
        ), // change to NetworkImage in production
        radius: 20,
      ),
      isOnline: chat.user.isOnline,
      title: chat.user.name,
      subtitle: lastMsg?.content ?? "No messages",
      time: lastMsg?.time,
      unreadCount: unreadCount,
    );
  }

  Widget _buildChannelItem(Channel channel, BuildContext context) {
    final lastMsg = channel.messages.isNotEmpty ? channel.messages.last : null;
    final unreadCount = channel.messages
        .where(
          (m) =>
              m.status == MessageStatus.unread &&
              m.sender.id != MockData.currentUser.id,
        )
        .length;
    final bool isSelected = selectedChatId == channel.channelName;

    return _buildGenericListItem(
      context: context,
      onTap: () => onChatSelected(ChatSelection.channel(channel)),
      isSelected: isSelected,
      avatarOrIcon: CircleAvatar(
        backgroundColor: kSuccessColor.withValues(alpha: 0.1),
        radius: 20,
        child: Icon(channel.icon, color: kSuccessColor, size: 20),
      ),
      isOnline: false, // Channels usually don't have online status
      title: channel.channelName,
      subtitle: lastMsg != null
          ? "${lastMsg.sender.name}: ${lastMsg.content}"
          : "No messages",
      time: lastMsg?.time,
      unreadCount: unreadCount,
    );
  }

  Widget _buildGenericListItem({
    required BuildContext context,
    required VoidCallback onTap,
    required bool isSelected,
    required Widget avatarOrIcon,
    required bool isOnline,
    required String title,
    required String subtitle,
    DateTime? time,
    required int unreadCount,
  }) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? kSuccessColor.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            // avatar or icon
            Stack(
              children: [
                avatarOrIcon,
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: kSuccessColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // name or channel
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),

                      // time
                      if (time != null)
                        Text(
                          _formatTime(time),
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: kBodySmall,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding / 8),
                  Row(
                    children: [
                      // last message
                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected
                                ? themeData.colorScheme.onSurface
                                : (unreadCount > 0
                                      ? themeData.colorScheme.onSurface
                                      : kTextColor),
                            fontSize: kBodySmall,
                            fontWeight: unreadCount > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),

                      // unread counter
                      if (unreadCount > 0)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 20),
                          margin: const EdgeInsetsDirectional.only(
                            start: kDefaultPadding,
                          ),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: kSuccessColor,
                            shape: BoxShape.circle,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 6.3),
                            child: Center(
                              child: Text(
                                unreadCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarHeader(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: Column(
        children: [
          // tittle
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: kDefaultPadding,
              end: kDefaultPadding / 4,
            ),
            child: Row(
              children: [
                Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: kBodyLarge,
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),

                // new chat button
                PopupMenuButton<int>(
                  tooltip: 'New Chat',
                  color: themeData.colorScheme.surface,
                  offset: const Offset(0, 32),
                  splashRadius: defaultRadius,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  onSelected: (value) {
                    if (value == 0) {
                      // new personal chat
                      _handleNewChat(context);
                    } else if (value == 1) {
                      // create channel
                      _handleCreateChannel(context);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_add_outlined,
                            size: 16,
                            color: themeData.colorScheme.onSurface,
                          ),
                          const SizedBox(width: kDefaultPadding),
                          const Text("New Chat"),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.group_add_outlined,
                            size: 16,
                            color: themeData.colorScheme.onSurface,
                          ),
                          const SizedBox(width: kDefaultPadding),
                          const Text("Create Channel"),
                        ],
                      ),
                    ),
                  ],
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 20,
                    child: Icon(
                      Icons.add_comment_outlined,
                      color: kSuccessColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: kDefaultPadding / 2),

          // search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SoftSearchBar(hintText: 'Search chat..'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleNewChat(BuildContext context) async {
    final selection = await showNewChatDialog(context);
    if (selection != null) {
      onChatSelected(selection);
    }
  }

  Future<void> _handleCreateChannel(BuildContext context) async {
    final selection = await showCreateChannelDialog(context);
    if (selection != null) {
      onChatSelected(selection);
    }
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: kDefaultPadding,
        end: kDefaultPadding / 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: themeData.colorScheme.onSurface,
            ),
          ),

          CustomIconButton(
            icon: Icons.more_vert,
            onTap: onTap,
            // shape: ButtonShape.circle,
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}

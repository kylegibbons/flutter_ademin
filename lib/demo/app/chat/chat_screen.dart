import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/chat/chat_model.dart';
import 'package:flutter_ademin/demo/app/chat/dialogs/create_channel_dialog.dart';
import 'package:flutter_ademin/demo/app/chat/dialogs/new_chat_dialog.dart';
import 'package:flutter_ademin/demo/app/chat/widgets/chat_content.dart';
import 'package:flutter_ademin/demo/app/chat/widgets/chat_sidebar.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Using ChatSelection Wrapper to hold Chat (Personal) or Channel
  ChatSelection? selectedChat;

  Future<void> _openNewChatDialog(BuildContext context) async {
    final chatSelection = await showNewChatDialog(context);
    if (mounted) {
      setState(() {
        if (chatSelection != null) {
          selectedChat = chatSelection;
        }
      });
    }
  }

  Future<void> _openCreateChannelDialog(BuildContext context) async {
    final chatSelection = await showCreateChannelDialog(context);
    if (mounted) {
      setState(() {
        if (chatSelection != null) {
          selectedChat = chatSelection;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return PortalMasterLayout(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > kScreenWidthMd) {
            // DESKTOP VIEW
            return Row(
              children: [
                SizedBox(
                  width: 300,
                  child: ChatListSidebar(
                    onChatSelected: (selection) {
                      setState(() {
                        selectedChat = selection;
                      });
                    },
                    selectedChatId: selectedChat?.id,
                  ),
                ),

                Expanded(
                  child: selectedChat != null
                      ? ChatContentScreen(
                          key: ValueKey(selectedChat!.id),
                          chatSelection: selectedChat!,
                          isMobile: false,
                          onMessagesUpdated: () => setState(() {}),
                        )
                      : _buildEmptyState(context),
                ),
              ],
            );
          } else {
            // MOBILE VIEW
            return ChatListSidebar(
              onChatSelected: (selection) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: Padding(
                        padding: EdgeInsets.only(
                          top: topPadding,
                          bottom: bottomPadding,
                        ),
                        child: ChatContentScreen(
                          chatSelection: selection,
                          isMobile: true,
                          onMessagesUpdated: () => setState(() {}),
                        ),
                      ),
                    ),
                  ),
                ).then((_) => setState(() {}));
              },
              selectedChatId: null,
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final themeData = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: kSuccessColor.withValues(alpha: 0.1),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 32,
                  color: kSuccessColor,
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Text(
                'Welcome to Chats',
                style: TextStyle(
                  fontSize: kHeadlineSmall,
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                'Choose a conversation from the sidebar or start a new one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: themeData.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding,
                alignment: WrapAlignment.center,
                children: [
                  FlatButton(
                    kText: 'New Chat',
                    bgColor: kSuccessColor,
                    kTextColor: Colors.white,
                    kLeadingIcon: Icons.person_add_outlined,
                    onPressed: () => _openNewChatDialog(context),
                  ),
                  CustomOutlinedButton(
                    kText: 'New Channel',
                    outlineColor: kSuccessColor,
                    kLeadingIcon: Icons.group_add_outlined,
                    onPressed: () => _openCreateChannelDialog(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

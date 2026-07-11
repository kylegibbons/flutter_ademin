import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/chat/chat_data.dart';
import 'package:flutter_ademin/demo/app/chat/chat_model.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

Future<ChatSelection?> showNewChatDialog(BuildContext context) async {
  final List<User> allUsers = MockData.allUsers;
  final themeData = Theme.of(context);

  return showDialog<ChatSelection>(
    context: context,
    builder: (context) {
      TextEditingController searchController = TextEditingController();
      List<User> filteredUsers = List.from(allUsers);

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: const EdgeInsetsDirectional.only(
              top: 0,
              bottom: kDefaultPadding,
              start: 0,
              end: 0,
            ),
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: kDefaultPadding / 4,
                    start: kDefaultPadding / 4,
                    top: kDefaultPadding / 4,
                    bottom: kDefaultPadding / 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: mediumHeight),
                      const Spacer(),
                      Text(
                        'Select Contact',
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      CustomIconButton(
                        icon: Icons.close,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        shape: ButtonShape.circle,
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  child: SoftSearchBar(
                    controller: searchController,
                    hintText: 'Search contact..',
                    onChanged: (value) {
                      setState(() {
                        filteredUsers = allUsers
                            .where(
                              (u) => u.name.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 480,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // List of Users
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              user.avatarUrl,
                            ), // replace with NetworkImage in production
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          subtitle: Text(
                            user.isOnline ? "Online" : "Offline",
                            style: TextStyle(
                              color: user.isOnline ? kSuccessColor : kTextColor,
                              fontSize: kBodySmall,
                            ),
                          ),
                          onTap: () {
                            final chatSelection = _startChatWith(user);
                            Navigator.pop(context, chatSelection);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// Helper function to start chat
ChatSelection _startChatWith(User selectedUser) {
  final existingIndex = MockData.personalChats.indexWhere(
    (chat) => chat.user.id == selectedUser.id,
  );

  late final Chat selectedChat;

  if (existingIndex != -1) {
    selectedChat = MockData.personalChats.removeAt(existingIndex);
    MockData.personalChats.insert(0, selectedChat);
  } else {
    selectedChat = Chat(user: selectedUser, messages: []);
    MockData.personalChats.insert(0, selectedChat);
  }

  return ChatSelection.personal(selectedChat);
}

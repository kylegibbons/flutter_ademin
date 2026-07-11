import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/chat/chat_data.dart';
import 'package:flutter_ademin/demo/app/chat/chat_model.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

Future<ChatSelection?> showCreateChannelDialog(BuildContext context) async {
  final TextEditingController nameController = TextEditingController();
  final themeData = Theme.of(context);

  // List of available icons for channels
  final List<IconData> availableIcons = [
    Icons.group,
    Icons.chat_bubble_outline,
    Icons.work_outline,
    Icons.favorite_border,
    Icons.alarm,
    Icons.calendar_today_outlined,
    Icons.camera_alt_outlined,
    Icons.mail_outline,
    Icons.lock_outline,
    Icons.location_on_outlined,
    Icons.phone_outlined,
    Icons.search,
    Icons.send_outlined,
    Icons.settings_outlined,
    Icons.shopping_cart_outlined,
    Icons.star_border,
    Icons.visibility_outlined,
    Icons.wifi,
    Icons.person_pin_circle_outlined,
    Icons.notifications_none,
    Icons.grid_view,
    Icons.book_outlined,
    Icons.build_outlined,
    Icons.delete_outline,
    Icons.download_outlined,
  ];

  int selectedIconIndex = 0; // Default first selected icon

  return showDialog<ChatSelection>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: const EdgeInsetsDirectional.only(
              top: 0,
              bottom: 0,
              start: 0,
              end: 0,
            ),
            actionsPadding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            title: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: kDefaultPadding / 4,
                start: kDefaultPadding / 4,
                top: kDefaultPadding / 4,
                bottom: kDefaultPadding / 4,
              ),
              child: Row(
                children: [
                  const SizedBox(width: mediumHeight),
                  const Spacer(),
                  Text(
                    'Create Channel',
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
            content: Container(
              width: 520,
              padding: const EdgeInsetsDirectional.only(
                top: 0,
                start: kDefaultPadding,
                end: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Channel Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),

                  CustomTextField(
                    controller: nameController,
                    hintText: "Channel Name",
                  ),
                  const SizedBox(height: kDefaultPadding),

                  Text(
                    'Channel Icon:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  // Grid Icons
                  Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: List.generate(availableIcons.length, (index) {
                      bool isSelected = selectedIconIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIconIndex = index),
                        child: Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? kSuccessColor.withValues(alpha: 0.1)
                                : kTextColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? kSuccessColor
                                  : Colors.transparent,
                              width: outlineWidth * 2,
                            ),
                          ),
                          child: Icon(
                            availableIcons[index],
                            size: 20,
                            color: isSelected ? kSuccessColor : kTextColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            actions: [
              FlatButton(
                kText: 'Create',
                bgColor: kSuccessColor,
                kTextColor: Colors.white,
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    final newChannel = Channel(
                      channelName: nameController.text,
                      icon: availableIcons[selectedIconIndex],
                      members: [MockData.currentUser],
                      messages: [],
                    );

                    MockData.groupChats.insert(0, newChannel);

                    Navigator.pop(context, ChatSelection.channel(newChannel));
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}

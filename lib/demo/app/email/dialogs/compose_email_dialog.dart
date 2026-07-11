import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_editor.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ComposeEmailDialog extends StatefulWidget {
  const ComposeEmailDialog({super.key});

  @override
  State<ComposeEmailDialog> createState() => _ComposeEmailDialogState();
}

class _ComposeEmailDialogState extends State<ComposeEmailDialog> {
  final TextEditingController toController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController bccController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final QuillController contentController = QuillController(
    document: Document(),
    selection: const TextSelection.collapsed(offset: 0),
  );

  bool showCc = false;
  bool showBcc = false;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      title: Container(
        height: mediumHeight + (0.5 * kDefaultPadding),
        decoration: BoxDecoration(color: kTableHeaderColor),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: kDefaultPadding,
            end: kDefaultPadding / 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'New Message',
                style: TextStyle(
                  fontSize: kBodyLarge,
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              CustomIconButton(
                icon: Icons.close,
                iconColor: themeData.colorScheme.onSurface,
                shape: ButtonShape.circle,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: mediaQueryData.size.width * 0.8,
          child: Column(
            children: [
              Container(
                height: mediumHeight,
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: themeData.colorScheme.outline,
                    width: outlineWidth,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: toController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'To',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsetsDirectional.only(
                            bottom: (mediumHeight - kBodyMedium) / 2,
                            start: kDefaultPadding,
                            end: kDefaultPadding,
                          ),
                        ),
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontSize: kBodyMedium,
                        ),
                      ),
                    ),
                    if (!showCc)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 2,
                        ),
                        child: InkWell(
                          onTap: () => setState(() => showCc = !showCc),
                          child: Text(
                            'Cc',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                          ),
                        ),
                      ),
                    if (!showBcc)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: kDefaultPadding / 2,
                        ),
                        child: InkWell(
                          onTap: () => setState(() => showBcc = !showBcc),
                          child: Text(
                            'Bcc',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                              fontSize: kBodyMedium,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              _buildAnimatedTextField(
                label: 'Cc',
                controller: ccController,
                visible: showCc,
              ),
              _buildAnimatedTextField(
                label: 'Bcc',
                controller: bccController,
                visible: showBcc,
              ),
              CustomTextField(
                controller: subjectController,
                labelText: 'Subject',
              ),
              const SizedBox(height: kDefaultPadding),
              QuillEditorCustom(controller: contentController, height: 480),
              const SizedBox(height: kDefaultPadding),
              const ComposeActionBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required String label,
    required TextEditingController controller,
    bool visible = true,
  }) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: visible
            ? Padding(
                key: ValueKey(label),
                padding: const EdgeInsetsDirectional.only(
                  bottom: kDefaultPadding,
                ),
                child: CustomTextField(
                  controller: controller,
                  labelText: label,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class ComposeActionBar extends StatelessWidget {
  const ComposeActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width <= kScreenWidthMd;
    return isMobile
        ? Wrap(
            runSpacing: kDefaultPadding / 2,
            spacing: kDefaultPadding / 2,
            children: [
              sendButton(themeData),
              attachButton(themeData),
              insertUrlButton(themeData),
              insertEmojiButton(themeData),
              addToDriveButton(themeData),
              addImageButton(themeData),
              confidentialModeButton(themeData),
              addSignatureButton(themeData),
              moreOptionsButton(themeData),
              discardDraftButton(themeData),
            ],
          )
        : Row(
            children: [
              sendButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              attachButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              insertUrlButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              insertEmojiButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              addToDriveButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              addImageButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              confidentialModeButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              addSignatureButton(themeData),
              const SizedBox(width: kDefaultPadding / 2),
              moreOptionsButton(themeData),
              const Spacer(),
              discardDraftButton(themeData),
            ],
          );
  }

  CustomIconButton discardDraftButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.delete_forever_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Discard draft',
  );

  CustomIconButton moreOptionsButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.more_vert,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'More options',
  );

  CustomIconButton addSignatureButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.edit_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Add signature',
  );

  CustomIconButton confidentialModeButton(ThemeData themeData) =>
      CustomIconButton(
        icon: Icons.lock_outline,
        iconColor: themeData.colorScheme.onSurface,
        onTap: () {},
        tooltipMessage: 'Confidential mode',
      );

  CustomIconButton addImageButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.image_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Add image',
  );

  CustomIconButton addToDriveButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.add_to_drive_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Add to Drive',
  );

  CustomIconButton insertEmojiButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.emoji_emotions_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Insert emoji',
  );

  CustomIconButton insertUrlButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.link_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Insert Url',
  );

  CustomIconButton attachButton(ThemeData themeData) => CustomIconButton(
    icon: Icons.attach_file_outlined,
    iconColor: themeData.colorScheme.onSurface,
    onTap: () {},
    tooltipMessage: 'Attach File',
  );

  SplitButton sendButton(ThemeData themeData) => SplitButton(
    label: 'Send',
    backgroundColor: kSuccessColor,
    onPrimaryPressed: () {},
    menuItems: [
      PopupMenuItem(
        value: 'schedule_send',
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: kDefaultPadding / 2,
        ),
        height: mediumHeight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.schedule_outlined,
              color: themeData.colorScheme.onSurface,
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              'Schedule Send',
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    ],
    onMenuItemSelected: (value) {},
  );
}

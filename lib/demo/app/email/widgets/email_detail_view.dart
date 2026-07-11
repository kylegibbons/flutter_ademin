import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/email/dialogs/compose_email_dialog.dart';
import 'package:flutter_ademin/demo/app/email/email_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EmailDetailView extends StatelessWidget {
  const EmailDetailView({
    super.key,
    required this.selectedEmail,
    required this.isReplyEditorVisible,
    required this.isForwardEditorVisible,
    required this.quillController,
    required this.toController,
    required this.scrollController,
    required this.onBack,
    required this.onBulkAction,
    required this.onMarkSelectedAsRead,
    required this.onToggleStar,
    required this.onToggleReplyEditor,
    required this.onToggleForwardEditor,
    required this.formatFullDateWithRelative,
  });

  final Email selectedEmail;
  final bool isReplyEditorVisible;
  final bool isForwardEditorVisible;
  final QuillController quillController;
  final TextEditingController toController;
  final ScrollController scrollController;
  final VoidCallback onBack;
  final ValueChanged<EmailFolder> onBulkAction;
  final VoidCallback onMarkSelectedAsRead;
  final ValueChanged<Email> onToggleStar;
  final VoidCallback onToggleReplyEditor;
  final VoidCallback onToggleForwardEditor;
  final String Function(DateTime timestamp) formatFullDateWithRelative;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthLg;
    final isStarred = selectedEmail.folder == EmailFolder.starred;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: kDefaultPadding / 4,
        bottom: kDefaultPadding / 4,
        end: kDefaultPadding / 4,
        start: isMobile ? kDefaultPadding / 4 : 0,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
                vertical: kDefaultPadding / 2,
              ),
              child: Row(
                children: [
                  CustomIconButton(
                    tooltipMessage: 'Back',
                    shape: ButtonShape.circle,
                    icon: Icons.arrow_back,
                    onTap: onBack,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  CustomIconButton(
                    tooltipMessage: 'Archive',
                    icon: Icons.archive_outlined,
                    onTap: () => onBulkAction(EmailFolder.inbox),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  CustomIconButton(
                    tooltipMessage: 'Trash',
                    icon: Icons.delete_outline,
                    onTap: () => onBulkAction(EmailFolder.trash),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  CustomIconButton(
                    tooltipMessage: 'Report Spam',
                    icon: Icons.report_outlined,
                    onTap: () => onBulkAction(EmailFolder.spam),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  CustomIconButton(
                    tooltipMessage: 'Mark as Read',
                    icon: Icons.mark_email_read_outlined,
                    onTap: onMarkSelectedAsRead,
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  const Spacer(),
                  CustomIconButton(
                    tooltipMessage: 'More',
                    icon: Icons.more_vert,
                    shape: ButtonShape.circle,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              selectedEmail.subject,
                              style: TextStyle(
                                fontSize: kHeadlineSmall,
                                fontWeight: FontWeight.w500,
                                color: themeData.colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: kDefaultPadding),
                              CustomBadge(
                                kColor: themeData.colorScheme.onSurface,
                                kText: selectedEmail.folder!.label,
                                isSoft: true,
                                isDismissible: true,
                              ),
                              CustomIconButton(
                                icon: isStarred
                                    ? Icons.star
                                    : Icons.star_border,
                                iconColor: isStarred
                                    ? Colors.amber
                                    : Colors.grey,
                                shape: ButtonShape.circle,
                                onTap: () => onToggleStar(selectedEmail),
                              ),
                              CustomIconButton(
                                icon: Icons.print_outlined,
                                onTap: () {},
                              ),
                              CustomIconButton(
                                icon: Icons.open_in_new_outlined,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    selectedEmail.senderName,
                                    style: TextStyle(
                                      fontSize: kBodyMedium,
                                      fontWeight: FontWeight.w600,
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    '<${selectedEmail.sender}>',
                                    style: TextStyle(
                                      fontSize: kBodyMedium,
                                      fontWeight: FontWeight.w500,
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'to: ${selectedEmail.recipient?.join(', ') ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: kBodyMedium,
                                  fontWeight: FontWeight.w500,
                                  color: themeData.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: kDefaultPadding,
                              ),
                              child: Text(
                                formatFullDateWithRelative(
                                  selectedEmail.timestamp,
                                ),
                                style: const TextStyle(fontSize: kBodyMedium),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding,
                        ),
                        child: Text(
                          selectedEmail.body,
                          style: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomOutlinedButton(
                                kText: 'Reply',
                                kLeadingIcon: Icons.reply_outlined,
                                outlineColor: themeData.colorScheme.onSurface,
                                isRounded: true,
                                onPressed: onToggleReplyEditor,
                              ),
                              const SizedBox(width: 8),
                              CustomOutlinedButton(
                                kText: 'Forward',
                                kLeadingIcon: Icons.forward_outlined,
                                outlineColor: themeData.colorScheme.onSurface,
                                isRounded: true,
                                onPressed: onToggleForwardEditor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: isReplyEditorVisible
                                ? _ReplyQuillEditor(
                                    mode: _ReplyEditorMode.reply,
                                    quillController: quillController,
                                    toController: toController,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: isForwardEditorVisible
                                ? _ReplyQuillEditor(
                                    mode: _ReplyEditorMode.forward,
                                    quillController: quillController,
                                    toController: toController,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ReplyEditorMode { reply, forward }

class _ReplyQuillEditor extends StatelessWidget {
  const _ReplyQuillEditor({
    required this.mode,
    required this.quillController,
    required this.toController,
  });

  final _ReplyEditorMode mode;
  final QuillController quillController;
  final TextEditingController toController;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeData.colorScheme.outline, width: 0.5),
        borderRadius: BorderRadius.circular(4),
        color: themeData.colorScheme.surfaceContainerHighest,
      ),
      clipBehavior: Clip.hardEdge,
      height: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: TextField(
              controller: toController,
              autofocus: mode == _ReplyEditorMode.forward,
              decoration: const InputDecoration(
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
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ),
          Divider(
            height: 0,
            color: themeData.colorScheme.outline,
            thickness: 0.5,
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: quillController,

              config: QuillEditorConfig(
                padding: const EdgeInsets.all(kDefaultPadding),
                autoFocus: mode == _ReplyEditorMode.reply,
                customStyles: DefaultStyles(
                  paragraph: DefaultTextBlockStyle(
                    TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontSize: kBodyMedium,
                    ),
                    const HorizontalSpacing(8, 8),
                    const VerticalSpacing(8, 8),
                    const VerticalSpacing(8, 8),
                    const BoxDecoration(),
                  ),
                  h1: DefaultTextBlockStyle(
                    TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontSize: kHeadlineLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    const HorizontalSpacing(8, 8),
                    const VerticalSpacing(12, 12),
                    const VerticalSpacing(12, 12),
                    const BoxDecoration(),
                  ),
                  h2: DefaultTextBlockStyle(
                    TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontSize: kHeadlineMedium,
                      fontWeight: FontWeight.bold,
                    ),
                    const HorizontalSpacing(8, 8),
                    const VerticalSpacing(10, 10),
                    const VerticalSpacing(10, 10),
                    const BoxDecoration(),
                  ),
                  h3: DefaultTextBlockStyle(
                    TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontSize: kHeadlineSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    const HorizontalSpacing(8, 8),
                    const VerticalSpacing(10, 10),
                    const VerticalSpacing(10, 10),
                    const BoxDecoration(),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 0,
            color: themeData.colorScheme.outline,
            thickness: 0.5,
          ),
          IconTheme(
            data: IconThemeData(color: kTextColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: QuillSimpleToolbar(
                controller: quillController,
                config: const QuillSimpleToolbarConfig(
                  toolbarIconAlignment: WrapAlignment.start,
                  toolbarIconCrossAlignment: WrapCrossAlignment.start,
                  showCodeBlock: false,
                  showInlineCode: false,
                  showQuote: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showClearFormat: false,
                  showListNumbers: false,
                  showListCheck: false,
                  showFontFamily: false,
                ),
              ),
            ),
          ),
          Divider(
            height: 0,
            color: themeData.colorScheme.outline,
            thickness: 0.5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            child: ComposeActionBar(),
          ),
        ],
      ),
    );
  }
}

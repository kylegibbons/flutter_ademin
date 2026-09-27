import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/email/email_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:intl/intl.dart';

class EmailListView extends StatelessWidget {
  const EmailListView({
    super.key,
    required this.visibleEmails,
    required this.selectedEmailIds,
    required this.allSelected,
    required this.someSelected,
    required this.emailsLength,
    required this.currentPage,
    required this.pageSize,
    required this.onTapEmail,
    required this.onToggleSelectAll,
    required this.onToggleSelectOne,
    required this.onToggleStar,
    required this.onBulkAction,
    required this.onMarkSelectedAsRead,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.mobileSidebarBuilder,
  });

  final List<Email> visibleEmails;
  final Set<String> selectedEmailIds;
  final bool allSelected;
  final bool someSelected;
  final int emailsLength;
  final int currentPage;
  final int pageSize;
  final ValueChanged<Email> onTapEmail;
  final VoidCallback onToggleSelectAll;
  final ValueChanged<String> onToggleSelectOne;
  final ValueChanged<Email> onToggleStar;
  final ValueChanged<EmailFolder> onBulkAction;
  final VoidCallback onMarkSelectedAsRead;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;
  final WidgetBuilder mobileSidebarBuilder;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthLg;
    final mediaQueryData = MediaQuery.of(context);

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
            Container(
              padding: EdgeInsetsDirectional.only(
                start: isMobile ? kDefaultPadding / 2 : kDefaultPadding,
                end: kDefaultPadding,
                top: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: kDefaultPadding / 2,
                      ),
                      child: CustomIconButton(
                        icon: Icons.list,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: mobileSidebarBuilder,
                            ),
                          );
                        },
                      ),
                    ),
                  const Expanded(
                    child: SoftSearchBar(hintText: 'Search emails..'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: kDefaultPadding / 2,
                  ),
                  child: Checkbox(
                    value: allSelected ? true : (someSelected ? null : false),
                    tristate: true,
                    onChanged: (_) => onToggleSelectAll(),
                  ),
                ),
                if (selectedEmailIds.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: kDefaultPadding,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconButton(
                          tooltipMessage: 'Archive',
                          icon: Icons.archive_outlined,
                          onTap: () => onBulkAction(EmailFolder.inbox),
                        ),
                        CustomIconButton(
                          tooltipMessage: 'Trash',
                          icon: Icons.delete_outline,
                          onTap: () => onBulkAction(EmailFolder.trash),
                        ),
                        CustomIconButton(
                          tooltipMessage: 'Report Spam',
                          icon: Icons.report_outlined,
                          onTap: () => onBulkAction(EmailFolder.spam),
                        ),
                        CustomIconButton(
                          tooltipMessage: 'Mark as Read',
                          icon: Icons.mark_email_read_outlined,
                          onTap: onMarkSelectedAsRead,
                        ),
                      ],
                    ),
                  ),
                CustomIconButton(
                  tooltipMessage: 'Refresh',
                  icon: Icons.refresh_outlined,
                  onTap: () {},
                  shape: ButtonShape.circle,
                ),
                CustomIconButton(
                  tooltipMessage: 'More',
                  icon: Icons.more_vert,
                  onTap: () {},
                ),
                const Spacer(),
                _PaginationControls(
                  emailsLength: emailsLength,
                  currentPage: currentPage,
                  pageSize: pageSize,
                  onPreviousPage: onPreviousPage,
                  onNextPage: onNextPage,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: visibleEmails.length,
                itemBuilder: (context, index) {
                  final email = visibleEmails[index];
                  final isSelected = selectedEmailIds.contains(email.id);
                  final isStarred = email.folder == EmailFolder.starred;

                  return InkWell(
                    onTap: () => onTapEmail(email),
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                        start: kDefaultPadding / 2,
                        end: kDefaultPadding,
                        top: kDefaultPadding / 2,
                        bottom: kDefaultPadding / 2,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => onToggleSelectOne(email.id),
                          ),
                          CustomIconButton(
                            icon: isStarred ? Icons.star : Icons.star_border,
                            iconColor: isStarred ? Colors.amber : Colors.grey,
                            shape: ButtonShape.circle,
                            onTap: () => onToggleStar(email),
                          ),
                          const SizedBox(width: kDefaultFontSize / 2),
                          Expanded(
                            flex: 2,
                            child: Text(
                              email.senderName,
                              style: TextStyle(
                                fontSize: kBodyMedium,
                                fontWeight: email.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w800,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (mediaQueryData.size.width > kScreenWidthSm)
                            Expanded(
                              flex: 8,
                              child: Row(
                                children: [
                                  Text(
                                    '${email.subject} ',
                                    style: TextStyle(
                                      fontSize: kBodyMedium,
                                      fontWeight: email.isRead
                                          ? FontWeight.w500
                                          : FontWeight.w800,
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      email.body,
                                      style: TextStyle(
                                        fontSize: kBodyMedium,
                                        fontWeight: FontWeight.w500,
                                        color: kTextColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Text(
                            DateFormat('hh:mm a').format(email.timestamp),
                            style: TextStyle(
                              fontSize: kBodySmall,
                              fontWeight: email.isRead
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaginationControls extends StatelessWidget {
  const _PaginationControls({
    required this.emailsLength,
    required this.currentPage,
    required this.pageSize,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  final int emailsLength;
  final int currentPage;
  final int pageSize;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;

  @override
  Widget build(BuildContext context) {
    var end = (currentPage + 1) * pageSize;
    if (end > emailsLength) {
      end = emailsLength;
    }
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$end of $emailsLength',
            style: const TextStyle(fontSize: kBodySmall),
          ),
          CustomIconButton(
            icon: Icons.chevron_left,
            shape: ButtonShape.circle,
            tooltipMessage: 'Previous',
            iconColor: themeData.colorScheme.onSurface,
            onTap: onPreviousPage,
          ),
          CustomIconButton(
            icon: Icons.chevron_right,
            shape: ButtonShape.circle,
            tooltipMessage: 'Next',
            iconColor: themeData.colorScheme.onSurface,
            onTap: onNextPage,
          ),
        ],
      ),
    );
  }
}

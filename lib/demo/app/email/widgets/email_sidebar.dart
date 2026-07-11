import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/email/dialogs/compose_email_dialog.dart';
import 'package:flutter_ademin/demo/app/email/email_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class EmailSidebar extends StatelessWidget {
  const EmailSidebar({
    super.key,
    required this.emailService,
    required this.folderSelected,
    required this.categorySelected,
    required this.onFolderSelected,
    required this.onCategorySelected,
  });

  final EmailService emailService;
  final EmailFolder? folderSelected;
  final EmailCategory? categorySelected;
  final ValueChanged<EmailFolder> onFolderSelected;
  final ValueChanged<EmailCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final isDesktop = MediaQuery.of(context).size.width >= kScreenWidthLg;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: isDesktop ? kDefaultPadding / 4 : topPadding,
        start: isDesktop ? kDefaultPadding / 4 : 0,
        end: isDesktop ? kDefaultPadding / 4 : 0,
        bottom: isDesktop ? kDefaultPadding / 4 : 0,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 240,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: FlatButton(
                  kText: 'Compose',
                  kTextColor: Colors.white,
                  bgColor: kErrorColor,
                  kLeadingIcon: Icons.add_circle_outline,
                  isFullWidth: true,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ComposeEmailDialog(),
                    );
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kDefaultPadding / 2),
                      ListView(
                        shrinkWrap: true,
                        children: EmailFolder.values.map((folder) {
                          final unreadCount =
                              emailService.countUnreadByFolder(folder);
                          final isSelected = folder == folderSelected;
                          return ListTile(
                            selected: isSelected,
                            selectedTileColor:
                                kSuccessColor.withValues(alpha: 0.1),
                            leading: Icon(
                              folder.icon,
                              color: isSelected ? kSuccessColor : kTextColor,
                            ),
                            title: Text(
                              folder.label,
                              style: TextStyle(
                                fontSize: kBodyMedium,
                                color: isSelected
                                    ? kSuccessColor
                                    : themeData.colorScheme.onSurface,
                                fontWeight: unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            selectedColor: kSuccessColor,
                            trailing: unreadCount == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kSuccessColor.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '$unreadCount',
                                      style: TextStyle(
                                        color: kSuccessColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              onFolderSelected(folder);
                              Navigator.of(context).maybePop();
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding / 2),
                      ListView(
                        shrinkWrap: true,
                        children: EmailCategory.values.map((category) {
                          final unreadCount =
                              emailService.countUnreadByCategory(category);
                          final isSelected = category == categorySelected;

                          return ListTile(
                            selected: isSelected,
                            selectedTileColor:
                                kSuccessColor.withValues(alpha: 0.1),
                            leading: Icon(
                              category.icon,
                              color: isSelected ? kSuccessColor : kTextColor,
                            ),
                            title: Text(
                              category.label,
                              style: TextStyle(
                                fontSize: kBodyMedium,
                                color: isSelected
                                    ? kSuccessColor
                                    : themeData.colorScheme.onSurface,
                                fontWeight: unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            selectedColor: kSuccessColor,
                            trailing: unreadCount == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kSuccessColor.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '$unreadCount',
                                      style: TextStyle(
                                        color: kSuccessColor,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                            onTap: () {
                              onCategorySelected(category);
                              Navigator.of(context).maybePop();
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: kTextColor.withValues(alpha: 0.3),
                      width: 0.6,
                    ),
                  ),
                ),
                child: FlatButton(
                  kText: 'Try Business Plan',
                  kTextColor: themeData.colorScheme.onSurface,
                  bgColor: kTableHeaderColor,
                  kLeadingIcon: Icons.workspace_premium_outlined,
                  kTrailingIcon: Icons.arrow_forward,
                  isRounded: true,
                  isAnimated: true,
                  isFullWidth: true,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/file_manager/file_manager_data.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/popup_menu.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

class FolderSection extends StatelessWidget {
  const FolderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Column(
        children: [
          // Header Section
          CardHeader(
            kText: 'All Folders',
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: SoftButton(
                kText: 'View All',
                bgColor: kSecondaryColor,
                size: ButtonSize.small,
                kTrailingIcon: Icons.chevron_right,
                onPressed: () {},
              ),
            ),
            showDivider: true,
          ),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ResponsiveWrap(
              breakpoints: {
                kScreenWidthSm: 1, // set breakpoint for 1 column layout,
                kScreenWidthMd: 2, // set breakpoint for 2 column layout
              },
              columnRatios: [1 / 2, 1 / 2],
              spacing: kDefaultPadding, // spacing
              runSpacing: kDefaultPadding, // run spacing
              children: MockData.folders.map((folder) {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        // color: kSecondaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(defaultRadius),
                        border: Border.all(
                          color: themeData.colorScheme.outline,
                          width: outlineWidth,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.folder,
                            color: Color(0xFFFFB74D),
                            size: 40,
                          ),

                          const SizedBox(height: kDefaultPadding),

                          Text(
                            folder.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${folder.fileCount} Files"),
                              Text(
                                "${folder.sizeGB} GB",
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // menu button
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: CustomPopupMenu<String>(
                        onSelected: (value) => debugPrint('Selected: $value'),
                        items: [
                          // open menu
                          PopupMenuItemData(
                            value: 'open',
                            text: 'Open folder',
                            icon: Icons.person_outline,
                            // showDividerAfter: true,
                          ),

                          // upload menu
                          PopupMenuItemData(
                            value: 'upload',
                            text: 'Upload file',
                            icon: Icons.edit,
                          ),

                          // share menu
                          PopupMenuItemData(
                            value: 'share',
                            text: 'Share folder',
                            icon: Icons.share,
                          ),

                          // delete menu
                          PopupMenuItemData(
                            value: 'delete',
                            text: 'Delete Folder',
                            icon: Icons.delete_outline,
                            iconColor: kErrorColor,
                            textStyle: TextStyle(color: kErrorColor),
                          ),
                        ],

                        // icon button
                        child: CustomIconButton(
                          icon: Icons.more_vert,
                          tooltipMessage: 'Options',
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

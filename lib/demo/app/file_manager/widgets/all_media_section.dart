import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/file_manager/dialogs/upload_files_dialog.dart';
import 'package:flutter_ademin/demo/app/file_manager/file_manager_data.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

class AllMedia extends StatelessWidget {
  const AllMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;
    final themeData = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding,
          horizontal: kDefaultPadding,
        ),
        child: Column(
          children: [
            // header
            Row(
              children: [
                Text(
                  'All Media'.toUpperCase(),
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Spacer(),
                // search bar
                isMobile
                    ? CustomIconButton(
                        icon: Icons.search,
                        tooltipMessage: 'Search',
                        onTap: () {},
                      )
                    : SizedBox(
                        width: 240,
                        child: SoftSearchBar(hintText: 'Search...'),
                      ),

                SizedBox(width: kDefaultPadding),
                // upload button
                isMobile
                    ? CustomIconButton(
                        icon: Icons.add,
                        iconColor: Colors.white,
                        buttonColor: kSecondaryColor,
                        tooltipMessage: 'Upload Files',
                        onTap: () {
                          uploadFilesDialog(context, themeData);
                        },
                      )
                    : FlatButton(
                        kText: 'Upload Files',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          uploadFilesDialog(context, themeData);
                        },
                        kLeadingIcon: Icons.add_outlined,
                      ),
              ],
            ),

            SizedBox(height: kDefaultPadding),

            // media grid
            AdaptiveWrap(
              breakpoints: {
                kScreenWidthSm: 1, // set breakpoint for 1 column layout,
                kScreenWidthMd: 2, // set breakpoint for 2 column layout
                kScreenWidthLg: 3, // set breakpoint for 3 column layout
              },
              columnRatios: const [1 / 3, 1 / 3, 1 / 3],
              spacing: kDefaultPadding, // spacing
              runSpacing: kDefaultPadding, // run spacing
              children: MockData.categories.map((cat) {
                return InkWell(
                  onTap: () {}, // openning files list
                  child: Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      border: Border.all(
                        color: themeData.colorScheme.outline,
                        width: outlineWidth,
                      ),
                    ),
                    child: Row(
                      children: [
                        // medias icons
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                            color: cat.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Icon(cat.icon, color: cat.color),
                        ),
                        const SizedBox(width: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // media title
                            Text(
                              cat.title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),

                            // percentage usages
                            Text("${cat.usagePercentage}% Used"),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // files count
                            Text("${cat.fileCount} files"),
                            // storage usage
                            Text(
                              "${cat.sizeGB} GB",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // upload files dialog
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/documentation/documentation_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class DocumentationCategoryGroup extends StatelessWidget {
  final DocCategory category;
  final bool isDesktop;
  final DocItem? selectedDoc;
  final ValueChanged<DocItem> onSelectDoc;
  final VoidCallback onCloseMenu;

  const DocumentationCategoryGroup({
    super.key,
    required this.category,
    required this.isDesktop,
    required this.selectedDoc,
    required this.onSelectDoc,
    required this.onCloseMenu,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            kDefaultPadding,
            kDefaultPadding,
            kDefaultPadding,
            kDefaultPadding / 2,
          ),
          child: Text(
            category.title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: themeData.colorScheme.onSurface,
            ),
          ),
        ),
        ...category.items.map((item) {
          final isSelected = selectedDoc?.id == item.id;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 2,
            ),
            child: ListTile(
              dense: true,
              selected: isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              selectedTileColor: kSecondaryColor.withValues(alpha: 0.1),
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              onTap: () {
                onSelectDoc(item);
                if (!isDesktop) {
                  onCloseMenu();
                }
              },
            ),
          );
        }),
      ],
    );
  }
}

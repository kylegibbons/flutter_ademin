import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/documentation/documentation_models.dart';
import 'package:flutter_ademin/demo/app/documentation/widget/documentation_category_group.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class DocumentationSidebar extends StatelessWidget {
  final List<DocCategory> categories;
  final bool isDesktop;
  final DocItem? selectedDoc;
  final ValueChanged<DocItem> onSelectDoc;
  final VoidCallback onCloseMenu;

  const DocumentationSidebar({
    super.key,
    required this.categories,
    required this.isDesktop,
    required this.selectedDoc,
    required this.onSelectDoc,
    required this.onCloseMenu,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        if (!isDesktop)
          ListTile(
            title: Text(
              'Menu',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            trailing: CustomIconButton(
              icon: Icons.close,
              onTap: onCloseMenu,
              shape: ButtonShape.circle,
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            children: categories
                .map(
                  (category) => DocumentationCategoryGroup(
                    category: category,
                    isDesktop: isDesktop,
                    selectedDoc: selectedDoc,
                    onSelectDoc: onSelectDoc,
                    onCloseMenu: onCloseMenu,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

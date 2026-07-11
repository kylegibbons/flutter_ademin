import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

// Category selector

class GalleryCategorySelector extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const GalleryCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final allCategories = [
      'All',
      ...categories.toSet(),
    ]; // Ensure no duplicates

    return Wrap(
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding / 2,
      alignment: WrapAlignment.center,
      children: allCategories.map((category) {
        final isSelected = category == selectedCategory;
        return CustomChoiceChip(
          label: category,
          selected: isSelected,
          onSelected: (_) => onCategorySelected(category),
        );
      }).toList(),
    );
  }
}

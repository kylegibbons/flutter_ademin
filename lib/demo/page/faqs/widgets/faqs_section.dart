import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/faqs/faqs_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/accordion.dart';

class FaqSection extends StatelessWidget {
  final FaqCategory category;
  final bool allowMultipleOpen;

  const FaqSection({
    super.key,
    required this.category,
    this.allowMultipleOpen = false,
  });

  // data helper

  List<AccordionItemData> mapFaqToAccordionItems(List<FaqItem> items) {
    return items.map((faq) {
      return AccordionItemData(title: faq.question, content: Text(faq.answer));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header (icon + title)
        Row(
          children: [
            Icon(category.icon, color: kSuccessColor, size: 24),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              category.title,
              style: TextStyle(
                fontSize: kBodyLarge,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),

        SizedBox(height: kDefaultPadding),

        // Accordion
        Accordion(
          items: mapFaqToAccordionItems(category.items),
          singleCollapse: true,
          suffixIcon: Icons.expand_more,
        ),
      ],
    );
  }
}

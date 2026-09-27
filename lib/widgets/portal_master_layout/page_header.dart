import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.breadcrumbItems,
    this.trailing,
  });

  final String title;
  final List<BreadcrumbItem> breadcrumbItems;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding * 0.8,
      ),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        border: Border(
          top: BorderSide(color: themeData.colorScheme.outline),
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        spacing: kDefaultPadding,
        runSpacing: kDefaultPadding * 0.5,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: kBodyMedium,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Breadcrumbs(items: breadcrumbItems),
              ?trailing,
            ],
          ),
        ],
      ),
    );
  }
}

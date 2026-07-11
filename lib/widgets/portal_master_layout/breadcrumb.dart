import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:go_router/go_router.dart';

class Breadcrumbs extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const Breadcrumbs({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      children: items.map((item) {
        final isLast = items.indexOf(item) == items.length - 1;
        return Row(
          children: [
            MouseRegion(
              cursor: isLast
                  ? SystemMouseCursors.basic
                  : SystemMouseCursors.click,
              child: GestureDetector(
                onTap: isLast ? null : () => context.go(item.uri),
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: isLast
                        ? kTextColor
                        : themeData.colorScheme.onSurface,
                    fontSize: kBodyMedium,
                    // fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.5,
                ),
                child: Icon(Icons.chevron_right, color: kTextColor, size: 16),
              ),
          ],
        );
      }).toList(),
    );
  }
}

class BreadcrumbItem {
  final String label;
  final String uri;

  BreadcrumbItem({required this.label, required this.uri});
}

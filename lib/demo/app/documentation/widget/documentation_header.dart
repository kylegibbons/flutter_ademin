import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class DocumentationHeader extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onMenuTap;

  const DocumentationHeader({
    super.key,
    required this.isDesktop,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? kDefaultPadding : kDefaultPadding / 4,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: themeData.colorScheme.outline,
            width: outlineWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isDesktop)
            CustomIconButton(icon: Icons.menu, onTap: onMenuTap),
          Text(
            'Docs',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: kBodyLarge,
              color: themeData.colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: SizedBox(
              height: mediumHeight,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                  filled: true,
                  fillColor: themeData.colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

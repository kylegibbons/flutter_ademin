import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

//Card title widget

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.kText,
    this.kWidget,
    this.isInsideCard = true,
    this.backgroundColor,
    this.textStyle,
    this.showDivider = true,
  });

  final String kText;
  final Widget? kWidget;
  final bool isInsideCard;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: cardHeaderHeight,
      decoration: BoxDecoration(color: backgroundColor ?? Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Padding(
            padding: !isInsideCard
                ? EdgeInsetsGeometry.zero
                : kWidget != null
                ? EdgeInsetsDirectional.only(
                    start: kDefaultPadding,
                    end: 0,
                    top: 0,
                    bottom: 0,
                  )
                : EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    kText.toUpperCase(),
                    style:
                        textStyle ??
                        TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: kBodyMedium,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (kWidget != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: kDefaultPadding / 2,
                      bottom: kDefaultPadding / 2,
                      start: kDefaultPadding,
                    ),
                    child: kWidget!,
                  ),
              ],
            ),
          ),
          Spacer(),
          if (showDivider == true) Divider(height: 0, thickness: outlineWidth),
        ],
      ),
    );
  }
}

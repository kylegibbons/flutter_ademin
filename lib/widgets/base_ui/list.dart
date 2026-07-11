import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/badge.dart';

//Custom List

class CustomList extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final IconData? globalIcon;
  final bool isNumber;
  final bool isActiveList;
  final bool hasBadge;

  const CustomList({
    super.key,
    required this.data,
    this.globalIcon,
    this.isNumber = false,
    this.isActiveList = false,
    this.hasBadge = false,
  });

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  int? _hoveredIndex;
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeData.colorScheme.outline,
          width: outlineWidth,
        ),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: ListView.builder(
        itemCount: widget.data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final isDisabled = widget.data[index]['disabled'] == true;

          Widget rowContent = Row(
            mainAxisAlignment: widget.hasBadge
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            crossAxisAlignment: widget.isNumber
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (widget.isNumber)
                Padding(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: Text(
                    '${index + 1}.',
                    style: TextStyle(
                      color: isDisabled
                          ? themeData.disabledColor
                          : (_selectedIndex == index
                                ? Colors.white
                                : themeData.colorScheme.onSurface),
                    ),
                  ),
                )
              else if (widget.globalIcon != null ||
                  widget.data[index]['kIcon'] != null)
                Padding(
                  padding: EdgeInsets.only(right: kDefaultPadding),
                  child: Icon(
                    widget.globalIcon ?? widget.data[index]['kIcon'],
                    color: isDisabled
                        ? themeData.disabledColor
                        : (_selectedIndex == index
                              ? Colors.white
                              : themeData.colorScheme.onSurface),
                    size: 16,
                  ),
                )
              else
                SizedBox.shrink(),
              Expanded(
                child: Text(
                  widget.data[index]['kText'],
                  style: TextStyle(
                    color: isDisabled
                        ? Colors
                              .grey // If disabled, set color to grey
                        : (_selectedIndex == index
                              ? Colors
                                    .white // If selected, set color to white
                              : themeData
                                    .colorScheme
                                    .onSurface), // Otherwise, use default text color
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              if (widget.hasBadge)
                Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding),
                  child: CustomBadge(
                    kText: widget.data[index]['badgeText'],
                    kColor: widget.data[index]['badgeColor'],
                  ),
                ),
            ],
          );

          if (widget.isActiveList) {
            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: InkWell(
                onTap: isDisabled
                    ? null
                    : () => setState(() => _selectedIndex = index),
                splashColor: isDisabled ? Colors.transparent : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.8 * kDefaultPadding,
                    horizontal: kDefaultPadding,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? kPrimaryColor
                        : (_hoveredIndex == index && !isDisabled
                              ? Colors.blueGrey.withValues(alpha: 0.05)
                              : Colors.transparent),
                    border: Border(
                      bottom: (index != widget.data.length - 1)
                          ? BorderSide(
                              color: themeData.colorScheme.outline,
                              width: outlineWidth,
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: rowContent,
                ),
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 0.8 * kDefaultPadding,
                horizontal: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: (index != widget.data.length - 1)
                      ? BorderSide(
                          color: themeData.colorScheme.outline,
                          width: outlineWidth,
                        )
                      : BorderSide.none,
                ),
              ),
              child: rowContent,
            );
          }
        },
      ),
    );
  }
}

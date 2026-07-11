import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/widgets/helper/html_render.dart';

// alerts widget

class Alert extends StatefulWidget {
  final String htmlContent;
  final Color kColor;
  final bool isOutlined;
  final bool isDismissible;
  final bool isSolid;
  final IconData? kIcon;

  const Alert({
    super.key,
    required this.htmlContent,
    required this.kColor,
    this.isOutlined = true,
    this.isDismissible = false,
    this.isSolid = false,
    this.kIcon,
  });

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    Widget alertContent = Container(
      decoration: BoxDecoration(
        color: widget.isSolid
            ? widget.kColor
            : widget.isOutlined
            ? Colors.transparent
            : widget.kColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: widget.isOutlined || widget.isSolid
              ? widget.kColor
              : widget.kColor.withValues(alpha: 0.1),
          width: 0.4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon
          if (widget.kIcon != null)
            SizedBox(
              width: 44.6,
              height: 44.6,
              child: Icon(
                widget.kIcon,
                color: widget.isSolid ? Colors.white : widget.kColor,
                size: 18,
              ),
            ),

          // content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 0.8 * kDefaultPadding,
                left: widget.kIcon != null ? 0 : 0.8 * kDefaultPadding,
                bottom: 0.8 * kDefaultPadding,
                right: widget.isDismissible ? 0 : 0.8 * kDefaultPadding,
              ),
              child: HtmlRender(
                data: widget.htmlContent,
                bodyTextColor: widget.isSolid ? Colors.white : widget.kColor,
                shrinkWrap: false,
              ),
            ),
          ),

          // close button
          widget.isDismissible
              ? InkWell(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  child: SizedBox(
                    height: 44.6,
                    width: 44.6,
                    child: Icon(
                      Icons.close,
                      color: widget.isSolid ? Colors.white : widget.kColor,
                      size: 18,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );

    if (widget.isDismissible) {
      return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          setState(() {
            _isVisible = false;
          });
        },
        child: alertContent,
      );
    } else {
      return alertContent;
    }
  }
}

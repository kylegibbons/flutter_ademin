import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

// custom badge widget

class CustomBadge extends StatefulWidget {
  final Color kColor;
  final String kText;
  final double? kFontSize;
  final bool isRounded;
  final bool isSoft;
  final bool isOutlined;
  final bool isDismissible;
  final bool leftBorder;
  final bool rightBorder;
  final bool isTagStyle;

  const CustomBadge({
    super.key,
    required this.kColor,
    required this.kText,
    this.kFontSize = kLabelSmall,
    this.isRounded = false,
    this.isSoft = false,
    this.isOutlined = false,
    this.isDismissible = false,
    this.leftBorder = false,
    this.rightBorder = false,
    this.isTagStyle = false,
  });

  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if (!_isVisible) return const SizedBox.shrink();

    return widget.isTagStyle
        ? ClipPath(clipper: LabelBadgeClipper(), child: badgeContent(themeData))
        : badgeContent(themeData);
  }

  Container badgeContent(ThemeData themeData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          widget.isRounded ? 50 : defaultRadius,
        ),
        border: Border(
          left: widget.leftBorder
              ? BorderSide(color: widget.kColor, width: 2)
              : BorderSide.none,
          right: widget.rightBorder
              ? BorderSide(color: widget.kColor, width: 2)
              : BorderSide.none,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: 8,
          right: widget.isDismissible ? 4 : 8,
        ),
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? Colors.transparent
              : widget.isSoft
              ? widget.kColor.withValues(alpha: 0.1)
              : widget.kColor,
          borderRadius: BorderRadius.circular(
            widget.isRounded ? 50 : defaultRadius,
          ),
          border: Border.all(
            color: widget.isSoft
                ? widget.kColor.withValues(alpha: 0.1)
                : widget.kColor,
            width: 0.4,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isTagStyle == true)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.circle,
                  color: widget.isSoft || widget.isOutlined
                      ? widget.kColor
                      : Colors.white,
                  size: 4,
                ),
              ),
            Text(
              widget.kText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.isSoft || widget.isOutlined
                    ? widget.kColor
                    : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: widget.kFontSize,
                height: 1.0,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
            if (widget.isDismissible == true)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: widget.isSoft || widget.isOutlined
                        ? widget.kColor
                        : Colors.white,
                    size: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

//label badge clipperwidget

class LabelBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    double arrowSize = 10;

    // Start from the left top point
    path.moveTo(arrowSize, 0);
    // Draw a straight line to the right-top corner
    path.lineTo(size.width, 0);
    // Draw a straight line to the right-bottom corner
    path.lineTo(size.width, size.height);
    // Draw a straight line back to the left-bottom part
    path.lineTo(arrowSize, size.height);
    // Draw the pointed arrow-like shape on the left side
    path.lineTo(0, size.height / 2);
    // Close the path by connecting the last point to the start
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LabelBadgeBorder extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color borderColor;

  const LabelBadgeBorder({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.red,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _LabelBadgePainter(color, borderColor),
    );
  }
}

class _LabelBadgePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  _LabelBadgePainter(this.fillColor, this.borderColor);

  @override
  void paint(Canvas canvas, Size size) {
    double arrowSize = 10;
    final path = Path()
      ..moveTo(arrowSize, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(arrowSize, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    // Fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

//ribbon position

enum RibbonPosition { left, right }

//Rounded Ribbon Card
class RoundedRibbonCard extends StatelessWidget {
  final String ribbonText;
  final Color ribbonColor;
  final RibbonPosition ribbonPosition;
  final Widget child;

  const RoundedRibbonCard({
    super.key,
    required this.ribbonText,
    required this.ribbonColor,
    required this.ribbonPosition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            border: Border.all(
              color: kTextColor.withValues(alpha: 0.4),
              width: outlineWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.5 * kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 0.5 * kDefaultPadding,
          left: ribbonPosition == RibbonPosition.left ? 0 : null,
          right: ribbonPosition == RibbonPosition.right ? 0 : null,
          child: Container(
            padding: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: ribbonPosition == RibbonPosition.left
                  ? 0.5 * kDefaultPadding
                  : kDefaultPadding,
              right: ribbonPosition == RibbonPosition.right
                  ? 0.5 * kDefaultPadding
                  : kDefaultPadding,
            ),
            decoration: BoxDecoration(
              color: ribbonColor,
              borderRadius: BorderRadius.only(
                topRight: ribbonPosition == RibbonPosition.left
                    ? const Radius.circular(50)
                    : Radius.zero,
                bottomRight: ribbonPosition == RibbonPosition.left
                    ? const Radius.circular(50)
                    : Radius.zero,
                topLeft: ribbonPosition == RibbonPosition.right
                    ? const Radius.circular(50)
                    : Radius.zero,
                bottomLeft: ribbonPosition == RibbonPosition.right
                    ? const Radius.circular(50)
                    : Radius.zero,
              ),
              boxShadow: [
                BoxShadow(
                  color: kTextColor.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(2, 2), // changes position of the shadow
                ),
              ],
            ),
            child: Text(
              ribbonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kLabelMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//Triangle Ribbon Card
class TriangleRibbonCard extends StatelessWidget {
  final String ribbonText;
  final Color ribbonColor;
  final RibbonPosition ribbonPosition;
  final Widget child;

  const TriangleRibbonCard({
    super.key,
    required this.ribbonText,
    required this.ribbonColor,
    required this.ribbonPosition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            border: Border.all(
              color: kTextColor.withValues(alpha: 0.4),
              width: outlineWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.5 * kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 0.4 * kDefaultPadding,
          left: ribbonPosition == RibbonPosition.left ? 0 : null,
          right: ribbonPosition == RibbonPosition.right ? 0 : null,
          child: ClipPath(
            clipper: TriangleClipper(ribbonPosition: ribbonPosition),
            child: Container(
              padding: EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: ribbonPosition == RibbonPosition.left
                    ? 0.5 * kDefaultPadding
                    : 1.5 * kDefaultPadding,
                right: ribbonPosition == RibbonPosition.right
                    ? 0.5 * kDefaultPadding
                    : 1.5 * kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: ribbonColor,
                boxShadow: [
                  BoxShadow(
                    color: kTextColor.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(
                      2,
                      2,
                    ), // changes position of the shadow
                  ),
                ],
              ),
              child: Text(
                ribbonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: kLabelMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//Reverse Triangle Ribbon Card
class ReverseTriangleRibbonCard extends StatelessWidget {
  final String ribbonText;
  final Color ribbonColor;
  final RibbonPosition ribbonPosition;
  final Widget child;

  const ReverseTriangleRibbonCard({
    super.key,
    required this.ribbonText,
    required this.ribbonColor,
    required this.ribbonPosition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            border: Border.all(
              color: kTextColor.withValues(alpha: 0.4),
              width: outlineWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2.5 * kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 0.5 * kDefaultPadding,
          left: ribbonPosition == RibbonPosition.left ? 0 : null,
          right: ribbonPosition == RibbonPosition.right ? 0 : null,
          child: ClipPath(
            clipper: ReverseTriangleClipper(ribbonPosition: ribbonPosition),
            child: Container(
              padding: EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: ribbonPosition == RibbonPosition.left
                    ? 0.5 * kDefaultPadding
                    : 1.5 * kDefaultPadding,
                right: ribbonPosition == RibbonPosition.right
                    ? 0.5 * kDefaultPadding
                    : 1.5 * kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: ribbonColor,
                boxShadow: [
                  BoxShadow(
                    color: kTextColor.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(
                      2,
                      2,
                    ), // changes position of the shadow
                  ),
                ],
              ),
              child: Text(
                ribbonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: kLabelMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//slope ribbon card

class SlopedRibbonCard extends StatelessWidget {
  final String ribbonText;
  final Color ribbonColor;
  final RibbonPosition ribbonPosition;
  final Widget child;

  const SlopedRibbonCard({
    super.key,
    required this.ribbonText,
    required this.ribbonColor,
    required this.ribbonPosition,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            border: Border.all(
              color: kTextColor.withValues(alpha: 0.4),
              width: outlineWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 4 * kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: child,
          ),
        ),
        Positioned(
          top: 24,
          left: ribbonPosition == RibbonPosition.left ? -24 : null,
          right: ribbonPosition == RibbonPosition.right ? -24 : null,
          child: Transform.rotate(
            angle: ribbonPosition == RibbonPosition.left
                ? -0.785398
                : 0.785398, // 45 degrees in radians
            child: Container(
              width: 120,
              color: ribbonColor,
              child: Center(
                child: Text(
                  ribbonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: kLabelMedium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//Reverse Triangle Ribbon Card
class HoverRibbonCard extends StatefulWidget {
  final String ribbonText;
  final IconData ribbonIcon; // Added icon for the ribbon
  final Color ribbonColor;
  final RibbonPosition ribbonPosition;
  final Widget child;

  const HoverRibbonCard({
    super.key,
    required this.ribbonText,
    required this.ribbonColor,
    required this.ribbonPosition,
    required this.child,
    required this.ribbonIcon,
  });

  @override
  State<HoverRibbonCard> createState() => _HoverRibbonCardState();
}

class _HoverRibbonCardState extends State<HoverRibbonCard> {
  bool _isHovered = false; // State variable to track hover
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true; // Set hover to true when mouse enters
      }),
      onExit: (_) => setState(() {
        _isHovered = false; // Set hover to false when mouse exits
      }),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border.all(
                color: kTextColor.withValues(alpha: 0.4),
                width: outlineWidth,
              ),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2.5 * kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: widget.child,
            ),
          ),
          Positioned(
            top: 0.5 * kDefaultPadding,
            left: widget.ribbonPosition == RibbonPosition.left ? 0 : null,
            right: widget.ribbonPosition == RibbonPosition.right ? 0 : null,
            child: ClipPath(
              clipper: ReverseTriangleClipper(
                ribbonPosition: widget.ribbonPosition,
              ),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ), // Duration for the animation
                width: _isHovered ? 100 : 52, // Adjust the width based on hover
                padding: EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  left: widget.ribbonPosition == RibbonPosition.left
                      ? 0.5 * kDefaultPadding
                      : kDefaultPadding,
                  right: widget.ribbonPosition == RibbonPosition.right
                      ? 0.5 * kDefaultPadding
                      : kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: widget.ribbonColor,
                  boxShadow: [
                    BoxShadow(
                      color: kTextColor.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(
                        2,
                        2,
                      ), // changes position of the shadow
                    ),
                  ],
                ),
                child: widget.ribbonPosition == RibbonPosition.left
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (_isHovered) ...[
                            Text(
                              widget.ribbonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: kLabelMedium,
                              ),
                            ),
                          ],
                          const Spacer(),
                          Icon(widget.ribbonIcon, color: Colors.white),
                          const Spacer(),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Icon(widget.ribbonIcon, color: Colors.white),
                          const Spacer(),
                          if (_isHovered) ...[
                            Text(
                              widget.ribbonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: kLabelMedium,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Triangle Clipper for the ribbon shape

class TriangleClipper extends CustomClipper<Path> {
  final RibbonPosition ribbonPosition;

  TriangleClipper({required this.ribbonPosition});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (ribbonPosition == RibbonPosition.left) {
      // Clip for left ribbon
      path.lineTo(size.width - kDefaultPadding, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(size.width - kDefaultPadding, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else {
      // Clip for right ribbon
      path.moveTo(kDefaultPadding, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(kDefaultPadding, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(kDefaultPadding, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Reverse Triangle Clipper for the ribbon shape

class ReverseTriangleClipper extends CustomClipper<Path> {
  final RibbonPosition ribbonPosition;

  ReverseTriangleClipper({required this.ribbonPosition});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (ribbonPosition == RibbonPosition.left) {
      // Clip for left ribbon
      path.lineTo(size.width, 0);
      path.lineTo(size.width - kDefaultPadding, size.height / 2);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else {
      // Clip for right ribbon
      path.moveTo(0, 0);
      path.lineTo(kDefaultPadding, size.height / 2);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(kDefaultPadding, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

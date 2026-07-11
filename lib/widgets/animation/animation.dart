import 'package:flutter/material.dart';

// Blink transition switcher

class BlinkTransitionSwitcher extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const BlinkTransitionSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<BlinkTransitionSwitcher> createState() =>
      _BlinkTransitionSwitcherState();
}

class _BlinkTransitionSwitcherState extends State<BlinkTransitionSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacityAnim = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0), weight: 50), // tutup
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50), // buka
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant BlinkTransitionSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child.key != widget.child.key) {
      // Jalankan animasi lagi setiap kali child berubah
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnim,
      child: widget.child,
    );
  }
}

// Hover animated widget to give lift effect to its child

class HoverAnimatedWidget extends StatefulWidget {
  final Widget child;
  final double hoverElevation;
  final double defaultElevation;
  final double yOffset;
  final Duration duration;

  const HoverAnimatedWidget({
    super.key,
    required this.child,
    this.hoverElevation = 4.0,
    this.defaultElevation = 0.0,
    this.yOffset = -4.0,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<HoverAnimatedWidget> createState() => _HoverAnimatedWidgetState();
}

class _HoverAnimatedWidgetState extends State<HoverAnimatedWidget> {
  bool _isHovered = false;

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final elevation =
        _isHovered ? widget.hoverElevation : widget.defaultElevation;
    final yTransform = _isHovered ? widget.yOffset : 0.0;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeInOut, // You can customize the curve
        transform: Matrix4.translationValues(0, yTransform, 0),
        child: Material(
          // Material widget is needed for elevation to be visible
          elevation: elevation,
          color: Theme.of(context)
              .colorScheme
              .surface, // Or a specific color if needed
          borderRadius: BorderRadius.circular(
            4,
          ), // Optional: if your child has rounded corners
          child: widget.child,
        ),
      ),
    );
  }
}

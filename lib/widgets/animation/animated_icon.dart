import 'package:flutter/material.dart';
import 'package:flutter_ademin/theme/themes.dart';

// animated icon (also support symbols)

enum TriggerType { hover, click, auto }

class CustomAnimatedIcon extends StatefulWidget {
  final IconData? icon;
  final IconData? symbol;
  final double size;
  final double weight;
  final Color? color;
  final Duration duration;
  final LoopingAnimationType animationType;
  final TriggerType triggeredOn;

  const CustomAnimatedIcon({
    super.key,
    this.icon,
    this.symbol,
    this.size = 20,
    this.weight = 200,
    this.color,
    this.duration = const Duration(seconds: 2),
    this.animationType = LoopingAnimationType.scale,
    this.triggeredOn = TriggerType.auto,
  }) : assert(
         icon != null || symbol != null,
         'Either icon or symbol must be provided',
       );

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

enum LoopingAnimationType { scale, rotate, fade, bounce }

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    if (widget.triggeredOn == TriggerType.auto) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    switch (widget.animationType) {
      case LoopingAnimationType.scale:
        return ScaleTransition(
          scale: _controller.drive(Tween(begin: 0.7, end: 1)),
          child: child,
        );
      case LoopingAnimationType.rotate:
        return RotationTransition(turns: _controller, child: child);
      case LoopingAnimationType.fade:
        return FadeTransition(opacity: _controller, child: child);
      case LoopingAnimationType.bounce:
        return ScaleTransition(
          scale: Tween(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
          ),
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconData = widget.icon ?? widget.symbol!;
    final icon = Icon(
      iconData,
      size: widget.size,
      color: widget.color ?? kPrimaryColor,
      weight: widget.weight,
    );
    final animated = _buildAnimation(context, icon);

    switch (widget.triggeredOn) {
      case TriggerType.hover:
        return MouseRegion(
          onEnter: (_) => _controller.forward(from: 0.1),
          // onExit: (_) => _controller.reverse(),
          child: animated,
        );
      case TriggerType.click:
        return GestureDetector(
          onTap: () => _controller.forward(from: 0.0),
          child: animated,
        );
      case TriggerType.auto:
        return animated;
    }
  }
}

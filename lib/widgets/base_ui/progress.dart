import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'dart:math';

enum CircularIndicatorStyle { solid, segmented }

class AdvancedCircularProgress extends StatefulWidget {
  final double? radius;
  final double? value; // 0.0..1.0 (null = indeterminate)
  final Color color;
  final double strokeWidth;
  final Color? backgroundColor;
  final TextStyle? percentageTextStyle;
  final bool showPercentage;
  final CircularIndicatorStyle style;
  final int segmentCount;
  final bool isAnimated;
  final Duration animationDuration;
  final Curve curve;
  final String? semanticsLabel;

  const AdvancedCircularProgress({
    super.key,
    this.value,
    this.radius = 18,
    required this.color,
    this.strokeWidth = 3,
    this.backgroundColor,
    this.percentageTextStyle,
    this.showPercentage = false,
    this.style = CircularIndicatorStyle.solid,
    this.segmentCount = 16,
    this.isAnimated = false,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.curve = Curves.easeInOut,
    this.semanticsLabel,
  });

  @override
  State<AdvancedCircularProgress> createState() =>
      _AdvancedCircularProgressState();
}

class _AdvancedCircularProgressState extends State<AdvancedCircularProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      // INDETERMINATE MODE
      return RotationTransition(
        turns: _controller,
        child: SizedBox(
          height: 2 * widget.radius!,
          width: 2 * widget.radius!,
          child: CustomPaint(
            painter: _CircularPainter(
              value: 1, // sebagian arc agar terlihat spinner
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              backgroundColor:
                  widget.backgroundColor ??
                  Theme.of(context).colorScheme.surfaceContainerLow,
              style: widget.style,
              segmentCount: widget.segmentCount,
            ),
            child: const SizedBox.expand(),
          ),
        ),
      );
    }

    // DETERMINATE MODE
    final double clamped = widget.value!.clamp(0.0, 1.0);

    if (widget.isAnimated) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: clamped),
        duration: widget.animationDuration,
        curve: widget.curve,
        builder: (context, animatedValue, child) {
          return buildProgress(animatedValue, context);
        },
      );
    } else {
      return buildProgress(clamped, context);
    }
  }

  SizedBox buildProgress(double clamped, BuildContext context) {
    return SizedBox(
      height: 2 * widget.radius!,
      width: 2 * widget.radius!,
      child: CustomPaint(
        painter: _CircularPainter(
          value: clamped,
          color: widget.color,
          strokeWidth: widget.strokeWidth,
          backgroundColor:
              widget.backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerLow,
          style: widget.style,
          segmentCount: widget.segmentCount,
        ),
        child: Center(
          child: widget.showPercentage
              ? Text(
                  "${(clamped * 100).toStringAsFixed(0)}%",
                  style:
                      widget.percentageTextStyle ??
                      TextStyle(
                        fontSize: 0.65 * widget.radius!,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              : null,
        ),
      ),
    );
  }
}

class _CircularPainter extends CustomPainter {
  final double value;
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;
  final CircularIndicatorStyle style;
  final int segmentCount;

  _CircularPainter({
    required this.value,
    required this.color,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.style,
    required this.segmentCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.shortestSide - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint basePaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    if (style == CircularIndicatorStyle.solid) {
      // background
      canvas.drawArc(rect, -pi / 2, 2 * pi, false, basePaint);
      // progress
      canvas.drawArc(rect, -pi / 2, 2 * pi * value, false, progressPaint);
    } else {
      _drawDashedCircle(canvas, rect, 1.0, basePaint, segmentCount);
      _drawDashedCircle(canvas, rect, value, progressPaint, segmentCount);
    }
  }

  void _drawDashedCircle(
    Canvas canvas,
    Rect rect,
    double percent,
    Paint paint,
    int segments,
  ) {
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * percent;
    final double segmentAngle = (2 * pi) / segments;
    final double gap = segmentAngle * 0.3;

    for (int i = 0; i < segments; i++) {
      final double segStart = startAngle + i * segmentAngle;
      final double segSweep = segmentAngle - gap;

      if (segStart < startAngle + sweepAngle) {
        final double remaining = (startAngle + sweepAngle) - segStart;
        final double drawSweep = remaining < segSweep ? remaining : segSweep;
        if (drawSweep > 0) {
          canvas.drawArc(rect, segStart, drawSweep, false, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CircularProgress extends StatelessWidget {
  final double? radius;
  final double? value; // 0.0..1.0 (null = indeterminate)
  final Color? color;
  final double strokeWidth;
  final Color? backgroundColor;
  final bool isAnimated;
  final Duration animationDuration;
  final Curve curve;
  final String? semanticsLabel;
  final TextStyle? percentageTextStyle;
  final bool showPercentage;

  const CircularProgress({
    super.key,
    this.value,
    this.radius = 18,
    this.color,
    this.strokeWidth = 4.0,
    this.backgroundColor,
    this.isAnimated = false,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.curve = Curves.easeInOut,
    this.semanticsLabel,
    this.percentageTextStyle,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final double? clampedValue = value?.clamp(0.0, 1.0);

    Widget indicator = SizedBox(
      height: 2 * radius!,
      width: 2 * radius!,
      child: _buildIndicator(context, clampedValue),
    );

    // Tambah teks persentase di tengah lingkaran
    if (showPercentage && clampedValue != null) {
      indicator = Stack(
        alignment: Alignment.center,
        children: [
          indicator,
          Text(
            "${(clampedValue * 100).toStringAsFixed(0)}%",
            style:
                percentageTextStyle ??
                TextStyle(
                  fontSize: 0.65 * radius!,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      );
    }

    // Aksesibilitas
    return Semantics(
      label: semanticsLabel,
      value: clampedValue != null
          ? "${(clampedValue * 100).toStringAsFixed(0)}%"
          : null,
      child: indicator,
    );
  }

  Widget _buildIndicator(BuildContext context, double? clampedValue) {
    if (clampedValue == null) {
      // Indeterminate mode
      return CircularProgressIndicator(
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(color!),
      );
    }

    if (!isAnimated) {
      return CircularProgressIndicator(
        value: clampedValue,
        strokeWidth: strokeWidth,
        backgroundColor:
            backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerLow,
        valueColor: AlwaysStoppedAnimation<Color>(color!),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: clampedValue),
      duration: animationDuration,
      curve: curve,
      builder: (context, animatedValue, _) {
        return CircularProgressIndicator(
          value: animatedValue,
          strokeWidth: strokeWidth,
          backgroundColor:
              backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(color!),
        );
      },
    );
  }
}

// Linear progress indicator

class LinearProgress extends StatelessWidget {
  final double? value; // 0.0..1.0 (null = indeterminate)
  final Color color;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? innerBorderRadius;
  final Color? backgroundColor;
  final bool isAnimated;
  final Duration animationDuration;
  final Curve curve;
  final String? semanticsLabel;
  final bool showPercentage;
  final TextStyle? percentageTextStyle;

  const LinearProgress({
    super.key,
    this.value,
    required this.color,
    this.height = 10.0,
    this.borderRadius,
    this.innerBorderRadius,
    this.backgroundColor,
    this.isAnimated = false,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.curve = Curves.linear,
    this.semanticsLabel,
    this.showPercentage = false,
    this.percentageTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry radius =
        borderRadius ?? BorderRadius.circular(height / 2);

    final double? clampedValue = value?.clamp(0.0, 1.0);

    // Build indicator
    Widget indicator = _buildIndicator(context, clampedValue);

    // Rounded clip
    indicator = ClipRRect(borderRadius: radius, child: indicator);

    Color getAdaptiveTextColor({
      required Color foreground,
      required Color background,
    }) {
      final blended = Color.alphaBlend(foreground, background);
      return blended.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    }

    Widget buildPercentageText(double value) {
      final textWidget = Text(
        "${(value * 100).toStringAsFixed(0)}%",
        style:
            percentageTextStyle ??
            TextStyle(
              color: getAdaptiveTextColor(
                foreground: color,
                background: Theme.of(context).scaffoldBackgroundColor,
              ),
              fontSize: height * 0.7,
              fontWeight: FontWeight.w500,
            ),
      );

      if (value == 0) {
        // show only text
        return Center(
          child: Text(
            "${(value * 100).toStringAsFixed(0)}%",
            style:
                percentageTextStyle ??
                TextStyle(
                  color: getAdaptiveTextColor(
                    foreground:
                        backgroundColor ??
                        Theme.of(context).colorScheme.surfaceContainerLow,
                    background: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  fontSize: height * 0.7,
                  fontWeight: FontWeight.w500,
                ),
          ),
        );
      }

      // show text with bar
      return LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth * value;
          return SizedBox(
            width: barWidth,
            height: height,
            child: Center(child: textWidget),
          );
        },
      );
    }

    // showPercentage
    if (showPercentage && clampedValue != null) {
      indicator = Stack(
        alignment: Alignment.centerLeft,
        children: [indicator, buildPercentageText(clampedValue)],
      );
    }

    return Semantics(
      label: semanticsLabel,
      value: clampedValue != null
          ? "${(clampedValue * 100).toStringAsFixed(0)}%"
          : null,
      child: SizedBox(height: height, child: indicator),
    );
  }

  Widget _buildIndicator(BuildContext context, double? clampedValue) {
    if (clampedValue == null) {
      return LinearProgressIndicator(
        value: null,
        minHeight: height,
        backgroundColor:
            backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerLow,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        borderRadius:
            innerBorderRadius ??
            borderRadius ??
            BorderRadius.circular(height / 2),
      );
    }

    if (!isAnimated) {
      return LinearProgressIndicator(
        value: clampedValue,
        minHeight: height,
        backgroundColor:
            backgroundColor ??
            Theme.of(context).colorScheme.surfaceContainerLow,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        borderRadius:
            innerBorderRadius ??
            borderRadius ??
            BorderRadius.circular(height / 2),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: clampedValue),
      duration: animationDuration,
      curve: curve,
      builder: (context, animatedValue, _) {
        return LinearProgressIndicator(
          value: animatedValue,
          minHeight: height,
          backgroundColor:
              backgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerLow,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius:
              innerBorderRadius ??
              borderRadius ??
              BorderRadius.circular(height / 2),
        );
      },
    );
  }
}

// progress card

class ProgressCard extends StatelessWidget {
  final double value;
  final String label;
  final String? timeLeft;
  final Color color;
  final Color? cardColor;

  const ProgressCard({
    super.key,
    required this.value,
    required this.label,
    this.timeLeft,
    required this.color,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).toInt();
    final themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: cardColor ?? kTableHeaderColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row teks atas
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Text(
                  "$percentage%",
                  style: TextStyle(fontWeight: FontWeight.w600, color: color),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
                if (timeLeft != null)
                  Text(
                    timeLeft!,
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
              ],
            ),
          ),

          // Linear Progress (pakai widget custom kamu)
          LinearProgress(
            value: value,
            color: color,
            backgroundColor: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            innerBorderRadius: BorderRadius.circular(0),
          ),
        ],
      ),
    );
  }
}

// // Custom Circular Progress Indicator

// class CustomCircularProgressIndicator extends StatelessWidget {
//   final double? value;
//   final Color color;
//   final double strokeWidth;
//   final Color? backgroundColor;
//   final bool isAnimated;
//   final Duration animationDuration;
//   final Curve curve;
//   final String? semanticsLabel;
//   final TextStyle? percentageTextStyle;
//   final bool showPercentage;

//   const CustomCircularProgressIndicator({
//     super.key,
//     this.value,
//     this.color = kPrimaryColor,
//     this.strokeWidth = 4.0,
//     this.backgroundColor,
//     this.isAnimated = false,
//     this.animationDuration = const Duration(milliseconds: 5000),
//     this.curve = Curves.easeInOut,
//     this.semanticsLabel,
//     this.percentageTextStyle,
//     this.showPercentage = false,
//   });

//   /// Converts `value` into a percentage string (e.g., "70%")
//   String? get semanticsValue {
//     if (value != null) {
//       final percentage = (value! * 100).toStringAsFixed(0);
//       return '$percentage%';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Semantics(
//           label: semanticsLabel,
//           value: semanticsValue,
//           child: isAnimated
//               ? TweenAnimationBuilder<double>(
//                   tween: Tween<double>(begin: 0, end: value ?? 0),
//                   duration: animationDuration,
//                   curve: curve,
//                   builder: (context, animatedValue, child) {
//                     return CircularProgressIndicator(
//                       value: animatedValue,
//                       strokeWidth: strokeWidth,
//                       backgroundColor:
//                           backgroundColor ?? Colors.blueGrey.shade300,
//                       valueColor: AlwaysStoppedAnimation<Color>(color),
//                     );
//                   },
//                 )
//               : CircularProgressIndicator(
//                   value: value,
//                   strokeWidth: strokeWidth,
//                   backgroundColor: backgroundColor ?? Colors.blueGrey.shade300,
//                   valueColor: AlwaysStoppedAnimation<Color>(color),
//                 ),
//         ),
//         if (showPercentage) // Display percentage only when value is set
//           Text(
//             '${(value! * 100).toStringAsFixed(0)}%',
//             style: percentageTextStyle ??
//                 TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//           ),
//       ],
//     );
//   }
// }

// // Custom Linear Progress Indicator

// class CustomLinearProgressIndicator extends StatelessWidget {
//   final double? value;
//   final Color color;
//   final double height;
//   final BorderRadiusGeometry? borderRadius;
//   final Color? backgroundColor;
//   final bool isAnimated;
//   final Duration animationDuration;
//   final Curve curve;
//   final String? semanticsLabel;

//   const CustomLinearProgressIndicator({
//     super.key,
//     this.value,
//     this.color = kPrimaryColor,
//     this.height = 10.0,
//     this.borderRadius,
//     this.backgroundColor,
//     this.isAnimated = false,
//     this.animationDuration = const Duration(milliseconds: 5000),
//     this.curve = Curves.easeInOut,
//     this.semanticsLabel,
//   });

//   /// Converts `value` into a percentage string (e.g., "70%")
//   String? get semanticsValue {
//     if (value != null) {
//       final percentage = (value! * 100).toStringAsFixed(0);
//       return '$percentage%';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius ?? BorderRadius.circular(50),
//       child: SizedBox(
//         height: height,
//         child: isAnimated
//             ? TweenAnimationBuilder<double>(
//                 tween: Tween<double>(begin: 0, end: value ?? 0),
//                 duration: animationDuration,
//                 curve: curve,
//                 builder: (context, animatedValue, child) {
//                   return LinearProgressIndicator(
//                     value: animatedValue,
//                     backgroundColor:
//                         backgroundColor ?? Colors.blueGrey.shade100,
//                     valueColor: AlwaysStoppedAnimation<Color>(color),
//                     semanticsLabel: semanticsLabel,
//                     semanticsValue:
//                         '${(animatedValue * 100).toStringAsFixed(0)}%',
//                     minHeight: height,
//                     borderRadius: borderRadius ?? BorderRadius.circular(50),
//                   );
//                 },
//               )
//             : linearProgressIndicatorMethod(),
//       ),
//     );
//   }

//   LinearProgressIndicator linearProgressIndicatorMethod() {
//     return LinearProgressIndicator(
//       value: value,
//       backgroundColor: backgroundColor ?? Colors.blueGrey.shade100,
//       valueColor: AlwaysStoppedAnimation<Color>(color),
//       semanticsLabel: semanticsLabel,
//       semanticsValue: semanticsValue,
//       minHeight: height,
//       borderRadius: borderRadius ?? BorderRadius.circular(50),
//     );
//   }
// }

// //Animated Progress Button Version 1

// /// Button States
// enum ProgressButtonState { idle, progressing, completed, error }

// /// Progress Button Widget
// class ProgressButton extends StatefulWidget {
//   final IconData initialIcon;
//   final String initialText;
//   final String progressText;
//   final IconData completedIcon;
//   final String completedText;
//   final IconData errorIcon;
//   final String errorText;
//   final Color buttonColor;
//   final Future<void> Function() onPressed;
//   final VoidCallback? onCompleted;
//   final VoidCallback? onError;
//   final Duration? estimatedDuration;
//   final bool? showPercentage;
//   final double buttonWidth;
//   final double buttonHeight;

//   const ProgressButton({
//     super.key,
//     required this.initialIcon,
//     required this.initialText,
//     required this.progressText,
//     required this.completedIcon,
//     required this.completedText,
//     required this.errorIcon,
//     required this.errorText,
//     required this.buttonColor,
//     required this.onPressed,
//     this.onCompleted,
//     this.onError,
//     this.estimatedDuration,
//     this.showPercentage = false,
//     this.buttonWidth = 200,
//     this.buttonHeight = mediumHeight,
//   });

//   @override
//   State<ProgressButton> createState() => _ProgressButtonState();
// }

// class _ProgressButtonState extends State<ProgressButton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   ProgressButtonState _buttonState = ProgressButtonState.idle;
//   double _progress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: widget.estimatedDuration ?? const Duration(seconds: 5),
//     )..addListener(() {
//         setState(() {
//           _progress = _animationController.value;
//         });
//       });

//     _animation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _handlePressed() async {
//     if (_buttonState == ProgressButtonState.completed) return;

//     setState(() {
//       _buttonState = ProgressButtonState.progressing;
//     });

//     try {
//       _animationController.forward();
//       await widget.onPressed();

//       setState(() {
//         _buttonState = ProgressButtonState.completed;
//       });

//       widget.onCompleted?.call();
//     } catch (e) {
//       setState(() {
//         _buttonState = ProgressButtonState.error;
//       });

//       widget.onError?.call();
//     } finally {
//       _animationController.reset();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.buttonWidth,
//       height: widget.buttonHeight,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.buttonColor,
//         ),
//         onPressed: _handlePressed,
//         child: _buildButtonChild(),
//       ),
//     );
//   }

//   Widget _buildButtonChild() {
//     switch (_buttonState) {
//       case ProgressButtonState.progressing:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Colors.white,
//                 value: _animation.value,
//               ),
//             ),
//             const SizedBox(width: kDefaultPadding / 2),
//             Text(
//               widget.progressText,
//               style: const TextStyle(color: Colors.white),
//             ),
//             if (widget.showPercentage!)
//               Padding(
//                 padding: const EdgeInsets.only(left: kDefaultPadding / 2),
//                 child: Text(
//                   '${(_progress * 100).round()}%',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: kBodySmall,
//                   ),
//                 ),
//               ),
//           ],
//         );

//       case ProgressButtonState.completed:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(widget.completedIcon, color: Colors.white),
//             const SizedBox(width: kDefaultPadding / 2),
//             Text(
//               widget.completedText,
//               style: const TextStyle(color: Colors.white),
//             ),
//             if (widget.showPercentage!)
//               const Padding(
//                 padding: EdgeInsets.only(left: kDefaultPadding / 2),
//                 child: Text(
//                   '100%',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: kBodySmall,
//                   ),
//                 ),
//               ),
//           ],
//         );

//       case ProgressButtonState.error:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(widget.errorIcon, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(
//               widget.errorText,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         );

//       case ProgressButtonState.idle:
//       default:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(widget.initialIcon, color: Colors.white),
//             const SizedBox(width: 8),
//             Text(
//               widget.initialText,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         );
//     }
//   }
// }

// //Animated Progress Button Indicator Version 2

// class ProgressButtonV2 extends StatefulWidget {
//   final IconData initialIcon;
//   final String initialText;
//   final String progressText;
//   final IconData completedIcon;
//   final String completedText;
//   final Color buttonColor, indicatorColor;
//   final VoidCallback onPressed;

//   const ProgressButtonV2({
//     super.key,
//     required this.initialIcon,
//     required this.initialText,
//     required this.progressText,
//     required this.completedIcon,
//     required this.completedText,
//     required this.buttonColor,
//     required this.indicatorColor,
//     required this.onPressed,
//   });

//   @override
//   State<ProgressButtonV2> createState() => _ProgressButtonV2State();
// }

// class _ProgressButtonV2State extends State<ProgressButtonV2>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _isProgressing = false;
//   bool _isCompleted = false;
//   late Ticker _ticker;
//   double _progress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     // Add initialization code here
//     _ticker = Ticker((elapsed) {
//       setState(() {
//         _progress = _animationController.value;
//       });
//     });
//     _ticker.start();

//     _animationController = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.linear,
//       ),
//     );

//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _isCompleted = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _ticker.stop();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _progressPressed() {
//     setState(() {
//       _isProgressing = true;
//     });
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 178,
//       height: mediumHeight,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: widget.buttonColor,
//         ),
//         onPressed: () {
//           _progressPressed();
//           widget.onPressed();
//         },
//         child: _isCompleted
//             ? FadeInWidget(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Icon(
//                       widget.completedIcon,
//                       color: Colors.white,
//                     ),
//                     const Spacer(),
//                     Text(
//                       widget.completedText,
//                       style: const TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               )
//             : _isProgressing
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       AnimatedBuilder(
//                         animation: _animation,
//                         builder: (context, child) {
//                           return Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 18,
//                                 width: 18,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: widget.indicatorColor,
//                                   backgroundColor: Colors.white,
//                                   value: _animation.value,
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       const Spacer(),
//                       Text(
//                         widget.progressText,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         '${(_progress * 100).round()}%',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: kBodySmall,
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Icon(
//                         widget.initialIcon,
//                         color: Colors.white,
//                       ),
//                       const Spacer(),
//                       Text(
//                         widget.initialText,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

// //Animated Progress Button Indicator Version 3

// class ProgressButtonV3 extends StatefulWidget {
//   final IconData initialIcon;
//   final String initialText;
//   final String progressText;
//   final IconData completedIcon;
//   final String completedText;
//   final Color buttonColor, completedColor;
//   final VoidCallback onPressed;

//   const ProgressButtonV3({
//     super.key,
//     required this.initialIcon,
//     required this.initialText,
//     required this.progressText,
//     required this.completedIcon,
//     required this.completedText,
//     required this.buttonColor,
//     required this.completedColor,
//     required this.onPressed,
//   });

//   @override
//   State<ProgressButtonV3> createState() => _ProgressButtonV3State();
// }

// class _ProgressButtonV3State extends State<ProgressButtonV3>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _isProgressing = false;
//   bool _isCompleted = false;
//   late Ticker _ticker;
//   double _progress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     // Add initialization code here
//     _ticker = Ticker((elapsed) {
//       setState(() {
//         _progress = _animationController.value;
//       });
//     });
//     _ticker.start();

//     _animationController = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.linear,
//       ),
//     );

//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _isCompleted = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _ticker.stop();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _progressPressed() {
//     setState(() {
//       _isProgressing = true;
//     });
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 180,
//       height: mediumHeight,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor:
//               _isCompleted ? widget.completedColor : widget.buttonColor,
//           padding: EdgeInsets.zero,
//         ),
//         onPressed: () {
//           _progressPressed();
//           widget.onPressed();
//         },
//         child: _isCompleted
//             ? FadeInWidget(
//                 child: Row(
//                   children: [
//                     const Spacer(),
//                     Icon(
//                       widget.completedIcon,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(
//                       width: kDefaultPadding,
//                     ),
//                     Text(
//                       widget.completedText,
//                       style: const TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer()
//                   ],
//                 ),
//               )
//             : _isProgressing
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Stack(
//                       children: [
//                         AnimatedBuilder(
//                           animation: _animation,
//                           builder: (context, child) {
//                             return LinearProgressIndicator(
//                               minHeight: mediumHeight,
//                               color: widget.completedColor,
//                               backgroundColor: Colors.transparent,
//                               value: _animation.value,
//                               // borderRadius: BorderRadius.circular(5),
//                             );
//                           },
//                         ),
//                         SizedBox(
//                           height: mediumHeight,
//                           child: Row(
//                             children: [
//                               const Spacer(),
//                               Text(
//                                 widget.progressText,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: kDefaultPadding,
//                               ),
//                               Text(
//                                 '${(_progress * 100).round()}%',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: kBodySmall,
//                                 ),
//                               ),
//                               const Spacer(),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 : Row(
//                     children: [
//                       const Spacer(),
//                       Icon(
//                         widget.initialIcon,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(
//                         width: kDefaultPadding,
//                       ),
//                       Text(
//                         widget.initialText,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

// //Animated Progress Button Indicator Version 4

// class ProgressButtonV4 extends StatefulWidget {
//   const ProgressButtonV4({super.key});

//   @override
//   State<ProgressButtonV4> createState() => _ProgressButtonV4State();
// }

// class _ProgressButtonV4State extends State<ProgressButtonV4>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool _isProgressing = false;
//   bool _isCompleted = false;
//   late Ticker _ticker;
//   double _progress = 0.0;
//   double buttonHeight = mediumHeight;

//   @override
//   void initState() {
//     super.initState();
//     // Add initialization code here
//     _ticker = Ticker((elapsed) {
//       setState(() {
//         _progress = _animationController.value;
//       });
//     });
//     _ticker.start();

//     _animationController = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     );

//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.linear,
//       ),
//     );

//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _isCompleted = true;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _ticker.stop();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _progressPressed() {
//     setState(() {
//       _isProgressing = true;
//     });
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 180,
//       height: buttonHeight,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           minimumSize: Size.fromHeight(buttonHeight),
//           backgroundColor: kInfoColor,
//           padding: EdgeInsets.zero,
//         ),
//         onPressed: _progressPressed,
//         child: _isCompleted
//             ? FadeInWidget(
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.download_done,
//                       color: Colors.white,
//                     ),
//                     SizedBox(
//                       width: kDefaultPadding,
//                     ),
//                     Text(
//                       "Completed",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : _isProgressing
//                 ? Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       SizedBox(
//                         height: buttonHeight,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Downloading...",
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: kDefaultPadding,
//                             ),
//                             Text(
//                               '${(_progress * 100).round()}%',
//                               style: const TextStyle(
//                                 fontSize: kBodySmall,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       AnimatedBuilder(
//                         animation: _animation,
//                         builder: (context, child) {
//                           return LinearProgressIndicator(
//                             minHeight: 2,
//                             color: Colors.white,
//                             backgroundColor: Colors.transparent,
//                             value: _animation.value,
//                             borderRadius: BorderRadius.circular(50),
//                           );
//                         },
//                       ),
//                     ],
//                   )
//                 : const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.cloud_download_outlined,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: kDefaultPadding,
//                       ),
//                       Text(
//                         "Download",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

// class FadeInWidget extends StatefulWidget {
//   Widget? child;
//   final Duration duration;

//   FadeInWidget(
//       {super.key,
//       this.child,
//       this.duration = const Duration(
//         milliseconds: 50,
//       )});

//   @override
//   State<FadeInWidget> createState() => _FadeInWidgetState();
// }

// class _FadeInWidgetState extends State<FadeInWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: widget.duration, vsync: this);
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       duration: widget.duration,
//       opacity: _animation.value,
//       child: widget.child,
//     );
//   }
// }

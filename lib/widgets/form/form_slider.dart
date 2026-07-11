import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

/// Track with border &  custom color
class BorderedTrackShape extends SliderTrackShape {
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;

  const BorderedTrackShape({
    this.fillColor = const Color(0xFFF5F5F5),
    this.borderColor = const Color(0xFFDDDDDD),
    this.borderRadius = 2,
    this.borderWidth = 1,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    // 🌟 1. HITUNG LEBAR THUMB
    // Mendapatkan lebar thumb. Diasumsikan thumbShape tidak null.
    final double thumbWidth = sliderTheme.thumbShape!
        .getPreferredSize(isEnabled, isDiscrete)
        .width;

    // Padding yang dibutuhkan (setengah lebar thumb)
    final double halfThumb = thumbWidth / 2;

    // 🌟 2. ATUR LEBAR TRACK
    // Lebar track dikurangi total lebar thumb (padding kiri + padding kanan)
    final double trackWidth = parentBox.size.width - thumbWidth;

    // 🌟 3. ATUR POSISI X TRACK
    // Track dimulai setelah padding setengah thumb
    final double trackLeft = offset.dx + halfThumb;

    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required Offset thumbCenter,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // 🌟 LOGIKA PERUBAHAN WARNA TRACK (Track Background)
    final Color trackFillColor = isEnabled
        ? fillColor // Warna saat aktif
        : fillColor.withValues(alpha: 0.4);

    // 🌟 LOGIKA PERUBAHAN WARNA BORDER
    final Color trackBorderColor = isEnabled
        ? borderColor // Warna border saat aktif
        : borderColor.withValues(alpha: 0.4); // Warna border saat disabled

    final Paint fillPaint = Paint()
      ..color = trackFillColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = trackBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final canvas = context.canvas;
    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, borderPaint);
  }
}

/// Thumb rectangle with custom argumen
class RectangularThumbShape extends SliderComponentShape {
  final Color color;
  final double width;
  final double height;
  final double borderRadius;

  const RectangularThumbShape({
    this.color = Colors.green,
    this.width = 12,
    this.height = 24,
    this.borderRadius = 2,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(width, height);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    bool isEnabled = false,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // 🌟 LOGIKA PERUBAHAN WARNA THUMB
    // final Color thumbColor = sliderTheme.thumbColor ?? color;

    // 🌟 Warna thumb berdasarkan animasi enable state
    final double t = enableAnimation.value;
    final Color effectiveThumbColor = Color.lerp(
      color.withValues(alpha: 0.8),
      color,
      t,
    )!;

    final Paint paint = Paint()
      ..color = effectiveThumbColor
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(center: center, width: width, height: height);
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, paint);
  }
}

//Custom Form Slider

class FormSlider extends FormField<double> {
  FormSlider({
    super.key,
    required double value,
    required double min,
    required double max,
    String? label,
    int? divisions,
    bool disable = false,
    ValueChanged<double>? onChanged,
    super.validator,
    Color? activeColor, // Optional color argument
  }) : super(
         builder: (FormFieldState<double> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Slider(
                 value: state.value!,
                 min: min,
                 max: max,
                 divisions: divisions,
                 label: state.value!.toStringAsFixed(1),
                 activeColor:
                     activeColor ?? kPrimaryColor, // Default to kPrimaryColor
                 onChanged: disable
                     ? null // Disable the slider interaction
                     : (newValue) {
                         state.didChange(newValue);
                         if (onChanged != null) onChanged(newValue);
                       },
               ),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 0.5 * kDefaultPadding),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyle(color: kErrorColor),
                   ),
                 ),
             ],
           );
         },
       );
}

//Custom Syncfusion Slider Thumb Slider
class CustomThumbShape extends SfThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    RenderBox? child,
    dynamic currentValue,
    SfRangeValues? currentValues,
    required Animation<double> enableAnimation,
    required Paint? paint,
    required RenderBox parentBox,
    required TextDirection textDirection,
    required SfSliderThemeData themeData,
    required SfThumb? thumb,
  }) {
    // Custom paint for the thumb
    final Paint thumbPaint = Paint()
      ..color = themeData.activeTrackColor ?? kPrimaryColor
      ..style = PaintingStyle.fill;

    // Draw the thumb as a circle
    context.canvas.drawCircle(center, kDefaultPadding / 2, thumbPaint);

    // Optional: Custom splash effect
    final Paint splashPaint = Paint()
      ..color = (themeData.activeTrackColor ?? kPrimaryColor).withValues(
        alpha: 0.1,
      )
      ..style = PaintingStyle.fill;

    context.canvas.drawCircle(center, 2.0 * enableAnimation.value, splashPaint);
  }
}

//Custom tooltip
class CustomTooltipShape extends SfTooltipShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset,
    Offset thumbCenter,
    TextPainter textPainter, {
    required Animation<double> animation,
    required Paint paint,
    required RenderBox parentBox,
    required SfSliderThemeData sliderThemeData,
    required Rect trackRect,
  }) {
    // Custom background color for tooltip
    final Paint tooltipPaint = Paint()
      ..color = Colors
          .blueAccent // Set your custom background color
      ..style = PaintingStyle.fill;

    const double tooltipWidth = 100.0;
    const double tooltipHeight = 30.0;

    // Draw tooltip background with the custom color
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx - tooltipWidth / 2,
          offset.dy - tooltipHeight - 30,
          tooltipWidth,
          tooltipHeight,
        ),
        const Radius.circular(8),
      ),
      tooltipPaint,
    );

    // Set the tooltip text
    textPainter.text = TextSpan(
      text: thumbCenter.dx.toStringAsFixed(
        0,
      ), // Tooltip text showing slider value
      style: const TextStyle(
        color: Colors.white, // Set your custom font color
        fontSize: 14,
      ),
    );

    // Layout the text
    textPainter.layout(minWidth: 0, maxWidth: tooltipWidth);

    // Draw the text inside the tooltip with the custom font color
    textPainter.paint(
      context.canvas,
      Offset(
        offset.dx - tooltipWidth / 2 + (tooltipWidth - textPainter.width) / 2,
        offset.dy - tooltipHeight / 2 - 30,
      ),
    );
  }
}

//Custom Syncfusion Slider

class CustomSfSlider extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final double interval;
  final bool showTicks;
  final bool showLabels;
  final bool enableTooltip;
  final int minorTicksPerInterval;
  final ValueChanged<double> onChanged;

  const CustomSfSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    this.interval = 1.0,
    this.showTicks = false,
    this.showLabels = false,
    this.enableTooltip = false,
    this.minorTicksPerInterval = 0,
    required this.onChanged,
  });

  @override
  State<CustomSfSlider> createState() => _CustomSfSliderState();
}

class _CustomSfSliderState extends State<CustomSfSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      min: widget.min,
      max: widget.max,
      value: _currentValue,
      interval: widget.interval,
      showTicks: widget.showTicks,
      showLabels: widget.showLabels,
      enableTooltip: widget.enableTooltip,
      minorTicksPerInterval: widget.minorTicksPerInterval,
      onChanged: (dynamic value) {
        setState(() {
          _currentValue = value;
        });
        widget.onChanged(value);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/animation/animated_icon.dart';
import 'package:flutkit_ademin/widgets/animation/animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnimatedIconMetricCard extends StatelessWidget {
  final String title;
  final String value;

  final IconData? icon;
  final Widget? trailing;

  final Color? iconColor;
  final Color? iconBackgroundColor;

  final double? changes;
  final String comparisonText;

  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  final Widget? footer;

  const AnimatedIconMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.trailing,
    this.iconColor,
    this.iconBackgroundColor,
    this.changes,
    this.comparisonText = 'Vs. Previous Month',
    this.titleStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.all(kDefaultPadding),
    this.onTap,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final bool hasChanges = changes != null;
    final bool isPositive = (changes ?? 0) >= 0;

    return HoverAnimatedWidget(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style:
                                titleStyle ??
                                TextStyle(
                                  fontSize: kBodyMedium,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),

                          const SizedBox(height: kDefaultPadding),

                          Text(
                            value,
                            style:
                                valueStyle ??
                                TextStyle(
                                  fontSize: kHeadlineSmall,
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),

                    if (trailing != null)
                      trailing!
                    else if (icon != null)
                      Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          color:
                              iconBackgroundColor ??
                              Colors.blueGrey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomAnimatedIcon(
                          symbol: icon!,
                          color: iconColor,
                          size: 32,
                          duration: const Duration(seconds: 2),
                          animationType: LoopingAnimationType.scale,
                          weight: 400,
                        ),
                      ),
                  ],
                ),

                if (hasChanges || footer != null) ...[
                  const SizedBox(height: kDefaultPadding / 2),
                ],

                if (hasChanges)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 12,
                              color: isPositive ? kSuccessColor : kErrorColor,
                            ),

                            Text(
                              '${changes!.abs().toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontSize: 10,
                                color: isPositive ? kSuccessColor : kErrorColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          comparisonText,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                ?footer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// chart metric card

class ChartMetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final double delta;
  final String deltaText;
  final List<double> chartData;

  const ChartMetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.delta,
    required this.deltaText,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = delta < 0;
    final changeColor = isNegative ? kErrorColor : kSuccessColor;
    final themeData = Theme.of(context);

    return HoverAnimatedWidget(
      child: Card(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final chartWidth = constraints.maxWidth * 0.5;
            return Stack(
              children: [
                // chart
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 84,
                    width: chartWidth,
                    margin: EdgeInsets.all(kDefaultPadding),

                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      margin: EdgeInsets.zero,
                      primaryXAxis: NumericAxis(isVisible: false),
                      primaryYAxis: NumericAxis(isVisible: false),
                      series: <CartesianSeries>[
                        SplineAreaSeries<double, int>(
                          dataSource: chartData,
                          xValueMapper: (_, i) => i,
                          yValueMapper: (value, _) => value,
                          gradient: LinearGradient(
                            colors: [
                              changeColor.withValues(alpha: 0.3),
                              changeColor.withValues(alpha: 0.0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderColor: changeColor,
                          borderWidth: 2,
                        ),
                      ],
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        activationMode: ActivationMode.singleTap,
                        tooltipAlignment: ChartAlignment.near,
                        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
                        lineDashArray: [4, 4],
                        lineWidth: 0.6,
                        lineColor: kTextColor,
                        tooltipSettings: InteractiveTooltip(
                          enable: true,
                          format: 'point.x : \$point.y',
                          color: themeData.colorScheme.surface,
                          textStyle: TextStyle(
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(subtitle),
                      SizedBox(height: kDefaultPadding),
                      // price and delta
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: kHeadlineSmall,
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 4),
                          Row(
                            children: [
                              Text(
                                '${isNegative ? '' : '+'}$delta%',
                                style: TextStyle(
                                  color: changeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' $deltaText',
                                style: TextStyle(color: kTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// square iconic Metric Card
class SquareIconicMetricCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final double percentage;
  final Color color;

  const SquareIconicMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.percentage,
    required this.color,
  });

  @override
  State<SquareIconicMetricCard> createState() => _SquareIconicMetricCardState();
}

class _SquareIconicMetricCardState extends State<SquareIconicMetricCard> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isPositive = widget.percentage >= 0;

    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // icon
              Container(
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                padding: EdgeInsets.all(kDefaultPadding),
                child: Icon(widget.icon, size: 28, color: widget.color),
              ),
              SizedBox(width: kDefaultPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        fontWeight: FontWeight.w500,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: kDefaultPadding / 2),

                    // value
                    Row(
                      children: [
                        Text(
                          widget.value,
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isPositive
                                ? kSuccessColor.withValues(alpha: 0.1)
                                : kErrorColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isPositive
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: isPositive ? kSuccessColor : kErrorColor,
                                size: 14,
                              ),
                              Text(
                                '${widget.percentage.abs().toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: kBodySmall,
                                  fontWeight: FontWeight.w600,
                                  color: isPositive
                                      ? kSuccessColor
                                      : kErrorColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: kDefaultPadding / 4),

                    // subtile
                    Text(widget.subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Iconic Metric Card

class IconicMetricData {
  final String title;
  final IconData icon;
  final double value;
  final double change;
  final bool isGain;
  final bool isPercentage;

  IconicMetricData({
    required this.title,
    required this.icon,
    required this.value,
    required this.change,
    required this.isGain,
    this.isPercentage = false,
  });
}

class IconicMetricCard extends StatelessWidget {
  final IconicMetricData data;
  const IconicMetricCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isLoss = data.change < 0;
    final Color bgColor = isLoss
        ? kErrorColor.withValues(alpha: 0.2)
        : kSuccessColor.withValues(alpha: 0.2);
    final Color textColor = isLoss ? kErrorColor : kSuccessColor;
    final themeData = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
    );
    return HoverAnimatedWidget(
      child: Card(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool smallConstraints = constraints.maxWidth < 244;
            return Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  // Icon
                  CircleAvatar(
                    backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
                    radius: smallConstraints ? 24 : 28,
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      radius: smallConstraints ? 14 : 16,
                      child: Icon(
                        data.icon,
                        color: Colors.white,
                        size: smallConstraints ? 16 : 18,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        Text(
                          data.title.toUpperCase(),
                          style: TextStyle(
                            fontSize: kBodySmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),

                        // ammount + changes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.isPercentage
                                  ? '${(data.value * 100).toStringAsFixed(2)} %'
                                  : currencyFormatter.format(data.value),
                              style: TextStyle(
                                fontSize: smallConstraints
                                    ? kBodyMedium + 2
                                    : kBodyLarge + 2,
                                fontWeight: FontWeight.w600,
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: smallConstraints ? 2 : 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(
                                  defaultRadius,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isLoss
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color: textColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: smallConstraints ? 2 : 4),
                                  Text(
                                    '${(data.change * 100).toStringAsFixed(2)} %',
                                    style: TextStyle(
                                      fontSize: smallConstraints ? 9 : 10,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Link Metric Card

class LinkMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final double changePercent;
  final String actionText;
  final FaIconData icon;
  final Color iconBgColor;

  const LinkMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.changePercent,
    required this.actionText,
    required this.icon,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = changePercent < 0;
    final changeColor = isNegative ? kErrorColor : kSuccessColor;
    final changeIcon = isNegative ? Icons.arrow_downward : Icons.arrow_upward;
    final themeData = Theme.of(context);

    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SizedBox(
            height: 108,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: kBodyMedium,
                        color: kTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),

                    /// Value
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: kHeadlineSmall,
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    Spacer(),

                    /// Action Link
                    InkWell(
                      onTap: () {},
                      child: Text(
                        actionText,
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // changes
                    Row(
                      children: [
                        Icon(changeIcon, size: 14, color: changeColor),
                        SizedBox(width: kDefaultPadding / 4),
                        Text(
                          "${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)} %",
                          style: TextStyle(
                            fontSize: kBodyMedium,
                            color: changeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    // icon
                    Container(
                      padding: EdgeInsets.all(kDefaultPadding * 0.8),
                      decoration: BoxDecoration(
                        color: iconBgColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                      child: FaIcon(icon, color: iconBgColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Compact Metric Card

class CompactMetricCard extends StatelessWidget {
  final CompactMetricCardData data;
  const CompactMetricCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final trendColor = data.isTrendUp ? kSuccessColor : kErrorColor;
    final trendIcon = data.isTrendUp
        ? Icons.arrow_circle_up_outlined
        : Icons.arrow_circle_down_outlined;
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // card title
                    Text(data.title.toUpperCase()),
                    SizedBox(height: kDefaultPadding / 2),
                    Row(
                      children: [
                        // card icon
                        Icon(
                          data.icon,
                          size: 28,
                          color: themeData.colorScheme.onSurface,
                          weight: 1,
                        ),

                        SizedBox(width: kDefaultPadding / 2),
                        // card value
                        Text(
                          data.value,
                          style: TextStyle(
                            fontSize: kHeadlineSmall,
                            fontWeight: FontWeight.w600,
                            color: themeData.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // trend icon
              Icon(trendIcon, color: trendColor, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class CompactMetricCardData {
  final String title;
  final String value;
  final IconData icon;
  final bool isTrendUp;

  CompactMetricCardData(this.title, this.value, this.icon, this.isTrendUp);
}

// Standard Metric Card

class StandardMetricCardData {
  final String title;
  final String value;
  final IconData icon;
  final String change;
  final bool isPositive;
  final String subtitle;

  StandardMetricCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.change,
    required this.isPositive,
    required this.subtitle,
  });
}

class StandardMetricCard extends StatelessWidget {
  final StandardMetricCardData data;

  const StandardMetricCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final iconColor = kInfoColor;
    final changeColor = data.isPositive ? kSuccessColor : kErrorColor;
    final themeData = Theme.of(context);

    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // titile
                  Text(
                    data.title,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: kBodyMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),

                  // value
                  Text(
                    data.value,
                    style: TextStyle(
                      fontSize: kHeadlineSmall,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),

                  // delta
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final bool smallConstraints = constraints.maxWidth < 180;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // up down icon
                          Icon(
                            data.isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: smallConstraints ? 12 : 14,
                            color: changeColor,
                          ),
                          SizedBox(width: kDefaultPadding / 2),

                          // change
                          Text(
                            data.change,
                            style: TextStyle(
                              color: changeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: smallConstraints
                                  ? kBodySmall
                                  : kBodyMedium,
                            ),
                          ),

                          // subtitle
                          SizedBox(width: kDefaultPadding / 2),
                          Text(
                            data.subtitle,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: smallConstraints
                                  ? kBodySmall
                                  : kBodyMedium,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),

              // icon
              PositionedDirectional(
                top: 0,
                end: 0,

                child: CircleAvatar(
                  backgroundColor: iconColor.withValues(alpha: 0.1),
                  radius: 22,
                  child: Icon(data.icon, color: iconColor, size: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

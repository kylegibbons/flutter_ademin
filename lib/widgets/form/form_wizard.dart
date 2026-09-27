import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

enum HeaderStyle { simple, detailed }

/// Data model untuk setiap step
class StepData {
  final String title;
  final Widget content;
  final GlobalKey<FormState>? formKey;

  StepData({required this.title, required this.content, this.formKey});
}

/// Custom Stepper reusable widget
class CustomHorizontalStepper extends StatefulWidget {
  final List<StepData> steps;
  final Color? headerColor;
  final HeaderStyle headerStyle;

  /// Callback ketika semua step selesai
  final VoidCallback? onFinish;

  /// Optional custom action buttons builder
  /// Jika tidak disediakan, maka tombol default akan digunakan
  final Widget Function(
    BuildContext context,
    int currentStep,
    VoidCallback nextStep,
    VoidCallback prevStep,
  )?
  actionBuilder;

  /// Optional untuk styling header text
  final double? headerFontSize;
  final FontWeight? headerFontWeight;
  final Color? headerTextColor;
  final Color? inactiveColor;
  final Color? lineColor;
  final Color? headerBgColor;
  final Color? nextButtonColor;
  final Color? prevButtonColor;

  const CustomHorizontalStepper({
    super.key,
    required this.steps,
    this.headerColor,
    this.headerBgColor,
    this.headerStyle = HeaderStyle.simple,
    this.onFinish,
    this.actionBuilder,
    this.headerFontSize,
    this.headerFontWeight,
    this.headerTextColor,
    this.inactiveColor,
    this.lineColor,
    this.nextButtonColor,
    this.prevButtonColor,
  });

  @override
  State<CustomHorizontalStepper> createState() =>
      _CustomHorizontalStepperState();
}

class _CustomHorizontalStepperState extends State<CustomHorizontalStepper> {
  int currentStep = 0;

  void nextStep() {
    final step = widget.steps[currentStep];

    // validate form
    if (step.formKey != null) {
      if (step.formKey!.currentState?.validate() != true) {
        return;
      }
    }

    if (currentStep < widget.steps.length - 1) {
      setState(() => currentStep++);
    } else {
      // final step function
      widget.onFinish?.call();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final inactiveColor = widget.inactiveColor ?? Colors.grey.shade300;
    final lineColor = widget.lineColor ?? widget.headerColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (widget.headerColor ?? kPrimaryColor).withValues(
                alpha: 0.2,
              ),
              width: outlineWidth,
            ),
            borderRadius: BorderRadius.circular(defaultRadius),
            color:
                (widget.headerBgColor ?? (widget.headerColor ?? kPrimaryColor))
                    .withValues(alpha: 0.1),
          ),
          padding: EdgeInsets.all(kDefaultPadding),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile =
                  MediaQuery.of(context).size.width < kScreenWidthMd;
              if (isMobile) {
                // show stepItem vertically
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.steps.length, (index) {
                    final isActive = index == currentStep;
                    final isCompleted = index < currentStep;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < widget.steps.length - 1
                            ? kDefaultPadding
                            : 0,
                      ),
                      child: stepItem(
                        isActive,
                        isCompleted,
                        index,
                        widget.headerColor ?? kPrimaryColor,
                        inactiveColor,
                        lineColor ?? kPrimaryColor,
                        themeData,
                      ),
                    );
                  }),
                );
              } else {
                // Show stepItem horizontally
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.steps.length, (index) {
                    final isActive = index == currentStep;
                    final isCompleted = index < currentStep;
                    return index < widget.steps.length - 1
                        ? Expanded(
                            child: stepItem(
                              isActive,
                              isCompleted,
                              index,
                              widget.headerColor ?? kPrimaryColor,
                              inactiveColor,
                              lineColor ?? kPrimaryColor,
                              themeData,
                            ),
                          )
                        : stepItem(
                            isActive,
                            isCompleted,
                            index,
                            widget.headerColor ?? kPrimaryColor,
                            inactiveColor,
                            lineColor ?? kPrimaryColor,
                            themeData,
                          );
                  }),
                );
              }
            },
          ),
        ),

        const SizedBox(height: 2 * kDefaultPadding),

        // CONTENT
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: widget.steps[currentStep].content,
        ),

        const SizedBox(height: 2 * kDefaultPadding),

        // ACTIONS
        widget.actionBuilder != null
            ? widget.actionBuilder!(context, currentStep, nextStep, prevStep)
            : defaultActions(themeData),
      ],
    );
  }

  Widget defaultActions(ThemeData themeData) {
    final isLast = currentStep == widget.steps.length - 1;
    final lang = Lang.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          FancyIconButton(
            kText: lang.back,
            kTextColor: themeData.colorScheme.onSurface,
            bgColor: widget.prevButtonColor ?? kTableHeaderColor,
            kLeadingIcon: Icons.arrow_back,
            onPressed: prevStep,
          )
        else
          const SizedBox.shrink(),
        FancyIconButton(
          kText: isLast ? lang.finish : lang.next,
          kTextColor: Colors.white,
          bgColor: widget.nextButtonColor ?? kSuccessColor,
          kTrailingIcon: isLast ? Icons.check : Icons.arrow_forward,
          onPressed: nextStep,
        ),
      ],
    );
  }

  Widget stepItem(
    bool isActive,
    bool isCompleted,
    int index,
    Color headerColor,
    Color inactiveColor,
    Color lineColor,
    ThemeData themeData,
  ) {
    final textColor = isActive || isCompleted
        ? (widget.headerTextColor ?? headerColor)
        : themeData.colorScheme.onSurface;

    final fontWeight =
        widget.headerFontWeight ??
        (isActive || isCompleted ? FontWeight.w600 : FontWeight.w500);

    final fontSize = widget.headerFontSize ?? kBodyMedium;

    final isMobile = MediaQuery.of(context).size.width < kScreenWidthMd;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: mediumHeight / 2,
          backgroundColor: isActive || isCompleted
              ? headerColor
              : Colors.white.withValues(alpha: 0.3),
          child: Text(
            "${index + 1}",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: isActive || isCompleted
                  ? Colors.white
                  : themeData.colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(width: kDefaultPadding / 2),
        if (widget.headerStyle == HeaderStyle.simple)
          Text(
            widget.steps[index].title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
          )
        else if (widget.headerStyle == HeaderStyle.detailed)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Step ${index + 1}",
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: isActive || isCompleted
                      ? (widget.headerTextColor ?? headerColor)
                      : kTextColor,
                ),
              ),
              Text(
                widget.steps[index].title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: textColor,
                ),
              ),
            ],
          ),
        if (!isMobile && index < widget.steps.length - 1)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              height: outlineWidth,
              color: currentStep > index ? headerColor : kTextColor,
            ),
          ),
      ],
    );
  }
}

// Custom Vertical Stepper

class CustomVerticalStepper extends StatefulWidget {
  final List<StepData> steps;
  final Color? headerColor;
  final HeaderStyle headerStyle;
  final VoidCallback? onFinish;
  final Widget Function(
    BuildContext context,
    int currentStep,
    VoidCallback nextStep,
    VoidCallback prevStep,
  )?
  actionBuilder;
  final double? headerFontSize;
  final FontWeight? headerFontWeight;
  final Color? headerTextColor;
  final Color? inactiveColor;
  final Color? lineColor;
  final Color? headerBgColor;
  final Color? nextButtonColor;
  final Color? prevButtonColor;

  const CustomVerticalStepper({
    super.key,
    required this.steps,
    this.headerColor,
    this.headerBgColor,
    this.headerStyle = HeaderStyle.simple,
    this.onFinish,
    this.actionBuilder,
    this.headerFontSize,
    this.headerFontWeight,
    this.headerTextColor,
    this.inactiveColor,
    this.lineColor,
    this.nextButtonColor,
    this.prevButtonColor,
  });

  @override
  State<CustomVerticalStepper> createState() => _CustomVerticalStepperState();
}

class _CustomVerticalStepperState extends State<CustomVerticalStepper> {
  int currentStep = 0;

  void nextStep() {
    final step = widget.steps[currentStep];
    if (step.formKey != null) {
      if (step.formKey!.currentState?.validate() != true) {
        return;
      }
    }
    if (currentStep < widget.steps.length - 1) {
      setState(() => currentStep++);
    } else {
      widget.onFinish?.call();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(widget.steps.length, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step header
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (widget.headerColor ?? kPrimaryColor).withValues(
                      alpha: 0.2,
                    ),
                    width: outlineWidth,
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color:
                      (widget.headerBgColor ??
                              (widget.headerColor ?? kPrimaryColor))
                          .withValues(alpha: 0.1),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding,
                ),
                margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: mediumHeight / 2,
                      backgroundColor: isActive || isCompleted
                          ? widget.headerColor
                          : widget.headerColor!.withValues(alpha: 0.2),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: widget.headerFontSize ?? kBodyMedium,
                          fontWeight: FontWeight.w600,
                          color: isActive || isCompleted
                              ? Colors.white
                              : themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    if (widget.headerStyle == HeaderStyle.simple)
                      Text(
                        widget.steps[index].title,
                        style: TextStyle(
                          fontSize: widget.headerFontSize ?? kBodyMedium,
                          fontWeight:
                              widget.headerFontWeight ??
                              (isActive || isCompleted
                                  ? FontWeight.w600
                                  : FontWeight.w500),
                          color: isActive || isCompleted
                              ? (widget.headerTextColor ?? widget.headerColor)
                              : themeData.colorScheme.onSurface,
                        ),
                      )
                    else if (widget.headerStyle == HeaderStyle.detailed)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Step ${index + 1}",
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: isActive || isCompleted
                                  ? (widget.headerTextColor ??
                                        widget.headerColor)
                                  : kTextColor,
                            ),
                          ),
                          SizedBox(width: kDefaultPadding / 2),
                          Text(
                            widget.steps[index].title,
                            style: TextStyle(
                              fontSize: widget.headerFontSize ?? kBodyMedium,
                              fontWeight:
                                  widget.headerFontWeight ??
                                  (isActive || isCompleted
                                      ? FontWeight.w600
                                      : FontWeight.w500),
                              color: isActive || isCompleted
                                  ? (widget.headerTextColor ??
                                        widget.headerColor)
                                  : themeData.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Step content (only show current step)
              if (isActive)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                    child: widget.steps[index].content,
                  ),
                ),
              // Actions (only show for current step)
              if (isActive)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2 * kDefaultPadding,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: widget.actionBuilder != null
                      ? widget.actionBuilder!(
                          context,
                          currentStep,
                          nextStep,
                          prevStep,
                        )
                      : defaultActions(themeData),
                ),
            ],
          );
        }),
      ],
    );
  }

  Widget defaultActions(ThemeData themeData) {
    final isLast = currentStep == widget.steps.length - 1;
    final lang = Lang.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          FancyIconButton(
            kText: lang.back,
            kTextColor: themeData.colorScheme.onSurface,
            bgColor: widget.prevButtonColor ?? kTableHeaderColor,
            kLeadingIcon: Icons.arrow_back,
            onPressed: prevStep,
          )
        else
          const SizedBox.shrink(),
        FancyIconButton(
          kText: isLast ? lang.finish : lang.next,
          kTextColor: Colors.white,
          bgColor: widget.nextButtonColor ?? kSuccessColor,
          kTrailingIcon: isLast ? Icons.check : Icons.arrow_forward,
          onPressed: nextStep,
        ),
      ],
    );
  }
}

// Custom Vertical Stepper 2 Column

class CustomVerticalStepper2Column extends StatefulWidget {
  final List<StepData> steps;
  final Color? headerColor;
  final HeaderStyle headerStyle;
  final VoidCallback? onFinish;
  final Widget Function(
    BuildContext context,
    int currentStep,
    VoidCallback nextStep,
    VoidCallback prevStep,
  )?
  actionBuilder;
  final double? headerFontSize;
  final FontWeight? headerFontWeight;
  final Color? headerTextColor;
  final Color? inactiveColor;
  final Color? lineColor;
  final Color? headerBgColor;
  final Color? nextButtonColor;
  final Color? prevButtonColor;
  final bool allowStepTap;

  const CustomVerticalStepper2Column({
    super.key,
    required this.steps,
    this.headerColor,
    this.headerBgColor,
    this.headerStyle = HeaderStyle.simple,
    this.onFinish,
    this.actionBuilder,
    this.headerFontSize,
    this.headerFontWeight,
    this.headerTextColor,
    this.inactiveColor,
    this.lineColor,
    this.nextButtonColor,
    this.prevButtonColor,
    this.allowStepTap = false,
  });

  @override
  State<CustomVerticalStepper2Column> createState() =>
      _CustomVerticalStepper2ColumnState();
}

class _CustomVerticalStepper2ColumnState
    extends State<CustomVerticalStepper2Column> {
  int currentStep = 0;

  void nextStep() {
    final step = widget.steps[currentStep];
    if (step.formKey != null) {
      if (step.formKey!.currentState?.validate() != true) {
        return;
      }
    }
    if (currentStep < widget.steps.length - 1) {
      setState(() => currentStep++);
    } else {
      widget.onFinish?.call();
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final inactiveColor = widget.inactiveColor ?? Colors.grey.shade300;
    final lineColor = widget.lineColor ?? widget.headerColor;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < kScreenWidthMd;
        if (isMobile) {
          // Fallback ke stepper vertikal biasa jika layar kecil
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(widget.steps.length, (index) {
                final isActive = index == currentStep;
                final isCompleted = index < currentStep;
                final isLast = index == widget.steps.length - 1;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: widget.allowStepTap
                            ? () {
                                setState(() => currentStep = index);
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 2,
                            horizontal: kDefaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? (widget.headerColor ?? kPrimaryColor)
                                      .withValues(alpha: .08)
                                : Colors.transparent,
                            border: Border.all(
                              width: outlineWidth,
                              color: isActive
                                  ? (widget.headerColor ?? kPrimaryColor)
                                  : isCompleted
                                  ? kSuccessColor
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: stepItem(
                            isActive,
                            isCompleted,
                            index,
                            widget.headerColor ?? kPrimaryColor,
                            inactiveColor,
                            lineColor ?? kPrimaryColor,
                            themeData,
                          ),
                        ),
                      ),
                      if (isActive)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                            horizontal: kDefaultPadding,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                            child: widget.steps[index].content,
                          ),
                        ),
                      if (isActive)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2 * kDefaultPadding,
                            left: kDefaultPadding,
                            right: kDefaultPadding,
                          ),
                          child: widget.actionBuilder != null
                              ? widget.actionBuilder!(
                                  context,
                                  currentStep,
                                  nextStep,
                                  prevStep,
                                )
                              : defaultActions(themeData),
                        ),
                    ],
                  ),
                );
              }),
            ],
          );
        }

        // Desktop/tablet: 2 column
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // step list
            SizedBox(
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(widget.steps.length, (index) {
                  final isActive = index == currentStep;
                  final isCompleted = index < currentStep;
                  final isLast = index == widget.steps.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: isLast ? 0 : kDefaultPadding,
                    ),
                    child: InkWell(
                      onTap: widget.allowStepTap
                          ? () {
                              setState(() => currentStep = index);
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                          horizontal: kDefaultPadding,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? (widget.headerColor ?? kPrimaryColor)
                                    .withValues(alpha: .08)
                              : Colors.transparent,
                          border: Border.all(
                            width: outlineWidth,
                            color: isActive
                                ? (widget.headerColor ?? kPrimaryColor)
                                : isCompleted
                                ? kSuccessColor
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(defaultRadius),
                        ),
                        child: stepItem(
                          isActive,
                          isCompleted,
                          index,
                          widget.headerColor ?? kPrimaryColor,
                          inactiveColor,
                          lineColor ?? kPrimaryColor,
                          themeData,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(width: kDefaultPadding),
            // Kanan: konten step aktif
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                    child: widget.steps[currentStep].content,
                  ),
                  const SizedBox(height: 2 * kDefaultPadding),
                  widget.actionBuilder != null
                      ? widget.actionBuilder!(
                          context,
                          currentStep,
                          nextStep,
                          prevStep,
                        )
                      : defaultActions(themeData),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget defaultActions(ThemeData themeData) {
    final isLast = currentStep == widget.steps.length - 1;
    final lang = Lang.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 0)
          FancyIconButton(
            kText: lang.back,
            kTextColor: themeData.colorScheme.onSurface,
            bgColor: widget.prevButtonColor ?? kTableHeaderColor,
            kLeadingIcon: Icons.arrow_back,
            onPressed: prevStep,
          )
        else
          const SizedBox.shrink(),
        FancyIconButton(
          kText: isLast ? lang.finish : lang.next,
          kTextColor: Colors.white,
          bgColor: widget.nextButtonColor ?? kSuccessColor,
          kTrailingIcon: isLast ? Icons.check : Icons.arrow_forward,
          onPressed: nextStep,
        ),
      ],
    );
  }

  Widget stepItem(
    bool isActive,
    bool isCompleted,
    int index,
    Color headerColor,
    Color inactiveColor,
    Color lineColor,
    ThemeData themeData,
  ) {
    final textColor = isActive || isCompleted
        ? (widget.headerTextColor ?? headerColor)
        : themeData.colorScheme.onSurface;

    final fontWeight =
        widget.headerFontWeight ??
        (isActive || isCompleted ? FontWeight.w600 : FontWeight.w500);

    final fontSize = widget.headerFontSize ?? kBodyMedium;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   radius: mediumHeight / 2,
        //   backgroundColor:
        //       isActive || isCompleted ? headerColor : kTableHeaderColor,
        //   child: Text(
        //     "${index + 1}",
        //     style: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.w600,
        //       color: isActive || isCompleted
        //           ? Colors.white
        //           : themeData.colorScheme.onSurface,
        //     ),
        //   ),
        // ),
        Icon(
          (isActive || isCompleted) ? Icons.check_circle : Icons.cancel,
          color: (isActive || isCompleted) ? kSuccessColor : kErrorColor,
          size: 16,
        ),
        const SizedBox(width: kDefaultPadding / 2),
        if (widget.headerStyle == HeaderStyle.simple)
          Text(
            widget.steps[index].title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
          )
        else if (widget.headerStyle == HeaderStyle.detailed)
          Row(
            children: [
              Text(
                "Step ${index + 1}",
                style: TextStyle(
                  fontSize: kBodyMedium,
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: kDefaultPadding / 2),
              Text(
                widget.steps[index].title,
                style: TextStyle(
                  fontSize: kBodyMedium,
                  fontWeight: FontWeight.w500,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

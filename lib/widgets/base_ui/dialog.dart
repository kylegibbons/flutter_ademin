import 'dart:math';

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:lottie/lottie.dart';

enum DialogAnimation {
  none,
  fadeInRight,
  fadeInLeft,
  fadeInTop,
  fadeInBottom,
  flip,
  zoom,
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  Widget? actions, // Misal Row atau Column
  double width = 520,
  bool isFullscreen = false,
  bool showCloseButton = false,
  bool isDismissible = true,
  DialogAnimation animation = DialogAnimation.none,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: "CustomDialog",
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return _buildAnimatedDialog(
        context,
        anim1,
        animation,
        _DialogLayout(
          title: title,
          content: content,
          actions: actions,
          width: width,
          isFullscreen: isFullscreen,
          showCloseButton: showCloseButton,
        ),
      );
    },
  );
}

Widget _buildAnimatedDialog(
  BuildContext context,
  Animation<double> anim,
  DialogAnimation type,
  Widget child,
) {
  switch (type) {
    case DialogAnimation.fadeInLeft:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.fadeInRight:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.fadeInTop:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.fadeInBottom:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.zoom:
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutBack)),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.flip:
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY((1 - anim.value) * pi / 1),
        child: FadeTransition(opacity: anim, child: child),
      );
    case DialogAnimation.none:
      return FadeTransition(opacity: anim, child: child);
  }
}

class _DialogLayout extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? actions;
  final double width;
  final bool isFullscreen;
  final bool showCloseButton;

  const _DialogLayout({
    required this.title,
    required this.content,
    this.actions,
    required this.width,
    required this.isFullscreen,
    required this.showCloseButton,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isFullscreen ? MediaQuery.of(context).size.width : width,
          height: isFullscreen ? MediaQuery.of(context).size.height : null,
          margin: EdgeInsets.only(
            top: isFullscreen ? MediaQuery.of(context).padding.top : 0,
            bottom: isFullscreen ? MediaQuery.of(context).padding.bottom : 0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(
              isFullscreen ? 0 : defaultRadius,
            ),
          ),
          child: Column(
            mainAxisSize: isFullscreen ? MainAxisSize.max : MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: kDefaultPadding / 4,
                  bottom: kDefaultPadding / 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: kDefaultPadding,
                        ),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: kBodyLarge,
                            color: themeData.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    showCloseButton
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: kDefaultPadding / 4,
                            ),
                            child: CustomIconButton(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icons.close,
                              shape: ButtonShape.circle,
                            ),
                          )
                        : SizedBox(height: mediumHeight),
                  ],
                ),
              ),

              // Content
              isFullscreen
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: SingleChildScrollView(child: content),
                      ),
                    )
                  : Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: SingleChildScrollView(child: content),
                      ),
                    ),
              // Actions
              if (actions != null) ...[
                if (isFullscreen) const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  child: actions,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  final double width;
  final double height;
  final Widget content;
  final List<Widget>? actionButtons;
  final bool showCloseButton;
  final bool isDismissible;
  final bool isFullScreen;
  final DialogAnimation animation;
  final MainAxisAlignment? actionAlignment;
  final EdgeInsets? contentPadding;

  const CustomDialog({
    super.key,
    this.width = 480,
    this.height = 480,
    required this.content,
    this.actionButtons,
    this.showCloseButton = false,
    this.isDismissible = true,
    this.isFullScreen = false,
    this.animation = DialogAnimation.none,
    this.actionAlignment = MainAxisAlignment.end,
    this.contentPadding,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the shaking animation using Tween
    _shakeAnimation =
        Tween<double>(begin: 0, end: 24).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _shakeController.reverse();
          }
        });

    _setupAnimation();
    _animationController.forward();
  }

  void _setupAnimation() {
    switch (widget.animation) {
      case DialogAnimation.none:
        _slideAnimation = Tween(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(_animationController);
        _fadeAnimation = Tween(
          begin: 1.0,
          end: 1.0,
        ).animate(_animationController);
        break;
      case DialogAnimation.fadeInRight:
        _slideAnimation = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(_animationController);
        break;
      case DialogAnimation.fadeInLeft:
        _slideAnimation = Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(_animationController);
        break;
      case DialogAnimation.fadeInTop:
        _slideAnimation = Tween(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(_animationController);
        break;
      case DialogAnimation.fadeInBottom:
        _slideAnimation = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(_animationController);
        break;
      case DialogAnimation.flip:
        _fadeAnimation = Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(_animationController);
        break;
      case DialogAnimation.zoom:
        _fadeAnimation = Tween(
          begin: 0.5,
          end: 1.0,
        ).animate(_animationController);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (!widget.isDismissible) {
          _shakeController.forward(); // Trigger shake animation
        }
      },
      child: Container(
        width: widget.isDismissible
            ? (widget.isFullScreen ? MediaQuery.of(context).size.width : null)
            : double.infinity,
        color: widget.isDismissible ? null : Colors.transparent,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            // Inside AnimatedBuilder
            Widget animatedChild = child!;
            // Apply main animation (only if animation is not 'none')
            if (widget.animation != DialogAnimation.none) {
              if (widget.animation == DialogAnimation.zoom) {
                animatedChild = ScaleTransition(
                  scale: _fadeAnimation,
                  child: child,
                );
              } else if (widget.animation == DialogAnimation.flip) {
                animatedChild = AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final rotationValue = _animationController.value * pi;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(rotationValue),
                      child: rotationValue <= pi / 2
                          ? child
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(pi),
                              child: child,
                            ),
                    );
                  },
                  child: FadeTransition(opacity: _fadeAnimation, child: child),
                );
              } else {
                animatedChild = SlideTransition(
                  position: _slideAnimation,
                  child: child,
                );
              }
            }

            // Apply Shake Effect (Independent of main animation)
            if (!widget.isDismissible) {
              animatedChild = AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  final offset = _shakeAnimation.value;
                  return Transform.translate(
                    offset: Offset(offset, 0), // Shake horizontally
                    child: child,
                  );
                },
                child: animatedChild,
              );
            }

            return animatedChild;
          },
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: widget.isFullScreen ? 0 : kDefaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            backgroundColor: themeData.colorScheme.surface,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: widget.isFullScreen
                    ? MediaQuery.of(context).size.width
                    : widget.width,
                maxHeight: widget.isFullScreen
                    ? MediaQuery.of(context).size.height
                    : widget.height,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        widget.contentPadding ??
                        EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisSize: widget.isFullScreen
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      children: [
                        // content
                        Expanded(child: widget.content),

                        // action buttons
                        if (widget.actionButtons != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: kDefaultPadding,
                            ),
                            child: OverflowBar(
                              alignment:
                                  widget.actionAlignment ??
                                  MainAxisAlignment.end,
                              children: widget.actionButtons!,
                            ),
                          ),
                      ],
                    ),
                  ),

                  //close button
                  if (widget.showCloseButton)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: kDefaultPadding / 4,
                        end: kDefaultPadding / 4,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: CustomIconButton(
                          icon: Icons.close,
                          shape: ButtonShape.circle,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }
}

// dialog content example, you can use this widget for simple dialog

class DialogContent extends StatelessWidget {
  const DialogContent({
    super.key,
    required this.title,
    this.subTitle,
    required this.content,
  });

  final String title;
  final String? subTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: kBodyLarge,
            color: themeData.colorScheme.onSurface,
          ),
        ),
        if (subTitle != null)
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            child: Text(
              subTitle!,
              style: TextStyle(
                fontSize: kBodyLarge,
                fontWeight: FontWeight.w500,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
        const SizedBox(height: kDefaultPadding),
        Expanded(child: SingleChildScrollView(child: content)),
      ],
    );
  }
}

/// MODAL CONTENT EXAMPLE

// transaction success

class TransactionSuccess extends StatelessWidget {
  const TransactionSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: 520,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4 * kDefaultPadding),

          // Icon
          SizedBox(
            width: 120,
            height: 120,
            child: DotLottieLoader.fromAsset(
              "assets/animations/wallet.lottie",
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(height: 1.5 * kDefaultPadding),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              "Your Payment Successful!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kHeadlineSmall,
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              "Your transaction has been completed successfully.\n"
              "The payment has been received and confirmed.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: kBodyLarge),
            ),
          ),
          const SizedBox(height: 1.5 * kDefaultPadding),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  kText: 'New Transaction',
                  bgColor: kPrimaryColor,
                  kTextColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(width: kDefaultPadding),
                CustomOutlinedButton(
                  kText: 'Copy Tracking Link',
                  outlineColor: kSuccessColor,
                  kLeadingIcon: Icons.link,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 3 * kDefaultPadding),

          // Invite friends
          Container(
            decoration: BoxDecoration(color: kTableHeaderColor),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 1.2 * kDefaultPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enjoying our service? ",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                  GestureDetector(
                    onTap: () {
                      // invite friends action
                    },
                    child: Text(
                      "Invite Friends",
                      style: TextStyle(
                        color: kInfoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// subscribe banner

class SubscribeBanner extends StatefulWidget {
  const SubscribeBanner({super.key});

  @override
  State<SubscribeBanner> createState() => _SubscribeBannerState();
}

class _SubscribeBannerState extends State<SubscribeBanner> {
  bool isApproved = false;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 480,
            height: 420,
            padding: const EdgeInsets.symmetric(
              horizontal: 3 * kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                RichText(
                  text: TextSpan(
                    text: "Subscribe today and enjoy ",
                    style: TextStyle(
                      fontSize: kHeadlineSmall,
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "23% off ",
                        style: TextStyle(
                          color: kErrorColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: "your first experience!"),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),

                // Subtitle
                Text(
                  "Stay connected with the latest updates, exclusive features, and special offers. Get early access to new releases and never miss out on what’s coming next.",
                  style: TextStyle(color: themeData.colorScheme.onSurface),
                ),
                const SizedBox(height: kDefaultPadding),

                // Email field + Button
                ActionInputField(
                  hintText: "Enter your email",
                  buttonText: "Subscribe Now",
                  buttonColor: kPrimaryColor,
                  onSubmit: (value) {
                    debugPrint("Subscribed!");
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                // Checkbox
                CustomCheckbox(
                  label:
                      'Get instant updates on features, events, and promotions.',
                  value: isApproved,
                  onChanged: (newValue) {
                    setState(() {
                      isApproved = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (mediaQueryData.size.width >= kScreenWidthXxl)
            SizedBox(
              width: 480,
              height: 420,
              child: Expanded(
                child: Image.asset(
                  "assets/images/success_team.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// subscribe banner

class SubscribeBanner1 extends StatefulWidget {
  const SubscribeBanner1({super.key});

  @override
  State<SubscribeBanner1> createState() => _SubscribeBanner1State();
}

class _SubscribeBanner1State extends State<SubscribeBanner1> {
  bool isApproved = false;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 480,
            height: 420,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 3 * kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  // Title
                  RichText(
                    text: TextSpan(
                      text: "Subscribe today and enjoy ",
                      style: TextStyle(
                        fontSize: kHeadlineSmall,
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "23% off ",
                          style: TextStyle(
                            color: kErrorColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: "your first experience!"),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),

                  // Subtitle
                  Text(
                    "Stay connected with the latest updates, exclusive features, and special offers. Get early access to new releases and never miss out on what’s coming next.",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                  const SizedBox(height: kDefaultPadding),

                  // Email field + Button
                  ActionInputField(
                    hintText: "Enter your email",
                    buttonText: "Subscribe Now",
                    buttonColor: kPrimaryColor,
                    onSubmit: (value) {
                      debugPrint("Subscribed!");
                    },
                  ),
                  const SizedBox(height: kDefaultPadding),

                  // Checkbox
                  CustomCheckbox(
                    label:
                        'Get instant updates on features, events, and promotions.',
                    value: isApproved,
                    onChanged: (newValue) {
                      setState(() {
                        isApproved = newValue!;
                      });
                    },
                  ),

                  Spacer(),
                ],
              ),
            ),
          ),
          if (mediaQueryData.size.width >= kScreenWidthXxl)
            SizedBox(
              width: 480,
              height: 420,
              child: Expanded(
                child: Image.asset(
                  "assets/images/success_team.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// warning dialog

class WarningDialog extends StatelessWidget {
  const WarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: 520,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4 * kDefaultPadding),
          SizedBox(
            width: 120,
            height: 120,
            child: DotLottieLoader.fromAsset(
              "assets/animations/alert.lottie",
              frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                if (dotlottie != null) {
                  return Lottie.memory(dotlottie.animations.values.single);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            "Important Warning!",
            style: TextStyle(
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: kHeadlineSmall,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          const Center(
            child: Text(
              "This action is irreversible. Are you sure you want to proceed?",
              style: TextStyle(fontSize: kBodyLarge),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 2 * kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SoftButton(
                kText: 'Cancel',
                bgColor: kSuccessColor,
                kLeadingIcon: Icons.cancel_outlined,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: kDefaultPadding),
              CustomOutlinedButton(
                kText: 'Proceed',
                outlineColor: kErrorColor,
                kLeadingIcon: Icons.arrow_circle_right_outlined,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: 4 * kDefaultPadding),
        ],
      ),
    );
  }
}

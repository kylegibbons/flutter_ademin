import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/html_render.dart';

// notification toast

class NotificationToast {
  static final List<OverlayEntry> _activeToasts = [];
  //show custom toast
  static void showToast({
    required BuildContext context,
    required String avatarUrl,
    required String message,
    required IconData icon,
    String title = 'New Notifications',
    bool showCloseButton = true,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
    Color? iconColor,
    double width = 320,
    bool singleToast = true,
    bool localAvatar = false,
  }) {
    // If single toast mode, remove all existing toasts
    if (singleToast && _activeToasts.isNotEmpty) {
      final active = List<OverlayEntry>.from(_activeToasts);
      for (var entry in active) {
        entry.remove();
      }
      _activeToasts.clear();
    }

    // Calculate vertical offset for stacking toasts
    double offset =
        _activeToasts.length * 132.0; // Adjust this value for spacing

    // Declare overlayEntry as late to be initialized later
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => NotificationToastWidget(
        title: title,
        avatarUrl: avatarUrl,
        localAvatar: localAvatar,
        icon: icon,
        message: message,
        iconColor: iconColor ?? kPrimaryColor,
        duration: duration,
        alignment: alignment,
        offset: offset,
        showCloseButton: showCloseButton,
        width: width,
        overlayEntry: overlayEntry,
      ),
    );

    _activeToasts.add(overlayEntry);
    Overlay.of(context).insert(overlayEntry);
  }
}

class NotificationToastWidget extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final TextStyle? textStyle;
  final Duration duration;
  final Alignment alignment;
  final double offset;
  final bool? showCloseButton; // Option to show close button

  final double? width;
  final OverlayEntry overlayEntry;

  final String avatarUrl;
  final bool localAvatar;
  final String timeAgo;

  const NotificationToastWidget({
    super.key,
    required this.title,
    required this.message,
    required this.iconColor,
    this.textStyle,
    required this.duration,
    required this.alignment,
    required this.offset,
    required this.icon,
    this.showCloseButton,
    this.width,
    required this.overlayEntry,
    this.avatarUrl = "",
    required this.localAvatar,
    this.timeAgo = "a few seconds ago",
  });

  @override
  State<NotificationToastWidget> createState() =>
      _NotificationToastWidgetState();
}

class _NotificationToastWidgetState extends State<NotificationToastWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = true; // Track the visibility of the toast
  late Timer _dismissTimer; // Timer to manage toast dismissal

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin:
          widget.alignment == Alignment.topCenter ||
              widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.topLeft
          ? const Offset(0, -1) // Slide down from the top
          : const Offset(0, 1), // Slide up from the bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation when the widget is initialized
    _controller.forward();

    // Dismiss the toast after the given duration
    _dismissTimer = Timer(
      widget.duration - const Duration(milliseconds: 300),
      () {
        if (mounted) {
          _closeToast();
        }
      },
    );
  }

  // This method will handle both manual and automatic closing
  void _closeToast() {
    if (_controller.isAnimating || !_isVisible) return;
    if (!NotificationToast._activeToasts.contains(widget.overlayEntry)) return;

    _controller.reverse().then((_) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _isVisible = false;
        });
        // Remove from overlay and active toasts immediately
        widget.overlayEntry.remove();
        NotificationToast._activeToasts.remove(widget.overlayEntry);
        // Cancel the dismiss timer
        _dismissTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer.cancel(); // Cancel the timer if it’s still active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    // If the toast is not visible, do not show it in the stack
    if (!_isVisible) return const SizedBox.shrink();
    return Positioned(
      top:
          (widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.topCenter)
          ? widget
                .offset // Apply the vertical offset for top alignments (including topCenter)
          : null,
      bottom:
          (widget.alignment == Alignment.bottomRight ||
              widget.alignment == Alignment.bottomLeft ||
              widget.alignment == Alignment.bottomCenter)
          ? widget
                .offset // Apply the vertical offset for bottom alignments (including bottomCenter)
          : null,
      left:
          (widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.bottomLeft)
          ? 0.0 // Align to the left for topLeft and bottomLeft
          : (widget.alignment == Alignment.topCenter ||
                widget.alignment == Alignment.bottomCenter)
          ? MediaQuery.of(context).size.width * 0.5 -
                150 *
                    0.5 // Center horizontally for topCenter/bottomCenter
          : null,
      right:
          (widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.bottomRight)
          ? 0.0 // Align to the right for topRight and bottomRight
          : null,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Align(
          alignment: widget.alignment,
          child: SlideTransition(
            position: _slideAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: widget.width!,
                decoration: BoxDecoration(
                  color: themeData.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          if (widget.showCloseButton!)
                            CustomIconButton(
                              icon: Icons.close,
                              shape: ButtonShape.circle,
                              buttonColor: kTableHeaderColor,
                              iconColor: themeData.colorScheme.onSurface,
                              size: ButtonSize.small,
                              onTap: _closeToast,
                            ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: widget.avatarUrl.isNotEmpty
                                    ? (widget.localAvatar
                                          ? AssetImage(widget.avatarUrl)
                                          : NetworkImage(widget.avatarUrl))
                                    : null,
                                backgroundColor: kTableHeaderColor,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      themeData.colorScheme.surface,
                                  child: Icon(
                                    widget.icon,
                                    size: 16,
                                    color: widget.iconColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: kDefaultPadding / 2),

                          // Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Message
                                HtmlRender(
                                  data: widget.message,
                                  bodyTextColor:
                                      themeData.colorScheme.onSurface,
                                ),
                                const SizedBox(height: kDefaultPadding / 4),
                                // Time
                                Text(
                                  widget.timeAgo,
                                  style: TextStyle(
                                    fontSize: kBodySmall,
                                    color: kInfoColor,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// default toast

class Toast {
  static final List<OverlayEntry> _activeToasts = [];
  //show custom toast
  static void showToast({
    required BuildContext context,
    required String message,
    required IconData icon,
    bool showCloseButton = false,
    bool bottomBorder = false,
    bool showProgress = false,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
    Color? color,
    double width = 300,
    bool singleToast = true,
  }) {
    // If single toast mode, remove all existing toasts
    if (singleToast && _activeToasts.isNotEmpty) {
      final active = List<OverlayEntry>.from(_activeToasts);
      for (var entry in active) {
        entry.remove();
      }
      _activeToasts.clear();
    }

    // Calculate vertical offset for stacking toasts
    double offset =
        _activeToasts.length * 60.0; // Adjust this value for spacing

    // Declare overlayEntry as late to be initialized later
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        icon: icon,
        message: message,
        color: color ?? kPrimaryColor,
        duration: duration,
        alignment: alignment,
        offset: offset,
        showCloseButton: showCloseButton,
        bottomBorder: bottomBorder,
        showProgress: showProgress,
        width: width,
        overlayEntry: overlayEntry,
      ),
    );

    _activeToasts.add(overlayEntry);
    Overlay.of(context).insert(overlayEntry);
  }
}

//toast widget

class ToastWidget extends StatefulWidget {
  final IconData icon;
  final String message;
  final Color color;
  final TextStyle? textStyle;
  final Duration duration;
  final Alignment alignment;
  final double offset;
  final bool? showCloseButton; // Option to show close button
  final bool? bottomBorder;
  final bool? showProgress;
  final double? width;
  final OverlayEntry overlayEntry;

  const ToastWidget({
    super.key,
    required this.message,
    required this.color,
    this.textStyle,
    required this.duration,
    required this.alignment,
    required this.offset,
    required this.icon,
    this.showCloseButton,
    this.bottomBorder,
    this.showProgress,
    this.width,
    required this.overlayEntry,
  });

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _progressController;
  bool _isVisible = true; // Track the visibility of the toast
  late Timer _dismissTimer; // Timer to manage toast dismissal

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin:
          widget.alignment == Alignment.topCenter ||
              widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.topLeft
          ? const Offset(0, -1) // Slide down from the top
          : const Offset(0, 1), // Slide up from the bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the animation when the widget is initialized
    _controller.forward();

    // Progress animation for the progress bar
    _progressController = AnimationController(
      vsync: this,
      duration:
          widget.duration -
          const Duration(milliseconds: 300), // Match the widget.duration
    );

    // Start the progress animation
    _progressController.forward();

    // Dismiss the toast after the given duration
    _dismissTimer = Timer(
      widget.duration - const Duration(milliseconds: 300),
      () {
        if (mounted) {
          _closeToast();
        }
      },
    );
  }

  // This method will handle both manual and automatic closing
  void _closeToast() {
    if (_controller.isAnimating || !_isVisible) return;
    if (!Toast._activeToasts.contains(widget.overlayEntry)) return;

    _controller.reverse().then((_) {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _isVisible = false;
        });
        // Remove from overlay and active toasts immediately
        widget.overlayEntry.remove();
        Toast._activeToasts.remove(widget.overlayEntry);
        // Cancel the dismiss timer
        _dismissTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer.cancel(); // Cancel the timer if it’s still active
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    // If the toast is not visible, do not show it in the stack
    if (!_isVisible) return const SizedBox.shrink();
    return Positioned(
      top:
          (widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.topCenter)
          ? widget
                .offset // Apply the vertical offset for top alignments (including topCenter)
          : null,
      bottom:
          (widget.alignment == Alignment.bottomRight ||
              widget.alignment == Alignment.bottomLeft ||
              widget.alignment == Alignment.bottomCenter)
          ? widget
                .offset // Apply the vertical offset for bottom alignments (including bottomCenter)
          : null,
      left:
          (widget.alignment == Alignment.topLeft ||
              widget.alignment == Alignment.bottomLeft)
          ? 0.0 // Align to the left for topLeft and bottomLeft
          : (widget.alignment == Alignment.topCenter ||
                widget.alignment == Alignment.bottomCenter)
          ? MediaQuery.of(context).size.width * 0.5 -
                150 *
                    0.5 // Center horizontally for topCenter/bottomCenter
          : null,
      right:
          (widget.alignment == Alignment.topRight ||
              widget.alignment == Alignment.bottomRight)
          ? 0.0 // Align to the right for topRight and bottomRight
          : null,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Align(
          alignment: widget.alignment,
          child: SlideTransition(
            position: _slideAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: widget.width!,
                decoration: BoxDecoration(
                  color: widget.bottomBorder!
                      ? themeData.colorScheme.surface
                      : widget.color,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultPadding,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            widget.icon,
                            color: widget.bottomBorder!
                                ? widget.color
                                : Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 0.5 * kDefaultPadding),
                          Expanded(
                            child: Text(
                              widget.message,
                              style:
                                  widget.textStyle ??
                                  TextStyle(
                                    color: widget.bottomBorder!
                                        ? widget.color
                                        : Colors.white,
                                  ),
                            ),
                          ),
                          if (widget.showCloseButton!)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: kDefaultPadding,
                              ),
                              child: InkWell(
                                onTap: _closeToast,
                                child: Icon(
                                  Icons.close,
                                  color: widget.bottomBorder!
                                      ? widget.color
                                      : Colors.white.withValues(alpha: 0.4),
                                ), // Close the toast manually
                              ),
                            ),
                        ],
                      ),
                    ),
                    (widget.bottomBorder! && !widget.showProgress!)
                        ? Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),

                    // Progress indicator at the bottom of the toast
                    widget.showProgress!
                        ? AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) => SizedBox(
                              height: 3,
                              child: LinearProgressIndicator(
                                value: _progressController
                                    .value, // Maps to the progress value
                                backgroundColor: themeData.colorScheme.surface,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  widget.color,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

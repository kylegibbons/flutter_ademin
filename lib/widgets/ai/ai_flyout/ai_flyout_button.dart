import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

/// A custom floating AI button that expands on hover, with a badge.
class AIFlyoutButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isActive;
  final int badgeCount;
  final bool hasInsight;
  final bool isLoading;
  final bool disabled;

  const AIFlyoutButton({
    super.key,
    required this.onTap,
    this.isActive = false,
    this.badgeCount = 0,
    this.hasInsight = false,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  State<AIFlyoutButton> createState() => _AIFlyoutButtonState();
}

class _AIFlyoutButtonState extends State<AIFlyoutButton> {
  bool _hovering = false;
  bool _pressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.disabled) return;
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.disabled) return;
    setState(() => _pressed = false);
  }

  void _handleTapCancel() {
    if (widget.disabled) return;
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Colors.white;
    final surface = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;
    final border = onSurface.withValues(alpha: 0.14);
    final Gradient background = widget.disabled
        ? LinearGradient(
            colors: [
              surface.withValues(alpha: 0.72),
              surface.withValues(alpha: 0.60),
            ],
          )
        : kPurpleGradient;

    final expanded = widget.isActive || _hovering;
    final width = expanded ? 170.0 : mediumHeight;
    final scale = widget.disabled
        ? 0.98
        : _pressed
        ? 0.96
        : 1.0;

    return MouseRegion(
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) {
        if (!widget.disabled) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (!widget.disabled) setState(() => _hovering = false);
      },
      child: Semantics(
        button: true,
        enabled: !widget.disabled,
        label: 'Open AI Operator',
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.disabled ? null : widget.onTap,
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: width,
              height: mediumHeight,
              decoration: BoxDecoration(
                gradient: background,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: border, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: onSurface.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 22,
                          color: widget.disabled
                              ? onSurface.withValues(alpha: 0.48)
                              : color,
                        ),
                        ClipRect(
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            child: SizedBox(
                              width: expanded ? 100 : 0,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 180),
                                opacity: expanded ? 1 : 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: kDefaultPadding / 2,
                                  ),
                                  child: Text(
                                    'AI Operator',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: kBodyMedium,
                                      color: widget.disabled
                                          ? onSurface.withValues(alpha: 0.48)
                                          : theme
                                                .colorScheme
                                                .onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.badgeCount > 0 || widget.hasInsight)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: _AIFlyoutBadge(
                        count: widget.badgeCount,
                        showDot: widget.hasInsight,
                        color: kErrorColor,
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
}

/// Badge widget to display a count or a small insight dot.
class _AIFlyoutBadge extends StatelessWidget {
  final int count;
  final bool showDot;
  final Color color;

  const _AIFlyoutBadge({
    required this.count,
    required this.showDot,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final hasCount = count > 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: hasCount
          ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: hasCount
          ? Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            )
          : Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
    );
  }
}

class AiOperatorButton extends StatefulWidget {
  const AiOperatorButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<AiOperatorButton> createState() => _AiOperatorButtonState();
}

class _AiOperatorButtonState extends State<AiOperatorButton>
    with TickerProviderStateMixin {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: _hovering ? 170 : 48,
        height: 48,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: widget.onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),

                ClipRect(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    child: SizedBox(
                      width: _hovering ? 100 : 0,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: _hovering ? 1 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'AI Operator',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

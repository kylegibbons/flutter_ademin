import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class SquareAvatar extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final ImageProvider image;

  const SquareAvatar({
    super.key,
    required this.size,
    this.borderRadius = defaultRadius,
    this.borderWidth,
    this.borderColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderWidth = 0.08 * (size / 2);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: borderColor ?? kTableHeaderColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(borderWidth ?? defaultBorderWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

// Custom Circle Avatar

class CustomCircleAvatar extends StatelessWidget {
  final double radius;
  final double? borderWidth;
  final Color? borderColor;
  final ImageProvider image;

  const CustomCircleAvatar({
    super.key,
    required this.radius,
    this.borderWidth,
    this.borderColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderWidth = 0.08 * radius;
    return CircleAvatar(
      radius: radius + (borderWidth ?? defaultBorderWidth),
      backgroundColor: borderColor ?? kTableHeaderColor,
      child: CircleAvatar(radius: radius, backgroundImage: image),
    );
  }
}

// assignee avatar stack

class AssigneeAvatarStack extends StatelessWidget {
  final List assignees;
  final double size;
  final bool localImg;

  const AssigneeAvatarStack({
    super.key,
    required this.assignees,
    this.size = 32,
    this.localImg = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: (size * 0.6 * assignees.length) + size / 2,
      height: size + 2,
      child: Stack(
        children: List.generate(assignees.length, (index) {
          final member = assignees[index];
          return Positioned(
            left: index * (size * 0.6),
            child: Tooltip(
              message: member.name,
              preferBelow: false,
              child: CircleAvatar(
                radius: (size / 2) + 1,
                backgroundColor: themeData.colorScheme.surface,
                child: CircleAvatar(
                  radius: size / 2,
                  backgroundImage: localImg
                      ? AssetImage(member.avatarUrl)
                      : NetworkImage(member.avatarUrl),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// GroupAvatarToolTip widget with hover effect and tooltip

class GroupAvatarToolTip extends StatefulWidget {
  final List<Map<String, String>> items;
  final double avatarRadius;
  final double overlapOffset;
  final int? maxItems; // Optional limit for maximum displayed items
  final bool localAvatar;

  const GroupAvatarToolTip({
    super.key,
    required this.items,
    this.avatarRadius = 24.0,
    this.overlapOffset = 36.0,
    this.maxItems,
    this.localAvatar = false,
  });

  @override
  State<GroupAvatarToolTip> createState() => _GroupAvatarToolTipState();
}

class _GroupAvatarToolTipState extends State<GroupAvatarToolTip> {
  int _hoveredIndex = -1; // Tracks hovered item index

  @override
  Widget build(BuildContext context) {
    // Limit items if maxItems is set
    final int displayedItemCount =
        widget.maxItems != null && widget.maxItems! < widget.items.length
        ? widget.maxItems!
        : widget.items.length;

    return SizedBox(
      height: 2 * widget.avatarRadius,

      // height: widget.itemSize + 10, // Extra space for hover animation
      child: Stack(
        children: [
          for (int i = 0; i < displayedItemCount; i++)
            HoverableStackedItem(
              index: i,
              itemInfo: widget.items[i],
              localAvatar: widget.localAvatar,
              itemSize: 2 * widget.avatarRadius,
              overlapOffset: widget.overlapOffset,
              isHovered: _hoveredIndex == i,
              onHover: (hover) {
                setState(() {
                  _hoveredIndex = hover ? i : -1;
                });
              },
            ),
          if (widget.maxItems != null && widget.items.length > widget.maxItems!)
            Positioned(
              left: displayedItemCount * widget.overlapOffset,
              child: MoreItemsPlaceholder(
                count: widget.items.length - displayedItemCount,
                itemSize: 2 * widget.avatarRadius,
              ),
            ),
        ],
      ),
    );
  }
}

class HoverableStackedItem extends StatelessWidget {
  final int index;
  final bool isHovered;
  final Function(bool) onHover;
  final Map<String, String> itemInfo;
  final double itemSize;
  final double overlapOffset;
  final bool localAvatar;

  const HoverableStackedItem({
    super.key,
    required this.index,
    required this.isHovered,
    required this.onHover,
    required this.itemInfo,
    required this.itemSize,
    required this.overlapOffset,
    required this.localAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: index * overlapOffset,
      child: MouseRegion(
        onEnter: (_) => onHover(true),
        onExit: (_) => onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: isHovered
              ? Matrix4.translationValues(0, -4, 0) // Slight lift on hover
              : Matrix4.identity(),
          child: Tooltip(
            message: itemInfo['label'] ?? '', // Tooltip shows item label
            preferBelow: false,
            verticalOffset: itemSize / 2,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(color: Colors.white),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  if (isHovered)
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 5), // Shadow for hovered item
                    ),
                ],
              ),
              child: CircleAvatar(
                radius: itemSize / 2,
                backgroundImage: itemInfo['image'] != null
                    ? (localAvatar
                          ? AssetImage(itemInfo['image']!)
                          : NetworkImage(itemInfo['image']!))
                    : null,
                child: itemInfo['image'] == null
                    ? Text(
                        itemInfo['label']?[0] ?? '',
                        style: TextStyle(
                          fontSize: itemSize / 2.5,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoreItemsPlaceholder extends StatelessWidget {
  final int count;
  final double itemSize;

  const MoreItemsPlaceholder({
    super.key,
    required this.count,
    required this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: itemSize / 2,
      backgroundColor: Colors.blueGrey.shade300,
      child: Text(
        '+$count',
        style: TextStyle(
          fontSize: itemSize / 3,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Group Avatar

class GroupAvatar extends StatefulWidget {
  final List<String> imageUrls;
  final List<String>? labels;
  final double avatarSize;
  final double overlapOffset;
  final int maxAvatars;
  final bool showLabel;
  final bool enableHoverShift;
  final Function(int index)? onTap; // Click per avatar
  final VoidCallback? onOverflowTap; // Click on +N
  final Color? borderColor;

  const GroupAvatar({
    super.key,
    required this.imageUrls,
    this.labels,
    this.avatarSize = 48.0,
    this.overlapOffset = 34.0,
    this.maxAvatars = 5,
    this.showLabel = false,
    this.enableHoverShift = true,
    this.onTap,
    this.onOverflowTap,
    this.borderColor,
  });

  @override
  State<GroupAvatar> createState() => _GroupAvatarState();
}

class _GroupAvatarState extends State<GroupAvatar> {
  int _hoveredIndex = -1;

  ImageProvider? _resolveAvatarProvider(String url) {
    final value = url.trim();
    if (value.isEmpty) return null;
    if (value.startsWith('assets/')) {
      return AssetImage(value);
    }
    return NetworkImage(value);
  }

  @override
  Widget build(BuildContext context) {
    final int totalImages = widget.imageUrls.length;
    final int displayCount = totalImages > widget.maxAvatars
        ? widget.maxAvatars
        : totalImages;
    final int overflowCount = totalImages - displayCount;

    // Create a render order list
    // Default: Overflow (-1) at the very end, followed by avatars 0 and up
    List<int> renderOrder = [];
    if (overflowCount > 0) renderOrder.add(-1);
    renderOrder.addAll(List.generate(displayCount, (index) => index));

    // If Avatar is hovered over, move it to the front of the list (end of the list)
    if (widget.enableHoverShift && _hoveredIndex != -1) {
      renderOrder.remove(_hoveredIndex);
      renderOrder.add(_hoveredIndex);
    }

    return SizedBox(
      height: widget.avatarSize + (1 / 18 * widget.avatarSize),
      child: Stack(
        clipBehavior: Clip.none,
        children: renderOrder.map((idx) {
          if (idx == -1) {
            return Positioned(
              key: const ValueKey('overflow_circle'),
              left: displayCount * widget.overlapOffset,
              child: GestureDetector(
                onTap: widget.onOverflowTap,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _buildOverflowCircle(overflowCount),
                ),
              ),
            );
          } else {
            return _buildAvatarItem(idx, widget.imageUrls[idx]);
          }
        }).toList(),
      ),
    );
  }

  Widget _buildAvatarItem(int index, String url) {
    final bool isHovered = _hoveredIndex == index;
    final themeData = Theme.of(context);
    final imageProvider = _resolveAvatarProvider(url);
    final label = widget.labels != null && index < widget.labels!.length
        ? widget.labels![index]
        : '';

    return AnimatedPositioned(
      key: ValueKey('avatar_$index'),
      duration: const Duration(milliseconds: 250),
      left: index * widget.overlapOffset,
      curve: Curves.easeInOut,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredIndex = index),
        onExit: (_) => setState(() => _hoveredIndex = -1),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onTap?.call(index),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(1 / 18 * widget.avatarSize),
                decoration: BoxDecoration(
                  color:
                      widget.borderColor ??
                      themeData.colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (widget.enableHoverShift && isHovered)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                  ],
                ),
                child: AnimatedScale(
                  scale: widget.enableHoverShift && isHovered ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: CircleAvatar(
                    radius: widget.avatarSize / 2,
                    backgroundImage: imageProvider,
                    backgroundColor: imageProvider == null
                        ? themeData.colorScheme.primaryContainer
                        : Colors.grey[200],
                    child: imageProvider == null
                        ? Text(
                            label.isEmpty ? '?' : label[0].toUpperCase(),
                            style: TextStyle(
                              color: themeData.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
              if (widget.showLabel && isHovered && widget.labels != null)
                Positioned(
                  // top: widget.avatarSize + 8,
                  top: -(kDefaultPadding + widget.avatarSize / 2),
                  child: _buildLabel(widget.labels![index]),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onInverseSurface,
          fontSize: kBodySmall,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOverflowCircle(int count) {
    final themeData = Theme.of(context);
    return Container(
      width: widget.avatarSize + 5,
      height: widget.avatarSize + 5,
      decoration: BoxDecoration(
        color: themeData.colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: widget.borderColor ?? themeData.colorScheme.surfaceContainer,
          width: 2.5,
        ),
      ),
      child: Center(
        child: Text(
          '+$count',
          style: TextStyle(
            color: themeData.colorScheme.onInverseSurface,
            fontSize: widget.avatarSize * 0.3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Image search results

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/search/search_result_data.dart';
import 'package:flutter_ademin/demo/page/search/search_result_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';

class ImageSearchResults extends StatefulWidget {
  const ImageSearchResults({super.key});

  @override
  State<ImageSearchResults> createState() => _ImageSearchResultsState();
}

class _ImageSearchResultsState extends State<ImageSearchResults> {
  final int itemsPerPage = 16;
  int currentPage = 1;

  void showGallerySlider({
    required BuildContext context,
    required List<GalleryItem> items,
    required int initialIndex,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return _GallerySliderDialog(items: items, initialIndex: initialIndex);
      },
    );
  }

  void _nextPage() {
    if ((currentPage * itemsPerPage) < imageSearchResultItem.length) {
      setState(() => currentPage++);
    }
  }

  void _prevPage() {
    if (currentPage > 1) {
      setState(() => currentPage--);
    }
  }

  List<GalleryItem> get currentItems {
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, imageSearchResultItem.length);
    return imageSearchResultItem.sublist(start, end);
  }

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxxl) return 6;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);
    return Column(
      children: [
        // search result grid
        GridView.builder(
          padding: EdgeInsets.all(kDefaultPadding),
          itemCount: currentItems.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.5,
            mainAxisSpacing: kDefaultPadding,
            crossAxisSpacing: kDefaultPadding,
          ),
          itemBuilder: (context, index) {
            final item = currentItems[index];
            return GestureDetector(
              onTap: () {
                showGallerySlider(
                  context: context,
                  items: currentItems,
                  initialIndex: index,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      child: Image.asset(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('by '),
                      Text(
                        item.author,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 16,
                        color: kTextColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${item.likes ~/ 100 / 10}K',
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.comment_outlined, size: 16, color: kTextColor),
                      SizedBox(width: 4),
                      Text(
                        '${item.comments ~/ 100 / 10}K',
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),

        // navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentPage > 1)
              CustomIconButton(
                icon: Icons.arrow_back,
                onTap: _prevPage,
                iconColor: themeData.colorScheme.primary,
              ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              child: Text(
                "Page $currentPage",
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
            if (currentPage < videoSearchResults.length / itemsPerPage)
              CustomIconButton(
                icon: Icons.arrow_forward,
                onTap: _nextPage,
                iconColor: themeData.colorScheme.primary,
              ),
          ],
        ),

        SizedBox(height: kDefaultPadding),
      ],
    );
  }
}

// gallery slider dialog

class _GallerySliderDialog extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const _GallerySliderDialog({required this.items, required this.initialIndex});

  @override
  State<_GallerySliderDialog> createState() => _GallerySliderDialogState();
}

class _GallerySliderDialogState extends State<_GallerySliderDialog> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
  }

  void _next() {
    if (_currentIndex < widget.items.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.all(2 * kDefaultPadding),
                child: Center(
                  child: Image.asset(
                    widget.items[index].imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (_currentIndex > 0)
            Positioned(
              left: 20,
              child: IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.white, size: 48),
                onPressed: _previous,
              ),
            ),
          if (_currentIndex < widget.items.length - 1)
            Positioned(
              right: 20,
              child: IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.white, size: 48),
                onPressed: _next,
              ),
            ),
        ],
      ),
    );
  }
}

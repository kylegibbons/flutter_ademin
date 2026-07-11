import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/gallery/gallery_models.dart';
// gallery slider dialog

class GallerySliderDialog extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const GallerySliderDialog({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<GallerySliderDialog> createState() => GallerySliderDialogState();
}

class GallerySliderDialogState extends State<GallerySliderDialog> {
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

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

class CustomCarousel extends StatefulWidget {
  final List<Widget> pages;
  final bool showControls;
  final bool showIndicator;
  final Duration autoSlideInterval;
  final double height;

  const CustomCarousel({
    super.key,
    required this.pages,
    this.showControls = true,
    this.showIndicator = true,
    this.autoSlideInterval = const Duration(seconds: 3),
    required this.height,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    if (widget.autoSlideInterval > Duration.zero) {
      _timer = Timer.periodic(widget.autoSlideInterval, (Timer timer) {
        if (_currentPage < widget.pages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _stopAutoSlide() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void _nextPage() {
    _stopAutoSlide();
    if (_currentPage < widget.pages.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _previousPage() {
    _stopAutoSlide();
    if (_currentPage > 0) {
      _currentPage--;
    } else {
      _currentPage = widget.pages.length - 1;
    }

    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: widget.pages,
            ),
          ),
          if (widget.showControls) ...[
            // Left Arrow Button
            Positioned(
              left: kDefaultPadding,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 32,
                ),
                onPressed: _previousPage,
              ),
            ),
            // Right Arrow Button
            Positioned(
              right: kDefaultPadding,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 32,
                ),
                onPressed: _nextPage,
              ),
            ),
          ],
          if (widget.showIndicator)
            Positioned(
              bottom: kDefaultPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.pages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentPage == index ? 10 : 6,
                    height: _currentPage == index ? 10 : 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

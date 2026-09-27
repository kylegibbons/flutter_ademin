import 'package:flutter/material.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Auth Screen Slider

class AuthScreenSlider extends StatelessWidget {
  const AuthScreenSlider({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Container(
      width: mediaQueryData.size.width >= 960 ? 480 : double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 3 * kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3 * kDefaultPadding),
          Image.asset(AppSettings.logoPath, height: 28.0),
          Spacer(),
          FaIcon(FontAwesomeIcons.quoteLeft, color: kSuccessColor, size: 56),
          const SizedBox(height: kDefaultPadding),
          const CustomCarousel(
            pages: [
              // slider pages
              Text(
                '"The UI is sleek, the components are well-structured, and the customization is seamless. It saved us weeks of development time!"',
                style: TextStyle(fontSize: kBodyLarge, color: Colors.white70),
              ),
              Text(
                '"I’ve tried many admin ui kits, but this one stands out. The design is modern, responsive, and easy to integrate. Highly recommended for any Flutter project!"',
                style: TextStyle(fontSize: kBodyLarge, color: Colors.white70),
              ),
              Text(
                '"The best Flutter admin dashboard ui kits I’ve used! Clean code, smooth performance, and excellent customer support. Perfect for any enterprise application."',
                style: TextStyle(fontSize: kBodyLarge, color: Colors.white70),
              ),
            ],
            showControls: false,
            showIndicator: true,
            autoSlideInterval: Duration(seconds: 3),
            height: 124,
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

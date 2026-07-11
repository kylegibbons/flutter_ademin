//full screen button

import 'package:flutter/material.dart';
import 'package:flutter_ademin/widgets/top_nav_bar/top_nav_button.dart';
import 'package:fullscreen_window/fullscreen_window.dart';

class FullScreenButton extends StatefulWidget {
  const FullScreenButton({super.key});

  @override
  State<FullScreenButton> createState() => _FullScreenButtonState();
}

class _FullScreenButtonState extends State<FullScreenButton> {
  bool isFullScreen = false;

  void setFullScreen(bool fullScreen) async {
    if (fullScreen) {
      await FullScreenWindow.setFullScreen(true);
    } else {
      await FullScreenWindow.setFullScreen(false);
    }

    setState(() {
      isFullScreen = fullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopNavButton(
      tooltipMessage: isFullScreen ? 'Exit Full Screen' : 'Full Screen',
      onTap: () => setFullScreen(!isFullScreen),
      icon: isFullScreen
          ? Icons.fullscreen_exit_outlined
          : Icons.fullscreen_outlined,
    );
  }
}

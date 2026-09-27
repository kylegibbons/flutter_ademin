// RTL Switch

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/providers/app_preferences_provider.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/top_nav_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RTLSwitch extends ConsumerWidget {
  const RTLSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRTL = ref.watch(
      appPreferencesProvider.select((state) => state.isRTL),
    );

    return TopNavButton(
      tooltipMessage: isRTL ? 'Switch to LTR' : 'Switch to RTL',
      onTap: () {
        ref.read(appPreferencesProvider.notifier).toggleRTL();
      },
      icon: isRTL
          ? Icons.format_textdirection_l_to_r
          : Icons.format_textdirection_r_to_l,
    );
  }
}

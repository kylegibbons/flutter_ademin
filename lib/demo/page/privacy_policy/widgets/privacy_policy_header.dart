import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/general.dart';

class PrivacyPolicyHeader extends StatelessWidget {
  const PrivacyPolicyHeader({super.key, required this.lastUpdatedDate});

  final String lastUpdatedDate;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Stack(
      children: [
        // Background with wave
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 240,
            width: double.infinity,
            color: kSecondaryColor.withValues(
              alpha: 0.3,
            ), // Light cream background
          ),
        ),
        // Centered title and subtitle
        Container(
          height: 240,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: kHeadlineMedium,
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Text(
                'Last update: $lastUpdatedDate',
                style: TextStyle(fontSize: kBodyLarge),
              ),
              const SizedBox(height: 2 * kDefaultPadding),
            ],
          ),
        ),
      ],
    );
  }
}

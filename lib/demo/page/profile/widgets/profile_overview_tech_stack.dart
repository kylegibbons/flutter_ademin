import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/profile_data.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/progress.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class TechStack extends StatelessWidget {
  const TechStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          CardHeader(kText: 'Technology Stack', showDivider: false),

          // tech stack list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: techStacks
                  .map(
                    (stack) => TechStackItem(
                      label: stack['label'],
                      progress: stack['progress'],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Tech Stack Item

class TechStackItem extends StatelessWidget {
  final String label;
  final double progress;

  const TechStackItem({super.key, required this.label, required this.progress});

  Color getColorByProgress(double progress) {
    if (progress >= 0.8) return kSuccessColor;
    if (progress >= 0.6) return kWarningColor;
    return kErrorColor;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColorByProgress(progress);

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: kBodyMedium,
              ),
            ),
            Spacer(),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: kBodyMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding / 2),
        LinearProgress(
          value: progress,
          color: color,
          backgroundColor: Colors.blueGrey.shade100,
          height: 8,
          borderRadius: BorderRadius.circular(50),
          semanticsLabel: 'Loading progress',
          isAnimated: true,
          animationDuration: Duration(seconds: 2),
          curve: Curves.elasticIn,
        ),
        SizedBox(height: kDefaultPadding),
      ],
    );
  }
}

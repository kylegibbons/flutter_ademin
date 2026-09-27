import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_data.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_project_card.dart';
// Project Grid

class ProjectContent extends StatelessWidget {
  const ProjectContent({super.key});

  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxxl) return 6;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: GridView.builder(
          itemCount: projects.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: kDefaultPadding,
            mainAxisSpacing: kDefaultPadding,
            mainAxisExtent: 144,
          ),
          itemBuilder: (context, index) {
            final project = projects[index];
            return ProjectCard(
              project: project,
              onTap: () {
                // handle tap
              },
            );
          },
        ),
      ),
    );
  }
}

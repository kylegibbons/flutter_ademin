import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_data.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/profile_project_card.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';

// project slider

class ProjectSlider extends StatefulWidget {
  const ProjectSlider({super.key});

  @override
  State<ProjectSlider> createState() => _ProjectSliderState();
}

class _ProjectSliderState extends State<ProjectSlider> {
  final ScrollController _scrollController = ScrollController();

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // header
          CardHeader(
            kText: 'Projects',
            showDivider: false,
            kWidget: Padding(
              padding: const EdgeInsetsDirectional.only(end: kDefaultPadding),
              child: Row(
                children: [
                  InkWell(
                    onTap: scrollLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(kDefaultPadding / 4),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  InkWell(
                    onTap: scrollRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(kDefaultPadding / 4),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 144,
            margin: EdgeInsetsDirectional.only(
              start: kDefaultPadding,
              end: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: projects.take(5).length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == projects.length - 1 ? 0 : kDefaultPadding,
                  ),
                  child: ProjectCard(
                    project: project,
                    onTap: () {
                      // handle tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

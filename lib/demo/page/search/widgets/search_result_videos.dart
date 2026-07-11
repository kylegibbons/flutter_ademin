// video search results

import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/search/search_result_data.dart';
import 'package:flutter_ademin/demo/page/search/search_result_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/base_ui/html_embed_stub.dart';

class VideoSearchResults extends StatefulWidget {
  const VideoSearchResults({super.key});

  @override
  State<VideoSearchResults> createState() => _VideoSearchResultsState();
}

class _VideoSearchResultsState extends State<VideoSearchResults> {
  final int itemsPerPage = 5;
  int currentPage = 1;

  // page navigation

  void _nextPage() {
    if ((currentPage * itemsPerPage) < videoSearchResults.length) {
      setState(() => currentPage++);
    }
  }

  void _prevPage() {
    if (currentPage > 1) {
      setState(() => currentPage--);
    }
  }

  List<VideoSearchResultItem> get currentItems {
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, videoSearchResults.length);
    return videoSearchResults.sublist(start, end);
  }

  // format number

  String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    return Column(
      children: [
        ListView.builder(
          itemCount: currentItems.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = currentItems[index];
            return Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kDefaultPadding / 2,
                bottom: index == currentItems.length - 1 ? 0 : kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  InkWell(
                    onTap: () {},
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyLarge,
                        color: themeData.colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 4),

                  // url
                  InkWell(
                    onTap: () {},
                    child: Text(
                      item.url,
                      style: TextStyle(color: kSuccessColor),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      double availableWidth =
                          constraints.maxWidth - kDefaultPadding;
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: mediaQueryData.size.width > kScreenWidthXxl
                                ? availableWidth * 0.3
                                : constraints.maxWidth * 1,
                            child:
                                // video thumbnail
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    defaultRadius,
                                  ),
                                  child: SizedBox(
                                    child: HtmlEmbed(
                                      url: item.videoUrl,
                                      aspectRatio: 16 / 9,
                                    ),
                                  ),
                                ),
                          ),
                          SizedBox(
                            width: mediaQueryData.size.width > kScreenWidthXxl
                                ? availableWidth * 0.7
                                : constraints.maxWidth * 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // description
                                Text(
                                  item.description,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 5,
                                ),
                                SizedBox(
                                  height: kDefaultPadding / 2,
                                ), // divider
                                Divider(height: kDefaultPadding),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // likes
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 16,
                                      color: kTextColor,
                                    ),
                                    SizedBox(width: kDefaultPadding / 4),
                                    Text(formatNumber(item.likes)),

                                    SizedBox(width: kDefaultPadding),

                                    // comments
                                    Icon(
                                      Icons.comment_outlined,
                                      size: 16,
                                      color: kTextColor,
                                    ),
                                    SizedBox(width: kDefaultPadding / 4),
                                    Text(formatNumber(item.comments)),
                                    SizedBox(width: kDefaultPadding),

                                    // author
                                    Icon(
                                      Icons.person_outline,
                                      size: 16,
                                      color: kTextColor,
                                    ),
                                    SizedBox(width: kDefaultPadding / 4),
                                    Text(item.author),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),

        SizedBox(height: kDefaultPadding),

        // pages navigations
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

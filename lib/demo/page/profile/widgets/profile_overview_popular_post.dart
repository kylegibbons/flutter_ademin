import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/profile/profile_data.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/demo/page/profile/widgets/popup_menu_button.dart';

class PopularPost extends StatelessWidget {
  const PopularPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          CardHeader(
            kText: 'Popular Posts',
            showDivider: false,
            kWidget: MorePopUpMenu(),
          ),

          // popular post list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: PopularPostList(),
          ),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

// popular post list

class PopularPostList extends StatelessWidget {
  const PopularPostList({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: popularPosts.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final post = popularPosts[index];
        final isLast = index == popularPosts.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : kDefaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  post.imageUrl,
                  height: 48,
                  width: 64,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: kDefaultPadding),

              // Title + Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Text(post.date),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

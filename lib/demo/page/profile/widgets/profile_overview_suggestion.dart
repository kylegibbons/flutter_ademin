import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/profile/profile_data.dart';
import 'package:flutter_ademin/demo/page/profile/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class FriendSuggestion extends StatelessWidget {
  const FriendSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            CardHeader(
              kText: 'Suggestions',
              showDivider: false,
              kWidget: MorePopUpMenu(),
            ),

            // suggestions list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SuggestionsList(),
            ),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

// suggestion list

class SuggestionsList extends StatelessWidget {
  const SuggestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: suggestions.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = suggestions[index];
        final isLast = index == popularPosts.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : kDefaultPadding),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(item.imageUrl),
              ),
              SizedBox(width: kDefaultPadding),

              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    Text(item.role),
                  ],
                ),
              ),

              // Action button
              InkWell(
                onTap: () {},
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: kSuccessColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.person_add_alt_outlined,
                    size: 16,
                    color: kSuccessColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

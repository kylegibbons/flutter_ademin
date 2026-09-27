import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/page/team/team_models.dart';
import 'package:flutkit_ademin/demo/page/team/widgets/popup_menu_button.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';

class ProfileCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onFavoriteTap;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top with background and icons
          Stack(
            children: [
              // background image
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(defaultRadius),
                  ),
                  image: DecorationImage(
                    image: AssetImage(profile.backgroundUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // favorite button
              // PositionedDirectional(
              //   start: kDefaultPadding / 2,
              //   top: kDefaultPadding / 2,
              //   child: GestureDetector(
              //     onTap: onFavoriteTap,
              //     child: CircleAvatar(
              //       backgroundColor: Colors.white.withValues(alpha: 0.8),
              //       radius: 14,
              //       child: Icon(
              //         Icons.star,
              //         size: 16,
              //         color: profile.isFavorite ? Colors.amber : Colors.grey,
              //       ),
              //     ),
              //   ),
              // ),

              // popup menu
              PositionedDirectional(end: 0, top: 0, child: TeamCardPopUpMenu()),

              // profile picture
              Positioned(
                top: 42,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 48,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage(profile.avatarUrl),
                  ),
                ),
              ),
            ],
          ),

          // name, position, and stats
          const SizedBox(height: 2 * kDefaultPadding),
          Text(
            profile.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: kBodyLarge,
              color: themeData.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(profile.role),
          const SizedBox(height: 2 * kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // projects number
              Column(
                children: [
                  Text(
                    profile.projects.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 4),
                  const Text("Projects"),
                ],
              ),
              const VerticalDivider(width: 1, thickness: 1),
              // task naumber
              Column(
                children: [
                  Text(
                    profile.tasks.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: kBodyLarge,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding / 4),
                  const Text("Tasks"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 2 * kDefaultPadding),

          // View profile button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FlatButton(
              kText: 'View Profile',
              kTextColor: themeData.colorScheme.onSurface,
              bgColor: themeData.colorScheme.primary.withValues(alpha: 0.1),
              isFullWidth: true,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

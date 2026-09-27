import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/top_nav_bar/top_nav_button.dart';

/// App Grid selector button ///

// App Grid Data Model
class AppItem {
  final String appImg, appTitle;

  AppItem({required this.appImg, required this.appTitle});
}

// app grid mockup data
List<AppItem> appItems = [
  AppItem(appImg: 'assets/images/mail_chimp.png', appTitle: 'Mail Chimp'),
  AppItem(appImg: 'assets/images/slack.png', appTitle: 'Slack'),
  AppItem(appImg: 'assets/images/dribbble.png', appTitle: 'Dribbble'),
  AppItem(appImg: 'assets/images/dropbox.png', appTitle: 'Dropbox'),
  AppItem(appImg: 'assets/images/github.png', appTitle: 'GitHub'),
  AppItem(appImg: 'assets/images/bitbucket.png', appTitle: 'Bitbucket'),
];

// App Grid Selector Button UI

class AppSelectorButton extends StatelessWidget {
  AppSelectorButton({super.key});

  final GlobalKey<PopupMenuButtonState> popupAppSelector =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);

    return PopupMenuButton(
      key: popupAppSelector,
      splashRadius: 0.0,
      tooltip: '',
      position: PopupMenuPosition.under,
      color: themeData.colorScheme.surface,
      constraints: BoxConstraints(
        maxWidth: mediaQueryData.size.width <= kScreenWidthMd
            ? mediaQueryData.size.width
            : 360,
      ),
      popUpAnimationStyle: AnimationStyle.noAnimation,
      itemBuilder: (context) {
        // Adding the header
        final header = PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favorite Apps',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                  fontSize: kBodyMedium,
                ),
              ),
              SoftButton(
                kText: 'View All',
                bgColor: kInfoColor,
                kTrailingIcon: Icons.arrow_forward,
                onPressed: () {},
              ),
            ],
          ),
        );

        // Generating the grid items
        final gridItems = PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 360,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(kDefaultPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                childAspectRatio: 1, // square-like layout
                crossAxisSpacing: kDefaultPadding,
                mainAxisSpacing: kDefaultPadding,
              ),
              itemCount: appItems.length,
              itemBuilder: (context, index) {
                final e = appItems[index];
                return InkWell(
                  onTap: () => Navigator.pop(context),
                  // hoverColor: kSecondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(e.appImg),
                      SizedBox(height: kDefaultPadding / 2),
                      Text(
                        e.appTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontSize: kBodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );

        // Returning the complete list with header, grid, and footer
        return [header, gridItems];
      },
      child: TopNavButton(
        tooltipMessage: 'Select Favorite App',
        onTap: () {
          popupAppSelector.currentState?.showButtonMenu();
        },
        icon: Icons.apps,
      ),
    );
  }
}

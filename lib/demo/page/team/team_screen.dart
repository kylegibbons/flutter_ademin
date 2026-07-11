import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/page/team/team_data.dart';
import 'package:flutter_ademin/demo/page/team/team_models.dart';
import 'package:flutter_ademin/demo/page/team/widgets/profile_card.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).team; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<UserProfile> profiles = dummyProfiles;

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxxl) return 6;
    if (width >= kScreenWidthXl) return 4;
    if (width >= kScreenWidthLg) return 3;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  void toggleFavorite(int index) {
    setState(() {
      profiles[index].isFavorite = !profiles[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //header
          PageHeader(
            title: lang.team.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.pages(2), uri: ''),
              BreadcrumbItem(label: lang.team, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: GridView.builder(
              itemCount: profiles.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: kDefaultPadding,
                mainAxisSpacing: kDefaultPadding,
                mainAxisExtent: 427,
              ),
              itemBuilder: (context, index) {
                return ProfileCard(
                  profile: profiles[index],
                  onFavoriteTap: () => toggleFavorite(index),
                );
              },
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

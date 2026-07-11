import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/base_ui/image.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).image; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.8,
            ),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              border: Border(
                top: BorderSide(color: kTextColor.withValues(alpha: 0.1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Wrap(
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding * 0.5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                //title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.image.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: kBodyMedium,
                      ),
                    ),
                  ],
                ),

                //breadcrumbs
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Breadcrumbs(
                      items: [
                        BreadcrumbItem(
                          label: lang.dashboard,
                          uri: RouteUri.home,
                        ),
                        BreadcrumbItem(label: lang.baseUI, uri: ''),
                        BreadcrumbItem(label: lang.image, uri: RouteUri.image),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                //circle avatar
                ShowCodeCard(
                  cardTitle: 'Default Circle Avatar',
                  uiView: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Asset Images
                          Text(
                            'Avatar with Asset Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 16</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 20</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 24</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 48,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 64,
                                      backgroundImage: AssetImage(
                                        'assets/images/avatar_6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 64</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Network Images
                          Text(
                            'Avatar with Network Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 16</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 20</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 24</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 48,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 64,
                                      backgroundImage: NetworkImage(
                                        'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 64</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// Avatar with Asset Image

CircleAvatar(
  radius: 16,
  backgroundImage: AssetImage(
      'assets/images/avatar_1.jpg'),
),

CircleAvatar(
  radius: 20,
  backgroundImage: AssetImage(
      'assets/images/avatar_2.jpg'),
),

    CircleAvatar(
  radius: 24,
  backgroundImage: AssetImage(
      'assets/images/avatar_3.jpg'),
),      

CircleAvatar(
  radius: 32,
  backgroundImage: AssetImage(
      'assets/images/avatar_4.jpg'),
),

CircleAvatar(
  radius: 48,
  backgroundImage: AssetImage(
      'assets/images/avatar_5.jpg'),
),  

CircleAvatar(
  radius: 64,
  backgroundImage: AssetImage(
      'assets/images/avatar_6.jpg'),
),

// Avatar with Network Image

CircleAvatar(
  radius: 16,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
  ),
),

CircleAvatar(
  radius: 20,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
  ),
),

  CircleAvatar(
  radius: 24,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
  ),
),

CircleAvatar(
  radius: 32,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
  ),
),

CircleAvatar(
  radius: 48,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
  ),
),

  CircleAvatar(
  radius: 64,
  backgroundImage: NetworkImage(
    'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
  ),
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //custom circle avatar
                ShowCodeCard(
                  cardTitle: 'Custom Circle Avatar',
                  description:
                      'Use <code>CustomCircleAvatar()</code> to set a custom circle avatar, with a border that can be adjusted in color and width.',
                  uiView: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Asset Images
                          Text(
                            'Custom Circle Avatar with Asset Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 16,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 16</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 20,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 20</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 24,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 24</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 32,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 48,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 64,
                                      borderColor: Colors.blueGrey.shade100,
                                      borderWidth:
                                          4, // set border width manually
                                      image: AssetImage(
                                        'assets/images/avatar_6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 64</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Network Images
                          Text(
                            'Custom Circle Avatar with Network Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 16,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 16</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 20,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 20</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 24,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 24</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 32,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 48,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomCircleAvatar(
                                      radius: 64,
                                      borderColor: Colors.blueGrey.shade100,
                                      borderWidth:
                                          4, // set border width manually
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>radius: 64</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// Custom Circle Avatar with Asset Image

CustomCircleAvatar(
  radius: 16,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_1.jpg'),
),

CustomCircleAvatar(
  radius: 20,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_2.jpg'),
),

CustomCircleAvatar(
  radius: 24,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_3.jpg'),
),

CustomCircleAvatar(
  radius: 32,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_4.jpg'),
),

CustomCircleAvatar(
  radius: 48,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_5.jpg'),
),

CustomCircleAvatar(
  radius: 64,
  borderColor: Colors.blueGrey.shade100,
  borderWidth:
      4, // set border width manually
  image: AssetImage(
      'assets/images/avatar_6.jpg'),
),

// Custom Circle Avatar with Network Image

CustomCircleAvatar(
  radius: 16,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
  ),
),

CustomCircleAvatar(
  radius: 20,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
  ),
),

CustomCircleAvatar(
  radius: 24,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
  ),
),

CustomCircleAvatar(
  radius: 32,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
  ),
),

CustomCircleAvatar(
  radius: 48,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
  ),
),

CustomCircleAvatar(
  radius: 64,
  borderColor: Colors.blueGrey.shade100,
  borderWidth: 4, // set border width manually
  image: NetworkImage(
    'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
  ),
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //Square avatar
                ShowCodeCard(
                  cardTitle: 'Square Avatar',
                  description:
                      'Use <code>SquareAvatar()</code> to set a custom circle avatar, with a border that can be adjusted in color and width.',
                  uiView: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Asset Images
                          Text(
                            'Square Avatar with Asset Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SquareAvatar(
                                      size: 32,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 40,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 40</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 48,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 64,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 64</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 96,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: AssetImage(
                                        'assets/images/avatar_5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 96</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 128,
                                      borderColor: Colors.blueGrey.shade100,
                                      borderWidth:
                                          4, // set border width manually
                                      image: AssetImage(
                                        'assets/images/avatar_6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 128</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Network Images
                          Text(
                            'Square Avatar with Network Image',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              spacing: kDefaultPadding,
                              runSpacing: kDefaultPadding,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SquareAvatar(
                                      size: 32,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 32</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 40,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 40</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 48,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 48</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 64,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 64</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 96,
                                      borderColor: Colors.blueGrey.shade100,
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 96</code>',
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SquareAvatar(
                                      size: 128,
                                      borderColor: Colors.blueGrey.shade100,
                                      borderWidth:
                                          4, // set border width manually
                                      image: NetworkImage(
                                        'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                    CardDescription(
                                      content: '<code>size: 128</code>',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// Square Avatar with Asset Image

SquareAvatar(
  size: 32,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_1.jpg'),
),

SquareAvatar(
  size: 40,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_2.jpg'),
),

SquareAvatar(
  size: 48,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_3.jpg'),
),

SquareAvatar(
  size: 64,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_4.jpg'),
),

SquareAvatar(
  size: 96,
  borderColor: Colors.blueGrey.shade100,
  image: AssetImage(
      'assets/images/avatar_5.jpg'),
),

SquareAvatar(
  size: 128,
  borderColor: Colors.blueGrey.shade100,
  borderWidth:
      4, // set border width manually
  image: AssetImage(
      'assets/images/avatar_6.jpg'),
),

// Square Avatar with Network Image

SquareAvatar(
  size: 32,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
  ),
),

SquareAvatar(
  size: 40,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
  ),
),

SquareAvatar(
  size: 48,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
  ),
),

SquareAvatar(
  size: 64,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
  ),
),

SquareAvatar(
  size: 96,
  borderColor: Colors.blueGrey.shade100,
  image: NetworkImage(
    'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
  ),
),

SquareAvatar(
  size: 128,
  borderColor: Colors.blueGrey.shade100,
  borderWidth:
      4, // set border width manually
  image: NetworkImage(
    'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
  ),
),
''',
                ),

                const SizedBox(height: kDefaultPadding),

                //groupped avatar
                ShowCodeCard(
                  cardTitle: 'Groupped Avatar',
                  description:
                      'Use <code>GroupAvatar()</code> to set a group avatar. Try hovering the avatar.',
                  uiView: GroupAvatar(
                    imageUrls: [
                      'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
                      'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
                      'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
                      'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
                      'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
                      'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
                    ],
                    labels: [
                      'Alice Land',
                      'Bob Dilan',
                      'Diana Meo',
                      'Lovilola',
                      'Norotiho',
                      'Noor Salm',
                    ],
                    showLabel: true,
                    onTap: (index) {
                      // Navigate to user profile
                      debugPrint("User Index-$index is clicked!");
                    },
                    onOverflowTap: () {
                      // Navigate to All Members Screen
                      debugPrint("Navigate to All Members Screen");
                    },
                  ),
                  codeView: '''
GroupAvatar(
  imageUrls: [
    'https://i.ibb.co.com/d4WPD8yd/avatar-1.jpg',
    'https://i.ibb.co.com/XxHRn53L/avatar-2.jpg',
    'https://i.ibb.co.com/GfMLWbbp/avatar-3.jpg',
    'https://i.ibb.co.com/d4yzQvBj/avatar-4.jpg',
    'https://i.ibb.co.com/4nFRtjD8/avatar-5.jpg',
    'https://i.ibb.co.com/jkVYktFy/avatar-6.jpg',
  ],
  labels: [
    'Alice Land',
    'Bob Dilan',
    'Diana Meo',
    'Lovilola',
    'Norotiho',
    'Noor Salm'
  ],
  showLabel: true,
  onTap: (index) {
    // Navigate to user profile
    debugPrint("User Index-\$index is clicked!");
  },
  onOverflowTap: () {
    // Navigate to All Members Screen
    debugPrint("Navigate to All Members Screen");
  },
),
''',
                ),
              ],
            ),
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/carousel.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).carousels; //update your page tittle here
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
    final mediaQueryData = MediaQuery.of(context);

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
                      lang.carousels.toUpperCase(),
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
                        BreadcrumbItem(
                          label: lang.carousels,
                          uri: RouteUri.carousel,
                        ),
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth =
                        constraints.maxWidth - kDefaultPadding;
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // slide only
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Slide only',
                            description:
                                'Use <code>CustomCarousel()</code> to set a carousel. It has autosliding function, you can specify the timing in the function.',
                            uiView: CustomCarousel(
                              pages: [
                                // slider pages
                                buildPage(kPrimaryColor, 'Page 1'),
                                buildPage(kSecondaryColor, 'Page 2'),
                                buildPage(kInfoColor, 'Page 3'),
                                buildPage(kWarningColor, 'Page 4'),
                                buildPage(kErrorColor, 'Page 5'),
                              ],
                              showControls: false,
                              showIndicator: false,
                              autoSlideInterval: const Duration(seconds: 3),
                              height: 400,
                            ),
                            codeView: '''
CustomCarousel(
  pages: [
    // slider pages
    buildPage(kPrimaryColor, 'Page 1'),
    buildPage(kSecondaryColor, 'Page 2'),
    buildPage(kInfoColor, 'Page 3'),
    buildPage(kWarningColor, 'Page 4'),
    buildPage(kErrorColor, 'Page 5'),
  ],
  showControls: false,
  showIndicator: false,
  autoSlideInterval: const Duration(seconds: 3),
  height: 400,
),

// build page method
Widget buildPage(Color color, String text) {
  return Container(
    color: color,
    height: 400,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: kBodyLarge,
          color: Colors.white,
        ),
      ),
    ),
  );
}
''',
                          ),
                        ),

                        //slide with control
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Slide with Control',
                            description:
                                'Use <code>CustomCarousel()</code> to set a carousel. It has autosliding function, you can specify the timing in the function.',
                            uiView: CustomCarousel(
                              pages: [
                                // slider pages
                                buildPage(kPrimaryColor, 'Page 1'),
                                buildPage(kSecondaryColor, 'Page 2'),
                                buildPage(kInfoColor, 'Page 3'),
                                buildPage(kWarningColor, 'Page 4'),
                                buildPage(kErrorColor, 'Page 5'),
                              ],
                              showControls: true,
                              showIndicator: false,
                              autoSlideInterval: const Duration(seconds: 4),
                              height: 400,
                            ),
                            codeView: '''
CustomCarousel(
  pages: [
    // slider pages
    buildPage(kPrimaryColor, 'Page 1'),
    buildPage(kSecondaryColor, 'Page 2'),
    buildPage(kInfoColor, 'Page 3'),
    buildPage(kWarningColor, 'Page 4'),
    buildPage(kErrorColor, 'Page 5'),
  ],
  showControls: true,
  showIndicator: false,
  autoSlideInterval: const Duration(seconds: 4),
  height: 400,
),

// build page method
Widget buildPage(Color color, String text) {
  return Container(
    color: color,
    height: 400,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: kBodyLarge,
          color: Colors.white,
        ),
      ),
    ),
  );
}
''',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double availableWidth =
                        constraints.maxWidth - kDefaultPadding;
                    return Wrap(
                      spacing: kDefaultPadding,
                      runSpacing: kDefaultPadding,
                      children: [
                        // slide with indicator and control
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Slide with Indicator and Control',
                            description:
                                'Use <code>CustomCarousel()</code> to set a carousel. It has autosliding function, you can specify the timing in the function.',
                            uiView: CustomCarousel(
                              pages: [
                                // slider pages
                                buildPage(kPrimaryColor, 'Page 1'),
                                buildPage(kSecondaryColor, 'Page 2'),
                                buildPage(kInfoColor, 'Page 3'),
                                buildPage(kWarningColor, 'Page 4'),
                                buildPage(kErrorColor, 'Page 5'),
                              ],
                              showControls: true,
                              showIndicator: true,
                              autoSlideInterval: const Duration(seconds: 5),
                              height: 400,
                            ),
                            codeView: '''
CustomCarousel(
  pages: [
    // slider pages
    buildPage(kPrimaryColor, 'Page 1'),
    buildPage(kSecondaryColor, 'Page 2'),
    buildPage(kInfoColor, 'Page 3'),
    buildPage(kWarningColor, 'Page 4'),
    buildPage(kErrorColor, 'Page 5'),
  ],
  showControls: true,
  showIndicator: true,
  autoSlideInterval: const Duration(seconds: 5),
  height: 400,
),

// build page method
Widget buildPage(Color color, String text) {
  return Container(
    color: color,
    height: 400,
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: kBodyLarge,
          color: Colors.white,
        ),
      ),
    ),
  );
}
''',
                          ),
                        ),

                        //slide with caption
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Slide with Caption',
                            description:
                                'Use <code>CustomCarousel()</code> to set a carousel. It has autosliding function, you can specify the timing in the function.',
                            uiView: CustomCarousel(
                              pages: [
                                // slider pages
                                buildPageCaption(
                                  kPrimaryColor,
                                  'Page 1',
                                  'This is the first page',
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                buildPageCaption(
                                  kSecondaryColor,
                                  'Page 2',
                                  'This is the second page',
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                buildPageCaption(
                                  kInfoColor,
                                  'Page 3',
                                  'This is the third page',
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                buildPageCaption(
                                  kWarningColor,
                                  'Page 4',
                                  'This is the fourth page',
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                buildPageCaption(
                                  kErrorColor,
                                  'Page 5',
                                  'This is the fifth page',
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                              ],
                              showControls: true,
                              showIndicator: false,
                              autoSlideInterval: const Duration(seconds: 4),
                              height: 400,
                            ),
                            codeView: '''
CustomCarousel(
  pages: [
    // slider pages
    buildPageCaption(
      kPrimaryColor,
      'Page 1',
      'This is the first page',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    buildPageCaption(
      kSecondaryColor,
      'Page 2',
      'This is the second page',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    buildPageCaption(
      kInfoColor,
      'Page 3',
      'This is the third page',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    buildPageCaption(
      kWarningColor,
      'Page 4',
      'This is the fourth page',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    buildPageCaption(
      kErrorColor,
      'Page 5',
      'This is the fifth page',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ],
  showControls: true,
  showIndicator: false,
  autoSlideInterval: const Duration(seconds: 4),
  height: 400,
),

// build page caption
buildPageCaption(Color color, String text, String title, String caption) {
  return Stack(
    children: [
      Container(
        color: color,
        height: 400,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: kBodyLarge,
              color: Colors.white,
            ),
          ),
        ),
      ),
      // Caption positioned at the bottom
      Positioned(
        bottom: 2 * kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
        child: Column(
          children: [
            //title
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: kBodyMedium,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 0.5 * kDefaultPadding,
            ),
            //caption
            Text(
              caption,
              style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );
}

''',
                          ),
                        ),
                      ],
                    );
                  },
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

  // build page caption
  Stack buildPageCaption(
    Color color,
    String text,
    String title,
    String caption,
  ) {
    return Stack(
      children: [
        Container(
          color: color,
          height: 400,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: kBodyLarge, color: Colors.white),
            ),
          ),
        ),
        // Caption positioned at the bottom
        Positioned(
          bottom: 2 * kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
          child: Column(
            children: [
              //title
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: kBodyMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0.5 * kDefaultPadding),
              //caption
              Text(
                caption,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // build page method
  Widget buildPage(Color color, String text) {
    return Container(
      color: color,
      height: 400,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: kBodyLarge, color: Colors.white),
        ),
      ),
    );
  }
}

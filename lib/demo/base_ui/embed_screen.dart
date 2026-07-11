import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/base_ui/html_embed.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class EmbedScreen extends StatefulWidget {
  const EmbedScreen({super.key});

  @override
  State<EmbedScreen> createState() => _EmbedScreenState();
}

class _EmbedScreenState extends State<EmbedScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).embed; //update your page tittle here
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
                      lang.embed.toUpperCase(),
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
                          label: lang.embed,
                          uri: RouteUri.progress,
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
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: const Column(
                            children: [
                              //Youtube 16:9
                              ShowCodeCard(
                                cardTitle: 'Video 16:9',
                                description:
                                    'Use <code>HtmlEmbed()</code> with <code>aspectRatio:16/9</code> argument to embed a url with 16/9 ascpect ratio. In this case a Youtube video qith 16/9 aspect ratio.',
                                uiView: HtmlEmbed(
                                  url:
                                      'https://www.youtube.com/embed/wgTBLj7rMPM?si=1kKvqjZPsT12H84A',
                                  aspectRatio: 16 / 9, //set aspect ratio
                                ),
                                codeView: '''
HtmlEmbed(
  url:
      'https://www.youtube.com/embed/wgTBLj7rMPM?si=1kKvqjZPsT12H84A',
  aspectRatio: 16 / 9, //set aspect ratio
),
                                ''',
                                height: 360,
                              ),

                              SizedBox(height: kDefaultPadding),

                              //Youtube 16:9, full Screen allowed
                              ShowCodeCard(
                                cardTitle: 'Video Fullscreen',
                                description:
                                    'Use <code>HtmlEmbed()</code> with <code>fullScreen: true</code> argument to embed a url with fullscreen mode allowed, in this case a Youtube video with fullscreen allowed.',
                                uiView: HtmlEmbed(
                                  url:
                                      'https://www.youtube.com/embed/b_sQ9bMltGU?si=Jxe_Sg3vhqiYD8Mu',
                                  aspectRatio: 16 / 9,
                                  fullScreen: true, //set fullScreen to true
                                ),
                                codeView: '''
HtmlEmbed(
  url:
      'https://www.youtube.com/embed/b_sQ9bMltGU?si=Jxe_Sg3vhqiYD8Mu',
  aspectRatio: 16 / 9,
  fullScreen: true, //set fullScreen to true
),
''',
                                height: 360,
                              ),
                              SizedBox(height: kDefaultPadding),

                              //Google Map
                              ShowCodeCard(
                                cardTitle: 'Google Map 1:1',
                                description:
                                    'Use <code>HtmlEmbed()</code> with <code>aspectRatio:1/1</code> argument to embed a url with 1:1 ascpect ratio.',
                                uiView: HtmlEmbed(
                                  url:
                                      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3025.306387783669!2d-74.04707532373037!3d40.68924937139695!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25090129c363d%3A0x40c6a5770d25022b!2sStatue%20of%20Liberty!5e0!3m2!1sen!2sid!4v1727679307723!5m2!1sen!2sid",
                                  aspectRatio: 1 / 1, //set aspect ratio
                                ),
                                codeView: '''
HtmlEmbed(
  url:
      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3025.306387783669!2d-74.04707532373037!3d40.68924937139695!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25090129c363d%3A0x40c6a5770d25022b!2sStatue%20of%20Liberty!5e0!3m2!1sen!2sid!4v1727679307723!5m2!1sen!2sid",
  aspectRatio: 1 / 1, //set aspect ratio
),
''',
                                height: 360,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: const Column(
                            children: [
                              //Video 4:3
                              ShowCodeCard(
                                cardTitle: 'Video 4:3',
                                description:
                                    'Use <code>HtmlEmbed()</code> with <code>aspectRatio:4/3</code> argument to embed a url with 4/3 ascpect ratio. In this case a Youtube video qith 4/3 aspect ratio.',
                                uiView: HtmlEmbed(
                                  url:
                                      'https://www.youtube.com/embed/N-RiyZlv8v8?si=yNAeUKQDFFCYt5_v',
                                  aspectRatio: 4 / 3,
                                  fullScreen: true,
                                ),
                                codeView: '''
HtmlEmbed(
  url:
      'https://www.youtube.com/embed/N-RiyZlv8v8?si=yNAeUKQDFFCYt5_v',
  aspectRatio: 4 / 3,
  fullScreen: true,
),
''',
                                height: 360,
                              ),

                              SizedBox(height: kDefaultPadding),

                              //Youtube 21:9, full Screen allowed
                              ShowCodeCard(
                                cardTitle: 'Video 21/9',
                                description:
                                    'Use <code>HtmlEmbed()</code> with <code>aspectRatio:21/9</code> argument to embed a url with 21/9 ascpect ratio. In this case a Youtube video qith 21/9 aspect ratio.',
                                uiView: HtmlEmbed(
                                  url:
                                      'https://www.youtube.com/embed/iEMgjrfuc58?si=03vlWY4dIeF-Bb96',
                                  aspectRatio: 21 / 9,
                                  fullScreen: true,
                                ),
                                codeView: '''
HtmlEmbed(
  url:
      'https://www.youtube.com/embed/iEMgjrfuc58?si=03vlWY4dIeF-Bb96',
  aspectRatio: 21 / 9,
  fullScreen: true,
),
''',
                                height: 360,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),
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

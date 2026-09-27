import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:flutkit_ademin/widgets/base_ui/typography.dart';

class TypographyScreen extends StatefulWidget {
  const TypographyScreen({super.key});

  @override
  State<TypographyScreen> createState() => _TypographyScreenState();
}

class _TypographyScreenState extends State<TypographyScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).typography; //update your page tittle here
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
    final textTheme = Theme.of(context).textTheme;

    return PortalMasterLayout(
      body: ListView(
        children: [
          //page title and breadcrumb
          Container(
            padding: EdgeInsets.symmetric(
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
                  offset: Offset(0, 1),
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
                      lang.typography.toUpperCase(),
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
                          label: lang.typography,
                          uri: RouteUri.typography,
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
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                //font family
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardHeader(kText: 'Font Family'),
                      Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Body Font Family'),
                            SizedBox(height: kDefaultPadding),
                            Text(
                              'Aa',
                              style: textTheme.displayLarge?.copyWith(
                                color: themeData.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            Text('Font Family'),
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              '"Poppins", sans-serif',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: kBodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: kDefaultPadding),

                //typography scale
                //                 ShowCodeCard(
                //                     cardTitle: 'Typography Scale',
                //                     description:
                //                         'A typographical scale is a set of related text styles to provide balance, cohesion, and visual variety in your apps.',
                //                     uiView: Column(
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         Text(
                //                           'Display Large',
                //                           style: textTheme.displayLarge?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Display Medium',
                //                           style: textTheme.displayMedium?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Display Small',
                //                           style: textTheme.displaySmall?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Headline Large',
                //                           style: textTheme.headlineLarge?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Headline Medium',
                //                           style: textTheme.headlineMedium?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Headline Small',
                //                           style: textTheme.headlineSmall?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Title Large',
                //                           style: textTheme.titleLarge?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Title Medium',
                //                           style: textTheme.titleMedium?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Title Small',
                //                           style: textTheme.titleSmall?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Label Large',
                //                           style: textTheme.labelLarge?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Label Medium',
                //                           style: textTheme.labelMedium?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Label Small',
                //                           style: textTheme.labelSmall?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Body Large',
                //                           style: textTheme.bodyLarge?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Body Medium',
                //                           style: textTheme.bodyMedium?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Body Small',
                //                           style: textTheme.bodySmall?.copyWith(
                //                             color: themeData.colorScheme.onSurface,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                     codeView: '''
                // Text(
                //   'Display Large',
                //   style: textTheme.displayLarge?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Display Medium',
                //   style: textTheme.displayMedium?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Display Small',
                //   style: textTheme.displaySmall?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Headline Large',
                //   style: textTheme.headlineLarge?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Headline Medium',
                //   style: textTheme.headlineMedium?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Headline Small',
                //   style: textTheme.headlineSmall?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Title Large',
                //   style: textTheme.titleLarge?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Title Medium',
                //   style: textTheme.titleMedium?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Title Small',
                //   style: textTheme.titleSmall?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Label Large',
                //   style: textTheme.labelLarge?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Label Medium',
                //   style: textTheme.labelMedium?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Label Small',
                //   style: textTheme.labelSmall?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Body Large',
                //   style: textTheme.bodyLarge?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Body Medium',
                //   style: textTheme.bodyMedium?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),

                // Text(
                //   'Body Small',
                //   style: textTheme.bodySmall?.copyWith(
                //     color: themeData.colorScheme.onSurface,
                //   ),
                // ),
                //                           '''),

                //                 SizedBox(
                //                   height: kDefaultPadding,
                //                 ),
                ShowCodeCard(
                  cardTitle: 'Font Size',
                  description:
                      'Use <code>kDisplayLarge</code>, <code>kDisplayMedium</code>,<code>kDisplaySmall</code>, <code>kHeadlineLarge</code>,<code>kHeadlineMedium</code>, <code>kHeadlineSmall</code>, <code>kTitleLarge</code>, <code>kTitleMedium</code>, <code>kTitleSmall</code>, <code>kLabelLarge</code>, <code>kLabelMedium</code>, <code>kLabelSmall</code>, <code>kBodyLarge</code>, <code>kBodyMedium</code>, <code>kBodySmall</code>, to change the font-size respectively.',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'kDisplayLarge',
                        style: TextStyle(fontSize: kDisplayLarge),
                      ),
                      Text(
                        'kDisplayMedium',
                        style: TextStyle(fontSize: kDisplayMedium),
                      ),
                      Text(
                        'kDisplaySmall',
                        style: TextStyle(fontSize: kDisplaySmall),
                      ),
                      Text(
                        'kHeadlineLarge',
                        style: TextStyle(fontSize: kHeadlineLarge),
                      ),
                      Text(
                        'kHeadlineMedium',
                        style: TextStyle(fontSize: kHeadlineMedium),
                      ),
                      Text(
                        'kHeadlineSmall',
                        style: TextStyle(fontSize: kHeadlineSmall),
                      ),
                      Text(
                        'kTitleLarge',
                        style: TextStyle(fontSize: kTitleLarge),
                      ),
                      Text(
                        'kTitleMedium',
                        style: TextStyle(fontSize: kTitleMedium),
                      ),
                      Text(
                        'kTitleSmall',
                        style: TextStyle(fontSize: kTitleSmall),
                      ),
                      Text(
                        'kLabelLarge',
                        style: TextStyle(fontSize: kLabelLarge),
                      ),
                      Text(
                        'kLabelMedium',
                        style: TextStyle(fontSize: kLabelMedium),
                      ),
                      Text(
                        'kLabelSmall',
                        style: TextStyle(fontSize: kLabelSmall),
                      ),
                      Text(
                        'kBodyLarge',
                        style: TextStyle(fontSize: kBodyLarge),
                      ),
                      Text(
                        'kBodyMedium',
                        style: TextStyle(fontSize: kBodyMedium),
                      ),
                      Text(
                        'kBodySmall',
                        style: TextStyle(fontSize: kBodySmall),
                      ),
                    ],
                  ),
                  codeView: '''
Text(
  'kDisplayLarge',
  style: TextStyle(
    fontSize: kDisplayLarge,
  ),
),

Text(
  'kDisplayMedium',
  style: TextStyle(
    fontSize: kDisplayMedium,
  ),
),

Text(
  'kDisplaySmall',
  style: TextStyle(
    fontSize: kDisplaySmall,
  ),
),

Text(
  'kHeadlineLarge',
  style: TextStyle(
    fontSize: kHeadlineLarge,
  ),
),

Text(
  'kHeadlineMedium',
  style: TextStyle(
    fontSize: kHeadlineMedium,
  ),
),

Text(
  'kHeadlineSmall',
  style: TextStyle(
    fontSize: kHeadlineSmall,
  ),
),

Text(
  'kTitleLarge',
  style: TextStyle(
    fontSize: kTitleLarge,
  ),
),

Text(
  'kTitleMedium',
  style: TextStyle(
    fontSize: kTitleMedium,
  ),
),

Text(
  'kTitleSmall',
  style: TextStyle(
    fontSize: kTitleSmall,
  ),
),

Text(
  'kLabelLarge',
  style: TextStyle(
    fontSize: kLabelLarge,
  ),
),

Text(
  'kLabelMedium',
  style: TextStyle(
    fontSize: kLabelMedium,
  ),
),

Text(
  'kLabelSmall',
  style: TextStyle(
    fontSize: kLabelSmall,
  ),
),

Text(
  'kBodyLarge',
  style: TextStyle(
    fontSize: kBodyLarge,
  ),
),

Text(
  'kBodyMedium',
  style: TextStyle(
    fontSize: kBodyMedium,
  ),
),

Text(
  'kBodySmall',
  style: TextStyle(
    fontSize: kBodySmall,
  ),
),
''',
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
                        //Text transform
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Text Transform',
                            description:
                                'Use <code>.toLowerCase()</code> or <code>.toUpperCase()</code> to transform the text.',
                            height: 140,
                            uiView: Column(
                              children: [
                                Text('Lowered case text.'.toLowerCase()),
                                SizedBox(height: kDefaultPadding),
                                Text('Uppercased text.'.toUpperCase()),
                              ],
                            ),
                            codeView: '''
Text(
  'Lowered case text.'.toLowerCase(),
),

Text(
  'Uppercased text.'.toUpperCase(),
),
''',
                          ),
                        ),

                        //Text decoration
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Text Decoration',
                            description:
                                'Use <code>TextDecoration.underline</code>, <code>TextDecoration.lineThrough</code>, or <code>TextDecoration.overline</code> to decorate text in components respectively.',
                            height: 300,
                            uiView: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'This text has a line underneath it.',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Text(
                                  'This text has a line going through it.',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding),
                                Text(
                                  'This text has a line over it.',
                                  style: TextStyle(
                                    decoration: TextDecoration.overline,
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Text(
  'This text has a line underneath it.',
  style: TextStyle(
      decoration: TextDecoration.underline),
),

Text(
  'This text has a line going through it.',
  style: TextStyle(
    decoration: TextDecoration.lineThrough,
  ),
),

Text(
  'This text has a line over it.',
  style: TextStyle(
    decoration: TextDecoration.overline,
  ),
),
''',
                          ),
                        ),
                      ],
                    );
                  },
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
                        //Text transform
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Left Aligned Blockquote',
                            description:
                                'Use <code>BlockQuote()</code> to set a left aligned blockquote.',
                            height: 140,
                            uiView: BlockQuote(
                              quote:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.',
                              author: 'Someone famous',
                              source: 'Source Title',
                              isLeftAligned: true, // Left aligned
                            ),
                            codeView: '''
BlockQuote(
  quote:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.',
  author: 'Someone famous',
  source: 'Source Title',
  isLeftAligned: true, // Left aligned
)
''',
                          ),
                        ),

                        //Text decoration
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Right Aligned Blockquote',
                            description:
                                'Use <code>BlockQuote()</code> to set a right aligned blockquote.',
                            height: 140,
                            uiView: BlockQuote(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Another famous person',
                              source: 'Another Source',
                              isLeftAligned: false, // Right aligned
                            ),
                            codeView: '''
BlockQuote(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Another famous person',
  source: 'Another Source',
  isLeftAligned: false, // Right aligned
)
''',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: kDefaultPadding),

                ShowCodeCard(
                  cardTitle: 'Blockquote Background Color',
                  description:
                      'Use <code>BlockQuoteBgColor()</code> to set a blockquote with background color.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: <Widget>[
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kSecondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kInfoColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kSuccessColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kWarningColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBgColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kErrorColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kPrimaryColor,
),

BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kSecondaryColor,
),

BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kInfoColor,
),

BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kSuccessColor,
),

BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kWarningColor,
),

BlockQuoteBgColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kErrorColor,
),
                  ''',
                ),

                SizedBox(height: kDefaultPadding),

                ShowCodeCard(
                  cardTitle: 'Blockquote Border Color',
                  description:
                      'Use <code>BlockQuoteBorderColor()</code> to set a blockquote with border color.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: <Widget>[
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kSecondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: true,
                              kColor: kInfoColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kSuccessColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kWarningColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BlockQuoteBorderColor(
                              quote:
                                  'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
                              author: 'Famous Person',
                              source: 'Source',
                              isLeftAligned: false,
                              kColor: kErrorColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kPrimaryColor,
),

BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kSecondaryColor,
),

BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: true,
  kColor: kInfoColor,
),

BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kSuccessColor,
),

BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kWarningColor,
),

BlockQuoteBorderColor(
  quote:
      'Another inspirational quote goes here. Life is beautiful! You should smile and enjoy it.',
  author: 'Famous Person',
  source: 'Source',
  isLeftAligned: false,
  kColor: kErrorColor,
),
                  ''',
                ),
              ],
            ),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

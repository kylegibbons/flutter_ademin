import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/chip.dart';
import 'package:flutkit_ademin/widgets/helper/card_description.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

class ChipScreen extends StatefulWidget {
  const ChipScreen({super.key});

  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends State<ChipScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).chip; //update your page tittle here
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
                  color: themeData.colorScheme.onSurface.withValues(alpha: 0.1),
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
                      lang.chip.toUpperCase(),
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
                        BreadcrumbItem(label: lang.chip, uri: RouteUri.badge),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ResponsiveWrap(
              breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
              columnRatios: [1 / 2, 1 / 2],
              children: [
                ShowCodeCard(
                  cardTitle: 'Custom Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary custom chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                      ),
                      // Secondary custom chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                      ),
                      // Success custom chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                      ),
                      // Info custom chip
                      CustomChip(label: const Text('Info'), color: kInfoColor),
                      // Warning custom chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                      ),
                      // Error custom chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                      ),
                      // Dark custom chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  codeView: '''
// Primary custom chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
),

// Secondary custom chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
),

// Success custom chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
),

// Info custom chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
),

// Warning custom chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
),

// Error custom chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
),

// Dark custom chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
),
''',
                ),
                ShowCodeCard(
                  cardTitle: 'Soft Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary soft chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Secondary soft chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Success soft chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Info soft chip
                      CustomChip(
                        label: const Text('Info'),
                        color: kInfoColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Warning soft chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Error soft chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                      // Dark soft chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                        type: ChipStyleType.soft, // set as soft chip
                      ),
                    ],
                  ),
                  codeView: '''
// Primary soft chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Secondary soft chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Success soft chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Info soft chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Warning soft chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Error soft chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
  type: ChipStyleType.soft, // set as soft chip
),

// Dark soft chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
  type: ChipStyleType.soft, // set as soft chip
),
''',
                ),
                ShowCodeCard(
                  cardTitle: 'Outlined Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary outlined chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Secondary outlined chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Success outlined chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Info outlined chip
                      CustomChip(
                        label: const Text('Info'),
                        color: kInfoColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Warning outlined chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Error outlined chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                      // Dark outlined chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                        type: ChipStyleType.outline, // set as outlined chip
                      ),
                    ],
                  ),
                  codeView: '''
// Primary outlined chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Secondary outlined chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Success outlined chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Info outlined chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Warning outlined chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Error outlined chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
  type: ChipStyleType.outline, // set as outlined chip
),

// Dark outlined chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
  type: ChipStyleType.outline, // set as outlined chip
),
''',
                ),
                ShowCodeCard(
                  cardTitle: 'Rounded Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary rounded chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Secondary rounded chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Success rounded chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                        type: ChipStyleType.soft,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Info rounded chip
                      CustomChip(
                        label: const Text('Info'),
                        color: kInfoColor,
                        type: ChipStyleType.soft,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Warning rounded chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                        type: ChipStyleType.outline,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Error rounded chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                        type: ChipStyleType.outline,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                      // Dark rounded chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                        type: ChipStyleType.outline,
                        shapeType: ChipShapeType.rounded, // set as rounded
                      ),
                    ],
                  ),
                  codeView: '''
// Primary rounded chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Secondary rounded chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Success rounded chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
  type: ChipStyleType.soft,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Info rounded chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
  type: ChipStyleType.soft,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Warning rounded chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
  type: ChipStyleType.outline,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Error rounded chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
  type: ChipStyleType.outline,
  shapeType: ChipShapeType.rounded, // set as rounded
),

// Dark rounded chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
  type: ChipStyleType.outline,
  shapeType: ChipShapeType.rounded, // set as rounded
),
''',
                ),
                ShowCodeCard(
                  cardTitle: 'Avatar Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary avatar chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_1.jpg',
                          ),
                        ),
                      ),
                      // Secondary avatar chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                        shapeType: ChipShapeType.rounded,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_2.jpg',
                          ),
                        ),
                      ),
                      // Success avatar chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                        type: ChipStyleType.soft,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_3.jpg',
                          ),
                        ),
                      ),
                      // Info avatar chip
                      CustomChip(
                        label: const Text('Info'),
                        color: kInfoColor,
                        type: ChipStyleType.soft,
                        shapeType: ChipShapeType.rounded,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_4.jpg',
                          ),
                        ),
                      ),
                      // Warning avatar chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                        type: ChipStyleType.outline,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_5.jpg',
                          ),
                        ),
                      ),
                      // Error avatar chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                        type: ChipStyleType.outline,
                        shapeType: ChipShapeType.rounded,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_6.jpg',
                          ),
                        ),
                      ),
                      // Dark avatar chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                        type: ChipStyleType.outline,
                        // add avatar
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/avatar_7.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  codeView: '''
// Primary avatar chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_1.jpg'),
  ),
),

// Secondary avatar chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
  shapeType: ChipShapeType.rounded,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_2.jpg'),
  ),
),

// Success avatar chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
  type: ChipStyleType.soft,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_3.jpg'),
  ),
),

// Info avatar chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
  type: ChipStyleType.soft,
  shapeType: ChipShapeType.rounded,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_4.jpg'),
  ),
),

// Warning avatar chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
  type: ChipStyleType.outline,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_5.jpg'),
  ),
),

// Error avatar chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
  type: ChipStyleType.outline,
  shapeType: ChipShapeType.rounded,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_6.jpg'),
  ),
),

// Dark avatar chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
  type: ChipStyleType.outline,
  // add avatar
  avatar: CircleAvatar(
    backgroundImage:
        AssetImage('assets/images/avatar_7.jpg'),
  ),
),
''',
                ),
                ShowCodeCard(
                  cardTitle: 'Delete Icon Chip',
                  description:
                      'Use <code>CustomChip()</code> to set a custom chip. This custom chip has multiple arguments to suit your design needs.',
                  uiView: Wrap(
                    spacing: kDefaultPadding / 2,
                    runSpacing: kDefaultPadding / 2,
                    children: [
                      // Primary delete chip
                      CustomChip(
                        label: const Text('Primary'),
                        color: kPrimaryColor,
                        deleteIcon: Icon(Icons.close), // set icon
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Secondary delete chip
                      CustomChip(
                        label: const Text('Secondary'),
                        color: kSecondaryColor,
                        shapeType: ChipShapeType.rounded,
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Success delete chip
                      CustomChip(
                        label: const Text('Success'),
                        color: kSuccessColor,
                        type: ChipStyleType.soft,
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Info delete chip
                      CustomChip(
                        label: const Text('Info'),
                        color: kInfoColor,
                        type: ChipStyleType.soft,
                        shapeType: ChipShapeType.rounded,
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Warning delete chip
                      CustomChip(
                        label: const Text('Warning'),
                        color: kWarningColor,
                        type: ChipStyleType.outline,
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Error delete chip
                      CustomChip(
                        label: const Text('Error'),
                        color: kErrorColor,
                        type: ChipStyleType.outline,
                        shapeType: ChipShapeType.rounded,
                        onDeleted: () {}, // handle chip removal
                      ),
                      // Dark delete chip
                      CustomChip(
                        label: const Text('Dark'),
                        color: Colors.black,
                        type: ChipStyleType.outline,
                        onDeleted: () {}, // handle chip removal
                      ),
                    ],
                  ),
                  codeView: '''
// Primary delete chip
CustomChip(
  label: const Text('Primary'),
  color: kPrimaryColor,
  deleteIcon: Icon(Icons.close), // set icon
  onDeleted: () {}, // handle chip removal
),

// Secondary delete chip
CustomChip(
  label: const Text('Secondary'),
  color: kSecondaryColor,
  shapeType: ChipShapeType.rounded,
  onDeleted: () {}, // handle chip removal
),

// Success delete chip
CustomChip(
  label: const Text('Success'),
  color: kSuccessColor,
  type: ChipStyleType.soft,
  onDeleted: () {}, // handle chip removal
),

// Info delete chip
CustomChip(
  label: const Text('Info'),
  color: kInfoColor,
  type: ChipStyleType.soft,
  shapeType: ChipShapeType.rounded,
  onDeleted: () {}, // handle chip removal
),

// Warning delete chip
CustomChip(
  label: const Text('Warning'),
  color: kWarningColor,
  type: ChipStyleType.outline,
  onDeleted: () {}, // handle chip removal
),

// Error delete chip
CustomChip(
  label: const Text('Error'),
  color: kErrorColor,
  type: ChipStyleType.outline,
  shapeType: ChipShapeType.rounded,
  onDeleted: () {}, // handle chip removal
),

// Dark delete chip
CustomChip(
  label: const Text('Dark'),
  color: Colors.black,
  type: ChipStyleType.outline,
  onDeleted: () {}, // handle chip removal
),
''',
                ),
              ],
            ),
          ),

          // chip input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Chip Input Field',
              description:
                  'Use <code>ChipInputField()</code> to set up chip input field.',
              uiView: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChipInputField(
                    initialTags: ['bug', 'important'],
                    suggestions: [
                      'bug',
                      'follow up',
                      'important',
                      'logo',
                      'review',
                      'todo',
                      'tomorrow',
                      'wordpress',
                    ],
                    onChanged: (tags) {
                      debugPrint('Current tags: $tags');
                    },
                  ),
                  SizedBox(height: kDefaultPadding),
                  CardDescription(
                    content: '''
<p>A user can:</p>
<ul>
  <li><strong>Add tags</strong> in two ways: By typing custom text and pressing <strong>Enter</strong>. Or, by selecting from a predefined list of suggestions.</li>
  <li><strong>View suggestions</strong> automatically when the field is tapped or focused.</li>
  <li><strong>Filter the suggestion list</strong> in real-time as they type.</li>
  <li><strong>Remove added tags</strong> by clicking the 'x' icon on a chip.</li>
  <li><strong>See all added tags</strong> displayed as neatly arranged Chips above the input field.</li>
</ul>
<p>This widget intelligently manages its state, ensuring that suggestions will not display tags that have already been selected.</p>
''',
                  ),
                ],
              ),
              codeView: '''
ChipInputField(
  initialTags: ['bug', 'important'],
  suggestions: [
    'bug',
    'follow up',
    'important',
    'logo',
    'review',
    'todo',
    'tomorrow',
    'wordpress',
  ],
  onChanged: (tags) {
    debugPrint('Current tags: \$tags');
  },
),
''',
            ),
          ),

          SizedBox(height: kDefaultPadding),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

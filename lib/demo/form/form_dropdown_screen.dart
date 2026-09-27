import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class FormDropDownScreen extends StatefulWidget {
  const FormDropDownScreen({super.key});

  @override
  State<FormDropDownScreen> createState() => _FormDropDownScreenState();
}

class _FormDropDownScreenState extends State<FormDropDownScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).formDropdown; //update your page tittle here
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
    MediaQuery.of(context);

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
                      lang.formDropdown.toUpperCase(),
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
                        BreadcrumbItem(label: lang.forms(2), uri: ''),
                        BreadcrumbItem(
                          label: lang.formDropdown,
                          uri: RouteUri.formDropdown,
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
                ShowCodeCard(
                  cardTitle: 'Custom Dropdown Form',
                  description:
                      'Use <code>CustomDropdownFormField()</code> to set a custom DropdownButtonFormField.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_4(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field with Initial Value',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field with Initial Value
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "us",
                                      child: Text("USA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("Japan"),
                                    ),
                                  ],
                                  initialValue: "id", // set initial value
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field without Initial Value',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field without Initial Value
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "basic",
                                      child: Text("Basic Plan"),
                                    ),
                                    DropdownMenuItem(
                                      value: "pro",
                                      child: Text("Pro Plan"),
                                    ),
                                    DropdownMenuItem(
                                      value: "enterprise",
                                      child: Text("Enterprise Plan"),
                                    ),
                                  ],
                                  initialValue: null, // no inital value
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field with Custom Icon',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field with Custom Icon
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "us",
                                      child: Text("USA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("Japan"),
                                    ),
                                  ],
                                  initialValue: "id",
                                  icon: Icons.flag_outlined,
                                  // set custom icon
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field with Hint & Custom Icon',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field with Hint & Custom Icon
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "paypal",
                                      child: Text("PayPal"),
                                    ),
                                    DropdownMenuItem(
                                      value: "credit_card",
                                      child: Text("Credit Card"),
                                    ),
                                    DropdownMenuItem(
                                      value: "bank",
                                      child: Text("Bank Transfer"),
                                    ),
                                  ],
                                  initialValue: null,
                                  hint: 'Select Payment', // set hint
                                  icon: Icons.payment, // set custom icon
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field with Icon Menu',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field with Icon Menu
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "basic",
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_border,
                                            size: 16,
                                          ), // Add your icon here
                                          SizedBox(width: kDefaultPadding / 2),
                                          Text("Basic Plan"),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "pro",
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                          ), // Add your icon here
                                          SizedBox(width: kDefaultPadding / 2),
                                          Text("Pro Plan"),
                                        ],
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "enterprise",
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.business,
                                            size: 16,
                                          ), // Add your icon here
                                          SizedBox(width: kDefaultPadding / 2),
                                          Text("Enterprise Plan"),
                                        ],
                                      ),
                                    ),
                                  ],
                                  initialValue: 'basic',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dropdown Field with Prefix Icon',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Dropdown Field with Prefix Icon
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "us",
                                      child: Text("USA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("Japan"),
                                    ),
                                  ],
                                  initialValue: "id",
                                  prefixIcon: Icons.south_america_outlined,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rounded Dropdown Field',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Rounded Dropdown Field
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "en",
                                      child: Text("English"),
                                    ),
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Bahasa Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("日本語"),
                                    ),
                                  ],
                                  initialValue: "en",
                                  hint: 'Select Language',
                                  radius: 50, // set rounded
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_4(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Disabled Dropdown Field',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Disabled Dropdown Field
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "admin",
                                      child: Text("Admin"),
                                    ),
                                    DropdownMenuItem(
                                      value: "editor",
                                      child: Text("Editor"),
                                    ),
                                    DropdownMenuItem(
                                      value: "viewer",
                                      child: Text("Viewer"),
                                    ),
                                  ],
                                  initialValue: "editor",
                                  enabled: false, // disable dropdown
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//Dropdown Field with Initial Value
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "id",
      child: Text("Indonesia"),
    ),
    DropdownMenuItem(
      value: "us",
      child: Text("USA"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("Japan"),
    ),
  ],
  initialValue: "id", // set initial value
),

//Dropdown Field without Initial Value
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "basic",
      child: Text("Basic Plan"),
    ),
    DropdownMenuItem(
      value: "pro",
      child: Text("Pro Plan"),
    ),
    DropdownMenuItem(
      value: "enterprise",
      child: Text("Enterprise Plan"),
    ),
  ],
  initialValue: null, // no inital value
),

//Dropdown Field with Custom Icon
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "id",
      child: Text("Indonesia"),
    ),
    DropdownMenuItem(
      value: "us",
      child: Text("USA"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("Japan"),
    ),
  ],
  initialValue: "id",
  icon: Icon(
    Icons.flag_outlined,
    color: themeData.colorScheme.onSurface,
  ), // set custom icon
),

//Dropdown Field with Hint & Custom Icon
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
        value: "paypal", child: Text("PayPal")),
    DropdownMenuItem(
        value: "credit_card",
        child: Text("Credit Card")),
    DropdownMenuItem(
        value: "bank",
        child: Text("Bank Transfer")),
  ],
  initialValue: null,
  hint: 'Select Payment', // set hint
  icon: const Icon(Icons.payment), // set custom icon
),

//Dropdown Field with Icon Menu
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "basic",
      child: Row(
        children: [
          Icon(
            Icons.star_border,
            size: 16,
          ), // Add your icon here
          SizedBox(width: kDefaultPadding / 2),
          Text("Basic Plan"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "pro",
      child: Row(
        children: [
          Icon(
            Icons.star,
            size: 16,
          ), // Add your icon here
          SizedBox(width: kDefaultPadding / 2),
          Text("Pro Plan"),
        ],
      ),
    ),
    DropdownMenuItem(
      value: "enterprise",
      child: Row(
        children: [
          Icon(
            Icons.business,
            size: 16,
          ), // Add your icon here
          SizedBox(width: kDefaultPadding / 2),
          Text("Enterprise Plan"),
        ],
      ),
    ),
  ],
  initialValue: 'basic',
),

//Dropdown Field with Prefix Icon
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "id",
      child: Text("Indonesia"),
    ),
    DropdownMenuItem(
      value: "us",
      child: Text("USA"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("Japan"),
    ),
  ],
  initialValue: "id",
  prefixIcon: Icons.south_america_outlined,
),

//Rounded Dropdown Field
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "en",
      child: Text("English"),
    ),
    DropdownMenuItem(
      value: "id",
      child: Text("Bahasa Indonesia"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("日本語"),
    ),
  ],
  initialValue: "en",
  hint: "Select Language",
  radius: 50, // set rounded
),

//Disabled Dropdown Field
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
        value: "admin", child: Text("Admin")),
    DropdownMenuItem(
        value: "editor", child: Text("Editor")),
    DropdownMenuItem(
        value: "viewer", child: Text("Viewer")),
  ],
  initialValue: "editor",
  enabled: false, // disable dropdown
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Dropdown Form Field Size',
                  description:
                      'use <code>size</code> argument to set dropdown form size.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Small Dropdown Field',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Small Dropdown Field
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "us",
                                      child: Text("USA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("Japan"),
                                    ),
                                  ],
                                  initialValue: "id",
                                  size: FormSize.small, // set small size
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medium Dropdown Field',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Medium Dropdown Field
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "paypal",
                                      child: Text("PayPal"),
                                    ),
                                    DropdownMenuItem(
                                      value: "credit_card",
                                      child: Text("Credit Card"),
                                    ),
                                    DropdownMenuItem(
                                      value: "bank",
                                      child: Text("Bank Transfer"),
                                    ),
                                  ],
                                  initialValue: null,
                                  hint: 'Select Payment',
                                  icon: Icons.payment,
                                  size: FormSize.medium, // set medium size
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Large Dropdown Field',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Large Dropdown Field
                                CustomDropdownFormField<String>(
                                  items: const [
                                    DropdownMenuItem(
                                      value: "id",
                                      child: Text("Indonesia"),
                                    ),
                                    DropdownMenuItem(
                                      value: "us",
                                      child: Text("USA"),
                                    ),
                                    DropdownMenuItem(
                                      value: "jp",
                                      child: Text("Japan"),
                                    ),
                                  ],
                                  initialValue: "id",
                                  prefixIcon: Icons.south_america_outlined,
                                  size: FormSize.large, // set large size
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//Small Dropdown Field
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "id",
      child: Text("Indonesia"),
    ),
    DropdownMenuItem(
      value: "us",
      child: Text("USA"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("Japan"),
    ),
  ],
  initialValue: "id",
  size: FormSize.small, // set small size
),

//Medium Dropdown Field
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
        value: "paypal", child: Text("PayPal")),
    DropdownMenuItem(
        value: "credit_card",
        child: Text("Credit Card")),
    DropdownMenuItem(
        value: "bank",
        child: Text("Bank Transfer")),
  ],
  initialValue: null,
  hint: 'Select Payment',
  icon: const Icon(Icons.payment),
  size: FormSize.medium, // set medium size
),

//Large Dropdown Field
CustomDropdownFormField<String>(
  items: const [
    DropdownMenuItem(
      value: "id",
      child: Text("Indonesia"),
    ),
    DropdownMenuItem(
      value: "us",
      child: Text("USA"),
    ),
    DropdownMenuItem(
      value: "jp",
      child: Text("Japan"),
    ),
  ],
  initialValue: "id",
  prefixIcon: Icons.south_america_outlined,
  size: FormSize.large, // set large size
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Multiple Dropdown Input',
                  description:
                      'Use <code>MultipleDropdown()</code> to choose one or more items from a predefined list of options.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          //multiple select
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Multiple Dropdown with Initial Value',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Multiple Dropdown with Initial Value
                                MultipleDropdown(
                                  allChoices: const [
                                    'Choice 1',
                                    'Choice 2',
                                    'Choice 3',
                                    'Choice 4',
                                    'Choice 5',
                                    'Choice 6',
                                    'Choice 7',
                                    'Choice 8',
                                    'Choice 9',
                                    'Choice 10',
                                  ],
                                  selectedChoices: const [
                                    'Choice 1',
                                    'Choice 2',
                                  ],
                                  onSelectionChanged: (selectedList) {
                                    debugPrint('Selected items: $selectedList');
                                  },
                                ),
                              ],
                            ),
                          ),

                          //email multiple select
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Multiple Dropdown without Initial Value',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Multiple Dropdown without Initial Value
                                MultipleDropdown(
                                  allChoices: const [
                                    'john.doe@domain.com',
                                    'jane.smith@domain.com',
                                    'michael.brown@domain.com',
                                    'emily.jones@domain.com',
                                    'david.lee@domain.com',
                                    'sarah.wilson@domain.com',
                                    'chris.johnson@domain.com',
                                    'kate.miller@domain.com',
                                    'robert.davis@domain.com',
                                    'lisa.white@domain.com',
                                  ],
                                  selectedChoices: const [],
                                  hint: 'Select emails...',
                                  onSelectionChanged: (selectedList) {
                                    debugPrint('Selected items: $selectedList');
                                  },
                                  chipColor: kSecondaryColor,
                                ),
                              ],
                            ),
                          ),

                          //rounded multiple dropdown
                          SizedBox(
                            width: calculateCardWidth_2(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Disabled Multiple Dropdown',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding / 2),

                                //Disabled Multiple Dropdown
                                MultipleDropdown(
                                  allChoices: const [
                                    'john.doe@domain.com',
                                    'jane.smith@domain.com',
                                    'michael.brown@domain.com',
                                    'emily.jones@domain.com',
                                    'david.lee@domain.com',
                                    'sarah.wilson@domain.com',
                                    'chris.johnson@domain.com',
                                    'kate.miller@domain.com',
                                    'robert.davis@domain.com',
                                    'lisa.white@domain.com',
                                  ],
                                  selectedChoices: const [
                                    'emily.jones@domain.com',
                                    'david.lee@domain.com',
                                    'sarah.wilson@domain.com',
                                  ],
                                  hint: 'Select emails...',
                                  onSelectionChanged: (selectedList) {
                                    debugPrint('Selected items: $selectedList');
                                  },
                                  chipColor: kInfoColor,
                                  enabled: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//Multiple Dropdown with Initial Value
MultipleDropdown(
  allChoices: const [
    'Choice 1',
    'Choice 2',
    'Choice 3',
    'Choice 4',
    'Choice 5',
    'Choice 6',
    'Choice 7',
    'Choice 8',
    'Choice 9',
    'Choice 10',
  ],
  selectedChoices: const [
    'Choice 1',
    'Choice 2',
  ],
  onSelectionChanged: (selectedList) {},
),


//Multiple Dropdown without Initial Value
MultipleDropdown(
  allChoices: const [
    'john.doe@domain.com',
    'jane.smith@domain.com',
    'michael.brown@domain.com',
    'emily.jones@domain.com',
    'david.lee@domain.com',
    'sarah.wilson@domain.com',
    'chris.johnson@domain.com',
    'kate.miller@domain.com',
    'robert.davis@domain.com',
    'lisa.white@domain.com',
  ],
  selectedChoices: const [],
  hint: 'Select emails...',
  onSelectionChanged: (selectedList) {},
  chipColor: kSecondaryColor,
),

//Disabled Multiple Dropdown
MultipleDropdown(
  allChoices: const [
    'john.doe@domain.com',
    'jane.smith@domain.com',
    'michael.brown@domain.com',
    'emily.jones@domain.com',
    'david.lee@domain.com',
    'sarah.wilson@domain.com',
    'chris.johnson@domain.com',
    'kate.miller@domain.com',
    'robert.davis@domain.com',
    'lisa.white@domain.com',
  ],
  selectedChoices: const [
    'emily.jones@domain.com',
    'david.lee@domain.com',
    'sarah.wilson@domain.com',
  ],
  hint: 'Select emails...',
  onSelectionChanged: (selectedList) {},
  chipColor: kErrorColor,
  enabled: false,
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

//Card content

class ExampleContent extends StatelessWidget {
  const ExampleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    );
  }
}

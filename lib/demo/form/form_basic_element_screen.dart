import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class FormBasicElement extends StatefulWidget {
  const FormBasicElement({super.key});

  @override
  State<FormBasicElement> createState() => _FormBasicElementState();
}

class _FormBasicElementState extends State<FormBasicElement> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).basicElement; //update your page tittle here
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
                      lang.basicElement.toUpperCase(),
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
                          label: lang.basicElement,
                          uri: RouteUri.basicElement,
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
                // Custom TextFormField
                ShowCodeCard(
                  cardTitle: 'Custom TextFormField',
                  description:
                      'Use <code>CustomTextFormField()</code> if you need to validate input (e.g., checking if the field is empty or meets certain criteria).',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdaptiveWrap(
                        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
                        breakpoints: {
                          kScreenWidthSm: 1,
                          kScreenWidthMd: 2,
                          kScreenWidthLg: 4,
                        },
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Basic Input
                              CustomTextFormField(hintText: ""),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Hint',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Input with Hint
                              CustomTextFormField(hintText: "It's a hint!"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Disabled Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Disabled Input
                              CustomTextFormField(
                                hintText: "It's disabled!",
                                enabled: false,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Readonly Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Readonly Input
                              CustomTextFormField(
                                hintText: "It's readonly!",
                                readOnly: true,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Prefix',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Input with Prefix
                              CustomTextFormField(
                                prefixIcon: Icons.mail_outline,
                                hintText: "example@gmail.com",
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Suffix',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Input with Suffix
                              CustomTextFormField(
                                suffixIcon: Icons.mail_outline,
                                hintText: "example@gmail.com",
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Password Input
                              CustomTextFormField(
                                hintText: 'Use a strong password',
                                isPassword: true,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rounded Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Rounded Input
                              CustomTextFormField(
                                prefixIcon: Icons.mail_outline,
                                hintText: "example@gmail.com",
                                radius: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Text Area',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5 * kDefaultPadding),

                          // Text area
                          CustomTextFormField(
                            hintText: "Type your message...",
                            minLines: 6,
                            maxLines: 6,
                          ),
                        ],
                      ),
                      SizedBox(height: 2 * kDefaultPadding),
                      CardDescription(
                        content:
                            'Add <code>floatingLabelBehavior:FloatingLabelBehavior.always</code> argument to set floating label.',
                      ),
                      SizedBox(height: 1.5 * kDefaultPadding),

                      // Floating lable
                      AdaptiveWrap(
                        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
                        breakpoints: {
                          kScreenWidthSm: 1,
                          kScreenWidthMd: 2,
                          kScreenWidthLg: 4,
                        },
                        spacing: kDefaultPadding,
                        runSpacing: 1.5 * kDefaultPadding,
                        children: [
                          //Basic Input
                          CustomTextFormField(
                            labelText: 'Basic Input',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "",
                          ),

                          //Input with Hint
                          CustomTextFormField(
                            labelText: 'Input with Hint',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "It's a hint!",
                          ),

                          //Disabled Input
                          CustomTextFormField(
                            labelText: 'Disabled Input',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "It's disabled!",
                            enabled: false,
                          ),

                          //Readonly Input
                          CustomTextFormField(
                            labelText: 'Readonly Input',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "It's readonly!",
                            readOnly: true,
                          ),

                          //Input with Prefix
                          CustomTextFormField(
                            labelText: 'Input with Prefix',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icons.mail_outline,
                            hintText: "example@gmail.com",
                          ),

                          //Input with Suffix
                          CustomTextFormField(
                            labelText: 'Input with Suffix',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icons.mail_outline,
                            hintText: "example@gmail.com",
                          ),

                          //Password Input
                          CustomTextFormField(
                            labelText: 'Password Input',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Use a strong password',
                            isPassword: true,
                          ),

                          //Rounded Input
                          CustomTextFormField(
                            labelText: 'Rounded Input',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: Icons.mail_outline,
                            hintText: "example@gmail.com",
                            radius: 50,
                          ),
                        ],
                      ),
                      SizedBox(height: 1.5 * kDefaultPadding),

                      // Text area
                      CustomTextFormField(
                        labelText: 'Text Area',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Type your message...",
                        minLines: 6,
                        maxLines: 6,
                      ),

                      SizedBox(height: 2 * kDefaultPadding),
                      CardDescription(
                        content:
                            'Add <code>size: FormSize.small</code>, <code>size: FormSize.medium</code>, or <code>size: FormSize.large</code> argument to set form size.',
                      ),
                      SizedBox(height: 1.5 * kDefaultPadding),
                      AdaptiveWrap(
                        columnRatios: [1 / 3, 1 / 3, 1 / 3],
                        breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 3},
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Small Sized Field',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Small Sized Field
                              CustomTextFormField(
                                prefixIcon: Icons.mail_outline,
                                hintText: "example@gmail.com",
                                size: FormSize.small,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Medium Size Field',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Medium Size Field
                              CustomTextFormField(
                                suffixIcon: Icons.mail_outline,
                                hintText: "example@gmail.com",
                                size: FormSize.medium,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Large Size Field',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 0.5 * kDefaultPadding),

                              //Large Size Field
                              CustomTextFormField(
                                hintText: 'Use a strong password',
                                isPassword: true,
                                size: FormSize.large,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
//Basic Input
CustomTextFormField(
  hintText: "",
),

//Input with Hint
CustomTextFormField(
  hintText: "It's a hint!",
),

//Disabled Input
CustomTextFormField(
  hintText: "It's disabled!",
  enabled: false,
),

//Readonly Input
CustomTextFormField(
  hintText: "It's readonly!",
  readOnly: true,
),

//Input with Prefix
CustomTextFormField(
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
),

//Input with Suffix
CustomTextFormField(
  suffixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
),

//Password Input
CustomTextFormField(
  hintText: 'Use a strong password',
  isPassword: true,
),

//Rounded Input
CustomTextFormField(
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  radius: 50,
),

// Text area
CustomTextFormField(
hintText: "Type your message...",
minLines: 6,
maxLines: 6,
),

//Small Sized Field
CustomTextFormField(
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  size: FormSize.small,
),

//Medium Size Field
CustomTextFormField(
  suffixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  size: FormSize.medium,
),

//Large Size Field
CustomTextFormField(
  hintText: 'Use a strong password',
  isPassword: true,
  size: FormSize.large,
),

/// FLOATING LABEL ///

//Basic Input
CustomTextFormField(
  labelText: 'Basic Input',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: "",
),

//Input with Hint
CustomTextFormField(
  labelText: 'Input with Hint',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: "It's a hint!",
),

//Disabled Input
CustomTextFormField(
  labelText: 'Disabled Input',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: "It's disabled!",
  enabled: false,
),

//Readonly Input
CustomTextFormField(
  labelText: 'Readonly Input',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: "It's readonly!",
  readOnly: true,
),

//Input with Prefix
CustomTextFormField(
  labelText: 'Input with Prefix',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
),

//Input with Suffix
CustomTextFormField(
  labelText: 'Input with Suffix',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  suffixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
),

//Password Input
CustomTextFormField(
  labelText: 'Password Input',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  hintText: 'Use a strong password',
  isPassword: true,
),

//Rounded Input
CustomTextFormField(
  labelText: 'Rounded Input',
  floatingLabelBehavior: FloatingLabelBehavior.always,
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  radius: 50,
),

  // Text area
CustomTextFormField(
labelText: 'Text Area',
floatingLabelBehavior: FloatingLabelBehavior.always,
hintText: "Type your message...",
minLines: 6,
maxLines: 6,
),

//Small Sized Field
CustomTextFormField(
  prefixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  size: FormSize.small,
),

//Medium Size Field
CustomTextFormField(
  suffixIcon: Icons.mail_outline,
  hintText: "example@gmail.com",
  size: FormSize.medium,
),

  //Large Size Field
CustomTextFormField(
  hintText: 'Use a strong password',
  isPassword: true,
  size: FormSize.large,
),
''',
                ),
                SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Default TextFormField',
                  description:
                      'Use <code>TextFormField()</code> if you need to validate input (e.g., checking if the field is empty or meets certain criteria).',
                  uiView: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AdaptiveWrap(
                        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
                        breakpoints: {
                          kScreenWidthSm: 1,
                          kScreenWidthMd: 2,
                          kScreenWidthLg: 4,
                        },
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Basic Input
                              TextFormField(
                                decoration: InputDecoration(hintText: ''),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Hint',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Input with Hint
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Input with Hint', // set hint
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Disable Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Disable Input
                              TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  hintText: 'Disable Input',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Readonly Input',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Readonly Input
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: 'Readonly Input',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Prefix',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Input with Prefix
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "example@gmail.com",
                                  prefixIcon: Icon(Icons.mail_outline),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Input with Suffix',
                                style: TextStyle(
                                  color: themeData.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding / 2),

                              //Input with Suffix
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "example@gmail.com",
                                  prefixIcon: Icon(Icons.mail_outline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: kDefaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Text Area',
                            style: TextStyle(
                              color: themeData.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 2),

                          //Text Area
                          TextFormField(
                            minLines: 6,
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText: 'Type something here...',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2 * kDefaultPadding),

                      CardDescription(
                        content:
                            'Add <code>floatingLabelBehavior:FloatingLabelBehavior.always</code> argument to set floating label.',
                      ),

                      SizedBox(height: 1.5 * kDefaultPadding),

                      /// Floating Label
                      AdaptiveWrap(
                        columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
                        breakpoints: {
                          kScreenWidthSm: 1,
                          kScreenWidthMd: 2,
                          kScreenWidthLg: 4,
                        },
                        spacing: kDefaultPadding,
                        runSpacing: 1.5 * kDefaultPadding,
                        children: [
                          //Basic Input
                          TextFormField(
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Basic Input',
                              hintText: '',
                            ),
                          ),

                          //Input with Hint
                          TextFormField(
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Input with Hint',
                              hintText: 'Input with Hint',
                            ),
                          ),

                          //Disable Input
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Disable Input',
                              hintText: 'Disable Input',
                            ),
                          ),

                          //Readonly Input
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Readonly Input',
                              hintText: 'Readonly Input',
                            ),
                          ),

                          //Input with Prefix
                          TextFormField(
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Input with Prefix',
                              hintText: "example@gmail.com",
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                          ),

                          //Input with Suffix
                          TextFormField(
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelText: 'Input with Suffix',
                              hintText: "example@gmail.com",
                              suffixIcon: Icon(Icons.mail_outline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.5 * kDefaultPadding),

                      //Text Area
                      TextFormField(
                        minLines: 6,
                        maxLines: 6,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Text Area',
                          hintText: 'Type something here...',
                        ),
                      ),
                    ],
                  ),
                  codeView: '''
//Basic Input
TextFormField(
  decoration: InputDecoration(
    hintText: '',
  ),
),

//Input with Hint
TextFormField(
  decoration: InputDecoration(
    hintText: 'Input with Hint', // set hint
  ),
),

//Disable Input
TextFormField(
  enabled: false,
  decoration: InputDecoration(
    hintText: 'Disable Input',
  ),
),

//Readonly Input
TextFormField(
  readOnly: true,
  decoration: InputDecoration(
    hintText: 'Readonly Input',
  ),
),

//Input with Prefix
TextFormField(
  decoration: InputDecoration(
    hintText: "example@gmail.com",
    prefixIcon: Icon(Icons.mail_outline),
  ),
),

//Input with Suffix
TextFormField(
  decoration: InputDecoration(
    hintText: "example@gmail.com",
    prefixIcon: Icon(Icons.mail_outline),
  ),
),

//Text Area
TextFormField(
  minLines: 6,
  maxLines: 6,
  decoration: InputDecoration(
    hintText: 'Type something here...',
  ),
),

/// FLOATING LABEL
//Basic Input
TextFormField(
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Basic Input',
    hintText: '',
  ),
),

//Input with Hint
TextFormField(
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Input with Hint',
    hintText: 'Input with Hint',
  ),
),

//Disable Input
TextFormField(
  enabled: false,
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Disable Input',
    hintText: 'Disable Input',
  ),
),

//Readonly Input
TextFormField(
  readOnly: true,
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Readonly Input',
    hintText: 'Readonly Input',
  ),
),

//Input with Prefix
TextFormField(
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Input with Prefix',
    hintText: "example@gmail.com",
    prefixIcon: Icon(Icons.mail_outline),
  ),
),

//Input with Suffix
TextFormField(
  decoration: InputDecoration(
    floatingLabelBehavior:
        FloatingLabelBehavior.always,
    labelText: 'Input with Suffix',
    hintText: "example@gmail.com",
    suffixIcon: Icon(Icons.mail_outline),
  ),
),

//Text Area
TextFormField(
  minLines: 6,
  maxLines: 6,
  decoration: InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: 'Text Area',
    hintText: 'Type something here...',
  ),
),                         
''',
                ),

                SizedBox(height: kDefaultPadding),

                //                 ShowCodeCard(
                //                   cardTitle: 'Custom TextField',
                //                   description:
                //                       'Use <code>CustomTextField()</code> if you need a straightforward input field without form validation.',
                //                   uiView: Column(
                //                     children: [
                //                       LayoutBuilder(
                //                         builder: (context, constraints) {
                //                           int numberOfCardsPerRow =
                //                               getNumberOfCardsPerRow_4(context);
                //                           return Wrap(
                //                             spacing: kDefaultPadding,
                //                             runSpacing: 2 * kDefaultPadding,
                //                             children: [
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Basic Input',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Basic Input
                //                                     CustomTextField(
                //                                       hintText: "",
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Input with Hint',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Input with Hint
                //                                     CustomTextField(
                //                                       hintText: "It's a hint!",
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Disabled Input',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Disabled Input
                //                                     CustomTextField(
                //                                       hintText: "It's disabled!",
                //                                       enabled: false,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Readonly Input',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),
                //                                     //Readonly Input
                //                                     CustomTextField(
                //                                       hintText: "It's readonly!",
                //                                       readOnly: true,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Input with Prefix',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Input with Prefix
                //                                     CustomTextField(
                //                                       prefixIcon: Icons.mail_outline,
                //                                       hintText: "example@gmail.com",
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Input with Suffix',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Input with Suffix
                //                                     CustomTextField(
                //                                       suffixIcon: Icons.mail_outline,
                //                                       hintText: "example@gmail.com",
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),

                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Password Input',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Password Input
                //                                     CustomTextField(
                //                                       hintText: 'Use a strong password',
                //                                       isPassword: true,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),

                //                               SizedBox(
                //                                 width: calculateCardWidth_4(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Rounded Input',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Rounded Input
                //                                     CustomTextField(
                //                                       prefixIcon: Icons.mail_outline,
                //                                       hintText: "example@gmail.com",
                //                                       radius: 50,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),

                //                               // Text area
                //                               Column(
                //                                 crossAxisAlignment: CrossAxisAlignment.start,
                //                                 children: [
                //                                   Text(
                //                                     'Text Area',
                //                                     style: TextStyle(
                //                                       color: themeData.colorScheme.onSurface,
                //                                       fontWeight: FontWeight.w600,
                //                                     ),
                //                                   ),
                //                                   SizedBox(
                //                                     height: 0.5 * kDefaultPadding,
                //                                   ),

                //                                   // Text area
                //                                   CustomTextField(
                //                                     hintText: "Type your message...",
                //                                     minLines: 6,
                //                                     maxLines: 6,
                //                                   ),
                //                                 ],
                //                               ),
                //                             ],
                //                           );
                //                         },
                //                       ),
                //                       SizedBox(
                //                         height: kDefaultPadding,
                //                       ),
                //                       LayoutBuilder(
                //                         builder: (context, constraints) {
                //                           int numberOfCardsPerRow =
                //                               getNumberOfCardsPerRow_3(context);
                //                           return Wrap(
                //                             spacing: kDefaultPadding,
                //                             runSpacing: kDefaultPadding,
                //                             children: [
                //                               SizedBox(
                //                                 width: calculateCardWidth_3(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Small Sized Field',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Small Sized Field
                //                                     CustomTextField(
                //                                       prefixIcon: Icons.mail_outline,
                //                                       hintText: "example@gmail.com",
                //                                       size: FormSize.small,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_3(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Medium Size Field',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Medium Size Field
                //                                     CustomTextField(
                //                                       suffixIcon: Icons.mail_outline,
                //                                       hintText: "example@gmail.com",
                //                                       size: FormSize.medium,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: calculateCardWidth_3(
                //                                     context, constraints, numberOfCardsPerRow),
                //                                 child: Column(
                //                                   crossAxisAlignment: CrossAxisAlignment.start,
                //                                   children: [
                //                                     Text(
                //                                       'Large Size Field',
                //                                       style: TextStyle(
                //                                         color: themeData.colorScheme.onSurface,
                //                                         fontWeight: FontWeight.w600,
                //                                       ),
                //                                     ),
                //                                     SizedBox(
                //                                       height: 0.5 * kDefaultPadding,
                //                                     ),

                //                                     //Large Size Field
                //                                     CustomTextField(
                //                                       hintText: 'Use a strong password',
                //                                       isPassword: true,
                //                                       size: FormSize.large,
                //                                     ),
                //                                   ],
                //                                 ),
                //                               ),
                //                             ],
                //                           );
                //                         },
                //                       ),
                //                     ],
                //                   ),
                //                   codeView: '''
                // //Basic Input
                // CustomTextField(
                //   hintText: "",
                // ),

                // //Input with Hint
                // CustomTextField(
                //   hintText: "It's a hint!",
                // ),

                // //Disabled Input
                // CustomTextField(
                //   hintText: "It's disabled!",
                //   enabled: false,
                // ),

                // //Readonly Input
                // CustomTextField(
                //   hintText: "It's readonly!",
                //   readOnly: true,
                // ),

                // //Input with Prefix
                // CustomTextField(
                //   prefixIcon: Icons.mail_outline,
                //   hintText: "example@gmail.com",
                // ),

                // //Input with Suffix
                // CustomTextField(
                //   suffixIcon: Icons.mail_outline,
                //   hintText: "example@gmail.com",
                // ),

                // //Password Input
                // CustomTextField(
                //   hintText: 'Use a strong password',
                //   isPassword: true,
                // ),

                // //Rounded Input
                // CustomTextField(
                //   prefixIcon: Icons.mail_outline,
                //   hintText: "example@gmail.com",
                //   radius: 50,
                // ),

                // // Text area
                // CustomTextField(
                // hintText: "Type your message...",
                // minLines: 6,
                // maxLines: 6,
                // ),

                // //Small Sized Field
                // CustomTextField(
                //   prefixIcon: Icons.mail_outline,
                //   hintText: "example@gmail.com",
                //   size: FormSize.small,
                // ),

                // //Medium Size Field
                // CustomTextField(
                //   suffixIcon: Icons.mail_outline,
                //   hintText: "example@gmail.com",
                //   size: FormSize.medium,
                // ),

                // //Large Size Field
                // CustomTextField(
                //   hintText: 'Use a strong password',
                //   isPassword: true,
                //   size: FormSize.large,
                // ),
                // ''',
                //                 ),
                //                 SizedBox(
                //                   height: kDefaultPadding,
                //                 ),

                // Text Button Field
                ShowCodeCard(
                  cardTitle: 'Input With Button',
                  description:
                      'Use <code>ActionInputField()</code> to set a textfield with button.',
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
                                  'Search Form',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Search Form
                                ActionInputField(
                                  hintText: "Type something...",
                                  buttonText: "Search",
                                  buttonColor: kPrimaryColor,
                                  textColor: Colors.white,
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
                                  'Tracking ID',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),
                                //Tracking ID
                                ActionInputField(
                                  hintText: "Enter Tracking ID",
                                  buttonText: "Track",
                                  buttonColor: kErrorColor,
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
                                  'Promo Code',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Promo Code
                                ActionInputField(
                                  hintText: "Enter promo code",
                                  buttonText: "Redeem",
                                  buttonColor: kSuccessColor,
                                ),
                              ],
                            ),
                          ),

                          // rounded input button
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
                                  'Rounded Search Form',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Rounded Search Form
                                ActionInputField(
                                  hintText: "Type something...",
                                  buttonText: "Search",
                                  buttonColor: kPrimaryColor,
                                  textColor: Colors.white,
                                  radius: 50,
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
                                  'Rounded Tracking ID',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Rounded Tracking ID
                                ActionInputField(
                                  hintText: "Enter Tracking ID",
                                  buttonText: "Track",
                                  buttonColor: kErrorColor,
                                  radius: 50,
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
                                  'Rounded Promo Code',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Rounded Promo Code
                                ActionInputField(
                                  hintText: "Enter promo code",
                                  buttonText: "Redeem",
                                  buttonColor: kSuccessColor,
                                  radius: 50,
                                ),
                              ],
                            ),
                          ),

                          // size input button
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
                                  'Small Search Form',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //Small Search Form
                                ActionInputField(
                                  hintText: "Type something...",
                                  buttonText: "Search",
                                  buttonColor: kPrimaryColor,
                                  textColor: Colors.white,
                                  size:
                                      FormSize.small, // set form size to small
                                  radius: 50,
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
                                  'Medium Input Button',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                //MEdium Tracking Form
                                ActionInputField(
                                  hintText: "Enter Tracking ID",
                                  buttonText: "Track",
                                  buttonColor: kErrorColor,
                                  radius: 50,
                                  size: FormSize
                                      .medium, // set form size to medium
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
                                  'Large Input Button',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5 * kDefaultPadding),

                                // Large Promo Form
                                ActionInputField(
                                  hintText: "Enter promo code",
                                  buttonText: "Redeem",
                                  buttonColor: kSuccessColor,
                                  radius: 50,
                                  size:
                                      FormSize.large, // set form size to large
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
//Search Form
ActionInputField(
  hintText: "Type something...",
  buttonText: "Search",
  buttonColor: kPrimaryColor,
  textColor: Colors.white,
),

//Tracking Form
ActionInputField(
  hintText: "Enter Tracking ID",
  buttonText: "Track",
  buttonColor: kErrorColor,
),

//Promo Code
ActionInputField(
  hintText: "Enter promo code",
  buttonText: "Redeem",
  buttonColor: kSuccessColor,
),

//Rounded Search Form
ActionInputField(
  hintText: "Type something...",
  buttonText: "Search",
  buttonColor: kPrimaryColor,
  textColor: Colors.white,
  radius: 50,
),

//Rounded Tracking Form
ActionInputField(
  hintText: "Enter Tracking ID",
  buttonText: "Track",
  buttonColor: kErrorColor,
  radius: 50,
),

//Rounded Promo Code
ActionInputField(
  hintText: "Enter promo code",
  buttonText: "Redeem",
  buttonColor: kSuccessColor,
  radius: 50,
),

//Small Search Form
ActionInputField(
  hintText: "Type something...",
  buttonText: "Search",
  buttonColor: kPrimaryColor,
  textColor: Colors.white,
  size: FormSize.small, // set form size to small
  radius: 50,
),

//MEdium Tracking Form
ActionInputField(
  hintText: "Enter Tracking ID",
  buttonText: "Track",
  buttonColor: kErrorColor,
  radius: 50,
  size: FormSize.medium, // set form size to medium
),

// Large Promo Form
ActionInputField(
  hintText: "Enter promo code",
  buttonText: "Redeem",
  buttonColor: kSuccessColor,
  radius: 50,
  size: FormSize.large, // set form size to large
),
''',
                ),

                SizedBox(height: kDefaultPadding),

                // search bar
                ShowCodeCard(
                  cardTitle: 'Search Bar',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_2(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
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
                                  'Outlined Search Bar',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Use <code>OutlineSearchBar()</code> to set search bar.',
                                ),
                                SizedBox(height: kDefaultPadding),

                                // Outlined Search Bar
                                OutlineSearchBar(hintText: 'Search...'),
                                SizedBox(height: kDefaultPadding),
                                OutlineSearchBar(
                                  hintText: 'Search...',
                                  radius: 50, // set as rounded
                                ),
                              ],
                            ),
                          ),
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
                                  'Soft Search Bar',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Use <code>SoftSearchBar()</code> to set soft search bar.',
                                ),
                                SizedBox(height: kDefaultPadding),

                                // Soft Search Bar
                                SoftSearchBar(hintText: 'Search...'),
                                SizedBox(height: kDefaultPadding),
                                SoftSearchBar(
                                  hintText: 'Search...',
                                  radius: 50, // set as rounded
                                ),
                              ],
                            ),
                          ),
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
                                  'Search Bar with Actions',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Use <code>SearchBarWithActions()</code> to set soft search bar.',
                                ),
                                SizedBox(height: kDefaultPadding),

                                // Search Bar with Actions
                                SearchBarWithActions(hintText: 'Search...'),
                              ],
                            ),
                          ),
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
                                  'Oversize Search Bar',
                                  style: TextStyle(
                                    color: themeData.colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CardDescription(
                                  content:
                                      'Use <code>OversizeSearchBar()</code> to set soft search bar.',
                                ),
                                SizedBox(height: kDefaultPadding),

                                // Oversize Search Bar
                                OversizeSearchBar(hintText: 'Search...'),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// Outlined Search Bar
OutlineSearchBar(
  hintText: 'Search...',
),

OutlineSearchBar(
  hintText: 'Search...',
  radius: 50, // set as rounded
),

// Soft Search Bar
SoftSearchBar(
  hintText: 'Search...',
),

SoftSearchBar(
  hintText: 'Search...',
  radius: 50, // set as rounded
),

// Search Bar with Actions
SearchBarWithActions(),

// Oversize Search Bar
OversizeSearchBar(),
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

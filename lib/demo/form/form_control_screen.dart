import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/form/form_checkbox_radio.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';
import 'package:flutkit_ademin/widgets/helper/show_code_card.dart';

// Enum definition for color variant radio button
enum RadioOptionColor { color1, color2, color3, color4, color5, color6, color7 }

// Enum definition for color variant outline radio button
enum RadioOptionOutline {
  outline1,
  outline2,
  outline3,
  outline4,
  outline5,
  outline6,
  outline7,
}

class FormCheckboxRadioScreen extends StatefulWidget {
  const FormCheckboxRadioScreen({super.key});

  @override
  State<FormCheckboxRadioScreen> createState() =>
      _FormCheckboxRadioScreenState();
}

class _FormCheckboxRadioScreenState extends State<FormCheckboxRadioScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).formControl; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Define the state of each checkbox
  bool isChecked1 = false;
  bool isChecked2 = true;
  bool isChecked3 = false;
  bool isChecked4 = true;
  bool isChecked5 = false;
  bool isChecked6 = true;
  bool isChecked7 = true;
  bool isChecked8 = true;
  bool isChecked9 = true;
  bool isChecked10 = true;
  bool isChecked11 = true;
  bool isChecked12 = true;
  bool isChecked13 = true;
  bool isChecked14 = true;
  bool isChecked15 = true;
  bool isChecked16 = true;
  bool isChecked17 = true;
  bool isChecked18 = true;
  bool isChecked19 = true;
  bool isChecked20 = true;

  // Define the state of each radio button

  bool isOption1Selected = true;
  bool isOption2Selected = false;
  bool isOption3Selected = true;
  bool isOption4Selected = false;
  bool isOption5Selected = true;
  bool isOption6Selected = false;

  // Define the state of each switch

  bool isSwitch1On = false;
  bool isSwitch2On = true;
  bool isSwitch3On = false;
  bool isSwitch4On = true;
  bool isSwitch5On = false;
  bool isSwitch6On = true;

  bool isSwitch7On = true;
  bool isSwitch8On = true;
  bool isSwitch9On = true;
  bool isSwitch10On = true;
  bool isSwitch11On = true;
  bool isSwitch12On = true;
  bool isSwitch13On = true;

  bool isSwitch14On = true;
  bool isSwitch15On = true;
  bool isSwitch16On = true;
  bool isSwitch17On = true;
  bool isSwitch18On = true;
  bool isSwitch19On = true;
  bool isSwitch20On = true;

  // Initialize for a default selection for radio button (color and outline)
  RadioOptionColor selectedColorOption = RadioOptionColor.color1;
  RadioOptionOutline selectedOutlineOption = RadioOptionOutline.outline4;

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
                      lang.formControl.toUpperCase(),
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
                          label: lang.formControl,
                          uri: RouteUri.formControl,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: kDefaultPadding),

          //content

          //Default Checkbox
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Default Checkbox',
              description:
                  'Use <code>Checkbox()</code> to set a default checkbox.',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_3(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox, with label on the right side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 2),

                            //Checkbox Label on right, isChecked1 = false
                            Row(
                              children: [
                                // checkbox
                                Checkbox(
                                  value: isChecked1,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked1 = newValue!;
                                    });
                                  },
                                ),

                                // label
                                Text(
                                  'Label on right',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),

                            //Checkbox Label on right, isChecked1 = true
                            Row(
                              children: [
                                // checkbox
                                Checkbox(
                                  value: isChecked2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked2 = newValue!;
                                    });
                                  },
                                ),

                                // label
                                Text(
                                  'Label on right',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ],
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox, with label on the left side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 2),

                            //Checkbox Label on left, isChecked3 = false
                            Row(
                              children: [
                                // label
                                Text(
                                  'Label on left',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                // checkbox
                                Checkbox(
                                  value: isChecked3,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked3 = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),

                            //Checkbox Label on left, isChecked4 = true
                            Row(
                              children: [
                                // label
                                Text(
                                  'Label on left',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                                // checkbox
                                Checkbox(
                                  value: isChecked4,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked4 = newValue!;
                                    });
                                  },
                                ),
                              ],
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Disable Checkbox',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                            //Checkbox Label on right, isChecked5 = false,
                            Row(
                              children: [
                                // checkbox
                                Checkbox(value: isChecked5, onChanged: null),

                                // label
                                Text(
                                  'Label on right',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),

                            //Checkbox Label on right, isChecked6 = true
                            Row(
                              children: [
                                // checkbox
                                Checkbox(value: isChecked6, onChanged: null),

                                // label
                                Text(
                                  'Label on right',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: themeData.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              codeView: '''
//Checkbox Label on right, isChecked1 = false
Row(
  children: [
    // checkbox
    Checkbox(
      value: isChecked1,
      onChanged: (newValue) {
        setState(() {
          isChecked1 = newValue!;
        });
      },
    ),

    // label
    Text(
      'Label on right',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    )
  ],
),

//Checkbox Label on right, isChecked1 = true
Row(
  children: [
    // checkbox
    Checkbox(
      value: isChecked2,
      onChanged: (newValue) {
        setState(() {
          isChecked2 = newValue!;
        });
      },
    ),

    // label
    Text(
      'Label on right',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    )
  ],
),

//Checkbox Label on left, isChecked3 = false
Row(
  children: [
    // label
    Text(
      'Label on left',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    ),
    // checkbox
    Checkbox(
      value: isChecked3,
      onChanged: (newValue) {
        setState(() {
          isChecked3 = newValue!;
        });
      },
    ),
  ],
),

//Checkbox Label on left, isChecked4 = true
Row(
  children: [
    // label
    Text(
      'Label on left',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    ),
    // checkbox
    Checkbox(
      value: isChecked4,
      onChanged: (newValue) {
        setState(() {
          isChecked4 = newValue!;
        });
      },
    ),
  ],
),

//Checkbox Label on right, isChecked5 = false, 
Row(
  children: [
    // checkbox
    Checkbox(
      value: isChecked5,
      onChanged: null, // disable checkbox
    ),

    // label
    Text(
      'Label on right',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    )
  ],
),

//Checkbox Label on right, isChecked6 = true
Row(
  children: [
    // checkbox
    Checkbox(
      value: isChecked6,
      onChanged: null, // disable checkbox
    ),

    // label
    Text(
      'Label on right',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: themeData.colorScheme.onSurface,
      ),
    )
  ],
),
''',
            ),
          ),

          SizedBox(height: kDefaultPadding),

          //Custom Checkbox
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Custom Checkbox',
              description:
                  'Use <code>CustomCheckbox()</code> to set a custom checkbox. You can set different arguments to suit use cases.',
              codeView: '''
//Checkbox Label on right, isChecked1 = false
CustomCheckbox(
  label: 'Label on right',
  value: isChecked1,
  onChanged: (newValue) {
    setState(() {
      isChecked1 = newValue!;
    });
  },
),

//Checkbox Label on right, isChecked1 = true
CustomCheckbox(
  label: 'Label on right',
  value: isChecked2,
  onChanged: (newValue) {
    setState(() {
      isChecked2 = newValue!;
    });
  },
),

//Checkbox Label on left, isChecked3 = false
CustomCheckbox(
  label: 'Label on left',
  value: isChecked3,
  onChanged: (newValue) {
    setState(() {
      isChecked3 = newValue!;
    });
  },
  isLabelOnRight: false,
),

//Checkbox Label on left, isChecked4 = true
CustomCheckbox(
  label: 'Label on left',
  value: isChecked4,
  onChanged: (newValue) {
    setState(() {
      isChecked4 = newValue!;
    });
  },
  isLabelOnRight: false,
),

//Checkbox Label on right, isChecked5 = false, isDisabled: true,
CustomCheckbox(
  label: 'Disable checkbox',
  value: isChecked5,
  onChanged: (newValue) {
    setState(() {
      isChecked5 = newValue!;
    });
  },
  isDisabled: true,
),

//Checkbox Label on right, isChecked5 = true, isDisabled: true,
CustomCheckbox(
  label: 'Disable checkbox',
  value: isChecked6,
  onChanged: (newValue) {
    setState(() {
      isChecked6 = newValue!;
    });
  },
  isDisabled: true,
),

// remove label to create checkbox without label
CustomCheckbox(
  value: isChecked2,
  onChanged: (newValue) {
    setState(() {
      isChecked2 = newValue!;
    });
  },
),

CustomCheckbox(
  value: isChecked3,
  onChanged: (newValue) {
    setState(() {
      isChecked3 = newValue!;
    });
  },
),

CustomCheckbox(
  value: isChecked4,
  onChanged: (newValue) {
    setState(() {
      isChecked4 = newValue!;
    });
  },
),
''',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_4(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox, with label on the right side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),

                            //Checkbox Label on right, isChecked1 = false
                            CustomCheckbox(
                              label: 'Label on right',
                              value: isChecked1,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked1 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),

                            //Checkbox Label on right, isChecked1 = true
                            CustomCheckbox(
                              label: 'Label on right',
                              value: isChecked2,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked2 = newValue!;
                                });
                              },
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox, with label on the left side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Checkbox Label on left, isChecked3 = false
                            CustomCheckbox(
                              label: 'Label on left',
                              value: isChecked3,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked3 = newValue!;
                                });
                              },
                              isLabelOnRight: false,
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Checkbox Label on left, isChecked4 = true
                            CustomCheckbox(
                              label: 'Label on left',
                              value: isChecked4,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked4 = newValue!;
                                });
                              },
                              isLabelOnRight: false,
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Disable Checkbox',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Checkbox Label on right, isChecked5 = false, isDisabled: true,
                            CustomCheckbox(
                              label: 'Disable checkbox',
                              value: isChecked5,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked5 = newValue!;
                                });
                              },
                              isDisabled: true,
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Checkbox Label on right, isChecked5 = true, isDisabled: true,
                            CustomCheckbox(
                              label: 'Disable checkbox',
                              value: isChecked6,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked6 = newValue!;
                                });
                              },
                              isDisabled: true,
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox without label',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Checkbox with out label
                            Row(
                              children: [
                                CustomCheckbox(
                                  value: isChecked1,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked1 = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomCheckbox(
                                  value: isChecked2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked2 = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomCheckbox(
                                  value: isChecked3,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked3 = newValue!;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomCheckbox(
                                  value: isChecked4,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isChecked4 = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: kDefaultPadding),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Color & Outlined Checkbox',
              description:
                  'Use <code>CustomCheckbox()</code> and add <code>activeColor</code> argument to set a checkbox with color varian. Add <code>isOutlined: true</code> argument to set an outlined switch. ',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Checkbox with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Primary',
                              value: isChecked7,
                              activeColor: kPrimaryColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked7 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Secondary',
                              value: isChecked8,
                              activeColor: kSecondaryColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked8 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Success',
                              value: isChecked9,
                              activeColor: kSuccessColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked9 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Info',
                              value: isChecked10,
                              activeColor: kInfoColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked10 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Warning',
                              value: isChecked11,
                              activeColor: kWarningColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked11 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Danger',
                              value: isChecked12,
                              activeColor: kErrorColor, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked12 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Dark',
                              value: isChecked13,
                              activeColor: themeData
                                  .colorScheme
                                  .onSurface, // set active color
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked13 = newValue!;
                                });
                              },
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Outline Checkbox, with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Primary',
                              value: isChecked14,
                              activeColor: kPrimaryColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked14 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Secondary',
                              value: isChecked15,
                              activeColor: kSecondaryColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked15 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Success',
                              value: isChecked16,
                              activeColor: kSuccessColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked16 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Info',
                              value: isChecked17,
                              activeColor: kInfoColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked17 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Warning',
                              value: isChecked18,
                              activeColor: kWarningColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked18 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Danger',
                              value: isChecked19,
                              activeColor: kErrorColor,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked19 = newValue!;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomCheckbox(
                              label: 'Checkbox Outline Dark',
                              value: isChecked20,
                              activeColor: themeData.colorScheme.onSurface,
                              isOutlined: true, // set as outlined checkbox
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked20 = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              codeView: '''
//Checkbox with color variation

CustomCheckbox(
  label: 'Checkbox Primary',
  value: isChecked7,
  activeColor: kPrimaryColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked7 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Secondary',
  value: isChecked8,
  activeColor: kSecondaryColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked8 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Success',
  value: isChecked9,
  activeColor: kSuccessColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked9 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Info',
  value: isChecked10,
  activeColor: kInfoColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked10 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Warning',
  value: isChecked11,
  activeColor: kWarningColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked11 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Danger',
  value: isChecked12,
  activeColor: kErrorColor, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked12 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Dark',
  value: isChecked13,
  activeColor: themeData
      .colorScheme.onSurface, // set active color
  onChanged: (newValue) {
    setState(() {
      isChecked13 = newValue!;
    });
  },
),

//Outline Checkbox, with color variation

CustomCheckbox(
  label: 'Checkbox Outline Primary',
  value: isChecked14,
  activeColor: kPrimaryColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked14 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Secondary',
  value: isChecked15,
  activeColor: kSecondaryColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked15 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Success',
  value: isChecked16,
  activeColor: kSuccessColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked16 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Info',
  value: isChecked17,
  activeColor: kInfoColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked17 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Warning',
  value: isChecked18,
  activeColor: kWarningColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked18 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Danger',
  value: isChecked19,
  activeColor: kErrorColor,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked19 = newValue!;
    });
  },
),

CustomCheckbox(
  label: 'Checkbox Outline Dark',
  value: isChecked20,
  activeColor: themeData.colorScheme.onSurface,
  isOutlined: true, // set as outlined checkbox
  onChanged: (newValue) {
    setState(() {
      isChecked20 = newValue!;
    });
  },
),
''',
            ),
          ),

          SizedBox(height: kDefaultPadding),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Multiple Checkbox',
              description:
                  'Use <code>MultiCheckboxWidget()</code> to set a multiple options checkbox. You can set different arguments to suit use cases.',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Select Your Favorite Tech',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'You can select more than one item.',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            MultiCheckboxWidget(
                              options: [
                                'Flutter',
                                'React Native',
                                'Swift (iOS)',
                                'Kotlin (Android)',
                                'Xamarin',
                                'PHP',
                              ],
                              selectedOptions: [
                                'Flutter',
                                'Swift (iOS)',
                                'Xamarin',
                              ],
                              activeColor: kSuccessColor,
                              isOutlined: false,
                              isLabelOnRight: true,
                              icon: Icons.check,
                              onChanged: (selected) {
                                debugPrint('Checkbox value: $selected');
                              },
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Select Your Dream Vacation Destination',
                              style: TextStyle(
                                color: themeData.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'You can select more than one item.',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            MultiCheckboxWidget(
                              options: [
                                'Paris, France',
                                'Kyoto, Japan',
                                'Santorini, Greece',
                                'Rio de Janeiro, Brazil',
                                'Banff National Park, Canada',
                                'Maldives Islands',
                              ],
                              selectedOptions: [
                                'Paris, France',
                                'Santorini, Greece',
                                'Banff National Park, Canada',
                                'Maldives Islands',
                              ],
                              activeColor: kErrorColor,
                              isOutlined: true,
                              isLabelOnRight: true,
                              icon: Icons.check_rounded,
                              onChanged: (selected) {
                                debugPrint('Checkbox value: $selected');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              codeView: '''
// Favorite Tech
MultiCheckboxWidget(
  options: [
    'Flutter',
    'React Native',
    'Swift (iOS)',
    'Kotlin (Android)',
    'Xamarin',
    'PHP'
  ],
  selectedOptions: [
    'Flutter',
    'Swift (iOS)',
    'Xamarin',
  ],
  activeColor: kSuccessColor,
  isOutlined: false,
  isLabelOnRight: true,
  icon: Icons.check,
  onChanged: (selected) {
    // selected options
  },
),

// Vacation Destination
MultiCheckboxWidget(
  options: [
    'Paris, France',
    'Kyoto, Japan',
    'Santorini, Greece',
    'Rio de Janeiro, Brazil',
    'Banff National Park, Canada',
    'Maldives Islands',
  ],
  selectedOptions: [
    'Paris, France',
    'Santorini, Greece',
    'Banff National Park, Canada',
    'Maldives Islands',
  ],
  activeColor: kErrorColor,
  isOutlined: true,
  isLabelOnRight: true,
  icon: Icons.check_rounded,
  onChanged: (selected) {
    // selected options
  },
),                           
            ''',
            ),
          ),

          SizedBox(height: kDefaultPadding),

          //Radio
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Radio Button',
              description:
                  'Use <code>CustomRadioButton()</code> to set a custom radio button. You can set different arguments to suit use cases.',
              codeView: '''
//Radio button active, label on the right
CustomRadioButton(
  label: 'Option 1',
  value: isOption1Selected,
  onChanged: (newValue) {
    setState(() {
      isOption1Selected = true;
      isOption2Selected =
          false; // Deselect other option
    });
  },
  isLabelOnRight: true,
),


CustomRadioButton(
  label: 'Option 2',
  value: isOption2Selected,
  onChanged: (newValue) {
    setState(() {
      isOption1Selected = false;
      isOption2Selected = true;
    });
  },
  isLabelOnRight: true,
),

//Radio button active, label on the left
CustomRadioButton(
  label: 'Option 3',
  value: isOption3Selected,
  onChanged: (newValue) {
    setState(() {
      isOption3Selected = true;
      isOption4Selected = false;
    });
  },
  isLabelOnRight: false, // set label on the left
),

CustomRadioButton(
  label: 'Option 4',
  value: isOption4Selected,
  onChanged: (newValue) {
    setState(() {
      isOption3Selected = false;
      isOption4Selected = true;
    });
  },
  isLabelOnRight: false, // set label on the left
),

//Disable radio button active
CustomRadioButton(
  label: 'Option 5',
  value: isOption5Selected,
  onChanged: (newValue) {
    setState(() {
      isOption5Selected = true;
      isOption6Selected = false;
    });
  },
  isLabelOnRight: true,
  isDisabled: true, // disable radio button
),

CustomRadioButton(
  label: 'Option 6',
  value: isOption6Selected,
  onChanged: (newValue) {
    setState(() {
      isOption3Selected = false;
      isOption4Selected = true;
    });
  },
  isLabelOnRight: true,
  isDisabled: true, // disable radio button
),

//Radio button without Label
// remove label argument
CustomRadioButton(
  value: isOption1Selected,
  onChanged: (newValue) {
    setState(() {
      isOption1Selected = true;
      isOption2Selected =
          false; 
    });
  },
),

CustomRadioButton(
  value: isOption2Selected,
  onChanged: (newValue) {
    setState(() {
      isOption1Selected = false;
      isOption2Selected = true;
    });
  },
),
''',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_4(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Radio Button, with label on the right side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Radio button active, label on the right
                            CustomRadioButton(
                              label: 'Option 1',
                              value: isOption1Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption1Selected = true;
                                  isOption2Selected =
                                      false; // Deselect other option
                                });
                              },
                              isLabelOnRight: true,
                            ),
                            SizedBox(height: kDefaultPadding),

                            CustomRadioButton(
                              label: 'Option 2',
                              value: isOption2Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption1Selected = false;
                                  isOption2Selected = true;
                                });
                              },
                              isLabelOnRight: true,
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Radio Button, with label on the left side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Radio button active, label on the left
                            CustomRadioButton(
                              label: 'Option 3',
                              value: isOption3Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption3Selected = true;
                                  isOption4Selected = false;
                                });
                              },
                              isLabelOnRight: false, // set label on the left
                            ),
                            SizedBox(height: kDefaultPadding),

                            CustomRadioButton(
                              label: 'Option 4',
                              value: isOption4Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption3Selected = false;
                                  isOption4Selected = true;
                                });
                              },
                              isLabelOnRight: false, // set label on the left
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Disable Radio button',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            //Disable radio button active
                            CustomRadioButton(
                              label: 'Option 5',
                              value: isOption5Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption5Selected = true;
                                  isOption6Selected = false;
                                });
                              },
                              isLabelOnRight: true,
                              isDisabled: true, // disable radio button
                            ),
                            SizedBox(height: kDefaultPadding),

                            CustomRadioButton(
                              label: 'Option 6',
                              value: isOption6Selected,
                              onChanged: (newValue) {
                                setState(() {
                                  isOption3Selected = false;
                                  isOption4Selected = true;
                                });
                              },
                              isLabelOnRight: true,
                              isDisabled: true, // disable radio button
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Radio button without Label',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            Row(
                              children: [
                                CustomRadioButton(
                                  value: isOption1Selected,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isOption1Selected = true;
                                      isOption2Selected = false;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomRadioButton(
                                  value: isOption2Selected,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isOption1Selected = false;
                                      isOption2Selected = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: kDefaultPadding),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Color & Outlined Radio Button',
              description:
                  'Use <code>CustomRadioButton()</code> and add <code>activeColor</code> argument to set a radio button with color varian. Add <code>isOutlined: true</code> argument to set as outlined radio button.',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Radio button with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Primary',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color1,
                              activeColor: kPrimaryColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color1;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Secondary',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color2,
                              activeColor: kSecondaryColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color2;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Success',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color3,
                              activeColor: kSuccessColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color3;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Info',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color4,
                              activeColor: kInfoColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color4;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Warning',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color5,
                              activeColor: kWarningColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color5;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Danger',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color6,
                              activeColor: kErrorColor, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color6;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Dark',
                              value:
                                  selectedColorOption ==
                                  RadioOptionColor.color7,
                              activeColor:
                                  themeData.colorScheme.onSurface, // set color
                              onChanged: (newValue) {
                                setState(() {
                                  selectedColorOption = RadioOptionColor.color7;
                                });
                              },
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Outline Radio Button, with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Primary',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline1,
                              activeColor: kPrimaryColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline1;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Secondary',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline2,
                              activeColor: kSecondaryColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline2;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Success',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline3,
                              activeColor: kSuccessColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline3;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Info',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline4,
                              activeColor: kInfoColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline4;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Warning',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline5,
                              activeColor: kWarningColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline5;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Danger',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline6,
                              activeColor: kErrorColor,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline6;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomRadioButton(
                              label: 'Radio Button Outline Dark',
                              value:
                                  selectedOutlineOption ==
                                  RadioOptionOutline.outline7,
                              activeColor: themeData.colorScheme.onSurface,
                              isOutlined: true, // set as outlined
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOutlineOption =
                                      RadioOptionOutline.outline7;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              codeView: '''
//Radio Button with color variation
CustomRadioButton(
  label: 'Radio Button Primary',
  value: selectedColorOption ==
      RadioOptionColor.color1,
  activeColor: kPrimaryColor, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color1;
    });
  },
),
 
CustomRadioButton(
  label: 'Radio Button Secondary',
  value: selectedColorOption ==
      RadioOptionColor.color2,
  activeColor: kSecondaryColor, // set color 
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color2;
    });
  },
),
 
CustomRadioButton(
  label: 'Radio Button Success',
  value: selectedColorOption ==
      RadioOptionColor.color3,
  activeColor: kSuccessColor, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color3;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Info',
  value: selectedColorOption ==
      RadioOptionColor.color4,
  activeColor: kInfoColor, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color4;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Warning',
  value: selectedColorOption ==
      RadioOptionColor.color5,
  activeColor: kWarningColor, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color5;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Danger',
  value: selectedColorOption ==
      RadioOptionColor.color6,
  activeColor: kErrorColor, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color6;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Dark',
  value: selectedColorOption ==
      RadioOptionColor.color7,
  activeColor: themeData.colorScheme.onSurface, // set color
  onChanged: (newValue) {
    setState(() {
      selectedColorOption = RadioOptionColor.color7;
    });
  },
),

//Outline Radio Button, with color variation

CustomRadioButton(
  label: 'Radio Button Outline Primary',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline1,
  activeColor: kPrimaryColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline1;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Secondary',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline2,
  activeColor: kSecondaryColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline2;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Success',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline3,
  activeColor: kSuccessColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline3;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Info',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline4,
  activeColor: kInfoColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline4;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Warning',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline5,
  activeColor: kWarningColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline5;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Danger',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline6,
  activeColor: kErrorColor,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline6;
    });
  },
),

CustomRadioButton(
  label: 'Radio Button Outline Dark',
  value: selectedOutlineOption ==
      RadioOptionOutline.outline7,
  activeColor: themeData.colorScheme.onSurface,
  isOutlined: true, // set as outlined 
  onChanged: (newValue) {
    setState(() {
      selectedOutlineOption =
          RadioOptionOutline.outline7;
    });
  },
),        
''',
            ),
          ),

          SizedBox(height: kDefaultPadding),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Switch',
              description:
                  'Use <code>CustomSwitch()</code> to set a custom switch. You can set different arguments to suit use cases.',
              codeView: '''
//Switch, with label on the right side
CustomSwitch(
  label: 'Switch 1',
  value: isSwitch1On,
  onChanged: (newValue) {
    setState(() {
      isSwitch1On = newValue;
    });
  },
),

CustomSwitch(
  label: 'Switch 2',
  value: isSwitch2On,
  onChanged: (newValue) {
    setState(() {
      isSwitch2On = newValue;
    });
  },
),

//Switch, with label on the left side
CustomSwitch(
  label: 'Switch 3',
  value: isSwitch3On,
  onChanged: (newValue) {
    setState(() {
      isSwitch3On = newValue;
    });
  },
  isLabelOnRight: false, // set label on the left
),

CustomSwitch(
  label: 'Switch 4',
  value: isSwitch4On,
  onChanged: (newValue) {
    setState(() {
      isSwitch4On = newValue;
    });
  },
  isLabelOnRight: false, // set label on the left
),

//Disable switch
CustomSwitch(
  label: 'Switch 5',
  value: isSwitch5On,
  onChanged: (newValue) {
    setState(() {
      isSwitch5On = newValue;
    });
  },
  isDisabled: true, // disable switch
),

CustomSwitch(
  label: 'Switch 6',
  value: isSwitch6On,
  onChanged: (newValue) {
    setState(() {
      isSwitch6On = newValue;
    });
  },
  isDisabled: true, // disable switch
),

//Switch without Label
//remove label argument
CustomSwitch(
  value: isSwitch1On,
  onChanged: (newValue) {
    setState(() {
      isSwitch1On = newValue;
    });
  },
),

CustomSwitch(
  value: isSwitch2On,
  onChanged: (newValue) {
    setState(() {
      isSwitch2On = newValue;
    });
  },
),

CustomSwitch(
  value: isSwitch3On,
  onChanged: (newValue) {
    setState(() {
      isSwitch3On = newValue;
    });
  },
),
''',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_4(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Switch, with label on the right side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 1',
                              value: isSwitch1On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch1On = newValue;
                                });
                              },
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 2',
                              value: isSwitch2On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch2On = newValue;
                                });
                              },
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Switch, with label on the left side',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 3',
                              value: isSwitch3On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch3On = newValue;
                                });
                              },
                              isLabelOnRight: false, // set label on the left
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 4',
                              value: isSwitch4On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch4On = newValue;
                                });
                              },
                              isLabelOnRight: false, // set label on the left
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Disable switch',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 5',
                              value: isSwitch5On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch5On = newValue;
                                });
                              },
                              isDisabled: true, // disable switch
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch 6',
                              value: isSwitch6On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch6On = newValue;
                                });
                              },
                              isDisabled: true, // disable switch
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Switch without Label',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            Row(
                              children: [
                                CustomSwitch(
                                  value: isSwitch1On,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isSwitch1On = newValue;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomSwitch(
                                  value: isSwitch2On,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isSwitch2On = newValue;
                                    });
                                  },
                                ),
                                SizedBox(width: kDefaultPadding),
                                CustomSwitch(
                                  value: isSwitch3On,
                                  onChanged: (newValue) {
                                    setState(() {
                                      isSwitch3On = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: kDefaultPadding),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ShowCodeCard(
              cardTitle: 'Color & Outlined Switch',
              description:
                  'Use <code>CustomSwitch()</code> and add <code>activeColor</code> argument to set a switch with color varian. Add <code> isOutlined: true</code> argument to set outlined switch.',
              uiView: LayoutBuilder(
                builder: (context, constraints) {
                  int numberOfCardsPerRow = getNumberOfCardsPerRow_2(context);
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Switch with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Primary',
                              value: isSwitch7On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch7On = newValue;
                                });
                              },
                              activeColor: kPrimaryColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Secondary',
                              value: isSwitch8On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch8On = newValue;
                                });
                              },
                              activeColor: kSecondaryColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Success',
                              value: isSwitch9On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch9On = newValue;
                                });
                              },
                              activeColor: kSuccessColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Info',
                              value: isSwitch10On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch10On = newValue;
                                });
                              },
                              activeColor: kInfoColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Warning',
                              value: isSwitch11On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch11On = newValue;
                                });
                              },
                              activeColor: kWarningColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Danger',
                              value: isSwitch12On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch12On = newValue;
                                });
                              },
                              activeColor: kErrorColor, // set color
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Switch Dark',
                              value: isSwitch13On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch13On = newValue;
                                });
                              },
                              activeColor:
                                  themeData.colorScheme.onSurface, // set color
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
                            SizedBox(height: 0.5 * kDefaultPadding),
                            Text(
                              'Outline Switch with color variation',
                              style: TextStyle(
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Primary',
                              value: isSwitch14On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch14On = newValue;
                                });
                              },
                              activeColor: kPrimaryColor,
                              isOutlined: true, // set as outlined
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Secondary',
                              value: isSwitch15On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch15On = newValue;
                                });
                              },
                              activeColor: kSecondaryColor,
                              isOutlined: true, // set as outlined
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Success',
                              value: isSwitch16On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch16On = newValue;
                                });
                              },
                              activeColor: kSuccessColor,
                              isOutlined: true,
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Info',
                              value: isSwitch17On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch17On = newValue;
                                });
                              },
                              activeColor: kInfoColor,
                              isOutlined: true, // set as outlined
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Warning',
                              value: isSwitch18On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch18On = newValue;
                                });
                              },
                              activeColor: kWarningColor,
                              isOutlined: true, // set as outlined
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Danger',
                              value: isSwitch19On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch19On = newValue;
                                });
                              },
                              activeColor: kErrorColor,
                              isOutlined: true, // set as outlined
                            ),
                            SizedBox(height: kDefaultPadding),
                            CustomSwitch(
                              label: 'Outline Switch Dark',
                              value: isSwitch20On,
                              onChanged: (newValue) {
                                setState(() {
                                  isSwitch20On = newValue;
                                });
                              },
                              activeColor: themeData.colorScheme.onSurface,
                              isOutlined: true, // set as outlined
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              codeView: '''
//Switch with color variation
CustomSwitch(
  label: 'Switch Primary',
  value: isSwitch7On,
  onChanged: (newValue) {
    setState(() {
      isSwitch7On = newValue;
    });
  },
  activeColor: kPrimaryColor, // set color
),

CustomSwitch(
  label: 'Switch Secondary',
  value: isSwitch8On,
  onChanged: (newValue) {
    setState(() {
      isSwitch8On = newValue;
    });
  },
  activeColor: kSecondaryColor, // set color
),

CustomSwitch(
  label: 'Switch Success',
  value: isSwitch9On,
  onChanged: (newValue) {
    setState(() {
      isSwitch9On = newValue;
    });
  },
  activeColor: kSuccessColor, // set color
),

CustomSwitch(
  label: 'Switch Info',
  value: isSwitch10On,
  onChanged: (newValue) {
    setState(() {
      isSwitch10On = newValue;
    });
  },
  activeColor: kInfoColor, // set color
),

CustomSwitch(
  label: 'Switch Warning',
  value: isSwitch11On,
  onChanged: (newValue) {
    setState(() {
      isSwitch11On = newValue;
    });
  },
  activeColor: kWarningColor, // set color
),

CustomSwitch(
  label: 'Switch Danger',
  value: isSwitch12On,
  onChanged: (newValue) {
    setState(() {
      isSwitch12On = newValue;
    });
  },
  activeColor: kErrorColor, // set color
),

CustomSwitch(
  label: 'Switch Dark',
  value: isSwitch13On,
  onChanged: (newValue) {
    setState(() {
      isSwitch13On = newValue;
    });
  },
  activeColor:
      themeData.colorScheme.onSurface, // set color
),

//Outline Switch with color variation
CustomSwitch(
  label: 'Outline Switch Primary',
  value: isSwitch14On,
  onChanged: (newValue) {
    setState(() {
      isSwitch14On = newValue;
    });
  },
  activeColor: kPrimaryColor,
  isOutlined: true, // set as outlined
),

CustomSwitch(
  label: 'Outline Switch Secondary',
  value: isSwitch15On,
  onChanged: (newValue) {
    setState(() {
      isSwitch15On = newValue;
    });
  },
  activeColor: kSecondaryColor,
  isOutlined: true, // set as outlined
),

CustomSwitch(
  label: 'Outline Switch Success',
  value: isSwitch16On,
  onChanged: (newValue) {
    setState(() {
      isSwitch16On = newValue;
    });
  },
  activeColor: kSuccessColor,
  isOutlined: true,
),

CustomSwitch(
  label: 'Outline Switch Info',
  value: isSwitch17On,
  onChanged: (newValue) {
    setState(() {
      isSwitch17On = newValue;
    });
  },
  activeColor: kInfoColor,
  isOutlined: true, // set as outlined
),

CustomSwitch(
  label: 'Outline Switch Warning',
  value: isSwitch18On,
  onChanged: (newValue) {
    setState(() {
      isSwitch18On = newValue;
    });
  },
  activeColor: kWarningColor,
  isOutlined: true, // set as outlined
),

CustomSwitch(
  label: 'Outline Switch Danger',
  value: isSwitch19On,
  onChanged: (newValue) {
    setState(() {
      isSwitch19On = newValue;
    });
  },
  activeColor: kErrorColor,
  isOutlined: true, // set as outlined
),

CustomSwitch(
  label: 'Outline Switch Dark',
  value: isSwitch20On,
  onChanged: (newValue) {
    setState(() {
      isSwitch20On = newValue;
    });
  },
  activeColor: themeData.colorScheme.onSurface,
  isOutlined: true, // set as outlined
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

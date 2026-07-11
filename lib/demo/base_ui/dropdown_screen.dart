import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/dropdown.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class DropdownScreen extends StatefulWidget {
  const DropdownScreen({super.key});

  @override
  State<DropdownScreen> createState() => _DropdownScreenState();
}

class _DropdownScreenState extends State<DropdownScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).dropdown; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? selectedValue;

  final List<DropdownMenuItem<String>> dropdownitems = [
    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
    DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
    DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
  ];

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
                      lang.dropdown.toUpperCase(),
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
                        BreadcrumbItem(
                          label: lang.dropdown,
                          uri: RouteUri.dropdown,
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
                //Custom Dropdown Button
                ShowCodeCard(
                  cardTitle: 'Custom Dropdown Button',
                  description:
                      'Use <code>CustomDropdownButton()</code> to set custom dropdown button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      CustomDropdownButton<String>(
                        label: 'Primary',
                        color: kPrimaryColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Secondary',
                        color: kSecondaryColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Success',
                        color: kSuccessColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Info',
                        color: kInfoColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Warning',
                        color: kWarningColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Error',
                        color: kErrorColor,
                        labelColor: Colors.white,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  codeView: '''
//  initializing variables and constants.

String? selectedValue;

final List<DropdownMenuItem<String>> dropdownitems = [
  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
];

CustomDropdownButton<String>(
  label: 'Primary',
  color: kPrimaryColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Secondary',
  color: kSecondaryColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Success',
  color: kSuccessColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Info',
  color: kInfoColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Warning',
  color: kWarningColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Error',
  color: kErrorColor,
  labelColor: Colors.white,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),
''',
                ),
                SizedBox(height: kDefaultPadding),

                //Soft Dropdown Button
                ShowCodeCard(
                  cardTitle: 'Soft Dropdown Button',
                  description:
                      'Use <code>CustomDropdownButton()</code> and add <code>type: DropdownType.soft</code> parameter to set soft dropdown button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      CustomDropdownButton<String>(
                        label: 'Primary',
                        color: kPrimaryColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Secondary',
                        color: kSecondaryColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Success',
                        color: kSuccessColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Info',
                        color: kInfoColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Warning',
                        color: kWarningColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Error',
                        color: kErrorColor,
                        type: DropdownType.soft,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  codeView: '''
//  initializing variables and constants.

String? selectedValue;

final List<DropdownMenuItem<String>> dropdownitems = [
  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
];

CustomDropdownButton<String>(
  label: 'Primary',
  color: kPrimaryColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Secondary',
  color: kSecondaryColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Success',
  color: kSuccessColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Info',
  color: kInfoColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Warning',
  color: kWarningColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Error',
  color: kErrorColor,
  type: DropdownType.soft,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),
''',
                ),
                SizedBox(height: kDefaultPadding),

                //Outlined Dropdown Button
                ShowCodeCard(
                  cardTitle: 'Outlined Dropdown Button',
                  description:
                      'Use <code>CustomDropdownButton()</code> and add <code>type: DropdownType.outline</code> parameter to set outlined dropdown button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      CustomDropdownButton<String>(
                        label: 'Primary',
                        color: kPrimaryColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Secondary',
                        color: kSecondaryColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Success',
                        color: kSuccessColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Info',
                        color: kInfoColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Warning',
                        color: kWarningColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Error',
                        color: kErrorColor,
                        type: DropdownType.outline,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  codeView: '''
//  initializing variables and constants.

String? selectedValue;

final List<DropdownMenuItem<String>> dropdownitems = [
  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
];

CustomDropdownButton<String>(
  label: 'Primary',
  color: kPrimaryColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Secondary',
  color: kSecondaryColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Success',
  color: kSuccessColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Info',
  color: kInfoColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Warning',
  color: kWarningColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Error',
  color: kErrorColor,
  type: DropdownType.outline,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),
''',
                ),
                SizedBox(height: kDefaultPadding),

                //Custom Dropdown Button
                ShowCodeCard(
                  cardTitle: 'Expanded Dropdown Button',
                  description:
                      'Use <code>CustomDropdownButton()</code> and add <code>isExpanded: true</code> parameter to set an expanded dropdown button.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      CustomDropdownButton<String>(
                        label: 'Primary',
                        color: kPrimaryColor,
                        labelColor: Colors.white,
                        isExpanded: true,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Secondary',
                        color: kSecondaryColor,
                        labelColor: Colors.white,
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerStart,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Success',
                        color: kSuccessColor,
                        type: DropdownType.soft,
                        isExpanded: true,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Info',
                        color: kInfoColor,
                        type: DropdownType.soft,
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerStart,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Warning',
                        color: kWarningColor,
                        type: DropdownType.outline,
                        isExpanded: true,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                      CustomDropdownButton<String>(
                        label: 'Error',
                        color: kErrorColor,
                        type: DropdownType.outline,
                        isExpanded: true,
                        alignment: AlignmentDirectional.centerStart,
                        items: dropdownitems,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  codeView: '''
//  initializing variables and constants.

String? selectedValue;

final List<DropdownMenuItem<String>> dropdownitems = [
  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
];

CustomDropdownButton<String>(
  label: 'Primary',
  color: kPrimaryColor,
  labelColor: Colors.white,
  isExpanded: true,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Secondary',
  color: kSecondaryColor,
  labelColor: Colors.white,
  isExpanded: true,
  alignment: AlignmentDirectional.centerStart,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Success',
  color: kSuccessColor,
  type: DropdownType.soft,
  isExpanded: true,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Info',
  color: kInfoColor,
  type: DropdownType.soft,
  isExpanded: true,
  alignment: AlignmentDirectional.centerStart,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Warning',
  color: kWarningColor,
  type: DropdownType.outline,
  isExpanded: true,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
),

CustomDropdownButton<String>(
  label: 'Error',
  color: kErrorColor,
  type: DropdownType.outline,
  isExpanded: true,
  alignment: AlignmentDirectional.centerStart,
  items: dropdownitems,
  value: selectedValue,
  onChanged: (value) {
    setState(() {
      selectedValue = value;
    });
  },
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

import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/card_description.dart';
import 'package:flutter_ademin/widgets/base_ui/dialog.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).dialog; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // create function to show multiple dialog
  void _showFirstDialog(BuildContext context) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "First Dialog Title",
      isDismissible: false,
      showCloseButton: true,
      content: Text(
        "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
        "Common types of dialogs in Flutter include:\n"
        "AlertDialog: A simple, lightweight dialog for alerting users.\n"
        "SimpleDialog: Used for showing simple choices or lists of items.\n"
        "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
        "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
        textAlign: TextAlign.justify,
      ),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SoftButton(
            kText: 'Close',
            bgColor: themeData.colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: kDefaultPadding),
          FlatButton(
            kText: 'Next',
            bgColor: kErrorColor,
            kTextColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
              _showSecondDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSecondDialog(BuildContext context) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "Second Dialog Title",
      isDismissible: false,
      showCloseButton: true,
      content: Text(
        "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
        "Common types of dialogs in Flutter include:\n"
        "AlertDialog: A simple, lightweight dialog for alerting users.\n"
        "SimpleDialog: Used for showing simple choices or lists of items.\n"
        "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
        "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
        textAlign: TextAlign.justify,
      ),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SoftButton(
            kText: 'Back',
            bgColor: themeData.colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
              _showFirstDialog(context);
            },
          ),
          const SizedBox(width: kDefaultPadding),
          FlatButton(
            kText: 'Completed',
            bgColor: kSuccessColor,
            kTextColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
                      lang.dialog.toUpperCase(),
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
                          label: lang.dialog,
                          uri: RouteUri.dialog,
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
                // default custom dialog
                AdaptiveWrap(
                  breakpoints: {kScreenWidthLg: 1, kScreenWidthXl: 2},
                  columnRatios: const [0.5, 0.5],
                  spacing: kDefaultPadding,
                  runSpacing: kDefaultPadding,
                  children: [
                    // default custom dialog
                    ShowCodeCard(
                      cardTitle: 'Custom Dialog',
                      description:
                          'Use <code>showCustomDialog()</code> to set a custom dialog. There are several arguments to customized this custom dialog.',
                      uiView: FlatButton(
                        kText: 'Custom Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Dialog Title",
                            content: Text(
                              "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                              "Common types of dialogs in Flutter include:\n"
                              "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                              "SimpleDialog: Used for showing simple choices or lists of items.\n"
                              "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                              "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                              textAlign: TextAlign.justify,
                            ),
                            actions: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SoftButton(
                                  kText: 'Close',
                                  bgColor: themeData.colorScheme.onSurface,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(width: kDefaultPadding),
                                FlatButton(
                                  kText: 'Save Changes',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      codeView: '''
showCustomDialog(
  context: context,
  title: "Dialog Title",
  content: Text('Widget Content Here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);                      
''',
                    ),

                    // close button
                    ShowCodeCard(
                      cardTitle: 'Close Button Dialog',
                      description:
                          'Use <code>showCustomDialog()</code> and add <code>showCloseButton: true</code> argument to set a custom dialog with close button.',
                      uiView: FlatButton(
                        kText: 'Close Button Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Dialog Title",
                            showCloseButton: true, // show close button
                            content: Text(
                              "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                              "Common types of dialogs in Flutter include:\n"
                              "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                              "SimpleDialog: Used for showing simple choices or lists of items.\n"
                              "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                              "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                              textAlign: TextAlign.justify,
                            ),
                            actions: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SoftButton(
                                  kText: 'Close',
                                  bgColor: themeData.colorScheme.onSurface,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(width: kDefaultPadding),
                                FlatButton(
                                  kText: 'Save Changes',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      codeView: '''
showCustomDialog(
  context: context,
  title: "Dialog Title",
  showCloseButton: true, // show close button
  content: Text('Widget Content Here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);                      
''',
                    ),

                    // non dismissible dialog
                    ShowCodeCard(
                      cardTitle: 'Non Dismissible Dialog',
                      description:
                          'Use <code>showCustomDialog()</code> and add <code>isDismissible: false</code> argument to set non dismissible dialog. Can not be closed using standard method like clicking outside the window.',
                      uiView: FlatButton(
                        kText: 'Non Dismissible Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Dialog Title",
                            isDismissible: false, // set non dismissible
                            showCloseButton: true,
                            content: Text(
                              "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                              "Common types of dialogs in Flutter include:\n"
                              "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                              "SimpleDialog: Used for showing simple choices or lists of items.\n"
                              "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                              "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                              textAlign: TextAlign.justify,
                            ),
                            actions: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SoftButton(
                                  kText: 'Close',
                                  bgColor: themeData.colorScheme.onSurface,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(width: kDefaultPadding),
                                FlatButton(
                                  kText: 'Save Changes',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      codeView: '''
showCustomDialog(
  context: context,
  title: "Dialog Title",
  isDismissible: false, // set as non dismissible
  showCloseButton: true, 
  content: Text('Widget Content Here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);                      
''',
                    ),

                    // Multiple Dialogs
                    ShowCodeCard(
                      cardTitle: 'Multiple Dialogs',
                      description:
                          'Create multiple <code>showCustomDialog()</code> to set multiple dialogs. A series of interconnected dialog. The initial dialog will serve as a gateway to the subsequent ones.',
                      uiView: FlatButton(
                        kText: 'Open First Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          _showFirstDialog(context);
                        },
                      ),
                      codeView: '''
  void _showFirstDialog(BuildContext context) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "First Dialog Title",
      isDismissible: false,
      showCloseButton: true,
      content: Text('Your widget here'),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SoftButton(
            kText: 'Close',
            bgColor: themeData.colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: kDefaultPadding),
          FlatButton(
            kText: 'Next',
            bgColor: kErrorColor,
            kTextColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
              _showSecondDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSecondDialog(BuildContext context) {
    final themeData = Theme.of(context);
    showCustomDialog(
      context: context,
      title: "Second Dialog Title",
      isDismissible: false,
      showCloseButton: true,
      content: Text('Your widget here'),
      actions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SoftButton(
            kText: 'Back',
            bgColor: themeData.colorScheme.onSurface,
            onPressed: () {
              Navigator.of(context).pop();
              _showFirstDialog(context);
            },
          ),
          const SizedBox(width: kDefaultPadding),
          FlatButton(
            kText: 'Completed',
            bgColor: kSuccessColor,
            kTextColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }                   
''',
                    ),

                    // Full Screen Dialog
                    ShowCodeCard(
                      cardTitle: 'Full Screen Dialog',
                      description:
                          'Use <code>showCustomDialog()</code> and add <code>isFullscreen: true</code> argument to set a full screen dialog.',
                      uiView: FlatButton(
                        kText: 'Full Screen Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Dialog Title",
                            showCloseButton: true,
                            isFullscreen: true, // set full screen
                            content: Text(
                              "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                              "Common types of dialogs in Flutter include:\n"
                              "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                              "SimpleDialog: Used for showing simple choices or lists of items.\n"
                              "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                              "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                              textAlign: TextAlign.justify,
                            ),
                            actions: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SoftButton(
                                  kText: 'Close',
                                  bgColor: themeData.colorScheme.onSurface,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(width: kDefaultPadding),
                                FlatButton(
                                  kText: 'Save Changes',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      codeView: '''
showCustomDialog(
  context: context,
  title: "Dialog Title",
  showCloseButton: true,
  isFullscreen: true, // set full screen
  content: Text('Widget Content Here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);                      
''',
                    ),

                    // Custom Width dialog
                    ShowCodeCard(
                      cardTitle: 'Custom Width Dialog',
                      description:
                          'Use <code>showCustomDialog()</code> and add <code>width</code> argument to set a custom width dialog.',
                      uiView: FlatButton(
                        kText: 'Custom Width Dialog',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          showCustomDialog(
                            context: context,
                            title: "Dialog Title",
                            width: 480, // set custom width
                            showCloseButton: true,
                            content: Text(
                              "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                              "Common types of dialogs in Flutter include:\n"
                              "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                              "SimpleDialog: Used for showing simple choices or lists of items.\n"
                              "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                              "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                              textAlign: TextAlign.justify,
                            ),
                            actions: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SoftButton(
                                  kText: 'Close',
                                  bgColor: themeData.colorScheme.onSurface,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(width: kDefaultPadding),
                                FlatButton(
                                  kText: 'Save Changes',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      codeView: '''
showCustomDialog(
  context: context,
  title: "Dialog Title",
  width: 480, // set custom width
  showCloseButton: true,
  content: Text('Widget Content Here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);                      
''',
                    ),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                // animation dialog
                ShowCodeCard(
                  cardTitle: 'Animation Dialogs',
                  height: 600,
                  uiView: AdaptiveWrap(
                    breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2},
                    columnRatios: [0.5, 0.5],
                    spacing: kDefaultPadding,
                    runSpacing: 2 * kDefaultPadding,
                    children: [
                      // Fade in right Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.fadeInRight</code> argument to set up a dialog with a fade-in animation from the right.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Fade in right Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation: DialogAnimation
                                    .fadeInRight, // fade in right animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Fade in left Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.fadeInLeft</code> argument to set up a dialog with a fade-in animation from the left.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Fade in left Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation: DialogAnimation
                                    .fadeInLeft, // fade in left animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Fade in bottom Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.fadeInBottom</code> argument to set up a dialog with a fade-in animation from the bottom.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Fade in bottom Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation: DialogAnimation
                                    .fadeInBottom, // fade in bottom animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Fade in top Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.fadeInTop</code> argument to set up a dialog with a fade-in animation from the top.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Fade in top Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation: DialogAnimation
                                    .fadeInTop, // fade in top animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Flip Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.flip</code> argument to set up a dialog with a flip animation.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Flip Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation:
                                    DialogAnimation.flip, // flip animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      // Zoom Dialog
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CardDescription(
                            content:
                                'Use <code>showCustomDialog()</code>, and add <code>animation: DialogAnimation.zoom</code> argument to set up a dialog with a zoom animation.',
                          ),
                          const SizedBox(height: kDefaultPadding),
                          FlatButton(
                            kText: 'Zoom Dialog',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                title: "Dialog Title",
                                animation:
                                    DialogAnimation.zoom, // zoom animation
                                showCloseButton: true,
                                content: Text(
                                  "In Flutter, a Dialog is a type of widget that temporarily displays content above the current page. A Dialog in Flutter is a Dialog window that overlays the current screen, preventing user interaction with the underlying content until the dialog is dismissed. It's often used to present important information, gather user input, or confirm actions. Dialogs are useful for showing alerts, asking users for confirmation, or displaying additional information. They typically contain buttons that allow users to close the dialog and return to the main screen.\n\n"
                                  "Common types of dialogs in Flutter include:\n"
                                  "AlertDialog: A simple, lightweight dialog for alerting users.\n"
                                  "SimpleDialog: Used for showing simple choices or lists of items.\n"
                                  "Dialog: A customizable dialog, which allows more control over the design and layout.\n\n"
                                  "Dialogs are dialog, which means users need to interact with them to proceed with their actions. They can be closed by pressing a button inside the dialog or tapping outside, depending on the configuration.",
                                  textAlign: TextAlign.justify,
                                ),
                                actions: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SoftButton(
                                      kText: 'Close',
                                      bgColor: themeData.colorScheme.onSurface,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SizedBox(width: kDefaultPadding),
                                    FlatButton(
                                      kText: 'Save Changes',
                                      bgColor: kSuccessColor,
                                      kTextColor: Colors.white,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  codeView: '''

// Fade in right Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.fadeInRight, // fade in right animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);

// Fade in left Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.fadeInLeft, // fade in left animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);

// Fade in bottom Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.fadeInBottom, // fade in bottom animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);

// Fade in top Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.fadeInTop, // fade in top animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);

// Flip Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.flip, // flip animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);

// Zoom Dialog
showCustomDialog(
  context: context,
  title: "Dialog Title",
  animation: DialogAnimation.zoom, // zoom animation
  showCloseButton: true,
  content: Text('Your widget here'),
  actions: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SoftButton(
        kText: 'Close',
        bgColor: themeData.colorScheme.onSurface,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      const SizedBox(width: kDefaultPadding),
      FlatButton(
        kText: 'Save Changes',
        bgColor: kSuccessColor,
        kTextColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  ),
);
                            
''',
                ),

                SizedBox(height: kDefaultPadding),

                // custom layout dialog
                ShowCodeCard(
                  cardTitle: 'Layout Dialog Examples',
                  description:
                      'Several examples of dialog layouts that you can use, not a reusable widget, you need to copy and paste the existing code, and adapt it to your needs.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      double availableWidth =
                          constraints.maxWidth - kDefaultPadding;
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Success Dialog
                          SizedBox(
                            width: mediaQueryData.size.width > kScreenWidthXxl
                                ? availableWidth * 0.5
                                : constraints.maxWidth * 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardDescription(
                                  content:
                                      'Example of success dialog, see code in <code>TransactionSuccess()</code> widget.',
                                ),
                                SizedBox(height: kDefaultPadding),
                                FlatButton(
                                  kText: 'Success Dialog',
                                  bgColor: kSuccessColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          Dialog(child: TransactionSuccess()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // subscribe Dialog
                          // SizedBox(
                          //   width: mediaQueryData.size.width > kScreenWidthXxl
                          //       ? availableWidth * 0.5
                          //       : constraints.maxWidth * 1,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       CardDescription(
                          //         content:
                          //             'Example of subscribe dialog, see code in <code>SubscribeBanner()</code> widget.',
                          //       ),
                          //       SizedBox(height: kDefaultPadding),
                          //       FlatButton(
                          //         kText: 'Subscribe Dialog',
                          //         bgColor: kInfoColor,
                          //         kTextColor: Colors.white,
                          //         onPressed: () {
                          //           showDialog(
                          //             context: context,
                          //             builder: (context) =>
                          //                 Dialog(child: SubscribeBanner()),
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Warning Dialog
                          SizedBox(
                            width: mediaQueryData.size.width > kScreenWidthXxl
                                ? availableWidth * 0.5
                                : constraints.maxWidth * 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardDescription(
                                  content:
                                      'Example of warning dialog, see code in <code>WarningDialog()</code> widget.',
                                ),
                                SizedBox(height: kDefaultPadding),
                                FlatButton(
                                  kText: 'Warning Dialog',
                                  bgColor: kWarningColor,
                                  kTextColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          Dialog(child: WarningDialog()),
                                    );
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
// Success Dialog
showDialog(
  context: context,
  builder: (context) => CustomDialog(
    showCloseButton: true,
    contentPadding: 0,
    content: TransactionSuccess(),
  ),
);

// Subscribe Dialog
showDialog(
  context: context,
  builder: (context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = 960.0;
        final height =
            constraints.maxWidth >
                    kScreenWidthXxl
                ? 420.0
                : 840.0;

        return CustomDialog(
          showCloseButton: true,
          width: width,
          height: height,
          contentPadding: 0,
          content: SubscribeBanner(),
        );
      },
    );
  },
);

// Warning Dialog
showDialog(
  context: context,
  builder: (context) => CustomDialog(
    content: WarningDialog(),
  ),
);
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

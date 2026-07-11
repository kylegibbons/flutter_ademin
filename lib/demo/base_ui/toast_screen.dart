import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

import 'package:flutter_ademin/widgets/base_ui/toast.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class ToastScreen extends StatefulWidget {
  const ToastScreen({super.key});

  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends State<ToastScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).toast; //update your page tittle here
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
                      lang.toast.toUpperCase(),
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
                        BreadcrumbItem(label: lang.toast, uri: RouteUri.toast),
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
                  cardTitle: 'Default Toast',
                  description:
                      'Use <code>Toast.showToast()</code> to set a toast. A toast is a small, non-interactive message that appears on the screen for a short time to provide information to a user',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary toast
                      FlatButton(
                        kText: 'Primary',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a primary message!',
                            color: kPrimaryColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),

                      // secondary toast
                      FlatButton(
                        kText: 'Secondary',
                        bgColor: kSecondaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a secondary message!',
                            color: kSecondaryColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),

                      // info toast
                      FlatButton(
                        kText: 'Info',
                        bgColor: kInfoColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is an info message!',
                            color: kInfoColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),

                      // success toast
                      FlatButton(
                        kText: 'Success',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.check_circle_outline,
                            message: 'This is a success message!',
                            color: kSuccessColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),

                      // warning toast
                      FlatButton(
                        kText: 'Warning',
                        bgColor: kWarningColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.warning_outlined,
                            message: 'This is a warning message!',
                            color: kWarningColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),

                      // error toast
                      FlatButton(
                        kText: 'Error',
                        bgColor: kErrorColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.error_outline,
                            message: 'This is an error message!',
                            color: kErrorColor,
                            alignment: Alignment.topRight,
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// primary toast
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: kPrimaryColor,
      alignment: Alignment.topRight,
    );
  },
),

// secondary toast
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
    );
  },
),

// info toast
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
    );
  },
),

// success toast
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
    );
  },
),

// warning toast
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
    );
  },
),

// error toast
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Border Bottom Toast',
                  description:
                      'Use <code>Toast.showToast()</code>, and add <code>bottomBorder: true</code> argument to set a toast with bottom border.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // primary border bottom toast
                      CustomOutlinedButton(
                        kText: 'Primary',
                        outlineColor: themeData.colorScheme.primary,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a primary message!',
                            color: themeData.colorScheme.primary,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),

                      // secondary border bottom toast
                      CustomOutlinedButton(
                        kText: 'Secondary',
                        outlineColor: kSecondaryColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a secondary message!',
                            color: kSecondaryColor,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),

                      // info border bottom toast
                      CustomOutlinedButton(
                        kText: 'Info',
                        outlineColor: kInfoColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is an info message!',
                            color: kInfoColor,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),

                      // success border bottom toast
                      CustomOutlinedButton(
                        kText: 'Success',
                        outlineColor: kSuccessColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.check_circle_outline,
                            message: 'This is a success message!',
                            color: kSuccessColor,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),

                      // warning border bottom toast
                      CustomOutlinedButton(
                        kText: 'Warning',
                        outlineColor: kWarningColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.warning_outlined,
                            message: 'This is a warning message!',
                            color: kWarningColor,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),

                      // error border bottom toast
                      CustomOutlinedButton(
                        kText: 'Error',
                        outlineColor: kErrorColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.error_outline,
                            message: 'This is an error message!',
                            color: kErrorColor,
                            alignment: Alignment.topRight,
                            bottomBorder: true, // set border bottom
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// primary border bottom toast
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: themeData.colorScheme.primary,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: themeData.colorScheme.primary,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),

// secondary border bottom toast
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),

// info border bottom toast
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),

// success border bottom toast
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),

// warning border bottom toast
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),

// error border bottom toast
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
      bottomBorder: true, // set border bottom
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Toast with Progress Indicator',
                  description:
                      'Use <code>Toast.showToast()</code>, and add <code>showProgress: true</code> argument to set a toast with progress indicator.',
                  uiView: Column(
                    children: [
                      // toast with progress indicator
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // primary toast
                          FlatButton(
                            kText: 'Primary',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a primary message!',
                                color: kPrimaryColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // secondary toast
                          FlatButton(
                            kText: 'Secondary',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a secondary message!',
                                color: kSecondaryColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // info toast
                          FlatButton(
                            kText: 'Info',
                            bgColor: kInfoColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is an info message!',
                                color: kInfoColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // success toast
                          FlatButton(
                            kText: 'Success',
                            bgColor: kSuccessColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.check_circle_outline,
                                message: 'This is a success message!',
                                color: kSuccessColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // warning toast
                          FlatButton(
                            kText: 'Warning',
                            bgColor: kWarningColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.warning_outlined,
                                message: 'This is a warning message!',
                                color: kWarningColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // error toast
                          FlatButton(
                            kText: 'Error',
                            bgColor: kErrorColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.error_outline,
                                message: 'This is an error message!',
                                color: kErrorColor,
                                alignment: Alignment.topRight,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: kDefaultPadding),

                      // border bottom toast with progress indicator
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // primary border bottom toast
                          CustomOutlinedButton(
                            kText: 'Primary',
                            outlineColor: themeData.colorScheme.primary,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a primary message!',
                                color: themeData.colorScheme.primary,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // secondary border bottom toast
                          CustomOutlinedButton(
                            kText: 'Secondary',
                            outlineColor: kSecondaryColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a secondary message!',
                                color: kSecondaryColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // info border bottom toast
                          CustomOutlinedButton(
                            kText: 'Info',
                            outlineColor: kInfoColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is an info message!',
                                color: kInfoColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // success border bottom toast
                          CustomOutlinedButton(
                            kText: 'Success',
                            outlineColor: kSuccessColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.check_circle_outline,
                                message: 'This is a success message!',
                                color: kSuccessColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // warning border bottom toast
                          CustomOutlinedButton(
                            kText: 'Warning',
                            outlineColor: kWarningColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.warning_outlined,
                                message: 'This is a warning message!',
                                color: kWarningColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),

                          // error border bottom toast
                          CustomOutlinedButton(
                            kText: 'Error',
                            outlineColor: kErrorColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.error_outline,
                                message: 'This is an error message!',
                                color: kErrorColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true, // show progress indicator
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// primary toast
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: kPrimaryColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// secondary toast
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// info toast
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// success toast
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// warning toast
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// error toast
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
      showProgress: true, // show progress indicator
    );
  },
),

// primary border bottom toast
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: themeData.colorScheme.primary,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: themeData.colorScheme.primary,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),

// secondary border bottom toast
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),

// info border bottom toast
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),

// success border bottom toast
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),

// warning border bottom toast
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),

// error border bottom toast
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true, // show progress indicator
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Toast with Close Button',
                  description:
                      'Use <code>Toast.showToast()</code>, and add <code>showCloseButton: true</code> argument to set a toast with close button.',
                  uiView: Column(
                    children: [
                      // toast with close button
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // primary toast
                          FlatButton(
                            kText: 'Primary',
                            bgColor: kPrimaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a primary message!',
                                color: kPrimaryColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // secondary toast
                          FlatButton(
                            kText: 'Secondary',
                            bgColor: kSecondaryColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a secondary message!',
                                color: kSecondaryColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // info toast
                          FlatButton(
                            kText: 'Info',
                            bgColor: kInfoColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is an info message!',
                                color: kInfoColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // success toast
                          FlatButton(
                            kText: 'Success',
                            bgColor: kSuccessColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.check_circle_outline,
                                message: 'This is a success message!',
                                color: kSuccessColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // warning toast
                          FlatButton(
                            kText: 'Warning',
                            bgColor: kWarningColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.warning_outlined,
                                message: 'This is a warning message!',
                                color: kWarningColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // error toast
                          FlatButton(
                            kText: 'Error',
                            bgColor: kErrorColor,
                            kTextColor: Colors.white,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.error_outline,
                                message: 'This is an error message!',
                                color: kErrorColor,
                                alignment: Alignment.topRight,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: kDefaultPadding),

                      // border bottom toast with progress indicator
                      Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // primary border bottom toast
                          CustomOutlinedButton(
                            kText: 'Primary',
                            outlineColor: themeData.colorScheme.primary,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a primary message!',
                                color: themeData.colorScheme.primary,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // secondary border bottom toast
                          CustomOutlinedButton(
                            kText: 'Secondary',
                            outlineColor: kSecondaryColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is a secondary message!',
                                color: kSecondaryColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // info border bottom toast
                          CustomOutlinedButton(
                            kText: 'Info',
                            outlineColor: kInfoColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.info_outline,
                                message: 'This is an info message!',
                                color: kInfoColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // success border bottom toast
                          CustomOutlinedButton(
                            kText: 'Success',
                            outlineColor: kSuccessColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.check_circle_outline,
                                message: 'This is a success message!',
                                color: kSuccessColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // warning border bottom toast
                          CustomOutlinedButton(
                            kText: 'Warning',
                            outlineColor: kWarningColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.warning_outlined,
                                message: 'This is a warning message!',
                                color: kWarningColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),

                          // error border bottom toast
                          CustomOutlinedButton(
                            kText: 'Error',
                            outlineColor: kErrorColor,
                            onPressed: () {
                              Toast.showToast(
                                context: context,
                                icon: Icons.error_outline,
                                message: 'This is an error message!',
                                color: kErrorColor,
                                alignment: Alignment.topRight,
                                bottomBorder: true,
                                showProgress: true,
                                showCloseButton: true, // show close button
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  codeView: '''
// primary toast
FlatButton(
  kText: 'Primary',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: kPrimaryColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// secondary toast
FlatButton(
  kText: 'Secondary',
  bgColor: kSecondaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// info toast
FlatButton(
  kText: 'Info',
  bgColor: kInfoColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// success toast
FlatButton(
  kText: 'Success',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// warning toast
FlatButton(
  kText: 'Warning',
  bgColor: kWarningColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// error toast
FlatButton(
  kText: 'Error',
  bgColor: kErrorColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// primary border bottom toast
CustomOutlinedButton(
  kText: 'Primary',
  outlineColor: themeData.colorScheme.primary,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a primary message!',
      color: themeData.colorScheme.primary,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// secondary border bottom toast
CustomOutlinedButton(
  kText: 'Secondary',
  outlineColor: kSecondaryColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// info border bottom toast
CustomOutlinedButton(
  kText: 'Info',
  outlineColor: kInfoColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// success border bottom toast
CustomOutlinedButton(
  kText: 'Success',
  outlineColor: kSuccessColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.check_circle_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// warning border bottom toast
CustomOutlinedButton(
  kText: 'Warning',
  outlineColor: kWarningColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),

// error border bottom toast
CustomOutlinedButton(
  kText: 'Error',
  outlineColor: kErrorColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.error_outline,
      message: 'This is an error message!',
      color: kErrorColor,
      alignment: Alignment.topRight,
      bottomBorder: true,
      showProgress: true,
      showCloseButton: true, // show close button
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Toast Display Location',
                  description:
                      'Use <code>Toast.showToast</code>, and add <code>alignment: Alignment</code> argument to set toast display location.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // default toast at top left
                      FlatButton(
                        kText: 'Top Left',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a success message!',
                            color: kSuccessColor,
                            alignment:
                                Alignment.topLeft, // set location to top left

                            showCloseButton: true,
                          );
                        },
                      ),

                      //default toast at top center
                      FlatButton(
                        kText: 'Top Center',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a success message!',
                            color: kSuccessColor,
                            alignment: Alignment
                                .topCenter, // set location to top center

                            showCloseButton: true,
                          );
                        },
                      ),

                      //border toast at top right
                      CustomOutlinedButton(
                        kText: 'Top right',
                        outlineColor: kSecondaryColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a secondary message!',
                            color: kSecondaryColor,
                            alignment:
                                Alignment.topRight, // set location to top right
                            showCloseButton: true,
                          );
                        },
                      ),

                      //border toast at bottom left
                      CustomOutlinedButton(
                        kText: 'Bottom Left',
                        outlineColor: kWarningColor,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.warning_outlined,
                            message: 'This is a warning message!',
                            color: kWarningColor,
                            alignment: Alignment
                                .bottomLeft, // set location to bottom left
                            showCloseButton: true,
                          );
                        },
                      ),

                      //progress toast at bottom center
                      FlatButton(
                        kText: 'Bottom Center',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info,
                            message: 'This is a primary message!',
                            color: kPrimaryColor,
                            alignment: Alignment
                                .bottomCenter, // set location to bottom center
                            duration: const Duration(seconds: 5),
                            showCloseButton: true,
                          );
                        },
                      ),

                      //progress toast at bottom right
                      FlatButton(
                        kText: 'Bottom Right',
                        bgColor: kPrimaryColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info,
                            message: 'This is an info message!',
                            color: kInfoColor,
                            alignment: Alignment
                                .bottomRight, // set location to bottom right
                            duration: const Duration(seconds: 5),
                            showCloseButton: true,
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// default toast at top left
FlatButton(
  kText: 'Top Left',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment:
          Alignment.topLeft, // set location to top left

      showCloseButton: true,
    );
  },
),

//default toast at top center
FlatButton(
  kText: 'Top Center',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      alignment: Alignment
          .topCenter, // set location to top center

      showCloseButton: true,
    );
  },
),

//border toast at top right
CustomOutlinedButton(
  kText: 'Top right',
  outlineColor: kSecondaryColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a secondary message!',
      color: kSecondaryColor,
      alignment:
          Alignment.topRight, // set location to top right
      showCloseButton: true,
    );
  },
),

//border toast at bottom left
CustomOutlinedButton(
  kText: 'Bottom Left',
  outlineColor: kWarningColor,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.warning_outlined,
      message: 'This is a warning message!',
      color: kWarningColor,
      alignment: Alignment
          .bottomLeft, // set location to bottom left
      showCloseButton: true,
    );
  },
),

//progress toast at bottom center
FlatButton(
  kText: 'Bottom Center',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info,
      message: 'This is a primary message!',
      color: kPrimaryColor,
      alignment: Alignment
          .bottomCenter, // set location to bottom center
      duration: const Duration(seconds: 5),
      showCloseButton: true,
    );
  },
),

//progress toast at bottom right
FlatButton(
  kText: 'Bottom Right',
  bgColor: kPrimaryColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info,
      message: 'This is an info message!',
      color: kInfoColor,
      alignment: Alignment
          .bottomRight, // set location to bottom right
      duration: const Duration(seconds: 5),
      showCloseButton: true,
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Multi Toast',
                  description:
                      'Use <code>Toast.showToast</code>, and add <code>singleToast: false</code> argument to set multi toast. Clik the button multiple times.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // multi toast
                      FlatButton(
                        kText: 'Multi Toast',
                        bgColor: kSuccessColor,
                        kTextColor: Colors.white,
                        onPressed: () {
                          Toast.showToast(
                            context: context,
                            icon: Icons.info_outline,
                            message: 'This is a success message!',
                            color: kSuccessColor,
                            duration: Duration(seconds: 8),
                            singleToast: false, // set as multi toast
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// multi toast
FlatButton(
  kText: 'Multi Toast',
  bgColor: kSuccessColor,
  kTextColor: Colors.white,
  onPressed: () {
    Toast.showToast(
      context: context,
      icon: Icons.info_outline,
      message: 'This is a success message!',
      color: kSuccessColor,
      duration: Duration(seconds: 8),
      singleToast: false, // set as multi toast
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Notification Toast',
                  description:
                      'Use <code>NotificationToast.showToast()</code> to set a notification toast.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // top right notification toast
                      CustomOutlinedButton(
                        kText: 'Top Right Notification Toast',
                        outlineColor: themeData.colorScheme.primary,
                        onPressed: () {
                          NotificationToast.showToast(
                            context: context,
                            message:
                                "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
                            icon: Icons.code,
                            iconColor: kErrorColor,
                            avatarUrl: "assets/images/avatar_2.jpg",
                            width: 360,
                            localAvatar: true,
                          );
                        },
                      ),

                      // top left notification toast
                      CustomOutlinedButton(
                        kText: 'Top Left Notification Toast',
                        outlineColor: kSecondaryColor,
                        onPressed: () {
                          NotificationToast.showToast(
                            context: context,
                            message:
                                "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
                            icon: Icons.code,
                            iconColor: kErrorColor,
                            avatarUrl: "assets/images/avatar_2.jpg",
                            width: 360,
                            localAvatar: true,
                            alignment: Alignment.topLeft, // set to top left
                          );
                        },
                      ),

                      // bottom right notification toast
                      CustomOutlinedButton(
                        kText: 'Bottom Right Notification Toast',
                        outlineColor: kSuccessColor,
                        onPressed: () {
                          NotificationToast.showToast(
                            context: context,
                            message:
                                "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
                            icon: Icons.code,
                            iconColor: kErrorColor,
                            avatarUrl: "assets/images/avatar_2.jpg",
                            width: 360,
                            localAvatar: true,
                            alignment:
                                Alignment.bottomRight, // set to bottom right
                          );
                        },
                      ),

                      // bottom right notification toast
                      CustomOutlinedButton(
                        kText: 'Bottom Left Notification Toast',
                        outlineColor: kErrorColor,
                        onPressed: () {
                          NotificationToast.showToast(
                            context: context,
                            message:
                                "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
                            icon: Icons.code,
                            iconColor: kErrorColor,
                            avatarUrl: "assets/images/avatar_2.jpg",
                            width: 360,
                            localAvatar: true,
                            alignment:
                                Alignment.bottomLeft, // set to bottom left
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// top right notification toast
CustomOutlinedButton(
  kText: 'Top Right Notification Toast',
  outlineColor: themeData.colorScheme.primary,
  onPressed: () {
    NotificationToast.showToast(
      context: context,
      message:
          "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
      icon: Icons.code,
      iconColor: kErrorColor,
      avatarUrl:"assets/images/avatar_2.jpg",
      localAvatar: true,
      width: 360,
    );
  },
),

// top left notification toast
CustomOutlinedButton(
  kText: 'Top Left Notification Toast',
  outlineColor: kSecondaryColor,
  onPressed: () {
    NotificationToast.showToast(
      context: context,
      message:
          "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
      icon: Icons.code,
      iconColor: kErrorColor,
      avatarUrl:"assets/images/avatar_2.jpg",
      localAvatar: true,
      width: 360,
      alignment: Alignment.topLeft, // set to top left
    );
  },
),

// bottom right notification toast
CustomOutlinedButton(
  kText: 'Bottom Right Notification Toast',
  outlineColor: kSuccessColor,
  onPressed: () {
    NotificationToast.showToast(
      context: context,
      message:
          "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
      icon: Icons.code,
      iconColor: kErrorColor,
      avatarUrl: "assets/images/avatar_2.jpg",
      localAvatar: true,
      width: 360,
      alignment:
          Alignment.bottomRight, // set to bottom right
    );
  },
),

// bottom right notification toast
CustomOutlinedButton(
  kText: 'Bottom Left Notification Toast',
  outlineColor: kErrorColor,
  onPressed: () {
    NotificationToast.showToast(
      context: context,
      message:
          "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
      icon: Icons.code,
      iconColor: kErrorColor,
      avatarUrl:"assets/images/avatar_2.jpg",
      localAvatar: true,
      width: 360,
      alignment:
          Alignment.bottomLeft, // set to bottom left
    );
  },
),
''',
                ),
                const SizedBox(height: kDefaultPadding),
                ShowCodeCard(
                  cardTitle: 'Multi Notification Toast',
                  description:
                      'Use <code>NotificationToast.showToast()</code>, and add <code>singleToast: false</code> argument to set a multi notification toast. Please click the button below multiple times.',
                  uiView: Wrap(
                    spacing: kDefaultPadding,
                    runSpacing: kDefaultPadding,
                    children: [
                      // multi notification toast
                      CustomOutlinedButton(
                        kText: 'Top Right Notification Toast',
                        outlineColor: themeData.colorScheme.primary,
                        onPressed: () {
                          NotificationToast.showToast(
                            context: context,
                            message:
                                "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
                            icon: Icons.code,
                            iconColor: kErrorColor,
                            avatarUrl: "assets/images/avatar_2.jpg",
                            localAvatar: true,
                            width: 360,
                            duration: Duration(seconds: 10),
                            singleToast: false, // set as multi toast
                          );
                        },
                      ),
                    ],
                  ),
                  codeView: '''
// multi notification toast
CustomOutlinedButton(
  kText: 'Top Right Notification Toast',
  outlineColor: themeData.colorScheme.primary,
  onPressed: () {
    NotificationToast.showToast(
        context: context,
        message:
            "<b>Prepare design mockups</b> was marked as complete by <b>John Marston</b>",
        icon: Icons.code,
        iconColor: kErrorColor,
        avatarUrl:"assets/images/avatar_2.jpg",
        localAvatar: true,
        width: 360,
        duration: Duration(seconds: 10),
        singleToast: false // set as multi toast
        );
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

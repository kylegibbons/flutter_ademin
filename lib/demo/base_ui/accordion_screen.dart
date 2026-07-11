import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/base_ui/accordion.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_card.dart';

class AccordionScreen extends StatefulWidget {
  const AccordionScreen({super.key});

  @override
  State<AccordionScreen> createState() => _AccordionScreenState();
}

class _AccordionScreenState extends State<AccordionScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(
        context,
      ).accordion; //update your page tittle here
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
                      lang.accordion.toUpperCase(),
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
                          label: lang.accordion,
                          uri: RouteUri.accordion,
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
                // default accordion and single accordion
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
                          child: ShowCodeCard(
                            cardTitle: 'Default Accordion',
                            description:
                                'Use <code>Accordion()</code> to set a default accordion. Multi expandable accordion, has default suffix icon.',
                            uiView: Accordion(
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Single Collapse Accordion',
                            description:
                                'Use <code>Accordion()</code>, and add <code>singleCollapse: true</code> argument to set a single collapse accordion.',
                            uiView: Accordion(
                              singleCollapse:
                                  true, // Toggle true for single mode
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  singleCollapse: true, // Toggle true for single mode
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                // Global Prefix Icon Accordion and suffix accordion
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
                          child: ShowCodeCard(
                            cardTitle: 'Global Prefix Icon Accordion',
                            description:
                                'Use <code>Accordion()</code> to set an accordion, add <code>prefixIcon</code> argument to set global prefix icon.',
                            uiView: Accordion(
                              prefixIcon: Icons
                                  .add_circle_outline, // set global prefix icon
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  prefixIcon: Icons.add_circle_outline, // set global prefix icon
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),                         
''',
                            height: 400,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Global Suffix Icon Accordion',
                            description:
                                'Use <code>Accordion()</code> to set an accordion, add <code>suffixIcon</code> argument to set global suffix icon.',
                            uiView: Accordion(
                              singleCollapse: true,
                              suffixIcon: Icons
                                  .expand_circle_down_outlined, // set global suffix icon
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  singleCollapse: true,
  suffixIcon: Icons.expand_circle_down_outlined, // set global suffix icon
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                // Distinct Prefix accordion and Distinct Suffix accordion
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
                          child: ShowCodeCard(
                            cardTitle: 'Distinct Prefix Accordion',
                            description:
                                'Use <code>Accordion()</code> and add <code>prefixIcon</code> in <code>AccordionItemData</code> to set distinct prefix icon.',
                            uiView: Accordion(
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  prefixIcon: Icons
                                      .flutter_dash, // set distinct prefix icon
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  prefixIcon: Icons
                                      .play_arrow_outlined, // set distinct prefix icon
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  prefixIcon:
                                      Icons.code, // set distinct prefix icon
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  prefixIcon:
                                      Icons.refresh, // set distinct prefix icon
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  prefixIcon: Icons
                                      .book_outlined, // set distinct prefix icon
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      prefixIcon: Icons.flutter_dash, // set distinct prefix icon
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      prefixIcon: Icons.play_arrow_outlined, // set distinct prefix icon
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      prefixIcon: Icons.code, // set distinct prefix icon
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      prefixIcon: Icons.refresh, // set distinct prefix icon
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      prefixIcon: Icons.book_outlined, // set distinct prefix icon
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Distinct Suffix Accordion',
                            description:
                                'Use <code>Accordion()</code> and add <code>suffixIcon</code> in <code>AccordionItemData</code> to set distinct suffix icon.',
                            uiView: Accordion(
                              singleCollapse: true,
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  suffixIcon: Icons
                                      .flutter_dash, // set distinct suffix icon
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  suffixIcon: Icons
                                      .play_arrow_outlined, // set distinct suffix icon
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  suffixIcon:
                                      Icons.code, // set distinct suffix icon
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  suffixIcon:
                                      Icons.refresh, // set distinct suffix icon
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  suffixIcon: Icons
                                      .book_outlined, // set distinct suffix icon
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  singleCollapse: true,
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      suffixIcon: Icons.flutter_dash, // set distinct suffix icon
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      suffixIcon: Icons.play_arrow_outlined, // set distinct suffix icon
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      suffixIcon: Icons.code, // set distinct suffix icon
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      suffixIcon: Icons.refresh, // set distinct suffix icon
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      suffixIcon: Icons.book_outlined, // set distinct suffix icon
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                // Prefix Suffix Accordion
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
                          child: ShowCodeCard(
                            cardTitle: 'Header Color Accordion',
                            description:
                                'Use <code>Accordion()</code>, then add <code>headerColor</code> and <code>headerTextColor</code> to set header color accordion.',
                            uiView: Accordion(
                              singleCollapse: false,
                              headerColor:
                                  kSecondaryColor, // set header color when collapse
                              headerTextColor: Colors
                                  .white, // set header text color when collapse
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  prefixIcon: Icons.flutter_dash,
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  prefixIcon: Icons.play_arrow_outlined,
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  prefixIcon: Icons.code,
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  prefixIcon: Icons.refresh,
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  prefixIcon: Icons.book_outlined,
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  singleCollapse: false,
  headerColor: kSecondaryColor, // set header color when collapse
  headerTextColor: Colors .white, // set header text color when collapse
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      prefixIcon: Icons.flutter_dash,
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      prefixIcon: Icons.play_arrow_outlined,
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      prefixIcon: Icons.code,
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      prefixIcon: Icons.refresh,
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      prefixIcon: Icons.book_outlined,
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'Header Color Accordion',
                            description:
                                'Use <code>Accordion()</code>, then add <code>headerColor</code> and <code>headerTextColor</code> to set header color accordion.',
                            uiView: Accordion(
                              singleCollapse: false,
                              headerColor: kSuccessColor.withValues(
                                alpha: 0.1,
                              ), // set header color when collapse
                              headerTextColor:
                                  kSuccessColor, // set header text color when collapse
                              items: [
                                AccordionItemData(
                                  title: "What is Flutter?",
                                  prefixIcon: Icons.flutter_dash,
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "How to get started with Flutter?",
                                  prefixIcon: Icons.play_arrow_outlined,
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is Dart?",
                                  prefixIcon: Icons.code,
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                AccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  prefixIcon: Icons.refresh,
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                AccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  prefixIcon: Icons.book_outlined,
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
Accordion(
  singleCollapse: false,
  headerColor: kSuccessColor.withValues(alpha: 0.1), // set header color when collapse
  headerTextColor: kSuccessColor, // set header text color when collapse                       
  items: [
    AccordionItemData(
      title: "What is Flutter?",
      prefixIcon: Icons.flutter_dash,
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    AccordionItemData(
      title: "How to get started with Flutter?",
      prefixIcon: Icons.play_arrow_outlined,
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    AccordionItemData(
      title: "What is Dart?",
      prefixIcon: Icons.code,
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    AccordionItemData(
      title: "What is hot reload in Flutter?",
      prefixIcon: Icons.refresh,
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    AccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      prefixIcon: Icons.book_outlined,
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: kDefaultPadding),

                // multiple accordion and single accordion
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
                          child: ShowCodeCard(
                            cardTitle: 'Border Accordion',
                            description:
                                'Use <code>BorderArcodion()</code> to set an accordion, with separated border.',
                            uiView: BorderArcodion(
                              borderColor: kSuccessColor, // set border color
                              singleCollapse: true,
                              suffixIcon: Icons.expand_more,
                              items: [
                                BorderArcodionItemData(
                                  title: "What is Flutter?",
                                  prefixIcon: Icons.flutter_dash,
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                BorderArcodionItemData(
                                  title: "How to get started with Flutter?",
                                  prefixIcon: Icons.play_arrow_outlined,
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                BorderArcodionItemData(
                                  title: "What is Dart?",
                                  prefixIcon: Icons.code,
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                BorderArcodionItemData(
                                  title: "What is hot reload in Flutter?",
                                  prefixIcon: Icons.refresh,
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                BorderArcodionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  prefixIcon: Icons.book_outlined,
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
BorderArcodion(
  borderColor: kSuccessColor, // set border color
  singleCollapse: true, 
  suffixIcon: Icons.expand_more,
  items: [
    BorderArcodionItemData(
      title: "What is Flutter?",
      prefixIcon: Icons.flutter_dash,
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    BorderArcodionItemData(
      title: "How to get started with Flutter?",
      prefixIcon: Icons.play_arrow_outlined,
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    BorderArcodionItemData(
      title: "What is Dart?",
      prefixIcon: Icons.code,
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    BorderArcodionItemData(
      title: "What is hot reload in Flutter?",
      prefixIcon: Icons.refresh,
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    BorderArcodionItemData(
      title:
          "Where can I find Flutter documentation?",
      prefixIcon: Icons.book_outlined,
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
                          ),
                        ),
                        SizedBox(
                          width: mediaQueryData.size.width > kScreenWidthXxl
                              ? availableWidth * 0.5
                              : constraints.maxWidth * 1,
                          child: ShowCodeCard(
                            cardTitle: 'No Border Accordion',
                            description:
                                'Use <code>NoBorderAccordion()</code> to set an accordion, with fill color and no border.',
                            uiView: NoBorderAccordion(
                              fillColor: kSuccessColor, // set fill color
                              singleCollapse: true,
                              suffixIcon: Icons.expand_more,
                              items: [
                                NoBorderAccordionItemData(
                                  title: "What is Flutter?",
                                  prefixIcon: Icons.flutter_dash,
                                  content: const Text(
                                    "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
                                  ),
                                ),
                                NoBorderAccordionItemData(
                                  title: "How to get started with Flutter?",
                                  prefixIcon: Icons.play_arrow_outlined,
                                  content: const Text(
                                    "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
                                  ),
                                ),
                                NoBorderAccordionItemData(
                                  title: "What is Dart?",
                                  prefixIcon: Icons.code,
                                  content: const Text(
                                    "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
                                  ),
                                ),
                                NoBorderAccordionItemData(
                                  title: "What is hot reload in Flutter?",
                                  prefixIcon: Icons.refresh,
                                  content: const Text(
                                    "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
                                  ),
                                ),
                                NoBorderAccordionItemData(
                                  title:
                                      "Where can I find Flutter documentation?",
                                  prefixIcon: Icons.book_outlined,
                                  content: const Text(
                                    "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
                                  ),
                                ),
                              ],
                            ),
                            codeView: '''
NoBorderAccordion(
  fillColor: kSuccessColor, // set fill color
  singleCollapse: true,
  suffixIcon: Icons.expand_more,
  items: [
    NoBorderAccordionItemData(
      title: "What is Flutter?",
      prefixIcon: Icons.flutter_dash,
      content: const Text(
        "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
    ),
    NoBorderAccordionItemData(
      title: "How to get started with Flutter?",
      prefixIcon: Icons.play_arrow_outlined,
      content: const Text(
        "To get started with Flutter, you can install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
    ),
    NoBorderAccordionItemData(
      title: "What is Dart?",
      prefixIcon: Icons.code,
      content: const Text(
        "Dart is a client-optimized programming language for apps on multiple platforms. It is the language used to write Flutter apps, providing features such as hot reload and a rich set of libraries.",
      ),
    ),
    NoBorderAccordionItemData(
      title: "What is hot reload in Flutter?",
      prefixIcon: Icons.refresh,
      content: const Text(
        "Hot reload allows developers to see the changes made in the code instantly reflected in the app without restarting it. This feature significantly speeds up the development process.",
      ),
    ),
    NoBorderAccordionItemData(
      title:
          "Where can I find Flutter documentation?",
      prefixIcon: Icons.book_outlined,
      content: const Text(
        "The official Flutter documentation can be found at https://flutter.dev/docs. It includes guides, API references, and other resources for developers.",
      ),
    ),
  ],
),
''',
                            height: 400,
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
          PortalFooter(),
        ],
      ),
    );
  }
}

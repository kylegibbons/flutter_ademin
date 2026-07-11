import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/card.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/widgets/helper/show_code_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).cards; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //content for SpinnerCard widget
  final List<String> contentItems = [
    "The card includes a custom spinner loader that appears in the center of the content when the user clicks the refresh button. This loader indicates that the content is being reloaded and disappears when the process is complete.",
    "The card is collapsible, meaning the user can minimize or expand the content using the minimize/expand button. This feature allows for better space management in the UI.",
    "The card also includes a close button that removes the card from view entirely. Users can click this button to close the card and free up screen space.",
  ];

  // Simulate data reloading SpinnerCard widget

  bool _loadingCircular = false;
  Future<void> _reloadCircular() async {
    setState(() {
      _loadingCircular = true;
    });
    await Future.delayed(Duration(seconds: 2)); // Simulating reload
    setState(() {
      _loadingCircular = false;
    });
  }

  bool _loadingSpinkit = false;
  Future<void> _reloadSpinkit() async {
    setState(() {
      _loadingSpinkit = true;
    });
    await Future.delayed(Duration(seconds: 2)); // Simulating reload
    setState(() {
      _loadingSpinkit = false;
    });
  }

  bool _loadingCupernico = false;
  Future<void> _reloadCupernico() async {
    setState(() {
      _loadingCupernico = true;
    });
    await Future.delayed(Duration(seconds: 2)); // Simulating reload
    setState(() {
      _loadingCupernico = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final mediaQueryData = MediaQuery.of(context);
    MediaQuery.of(context);

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
                      lang.cards.toUpperCase(),
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
                        BreadcrumbItem(label: lang.cards, uri: RouteUri.card),
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
                // CONTENT

                //Card with Spinner Loader
                ShowCodeContainer(
                  title: 'Card with Spinner Loader',
                  description:
                      'Use <code>SpinnerCard()</code> to set a card with spinner loader.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Card with Circular Loader
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SpinnerCard(
                              loaderType: LoaderType.circular,
                              kTitle: 'Card with Circular Loader',
                              // example content, you can change to your own content widget
                              content: ListView.builder(
                                shrinkWrap: true,
                                itemCount: contentItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: kDefaultPadding,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: kSuccessColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(contentItems[index]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              reload:
                                  _reloadCircular, // Pass the reload function
                              isLoading:
                                  _loadingCircular, // Pass the loading state
                            ),
                          ),

                          // Card with SpinKit Wave Loader
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SpinnerCard(
                              loaderType: LoaderType.spinkitWave,
                              kTitle: 'Card with SpinKit Wave Loader',
                              // example content, you can change to your own content widget
                              content: ListView.builder(
                                shrinkWrap: true,
                                itemCount: contentItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: kDefaultPadding,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: kSuccessColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(contentItems[index]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              reload:
                                  _reloadSpinkit, // Pass the reload function
                              isLoading:
                                  _loadingSpinkit, // Pass the loading state
                            ),
                          ),

                          // Card with Cupertino Style Loader
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: SpinnerCard(
                              loaderType: LoaderType.cupertino,
                              kTitle: 'Card with Cupertino Style Loader',
                              // example content, you can change to your own content widget
                              content: ListView.builder(
                                shrinkWrap: true,
                                itemCount: contentItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: kDefaultPadding,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: kSuccessColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(contentItems[index]),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              reload:
                                  _reloadCupernico, // Pass the reload function
                              isLoading:
                                  _loadingCupernico, // Pass the loading state
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// Card with Circular Loader
SpinnerCard(
  loaderType: LoaderType.circular,
  kTitle: 'Card with Circular Loader',
  // example content, you can change to your own content widget
  content: ListView.builder(
    shrinkWrap: true,
    itemCount: contentItems.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: kDefaultPadding),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle,
                color: kSuccessColor, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                contentItems[index],
              ),
            ),
          ],
        ),
      );
    },
  ),
  reload:
      _reloadCircular, // Pass the reload function
  isLoading:
      _loadingCircular, // Pass the loading state
),

// Card with SpinKit Wave Loader
SpinnerCard(
  loaderType: LoaderType.spinkitWave,
  kTitle: 'Card with SpinKit Wave Loader',
  // example content, you can change to your own content widget
  content: ListView.builder(
    shrinkWrap: true,
    itemCount: contentItems.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: kDefaultPadding),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle,
                color: kSuccessColor, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                contentItems[index],
              ),
            ),
          ],
        ),
      );
    },
  ),
  reload:
      _reloadSpinkit, // Pass the reload function
  isLoading:
      _loadingSpinkit, // Pass the loading state
),

// Card with Cupertino Style Loader
SpinnerCard(
  loaderType: LoaderType.cupertino,
  kTitle: 'Card with Cupertino Style Loader',
  // example content, you can change to your own content widget
  content: ListView.builder(
    shrinkWrap: true,
    itemCount: contentItems.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: kDefaultPadding),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle,
                color: kSuccessColor, size: 16),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                contentItems[index],
              ),
            ),
          ],
        ),
      );
    },
  ),
  reload:
      _reloadCupernico, // Pass the reload function
  isLoading:
      _loadingCupernico, // Pass the loading state
),

//content for SpinnerCard widget
final List<String> contentItems = [
  "The card includes a custom spinner loader that appears in the center of the content when the user clicks the refresh button. This loader indicates that the content is being reloaded and disappears when the process is complete.",
  "The card is collapsible, meaning the user can minimize or expand the content using the minimize/expand button. This feature allows for better space management in the UI.",
  "The card also includes a close button that removes the card from view entirely. Users can click this button to close the card and free up screen space."
];

// Simulate data reloading SpinnerCard widget

bool _loadingCircular = false;
Future<void> _reloadCircular() async {
  setState(() {
    _loadingCircular = true;
  });
  await Future.delayed(Duration(seconds: 2)); // Simulating reload
  setState(() {
    _loadingCircular = false;
  });
}

bool _loadingSpinkit = false;
Future<void> _reloadSpinkit() async {
  setState(() {
    _loadingSpinkit = true;
  });
  await Future.delayed(Duration(seconds: 2)); // Simulating reload
  setState(() {
    _loadingSpinkit = false;
  });
}

bool _loadingCupernico = false;
Future<void> _reloadCupernico() async {
  setState(() {
    _loadingCupernico = true;
  });
  await Future.delayed(Duration(seconds: 2)); // Simulating reload
  setState(() {
    _loadingCupernico = false;
  });
}                          

''',
                ),

                SizedBox(height: kDefaultPadding),

                //Card Header Footer
                ShowCodeContainer(
                  title: 'Card Header Footer',
                  description:
                      'Use <code>HeaderFooterCard()</code> to set a card with header and footer. We can set optional header icon and close button.',
                  uiView: LayoutBuilder(
                    builder: (context, constraints) {
                      int numberOfCardsPerRow = getNumberOfCardsPerRow_3(
                        context,
                      );
                      return Wrap(
                        spacing: kDefaultPadding,
                        runSpacing: kDefaultPadding,
                        children: [
                          // Header Footer Card
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HeaderFooterCard(
                              headerTitle: 'Hi, Umar Hamzah',
                              showCloseButton: true,
                              // this is example content, you can replace it with your own content widget.
                              cardContent: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "How to get creative in your work ?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: themeData.colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: kDefaultPadding / 2),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              // this is example footer, you can replace it with your own footer widget.
                              cardFooter: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '1 hour Ago',
                                    style: TextStyle(fontSize: kBodySmall),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          'Read More',
                                          style: TextStyle(
                                            color: kSuccessColor,
                                            fontSize: kBodySmall,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 8,
                                          color: kSuccessColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HeaderFooterCard(
                              headerIcon: Icons.person,
                              headerTitle: 'Karin Azzahra',
                              // this is example content, you can replace it with your own content widget.
                              cardContent: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // this is example footer, you can replace it with your own footer widget.
                              cardFooter: Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'View All Notification (6)',
                                        style: TextStyle(
                                          color: kSecondaryColor,
                                          fontSize: kBodySmall,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 8,
                                        color: kSecondaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: HeaderFooterCard(
                              headerTitle: 'Employee Card',
                              showCloseButton: true,
                              // this is example content, you can replace it with your own content widget.
                              cardContent: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPadding,
                                  ),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/avatar_5.jpg",
                                        ),
                                      ),
                                      SizedBox(height: kDefaultPadding),
                                      Text(
                                        "Brad Pratt",
                                        style: TextStyle(
                                          color:
                                              themeData.colorScheme.onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 0.5 * kDefaultPadding),
                                      Text(
                                        "Frontend Programmer",
                                        style: TextStyle(fontSize: kBodySmall),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // this is example footer, you can replace it with your own footer widget.
                              cardFooter: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(width: kDefaultPadding),
                                  InkWell(
                                    onTap: () {},
                                    child: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: kDefaultPadding),
                                  InkWell(
                                    onTap: () {},
                                    child: FaIcon(
                                      FontAwesomeIcons.linkedinIn,
                                      size: 14,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(width: kDefaultPadding),
                                  InkWell(
                                    onTap: () {},
                                    child: FaIcon(
                                      FontAwesomeIcons.envelope,
                                      size: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''

 //Header Footer Card Read More
HeaderFooterCard(
  headerTitle: 'Hi, Umar Hamzah',
  showCloseButton: true,
  // this is example content, you can replace it with your own content widget.
  cardContent: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "How to get creative in your work ?",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: themeData.colorScheme.onSurface,
        ),
      ),
      SizedBox(height: kDefaultPadding / 2),
      Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
  // this is example footer, you can replace it with your own footer widget.
  cardFooter: Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '1 hour Ago',
        style: TextStyle(
          fontSize: kBodySmall,
        ),
      ),
      InkWell(
        onTap: () {},
        child: Row(
          children: [
            Text(
              'Read More',
              style: TextStyle(
                color: kSuccessColor,
                fontSize: kBodySmall,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 8,
              color: kSuccessColor,
            ),
          ],
        ),
      ),
    ],
  ),
),

 //Header Footer Card Notification
HeaderFooterCard(
  headerIcon: Icons.person,
  headerTitle: 'Karin Azzahra',
  // this is example content, you can replace it with your own content widget.
  cardContent: Text(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    maxLines: 7,
    overflow: TextOverflow.ellipsis,
  ),
  // this is example footer, you can replace it with your own footer widget.
  cardFooter: Center(
    child: InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View All Notification (6)',
            style: TextStyle(
              color: kSecondaryColor,
              fontSize: kBodySmall,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 8,
            color: kSecondaryColor,
          ),
        ],
      ),
    ),
  ),
),

 //Header Footer Card Employee Card
HeaderFooterCard(
  headerTitle: 'Employee Card',
  showCloseButton: true,
  // this is example content, you can replace it with your own content widget.
  cardContent: Center(
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/avatar_5.jpg"),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            "Brad Pratt",
            style: TextStyle(
              color:
                  themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 0.5 * kDefaultPadding,
          ),
          Text(
            "Frontend Programmer",
            style: TextStyle(
              fontSize: kBodySmall,
            ),
          ),
        ],
      ),
    ),
  ),
  // this is example footer, you can replace it with your own footer widget.
  cardFooter: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {},
        child: FaIcon(
          FontAwesomeIcons.facebook,
          size: 14,
          color: Colors.blue,
        ),
      ),
      SizedBox(
        width: kDefaultPadding,
      ),
      InkWell(
        onTap: () {},
        child: FaIcon(
          FontAwesomeIcons.whatsapp,
          size: 14,
          color: Colors.green,
        ),
      ),
      SizedBox(
        width: kDefaultPadding,
      ),
      InkWell(
        onTap: () {},
        child: FaIcon(
          FontAwesomeIcons.linkedinIn,
          size: 14,
          color: Colors.blueGrey,
        ),
      ),
      SizedBox(
        width: kDefaultPadding,
      ),
      InkWell(
        onTap: () {},
        child: FaIcon(
          FontAwesomeIcons.envelope,
          size: 14,
          color: Colors.red,
        ),
      ),
    ],
  ),
),                        
''',
                ),

                SizedBox(height: kDefaultPadding),

                ShowCodeContainer(
                  title: 'Card Border Color',
                  description:
                      'Use <code>BorderColorCard()</code> to set a card with border color.',
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
                            child: BorderColorCard(
                              color: kPrimaryColor,
                              headerTitle: 'Handle to Forecast',
                              status: 'Poor',
                              statusColor: kErrorColor,
                              progress: '75%',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: kWarningColor,
                              headerTitle: 'Project Alpha',
                              status: 'Good',
                              statusColor: kSuccessColor,
                              progress: '85%',
                              content:
                                  'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: kInfoColor,
                              headerTitle: 'Market Trends',
                              status: 'Moderate',
                              statusColor: kWarningColor,
                              progress: '65%',
                              content:
                                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: kSecondaryColor,
                              headerTitle: 'Sales Analysis',
                              status: 'Poor',
                              statusColor: kErrorColor,
                              progress: '50%',
                              content:
                                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: kErrorColor,
                              headerTitle: 'Financial Forecast',
                              status: 'Good',
                              statusColor: kSuccessColor,
                              progress: '90%',
                              content:
                                  'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: kSuccessColor,
                              headerTitle: 'Team Productivity',
                              status: 'Excellent',
                              statusColor: kSuccessColor,
                              progress: '95%',
                              content:
                                  'Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BorderColorCard(
                              color: themeData.colorScheme.onSurface,
                              headerTitle: 'Risk Assessment',
                              status: 'Poor',
                              statusColor: kErrorColor,
                              progress: '45%',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
BorderColorCard(
  color: kPrimaryColor,
  headerTitle: 'Handle to Forecast',
  status: 'Poor',
  statusColor: kErrorColor,
  progress: '75%',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: kWarningColor,
  headerTitle: 'Project Alpha',
  status: 'Good',
  statusColor: kSuccessColor,
  progress: '85%',
  content:
      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: kInfoColor,
  headerTitle: 'Market Trends',
  status: 'Moderate',
  statusColor: kWarningColor,
  progress: '65%',
  content:
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: kSecondaryColor,
  headerTitle: 'Sales Analysis',
  status: 'Poor',
  statusColor: kErrorColor,
  progress: '50%',
  content:
      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: kErrorColor,
  headerTitle: 'Financial Forecast',
  status: 'Good',
  statusColor: kSuccessColor,
  progress: '90%',
  content:
      'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: kSuccessColor,
  headerTitle: 'Team Productivity',
  status: 'Excellent',
  statusColor: kSuccessColor,
  progress: '95%',
  content:
      'Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),

BorderColorCard(
  color: themeData.colorScheme.onSurface,
  headerTitle: 'Risk Assessment',
  status: 'Poor',
  statusColor: kErrorColor,
  progress: '45%',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
),
''',
                ),

                SizedBox(height: kDefaultPadding),

                ShowCodeContainer(
                  title: 'Card Background Color',
                  description:
                      'Use <code>BackgroundColorCard()</code> to set a card with solid background color.',
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
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_1.jpg',
                              name: 'Hani Salma',
                              job: 'Graphic Designer',
                              status: 'started a new conversation',
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_2.jpg',
                              name: 'Jeffrey Montgomery',
                              job: 'UI/UX Designer',
                              status: 'updated his portfolio',
                              color: kSecondaryColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_3.jpg',
                              name: 'Sophia Williams',
                              job: 'Product Manager',
                              status: 'scheduled a meeting',
                              color: kInfoColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_4.jpg',
                              name: 'Aiden Smith',
                              job: 'Software Engineer',
                              status: 'committed new code',
                              color: kSuccessColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_5.jpg',
                              name: 'Emma Johnson',
                              job: 'Data Scientist',
                              status: 'shared a new report',
                              color: kWarningColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_6.jpg',
                              name: 'Liam Brown',
                              job: 'DevOps Engineer',
                              status: 'deployed new updates',
                              color: kErrorColor,
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: BackgroundColorCard(
                              userImg: 'assets/images/avatar_7.jpg',
                              name: 'Olivia Martinez',
                              job: 'Marketing Specialist',
                              status: 'launched a campaign',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
BackgroundColorCard(
  userImg: 'assets/images/avatar_1.jpg',
  name: 'Hani Salma',
  job: 'Graphic Designer',
  status: 'started a new conversation',
  color: kPrimaryColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_2.jpg',
  name: 'Jeffrey Montgomery',
  job: 'UI/UX Designer',
  status: 'updated his portfolio',
  color: kSecondaryColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_3.jpg',
  name: 'Sophia Williams',
  job: 'Product Manager',
  status: 'scheduled a meeting',
  color: kInfoColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_4.jpg',
  name: 'Aiden Smith',
  job: 'Software Engineer',
  status: 'committed new code',
  color: kSuccessColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_5.jpg',
  name: 'Emma Johnson',
  job: 'Data Scientist',
  status: 'shared a new report',
  color: kWarningColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_6.jpg',
  name: 'Liam Brown',
  job: 'DevOps Engineer',
  status: 'deployed new updates',
  color: kErrorColor,
),

BackgroundColorCard(
  userImg: 'assets/images/avatar_7.jpg',
  name: 'Olivia Martinez',
  job: 'Marketing Specialist',
  status: 'launched a campaign',
  color: Colors.black,
),
''',
                ),

                SizedBox(height: kDefaultPadding),

                // Vertical Thumbnail Card
                ShowCodeContainer(
                  title: 'Vertical Thumbnail Card',
                  description:
                      'Use <code>VerticalThumbnailCard()</code> to set a vertical thumbnail card',
                  height: 480,
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
                            child: VerticalThumbnailCard(
                              thumbnailLocation: ThumbnailLocation.top,
                              thumbnail: 'assets/images/thumbnail_2.jpg',
                              header: 'Card with Image Thumbnail at The Top',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              footer: 'Last updated 3 hours ago',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: VerticalThumbnailCard(
                              thumbnailLocation: ThumbnailLocation.middle,
                              thumbnail: 'assets/images/thumbnail_1.jpg',
                              header: 'Card with Image Thumbnail in The Middle',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              footer: 'Last updated 3 hours ago',
                            ),
                          ),
                          SizedBox(
                            width: calculateCardWidth_3(
                              context,
                              constraints,
                              numberOfCardsPerRow,
                            ),
                            child: VerticalThumbnailCard(
                              thumbnailLocation: ThumbnailLocation.bottom,
                              thumbnail: 'assets/images/thumbnail_3.jpg',
                              header: 'Card with Image Thumbnail at The Bottom',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              footer: 'Last updated 3 hours ago',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// thumbnail at top
VerticalThumbnailCard(
  thumbnailLocation: ThumbnailLocation.top,
  thumbnail: 'assets/images/thumbnail_2.jpg',
  header: 'Card with Image Thumbnail at The Top',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  footer: 'Last updated 3 hours ago',
),

// thumbnail at middle
VerticalThumbnailCard(
  thumbnailLocation: ThumbnailLocation.middle,
  thumbnail: 'assets/images/thumbnail_1.jpg',
  header: 'Card with Image Thumbnail in The Middle',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  footer: 'Last updated 3 hours ago',
),

// thumbnail at bottom
VerticalThumbnailCard(
  thumbnailLocation: ThumbnailLocation.bottom,
  thumbnail: 'assets/images/thumbnail_3.jpg',
  header: 'Card with Image Thumbnail at The Bottom',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  footer: 'Last updated 3 hours ago',
),
''',
                ),

                SizedBox(height: kDefaultPadding),

                ShowCodeContainer(
                  title: 'Horizontal Thumbnail Card',
                  description:
                      'Use <code>HorizontalThumbnailCard()</code> to set a horizontal thumbnail card',
                  height: 400,
                  uiView: LayoutBuilder(
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
                            child: HorizontalThumbnailCard(
                              thumbnailLocation:
                                  HorizontalThumbnailLocation.left,
                              thumbnail: 'assets/images/thumbnail_1.jpg',
                              header:
                                  'Card with Image Thumbnail at The Left Side',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              footer: 'Last updated 3 hours ago',
                            ),
                          ),
                          SizedBox(
                            width: mediaQueryData.size.width > kScreenWidthXxl
                                ? availableWidth * 0.5
                                : constraints.maxWidth * 1,
                            child: HorizontalThumbnailCard(
                              thumbnailLocation:
                                  HorizontalThumbnailLocation.right,
                              thumbnail: 'assets/images/thumbnail_2.jpg',
                              header:
                                  'Card with Image Thumbnail at The Right Side',
                              content:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              footer: 'Last updated 3 hours ago',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  codeView: '''
// left thumbnail
HorizontalThumbnailCard(
  thumbnailLocation:
      HorizontalThumbnailLocation.left,
  thumbnail: 'assets/images/thumbnail_1.jpg',
  header:
      'Card with Image Thumbnail at The Left Side',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  footer: 'Last updated 3 hours ago',
),

// right thumbnail
HorizontalThumbnailCard(
  thumbnailLocation:
      HorizontalThumbnailLocation.right,
  thumbnail: 'assets/images/thumbnail_2.jpg',
  header:
      'Card with Image Thumbnail at The Right Side',
  content:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  footer: 'Last updated 3 hours ago',
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

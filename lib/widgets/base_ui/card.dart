import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Header Footer Card Widget

class HeaderFooterCard extends StatefulWidget {
  final IconData? headerIcon;
  final String headerTitle;
  final bool showCloseButton;
  final Widget cardContent;
  final Widget? cardFooter;
  const HeaderFooterCard({
    super.key,
    this.headerIcon,
    required this.headerTitle,
    this.showCloseButton = false,
    required this.cardContent,
    this.cardFooter,
  });

  @override
  State<HeaderFooterCard> createState() => _HeaderFooterCardState();
}

class _HeaderFooterCardState extends State<HeaderFooterCard> {
  bool _closed = false;

  // Close the card
  void _closeCard() {
    setState(() {
      _closed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if (_closed) {
      return SizedBox(); // Return an empty widget if the card is closed
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.headerIcon != null)
                  Padding(
                    padding: EdgeInsets.only(right: kDefaultPadding / 2),
                    child: Icon(widget.headerIcon, color: kTextColor, size: 18),
                  ),
                Text(
                  widget.headerTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                if (widget.showCloseButton)
                  InkWell(
                    onTap: _closeCard,
                    child: Icon(
                      Icons.close,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
              ],
            ),
          ),

          Divider(height: 0),

          // Content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: widget.cardContent,
          ),

          // Footer
          if (widget.cardFooter != null)
            Column(
              children: [
                Divider(height: 0),
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: widget.cardFooter,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class RightThumbnailCard extends StatelessWidget {
  const RightThumbnailCard({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'Card with Image Thumbnail at The Right Side',
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(height: 0),

                //content
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //time
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    "Last updated 3 hours ago",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),

          //image thumbnail
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: Image.asset(
              'assets/images/thumbnail_2.jpg',
              height: 180,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

//Card with image thumbnail at left side

class LeftThumbnailCard extends StatelessWidget {
  const LeftThumbnailCard({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          //image thumbnail
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            child: Image.asset(
              'assets/images/thumbnail_1.jpg',
              height: 180,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'Card with Image Thumbnail at The Left Side',
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(height: 0),

                //content
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                //time
                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    "Last updated 3 hours ago",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Vertical Thumbnail Card

// Enumeration to define the thumbnail location
enum ThumbnailLocation { top, middle, bottom }

class VerticalThumbnailCard extends StatelessWidget {
  final ThumbnailLocation thumbnailLocation;
  final String thumbnail;
  final String header;
  final String content;
  final String footer;

  const VerticalThumbnailCard({
    super.key,
    required this.thumbnailLocation,
    required this.thumbnail,
    required this.header,
    required this.content,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // Helper function to build the card's children based on the thumbnail location
    List<Widget> buildCardChildren() {
      switch (thumbnailLocation) {
        case ThumbnailLocation.top:
          return [
            // thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              child: Image.asset(
                thumbnail,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),

            // header
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                header,
                style: TextStyle(
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            _buildDivider(),
            // content
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildDivider(),

            // footer
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                footer,
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
          ];
        case ThumbnailLocation.middle:
          return [
            // header
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                header,
                style: TextStyle(
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildDivider(),
            // content
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // thumbnail
            ClipRRect(
              child: Image.asset(
                thumbnail,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),

            // footer
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                footer,
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
          ];
        case ThumbnailLocation.bottom:
          return [
            // header
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                header,
                style: TextStyle(
                  color: themeData.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildDivider(),
            // content
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildDivider(),
            // footer
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                footer,
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              child: Image.asset(
                thumbnail,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
          ];
      }
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildCardChildren(),
      ),
    );
  }

  // Helper function to create a divider
  Widget _buildDivider() => Divider(height: 0);
}

// Horizontal Thumbnail Card

// Enumeration to define the thumbnail location
enum HorizontalThumbnailLocation { left, right }

class HorizontalThumbnailCard extends StatelessWidget {
  final HorizontalThumbnailLocation thumbnailLocation;
  final String thumbnail;
  final String header;
  final String content;
  final String footer;

  const HorizontalThumbnailCard({
    super.key,
    required this.thumbnailLocation,
    required this.thumbnail,
    required this.header,
    required this.content,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // Helper function to build the card's children based on the thumbnail location
    List<Widget> buildCardChildren() {
      switch (thumbnailLocation) {
        case HorizontalThumbnailLocation.left:
          return [
            // thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              child: Image.asset(
                thumbnail,
                height: 180,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      header,
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(height: 0),

                  //content
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //footer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      footer,
                      style: TextStyle(color: themeData.colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
          ];
        case HorizontalThumbnailLocation.right:
          return [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      header,
                      style: TextStyle(
                        color: themeData.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(height: 0),

                  //content
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //footer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      footer,
                      style: TextStyle(color: themeData.colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),

            // thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              child: Image.asset(
                thumbnail,
                height: 180,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ];
      }
    }

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildCardChildren(),
      ),
    );
  }
}

//Card Background Color widget

class BackgroundColorCard extends StatelessWidget {
  const BackgroundColorCard({
    super.key,
    required this.userImg,
    required this.name,
    required this.job,
    required this.status,
    required this.color,
  });

  final String userImg, name, job, status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Column(
        children: [
          //avatar, name, message
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: AssetImage(userImg)),
                SizedBox(width: kDefaultPadding),
                Flexible(
                  child: RichText(
                    softWrap: true,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: " "),
                        TextSpan(
                          text: job,
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(text: " "),
                        TextSpan(
                          text: status,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //connect button
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Connect Now", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Card Border Color Widget

class BorderColorCard extends StatelessWidget {
  const BorderColorCard({
    super.key,
    required this.color,
    required this.headerTitle,
    required this.status,
    required this.statusColor,
    required this.progress,
    required this.content,
  });

  final Color color, statusColor;
  final String headerTitle, status, progress, content;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 0.7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            // Header Row
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: themeData.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: kLabelSmall,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(progress),
                ],
              ),
            ),

            Divider(height: 0, color: color, thickness: 0.7),

            // Body content
            Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kDefaultPadding,
              ),
              child: Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: themeData.colorScheme.onSurface),
              ),
            ),

            //Footer
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Read More",
                          style: TextStyle(
                            color: color,
                            fontSize: kBodySmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_ios, color: color, size: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Card with Spinner Loader

//define loader type
enum LoaderType { circular, spinkitWave, cupertino }

class SpinnerCard extends StatefulWidget {
  final LoaderType loaderType;
  final String kTitle;
  final Widget content;
  final VoidCallback reload;
  final bool isLoading;

  const SpinnerCard({
    super.key,
    required this.loaderType,
    required this.kTitle,
    required this.content,
    required this.reload,
    this.isLoading = false,
  });

  @override
  State<SpinnerCard> createState() => _SpinnerCardState();
}

class _SpinnerCardState extends State<SpinnerCard> {
  bool _minimized = false;
  bool _closed = false;

  // Toggle card minimization
  void _toggleMinimize() {
    setState(() {
      _minimized = !_minimized;
    });
  }

  // Close the card
  void _closeCard() {
    setState(() {
      _closed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    if (_closed) {
      return SizedBox(); // Return an empty widget if the card is closed
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              children: [
                Text(
                  widget.kTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: widget.isLoading ? null : widget.reload,
                  child: Icon(
                    Icons.refresh,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: kDefaultPadding),
                InkWell(
                  onTap: _toggleMinimize,
                  child: Icon(
                    _minimized ? Icons.expand_more : Icons.expand_less,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: kDefaultPadding),
                InkWell(
                  onTap: _closeCard,
                  child: Icon(
                    Icons.close,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 0),

          // Body content that can be minimized
          if (!_minimized)
            Stack(
              children: [
                // The main content (ListView.builder)
                Container(
                  padding: EdgeInsets.only(
                    top: kDefaultPadding,
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: widget.content,
                ),
                // The overlay spinner while loading
                if (widget.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: themeData.colorScheme.surface.withValues(
                        alpha: 0.4,
                      ),
                      child: Center(child: _buildLoader()),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  // Method to switch between loader types
  Widget _buildLoader() {
    switch (widget.loaderType) {
      case LoaderType.spinkitWave:
        return SpinKitWave(color: kErrorColor, size: 44.0);
      case LoaderType.cupertino:
        return CupertinoActivityIndicator(radius: 20, color: kSecondaryColor);
      case LoaderType.circular:
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kSuccessColor),
        );
    }
  }
}

//EmployeeCard Data

class Employee {
  final String name;
  final String position;
  final String imageUrl;
  final String amount;

  Employee({
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.amount,
  });
}

final List<Employee> employees = [
  Employee(
    name: "Deasy Melin",
    position: "Digital Marketing",
    imageUrl: "assets/images/avatar_1.jpg",
    amount: "\$17,548",
  ),
  Employee(
    name: "Umar Hamzah",
    position: "Manager",
    imageUrl: "assets/images/avatar_2.jpg",
    amount: "\$9,785",
  ),
  Employee(
    name: "Jhon Johnson",
    position: "Development",
    imageUrl: "assets/images/avatar_3.jpg",
    amount: "\$3,542",
  ),
  Employee(
    name: "Erica Roman",
    position: "Fashion Designer",
    imageUrl: "assets/images/avatar_4.jpg",
    amount: "\$758",
  ),
  Employee(
    name: "Brad Pratt",
    position: "Design",
    imageUrl: "assets/images/avatar_5.jpg",
    amount: "\$1,856",
  ),
  // Add more employees if needed
];

//EmployeeCard Widget

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(employee.imageUrl),
                  radius: 20,
                ),
                SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      employee.position,
                      style: TextStyle(fontSize: kBodySmall),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Text(
              employee.amount,
              style: TextStyle(
                color: themeData.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: kBodyMedium,
              ),
            ),
            Text('Expense Account', style: TextStyle(fontSize: kBodySmall)),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  'See Details',
                  style: TextStyle(fontSize: kBodySmall),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

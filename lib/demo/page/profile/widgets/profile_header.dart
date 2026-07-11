import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';

// Profile header

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableWidth = constraints.maxWidth - kDefaultPadding;
        return Wrap(
          spacing: kDefaultPadding,
          runSpacing: kDefaultPadding,
          children: [
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.7
                  : constraints.maxWidth * 1,
              child: Wrap(
                runSpacing: 2 * kDefaultPadding,
                children: [
                  // Avatar
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 46,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage('assets/images/avatar_2.jpg'),
                    ),
                  ),

                  SizedBox(width: kDefaultPadding),

                  // name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Umar Hamzah',
                        style: TextStyle(
                          fontSize: kTitleLarge,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Owner & Admin',
                        style: TextStyle(
                          fontSize: kBodyLarge,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding / 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // location
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                          SizedBox(width: kDefaultPadding / 4),
                          Text(
                            'Metrocity, Indonesia',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          SizedBox(width: kDefaultPadding),

                          // company
                          Icon(
                            Icons.corporate_fare_outlined,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                          SizedBox(width: kDefaultPadding / 4),
                          Text(
                            'TekoTech',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: mediaQueryData.size.width > kScreenWidthXxl
                  ? availableWidth * 0.3
                  : constraints.maxWidth * 1,
              child: Row(
                mainAxisAlignment: mediaQueryData.size.width > kScreenWidthXxl
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  // stats
                  Column(
                    children: [
                      Text(
                        '325',
                        style: TextStyle(
                          fontSize: kTitleLarge,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Projects',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 2 * kDefaultPadding),

                  Column(
                    children: [
                      Text(
                        '147',
                        style: TextStyle(
                          fontSize: kTitleLarge,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Tasks',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
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
    );
  }
}

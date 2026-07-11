import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/dashboard_analytics_data.dart';
import 'package:flutter_ademin/demo/dashboard/analytics/widgets/popup_menu_button.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/widgets/helper/card_header.dart';

class TopPagesTable extends StatelessWidget {
  const TopPagesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyleHeader = TextStyle(
      fontWeight: FontWeight.w600,
      color: kTextColor,
    );
    final themeData = Theme.of(context);

    return SizedBox(
      height: 438,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            CardHeader(kText: 'Top Pages', kWidget: PeriodPopUpMenu()),

            // Table Header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              ),
              decoration: BoxDecoration(color: kTableHeaderColor),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text('Active Page', style: textStyleHeader),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Active', style: textStyleHeader),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Users', style: textStyleHeader),
                  ),
                ],
              ),
            ),
            Divider(height: 0),
            SizedBox(height: kDefaultPadding / 2),

            // Table Rows
            ...topPages.map((page) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2,
                  horizontal: kDefaultPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        page.path,
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: themeData.colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        page.active.toString(),
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${page.users.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: kDefaultPadding / 2),
          ],
        ),
      ),
    );
  }
}

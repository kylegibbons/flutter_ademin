import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/utils/responsive_helper.dart';
import 'package:flutkit_ademin/widgets/base_ui/metric_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ecommerce metrics card

class EcommerceDashboardMetrics extends StatelessWidget {
  const EcommerceDashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrap(
      breakpoints: {
        kScreenWidthSm: 1,
        kScreenWidthLg: 2,
        kScreenWidthXl: 4,

      },
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4,],
      children: [
        LinkMetricCard(
          title: 'Total Revenue',
          value: '\$759.15k',
          changePercent: 14.64,
          actionText: 'Net revenue',
          icon: FontAwesomeIcons.dollarSign,
          iconBgColor: kInfoColor,
        ),
        LinkMetricCard(
          title: 'Orders',
          value: '26,124',
          changePercent: -2.54,
          actionText: 'All orders',
          icon: FontAwesomeIcons.bagShopping,
          iconBgColor: kSuccessColor,
        ),
        LinkMetricCard(
          title: 'Customers',
          value: '18,335',
          changePercent: 24.58,
          actionText: 'All costumers',
          icon: FontAwesomeIcons.user,
          iconBgColor: kWarningColor,
        ),
        
        LinkMetricCard(
          title: 'Conversion Rate',
          value: '15.89%',
          changePercent: 6.13,
          actionText: 'See details',
          icon: FontAwesomeIcons.check,
          iconBgColor: kSecondaryColor,
        ),
      ],
    );
  }
}

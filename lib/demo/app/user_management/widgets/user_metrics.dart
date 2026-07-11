import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/user_management/user_management_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/animation/animation.dart';

class UserMetricsSection extends StatelessWidget {
  final List<UserModel> users;
  const UserMetricsSection({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final metrics = UserMetrics.fromUsers(users);
    return AdaptiveWrap(
      breakpoints: {kScreenWidthMd: 1, kScreenWidthLg: 2, kScreenWidthXl: 4},
      columnRatios: const [0.25, 0.25, 0.25, 0.25],
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      children: [
        MetricCard(
          title: 'Total Users',
          value: metrics.totalUsers
              .toString(), // in production metrics data should come from a backend aggregate API, not from UI list
          delta: 23.4,
          icon: Icons.people_outline,
          color: kInfoColor,
        ),
        MetricCard(
          title: 'Active Users',
          value: metrics.activeUsers.toString(),
          delta: -3.2,
          icon: Icons.check_circle_outline,
          color: kSuccessColor,
        ),
        MetricCard(
          title: 'Paid Users',
          value: metrics.paidUsers.toString(),
          delta: 4.5,
          icon: Icons.workspace_premium_outlined,
          color: kSecondaryColor,
        ),
        MetricCard(
          title: 'Suspended / Banned',
          value: metrics.restrictedUsers.toString(),
          delta: -9.8,
          icon: Icons.block,
          color: kErrorColor,
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final double delta;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.delta,
    required this.icon,
    required this.color,
  });

  bool get isPositive => delta >= 0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final trendColor = isPositive ? kSuccessColor : kErrorColor;
    final trendIcon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // card title
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      // card value
                      Text(
                        value,
                        style: TextStyle(
                          color: themeData.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: kHeadlineSmall,
                        ),
                      ),
                    ],
                  ),

                  // icon
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(defaultRadius),
                      // shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                ],
              ),

              // TREND LINE
              Row(
                children: [
                  Icon(trendIcon, size: 14, color: trendColor),
                  const SizedBox(width: 4),
                  Text(
                    '${delta.abs().toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: trendColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(' vs previous month'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

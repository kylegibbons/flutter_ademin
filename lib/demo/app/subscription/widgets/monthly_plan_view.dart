import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/subscription/subscription_data.dart';
import 'package:flutter_ademin/demo/app/subscription/widgets/pricing_card.dart';

class MonthlyPlanView extends StatelessWidget {
  const MonthlyPlanView({super.key});

  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXxl) return 4;
    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = calculateCrossAxisCount(screenWidth);
    return Container(
      key: ValueKey('monthly'),
      child: GridView.builder(
        itemCount: plans.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: kDefaultPadding,
          mainAxisSpacing: kDefaultPadding,
          mainAxisExtent: 648,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return PricingCard(plan: plan);
        },
      ),
    );
  }
}

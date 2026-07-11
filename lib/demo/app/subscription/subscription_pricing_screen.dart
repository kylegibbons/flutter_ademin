import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/subscription/widgets/annual_plan_view.dart';
import 'package:flutter_ademin/demo/app/subscription/widgets/monthly_plan_view.dart';
import 'package:flutter_ademin/demo/app/subscription/widgets/pricing_tab_selector.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle = Lang.of(context).pricing; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // selected index for billing tab

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          PageHeader(
            title: lang.pricing.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.pricing, uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                SizedBox(height: kDefaultPadding),
                Text(
                  "Plans & Pricing",
                  style: TextStyle(
                    color: themeData.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: kHeadlineSmall,
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Text(
                  'Simple pricing. Powerful features for your business, without the hidden costs.',
                  style: TextStyle(fontSize: kBodyLarge),
                ),
                SizedBox(height: kDefaultPadding),
                PricingTabSelector(
                  selectedIndex: selectedIndex,
                  onTabChanged: (index) =>
                      setState(() => selectedIndex = index),
                ),
                SizedBox(height: kDefaultPadding),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: selectedIndex == 0
                      ? MonthlyPlanView(key: ValueKey('monthly'))
                      : AnnualPlanView(key: ValueKey('annually')),
                ),
                SizedBox(height: 2 * kDefaultPadding),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4 * kDefaultPadding,
                  ),
                  child: Text(
                    'Supporters enjoy a 30% discount on early access, plus an additional 20% off the annual plan. You’ll also gain exclusive behind-the-scenes access to the product, code, and insights — and play a key role in shaping its future.',
                    style: TextStyle(fontSize: kBodyMedium),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 2 * kDefaultPadding),
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

// billing tab selector

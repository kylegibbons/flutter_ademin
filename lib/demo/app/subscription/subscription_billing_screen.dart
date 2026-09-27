import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/subscription/widgets/billing_history_table.dart';
import 'package:flutkit_ademin/demo/app/subscription/widgets/current_plan_card.dart';
import 'package:flutkit_ademin/demo/app/subscription/widgets/payment_method_card.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      //update your page tittle here
      final pageTitle = Lang.of(context).billing;
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // page header
          PageHeader(
            title: lang.billing.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.billing, uri: ''),
            ],
          ),
          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final isMobile = screenWidth < kScreenWidthXl;

                    ///  Mobile → vertical (natural height)
                    if (isMobile) {
                      return Column(
                        children: const [
                          CurrentPlanCard(),
                          SizedBox(height: kDefaultPadding),
                          PaymentMethodCard(
                            cardBrand: "Visa",
                            last4Digits: "4242",
                            expiry: "12/2028",
                          ),
                        ],
                      );
                    }

                    /// Desktop → equal height
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Expanded(flex: 7, child: CurrentPlanCard()),
                          SizedBox(width: kDefaultPadding),
                          Expanded(
                            flex: 3,
                            child: PaymentMethodCard(
                              cardBrand: "Visa",
                              last4Digits: "4242",
                              expiry: "12/2028",
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: kDefaultPadding),

                // billing history
                BillingHistoryTable(),
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

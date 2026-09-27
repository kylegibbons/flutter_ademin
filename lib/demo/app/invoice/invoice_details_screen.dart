import 'package:flutter/material.dart';
import 'package:flutkit_ademin/app_router.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/invoice/invoice_data.dart';
import 'package:flutkit_ademin/demo/app/invoice/widgets/invoices_details.dart';
import 'package:flutkit_ademin/generated/l10n.dart';
import 'package:flutkit_ademin/widgets/helper/page_title.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutkit_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutkit_ademin/configs/global_config.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle =
          '${Lang.of(context).invoices(1)} ${Lang.of(context).detail}'; //update your page tittle here
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
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final double dynamicHorizontalPadding = screenWidth < kScreenWidthXl
        ? kDefaultPadding
        : 8 * kDefaultPadding;

    final double dynamicVerticalPadding = screenWidth < kScreenWidthXl
        ? kDefaultPadding
        : 2 * kDefaultPadding;

    return PortalMasterLayout(
      body: ListView(
        children: [
          // header
          PageHeader(
            title: '${Lang.of(context).invoices(1)} ${Lang.of(context).detail}'
                .toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.invoices(2), uri: ''),
            ],
          ),

          //content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicHorizontalPadding,
              vertical: dynamicVerticalPadding,
            ),
            child: InvoiceDetails(invoice: mockInvoice),
          ),

          //footer
          PortalFooter(),
        ],
      ),
    );
  }
}

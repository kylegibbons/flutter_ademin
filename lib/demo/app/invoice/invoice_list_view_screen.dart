import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/invoice/widgets/invoices_metrics.dart';
import 'package:flutter_ademin/demo/app/invoice/widgets/invoices_table.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class InvoiceListViewScreen extends StatefulWidget {
  const InvoiceListViewScreen({super.key});

  @override
  State<InvoiceListViewScreen> createState() => _InvoiceListViewScreenState();
}

class _InvoiceListViewScreenState extends State<InvoiceListViewScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle =
          '${Lang.of(context).invoices(1)} ${Lang.of(context).list}'; //update your page tittle here
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

    return PortalMasterLayout(
      body: ListView(
        children: [
          // header
          PageHeader(
            title: '${Lang.of(context).invoices(1)} ${Lang.of(context).list}'
                .toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(label: lang.invoices(2), uri: ''),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // invoices metrics
                InvoiceMetrics(),

                SizedBox(height: kDefaultPadding),

                // invoices list
                InvoiceTable(),
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

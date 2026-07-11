import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/invoice/widgets/create_invoice_form.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';

class InvoiceCreateScreen extends StatefulWidget {
  const InvoiceCreateScreen({super.key});

  @override
  State<InvoiceCreateScreen> createState() => _InvoiceCreateScreenState();
}

class _InvoiceCreateScreenState extends State<InvoiceCreateScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pageTitle = 'Create ${Lang.of(context).invoices(1)}';
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < kScreenWidthXl
        ? kDefaultPadding
        : 8 * kDefaultPadding;
    final verticalPadding = screenWidth < kScreenWidthXl
        ? kDefaultPadding
        : 2 * kDefaultPadding;

    return PortalMasterLayout(
      body: ListView(
        children: [
          PageHeader(
            title: 'Create ${lang.invoices(1)}'.toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(
                label: lang.invoices(2),
                uri: RouteUri.invoiceList,
              ),
              BreadcrumbItem(label: 'Create', uri: ''),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Card(child: const CreateInvoiceForm()),
          ),
          const PortalFooter(),
        ],
      ),
    );
  }
}

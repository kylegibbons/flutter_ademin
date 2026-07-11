import 'package:flutter/material.dart';
import 'package:flutter_ademin/app_router.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_list_metrics.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_list_table.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/breadcrumb.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/page_header.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class TicketListViewScreen extends StatefulWidget {
  const TicketListViewScreen({super.key});

  @override
  State<TicketListViewScreen> createState() => _TicketListViewScreenState();
}

class _TicketListViewScreenState extends State<TicketListViewScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle =
          '${Lang.of(context).ticket(2)} ${Lang.of(context).list}'; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // responsive grid item count based on screen width
  int calculateCrossAxisCount(double width) {
    if (width >= kScreenWidthXl) return 4;

    if (width >= kScreenWidthSm) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return PortalMasterLayout(
      body: ListView(
        children: [
          // header
          PageHeader(
            title: '${Lang.of(context).ticket(2)} ${Lang.of(context).list}'
                .toUpperCase(),
            breadcrumbItems: [
              BreadcrumbItem(label: lang.dashboard, uri: RouteUri.home),
              BreadcrumbItem(label: lang.apps(2), uri: ''),
              BreadcrumbItem(
                label: '${Lang.of(context).ticket(2)} ${Lang.of(context).list}',
                uri: '',
              ),
            ],
          ),

          //content
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                // ticket metrics
                TicketMetrics(),

                SizedBox(height: kDefaultPadding),

                // tickets list
                TicketListTable(),
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

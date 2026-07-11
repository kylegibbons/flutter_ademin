import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_data.dart';
import 'package:flutter_ademin/demo/app/support_ticket/ticket_models.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_details_attachment.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_details_description.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_details_header.dart';
import 'package:flutter_ademin/demo/app/support_ticket/widgets/ticket_details_sidebar.dart';
import 'package:flutter_ademin/generated/l10n.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/helper/page_title.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_footer.dart';
import 'package:flutter_ademin/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter_ademin/configs/global_config.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Dynamically update the <title> tag after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageTitle =
          '${Lang.of(context).ticket(2)} ${Lang.of(context).detail}'; //update your page tittle here
      updatePageTitle('$pageTitle | ${AppSettings.appName}');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TicketDetail ticket = dummyTicketDetail;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < kScreenWidthSm;

    return PortalMasterLayout(
      body: ListView(
        children: [
          Stack(
            children: [
              // header background
              Container(
                decoration: BoxDecoration(color: themeData.colorScheme.surface),
                foregroundDecoration: BoxDecoration(
                  color: kSecondaryColor.withValues(alpha: 0.1),
                ),
                height: isMobile ? 260 : 160,
              ),

              // content
              Container(
                padding: EdgeInsets.only(
                  top: 1.5 * kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                child: Column(
                  children: [
                    // ticket details header
                    TicketDetailsHeader(ticket: ticket, isMobile: isMobile),

                    SizedBox(height: 1.5 * kDefaultPadding),

                    AdaptiveWrap(
                      breakpoints: {kScreenWidthXl: 1, kScreenWidthXxl: 2},
                      columnRatios: [0.7, 0.3],
                      children: [
                        // ticket details description
                        TicketDetailsDescription(ticket: ticket),

                        Column(
                          children: [
                            // Ticket Details sidebar
                            TicketDetailSidebar(ticket: dummyTicketDetail),

                            const SizedBox(height: kDefaultPadding),

                            // Ticket Details Attachment
                            AttachmentSidebar(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          //footer
          const PortalFooter(),
        ],
      ),
    );
  }
}

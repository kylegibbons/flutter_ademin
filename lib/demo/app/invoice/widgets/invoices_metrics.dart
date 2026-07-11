import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/animation/animation.dart';

class InvoiceMetrics extends StatelessWidget {
  const InvoiceMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveWrap(
      columnRatios: [1 / 4, 1 / 4, 1 / 4, 1 / 4],
      spacing: kDefaultPadding,
      runSpacing: kDefaultPadding,
      breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2, kScreenWidthLg: 4},
      children: [
        InvoiceSummaryCard(
          title: "Invoices Sent",
          amount: "\$549.26k",
          countText: "1,268",
          subtitle: "Invoices sent",
          percentChange: "+79.21 %",
          icon: Icons.description_outlined,
        ),
        InvoiceSummaryCard(
          title: "Paid Invoices",
          amount: "\$519.66k",
          countText: "1,759",
          subtitle: "Paid by clients",
          percentChange: "-9.03 %",
          icon: Icons.check_box_outlined,
        ),
        InvoiceSummaryCard(
          title: "Unpaid Invoices",
          amount: "\$141.98k",
          countText: "836",
          subtitle: "Unpaid by clients",
          percentChange: "-9.51 %",
          icon: Icons.access_time_outlined,
        ),
        InvoiceSummaryCard(
          title: "Cancelled Invoices",
          amount: "\$86.2k",
          countText: "8702",
          subtitle: "Cancelled by clients",
          percentChange: "+8.56 %",
          icon: Icons.cancel_outlined,
        ),
      ],
    );
  }
}

// invoices summary card

class InvoiceSummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String countText;
  final IconData icon;

  final String percentChange;
  final String subtitle;

  const InvoiceSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.countText,
    required this.icon,
    required this.percentChange,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return HoverAnimatedWidget(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + Percentage Change
              Row(
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: kBodyMedium,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        percentChange.startsWith('+')
                            ? Icons.arrow_outward
                            : Icons.south_east,
                        color: percentChange.startsWith('+')
                            ? kSuccessColor
                            : kErrorColor,
                        size: 14,
                      ),
                      SizedBox(width: kDefaultPadding / 4),
                      Text(
                        percentChange,
                        style: TextStyle(
                          fontSize: kBodyMedium,
                          color: percentChange.startsWith('+')
                              ? kSuccessColor
                              : kErrorColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ammount in $
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: kHeadlineSmall,
                          fontWeight: FontWeight.w600,
                          color: themeData.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: kDefaultPadding),

                      // invoices ammout
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: kWarningColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              countText,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: kBodyMedium,
                              color: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Spacer(),

                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSuccessColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(icon, color: kSuccessColor, size: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

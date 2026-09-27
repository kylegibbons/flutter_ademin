import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/helper/card_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RecentTransactionList extends StatelessWidget {
  const RecentTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(kText: 'Recent Transaction'),
          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: transactions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final bool isLastItem = index == transactions.length - 1;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: isLastItem ? 0 : kDefaultPadding,
                  ),
                  child: RecentTransactionItem(
                    transaction: transactions[index],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FlatButton(
              kText: 'View All Transactions',
              bgColor: kInfoColor.withValues(alpha: 0.1),
              kTextColor: kInfoColor,
              kTrailingIcon: Icons.arrow_forward,
              isFullWidth: true,
              onPressed: () {},
            ),
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

// recent transaction item

class RecentTransactionItem extends StatelessWidget {
  final TransactionItem transaction;

  const RecentTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final meta = getCurrencyMeta(transaction.currencyCode);
    final isPositive = transaction.amount >= 0;
    final themeData = Theme.of(context);
    final numberFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey.withValues(alpha: 0.2),
          radius: 16,
          child: CircleAvatar(
            backgroundColor: meta.color,
            radius: 14,
            child: FaIcon(meta.icon, color: Colors.white, size: 14),
          ),
        ),
        const SizedBox(width: kDefaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${meta.name} (${transaction.currencyCode})',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: themeData.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 4),
              Text(
                transaction.date,
                style: TextStyle(color: kTextColor, fontSize: kBodyMedium),
              ),
            ],
          ),
        ),
        Text(
          '${isPositive ? '+' : '-'} ${numberFormat.format(transaction.amount.abs())}',
          style: TextStyle(
            color: isPositive ? kSuccessColor : kErrorColor,
            fontWeight: FontWeight.w500,
            fontSize: kBodyMedium,
          ),
        ),
      ],
    );
  }
}

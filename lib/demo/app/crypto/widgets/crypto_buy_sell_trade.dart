import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/base_ui/tab.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';

class TradeWidget extends StatefulWidget {
  const TradeWidget({super.key});

  @override
  State<TradeWidget> createState() => _TradeWidgetState();
}

class _TradeWidgetState extends State<TradeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _amountController = TextEditingController(
    text: '3',
  );
  final TextEditingController _priceController = TextEditingController(
    text: '\$3.043115',
  );
  final TextEditingController _totalController = TextEditingController(
    text: '1308.16',
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buy/Sell Tab Bar
          HorizontalTabBar(
            indicatorColor: kSuccessColor,
            labelColor: kSuccessColor,
            unselectedLabelColor: themeData.colorScheme.onSurface,
            isScrollable: false,
            indicatorWeight: 1.6,
            tabBarHeight: 64,
            tabs: [
              TabBarItem(
                label: 'Buy',
                icon: Icons.add_shopping_cart_outlined,
                content: SizedBox(
                  height: 640,
                  child: _buildTradeForm('Buy Coin', kSuccessColor),
                ),
              ),
              TabBarItem(
                label: 'Sell',
                icon: Icons.attach_money_outlined,
                content: SizedBox(
                  height: 640,
                  child: _buildTradeForm('Sell Coin', kErrorColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTradeForm(String buttonText, Color buttonColor) {
    final themeData = Theme.of(context);
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kWarningColor.withValues(alpha: 0.1),
            ),
            padding: EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText == 'Buy Coin' ? 'Buy Coin' : 'Sell Coin',
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.bold,
                    color: buttonColor,
                  ),
                ),
                Spacer(),
                Text(
                  'USD Balance : ',
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    color: kInfoColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$11,526.47',
                  style: TextStyle(
                    fontSize: kBodyMedium,
                    fontWeight: FontWeight.bold,
                    color: themeData.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          // currency
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FormLabel(
              text: 'Currency :',
              showRequired: false,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomDropdownFormField<String>(
              hint: 'Choose Currency',
              items: [
                DropdownMenuItem(
                  value: "btc",
                  child: Text(
                    "BTC",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
                DropdownMenuItem(
                  value: "eth",
                  child: Text(
                    "ETH",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
                DropdownMenuItem(
                  value: "ltc",
                  child: Text(
                    "LTC",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
              ],
              initialValue: 'btc',
              onChanged: (String? newValueCurrency) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: kDefaultPadding),

          // payment method
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FormLabel(
              text: 'Payment Method :',
              showRequired: false,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomDropdownFormField<String>(
              hint: 'Choose Payment Method',
              items: [
                DropdownMenuItem(
                  value: "walletBC",
                  child: Text(
                    "Wallet Bc",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
                DropdownMenuItem(
                  value: "creadiCard",
                  child: Text(
                    "Credit Card",
                    style: TextStyle(color: themeData.colorScheme.onSurface),
                  ),
                ),
              ],
              initialValue: 'walletBC',
              onChanged: (String? newValueWallet) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: kDefaultPadding),

          // amount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FormLabel(
              text: 'Amount :',
              showRequired: false,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomTextFormField(
              controller: _amountController,
              labelText: 'Enter Amount',
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: kDefaultPadding),

          // price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FormLabel(
              text: 'Price :',
              showRequired: false,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomTextFormField(
              controller: _priceController,
              readOnly: true,
            ),
          ),

          SizedBox(height: kDefaultPadding),

          // total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FormLabel(
              text: 'Total :',
              showRequired: false,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomTextFormField(
              controller: _totalController,
              readOnly: true,
            ),
          ),

          Spacer(),

          // Transaction Fees, Min Received, Estimated Rate
          _buildInfoRow('Transaction Fees (0.05%)', '\$1.08'),
          const SizedBox(height: kDefaultPadding / 2),
          _buildInfoRow('Minimum Received (2%)', '\$7.85'),
          const SizedBox(height: kDefaultPadding / 2),
          _buildInfoRow('Estimated Rate', '1 BTC ~ \$46982.70'),
          Spacer(),

          // button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: FlatButton(
              kText: buttonText,
              bgColor: buttonColor,
              kTextColor: Colors.white,
              isFullWidth: true,
              onPressed: () {
                // Implement buy/sell logic here
                // print('${buttonText} button pressed!');
              },
            ),
          ),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: kBodyMedium, color: kTextColor),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: kBodyMedium,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

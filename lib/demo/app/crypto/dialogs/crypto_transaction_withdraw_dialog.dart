import 'package:flutter/material.dart';
import 'package:flutkit_ademin/constants/dimens.dart';
import 'package:flutkit_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';
import 'package:flutkit_ademin/widgets/base_ui/button.dart';
import 'package:flutkit_ademin/widgets/form/form_basic_element.dart';
import 'package:flutkit_ademin/widgets/form/form_dropdown.dart';

class WithdrawDialog extends StatefulWidget {
  final WalletAsset asset;

  const WithdrawDialog({super.key, required this.asset});

  @override
  State<WithdrawDialog> createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  late CryptoNetwork selectedNetwork;

  final TextEditingController addressController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectedNetwork = CryptoNetwork.bitcoin;
  }

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildNetworkSelector(),

          const SizedBox(height: kDefaultPadding),

          CustomTextFormField(
            hintText: 'Recipient Address',
            suffixIcon: Icons.qr_code_scanner,
          ),

          const SizedBox(height: kDefaultPadding),

          CustomTextFormField(
            hintText: 'Amount',
            suffixIcon: Icons.currency_bitcoin_outlined,
          ),

          const SizedBox(height: kDefaultPadding),

          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              border: Border.all(
                color: themeData.colorScheme.outline,
                width: outlineWidth,
              ),
            ),
            child: Column(
              children: [
                _InfoRow(
                  title: 'Available',
                  value: '${widget.asset.balance} ${widget.asset.symbol}',
                ),
                const SizedBox(height: kDefaultPadding),
                _InfoRow(
                  title: 'Network Fee',
                  value: '0.0002 ${widget.asset.symbol}',
                ),
                const SizedBox(height: kDefaultPadding),
                _InfoRow(
                  title: 'Receive Amount',
                  value: '0.0498 ${widget.asset.symbol}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 1.5 * kDefaultPadding),

          _buildWarningCard(),

          const SizedBox(height: 1.5 * kDefaultPadding),

          FlatButton(
            kText: 'Confirm Withdraw',
            isFullWidth: true,
            bgColor: kSecondaryColor,
            kTextColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkSelector() {
    return CustomDropdownFormField<CryptoNetwork>(
      hint: 'Select Network',
      items: CryptoNetwork.values.map((network) {
        return DropdownMenuItem(
          value: network,
          child: Text(_networkName(network)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedNetwork = value!;
        });
      },
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kWarningColor.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(defaultRadius),
        border: Border.all(color: kWarningColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: kWarningColor),
          const SizedBox(width: kDefaultPadding),

          Expanded(
            child: Text(
              'Only send ${widget.asset.symbol} via ${_networkName(selectedNetwork)} network.',
              style: TextStyle(color: kWarningColor),
            ),
          ),
        ],
      ),
    );
  }

  String _networkName(CryptoNetwork network) {
    switch (network) {
      case CryptoNetwork.bitcoin:
        return 'Bitcoin';

      case CryptoNetwork.ethereum:
        return 'ERC20';

      case CryptoNetwork.tron:
        return 'TRC20';

      case CryptoNetwork.bsc:
        return 'BEP20';

      case CryptoNetwork.solana:
        return 'Solana';
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      children: [
        Text(title, style: TextStyle(color: themeData.colorScheme.onSurface)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeData.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

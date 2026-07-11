import 'package:flutter/material.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_data.dart';
import 'package:flutter_ademin/demo/app/crypto/crypto_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_dropdown.dart';

// deposit_dialog.dart

class DepositDialog extends StatefulWidget {
  final WalletAsset asset;

  const DepositDialog({super.key, required this.asset});

  @override
  State<DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends State<DepositDialog> {
  late CryptoNetwork selectedNetwork;

  @override
  void initState() {
    super.initState();

    selectedNetwork = CryptoNetwork.bitcoin;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // network selector
          _buildNetworkSelector(),

          const SizedBox(height: kDefaultPadding),

          // QR code
          Icon(
            Icons.qr_code_2,
            size: 200,
            color: themeData.colorScheme.onSurface,
          ),

          const SizedBox(height: kDefaultPadding),
          // warning note
          _buildWarningCard(),

          const SizedBox(height: 2 * kDefaultPadding),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              border: Border.all(
                color: themeData.colorScheme.outline,
                width: outlineWidth,
              ),
            ),
            child: SelectableText(
              mockWalletAddress.address,
              textAlign: TextAlign.center,
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ),

          const SizedBox(height: kDefaultPadding),

          // action
          AdaptiveWrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding,
            breakpoints: {kScreenWidthSm / 2: 1, kScreenWidthSm: 2},
            columnRatios: [0.5, 0.5],
            children: [
              CustomOutlinedButton(
                kText: 'Copy',
                kLeadingIcon: Icons.copy,
                textColor: themeData.colorScheme.onSurface,
                outlineColor: themeData.colorScheme.outline,
                onPressed: () {},
              ),
              FlatButton(
                kText: 'Share',
                bgColor: kSecondaryColor,
                kLeadingIcon: Icons.share,
                kTextColor: Colors.white,
                onPressed: () {},
              ),
            ],
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
                  title: 'Network',
                  value: _networkName(selectedNetwork),
                ),
                const SizedBox(height: 14),
                _InfoRow(
                  title: 'Minimum Deposit',
                  value:
                      '${mockWalletAddress.minimumDeposit} ${widget.asset.symbol}',
                ),
                const SizedBox(height: 14),
                _InfoRow(
                  title: 'Confirmations',
                  value: '${mockWalletAddress.confirmations}',
                ),
              ],
            ),
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

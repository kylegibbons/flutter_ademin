import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ademin/constants/dimens.dart';
import 'package:flutter_ademin/demo/app/subscription/subscription_models.dart';
import 'package:flutter_ademin/theme/themes.dart';
import 'package:flutter_ademin/utils/responsive_helper.dart';
import 'package:flutter_ademin/widgets/base_ui/button.dart';
import 'package:flutter_ademin/widgets/form/form_basic_element.dart';

class AddEditCardFormDialog extends StatefulWidget {
  final PaymentMethod? method;
  final ValueChanged<PaymentMethod> onSaved;

  const AddEditCardFormDialog({super.key, this.method, required this.onSaved});

  @override
  State<AddEditCardFormDialog> createState() => _AddEditCardFormDialogState();
}

class _AddEditCardFormDialogState extends State<AddEditCardFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController cardNumberController;
  late final TextEditingController nameController;
  late final TextEditingController expiryController;
  late final TextEditingController cvvController;

  CardBrand brand = CardBrand.unknown;

  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController(
      text: widget.method?.cardNumber ?? '',
    );
    nameController = TextEditingController(
      text: widget.method?.holderName ?? '',
    );
    expiryController = TextEditingController(text: widget.method?.expiry ?? '');
    cvvController = TextEditingController();

    cardNumberController.addListener(_handlePreviewChange);
    nameController.addListener(_handlePreviewChange);
    expiryController.addListener(_handlePreviewChange);
    _detectBrand();
  }

  void _handlePreviewChange() {
    _detectBrand();
    setState(() {});
  }

  void _detectBrand() {
    final input = cardNumberController.text.replaceAll(' ', '');

    if (input.startsWith('4')) {
      brand = CardBrand.visa;
    } else if (input.startsWith('5')) {
      brand = CardBrand.mastercard;
    } else if (input.startsWith('3')) {
      brand = CardBrand.amex;
    } else {
      brand = CardBrand.unknown;
    }
  }

  String _formatCard(String input) {
    input = input.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      buffer.write(input[i]);
      if ((i + 1) % 4 == 0 && i != input.length - 1) {
        buffer.write(' ');
      }
    }
    return buffer.toString();
  }

  String _formatExpiry(String input) {
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    final limited = digits.length > 4 ? digits.substring(0, 4) : digits;

    if (limited.length <= 2) {
      return limited;
    }

    return '${limited.substring(0, 2)}/${limited.substring(2)}';
  }

  String? _validateExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return "Invalid";
    }

    final parts = value.split('/');
    if (parts.length != 2 || parts[0].length != 2 || parts[1].length != 2) {
      return "Use MM/YY";
    }

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null || month < 1 || month > 12) {
      return "Invalid month";
    }

    return null;
  }

  String _brandLabel(CardBrand brand) {
    switch (brand) {
      case CardBrand.visa:
        return "Visa";
      case CardBrand.mastercard:
        return "Mastercard";
      case CardBrand.amex:
        return "Amex";
      case CardBrand.unknown:
        return "Card";
    }
  }

  String _brandAsset(CardBrand brand) {
    switch (brand) {
      case CardBrand.mastercard:
        return "assets/images/mastercard.png";
      case CardBrand.visa:
      case CardBrand.amex:
      case CardBrand.unknown:
        return "assets/images/visa.png";
    }
  }

  @override
  void dispose() {
    cardNumberController.removeListener(_handlePreviewChange);
    nameController.removeListener(_handlePreviewChange);
    expiryController.removeListener(_handlePreviewChange);
    cardNumberController.dispose();
    nameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final isEditing = widget.method != null;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardPreview(
            number: cardNumberController.text,
            name: nameController.text,
            expiry: expiryController.text,
            brand: brand,
          ),
          const SizedBox(height: kDefaultPadding),
          Form(
            key: _formKey,
            child: Column(
              children: [
                FormLabel(text: 'Card Number'),
                SizedBox(height: kDefaultPadding / 2),
                CustomTextFormField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  hintText: '1234 5678 9876 5432',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      final formatted = _formatCard(newValue.text);
                      return TextEditingValue(
                        text: formatted,
                        selection: TextSelection.collapsed(
                          offset: formatted.length,
                        ),
                      );
                    }),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.replaceAll(' ', '').length < 16) {
                      return "Invalid card number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                FormLabel(text: 'Card Holder Name'),
                SizedBox(height: kDefaultPadding / 2),
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'John Doe',
                  validator: (value) => value!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: kDefaultPadding),
                AdaptiveWrap(
                  columnRatios: [0.5, 0.5],
                  breakpoints: {kScreenWidthSm: 1, kScreenWidthMd: 2},
                  children: [
                    Column(
                      children: [
                        FormLabel(text: 'Expiry Date'),
                        SizedBox(height: kDefaultPadding / 2),
                        CustomTextFormField(
                          controller: expiryController,
                          hintText: 'MM/YY',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            TextInputFormatter.withFunction((
                              oldValue,
                              newValue,
                            ) {
                              final formatted = _formatExpiry(newValue.text);
                              return TextEditingValue(
                                text: formatted,
                                selection: TextSelection.collapsed(
                                  offset: formatted.length,
                                ),
                              );
                            }),
                          ],
                          validator: _validateExpiry,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FormLabel(text: 'CVV'),
                        SizedBox(height: kDefaultPadding / 2),
                        CustomTextFormField(
                          controller: cvvController,
                          hintText: '123',
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 3 ? "Invalid" : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            children: [
              Icon(Icons.lock, size: 16),
              const SizedBox(width: kDefaultPadding / 2),
              Text(
                "Your payment info is securely encrypted",
                style: TextStyle(fontSize: kBodySmall),
              ),
            ],
          ),
          const SizedBox(height: 1.5 * kDefaultPadding),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  kText: 'Cancel',
                  outlineColor: themeData.colorScheme.primary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: FlatButton(
                  kText: isEditing ? "Save Changes" : "Add Card",
                  bgColor: kSecondaryColor,
                  kTextColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSaved(
                        PaymentMethod(
                          cardNumber: cardNumberController.text,
                          holderName: nameController.text,
                          brand: _brandLabel(brand),
                          expiry: expiryController.text,
                          icon: _brandAsset(brand),
                          isDefault: widget.method?.isDefault ?? false,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Card Preview Widget
class _CardPreview extends StatelessWidget {
  final String number;
  final String name;
  final String expiry;
  final CardBrand brand;

  const _CardPreview({
    required this.number,
    required this.name,
    required this.expiry,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2 * defaultRadius),
        gradient: const LinearGradient(
          colors: [Colors.black87, Colors.black54],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Brand
          Align(
            alignment: Alignment.topRight,
            child: Text(
              _brandText(),
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const Spacer(),

          /// Number
          Text(
            number.isEmpty ? "**** **** **** ****" : number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: kDefaultPadding / 2),

          /// Name + Expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.isEmpty ? "CARD HOLDER" : name.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                expiry.isEmpty ? "MM/YY" : expiry,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _brandText() {
    switch (brand) {
      case CardBrand.visa:
        return "VISA";
      case CardBrand.mastercard:
        return "MASTERCARD";
      case CardBrand.amex:
        return "AMEX";
      default:
        return "CARD";
    }
  }
}

// feature item model for current / active plan card

import 'package:flutter/material.dart';
import 'package:flutter_ademin/theme/themes.dart';

class FeatureItemModel {
  final String text;
  final bool isActive;

  const FeatureItemModel({required this.text, required this.isActive});
}

// plan usage models

class UsageModel {
  final String title;
  final double value;
  final double max;
  final String unit;

  UsageModel({
    required this.title,
    required this.value,
    required this.max,
    required this.unit,
  });
}

// update payment method models

enum CardBrand { visa, mastercard, amex, unknown }

enum PaymentMethodAction { setDefault, edit, remove }

class PaymentMethod {
  final String cardNumber;
  final String holderName;
  final String brand;
  final String expiry;
  final String icon; // asset path
  final bool isDefault;

  const PaymentMethod({
    required this.cardNumber,
    required this.holderName,
    required this.brand,
    required this.expiry,
    required this.icon,
    this.isDefault = false,
  });

  String get last4 {
    final digits = cardNumber.replaceAll(' ', '');
    if (digits.length < 4) return digits;
    return digits.substring(digits.length - 4);
  }

  PaymentMethod copyWith({
    String? cardNumber,
    String? holderName,
    String? brand,
    String? expiry,
    String? icon,
    bool? isDefault,
  }) {
    return PaymentMethod(
      cardNumber: cardNumber ?? this.cardNumber,
      holderName: holderName ?? this.holderName,
      brand: brand ?? this.brand,
      expiry: expiry ?? this.expiry,
      icon: icon ?? this.icon,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

// billing history

enum BillingStatus { paid, pending, failed }

class BillingModel {
  final String invoice;
  final DateTime date;
  final double amount;
  final BillingStatus status;
  final String description;

  const BillingModel({
    required this.invoice,
    required this.date,
    required this.amount,
    required this.status,
    required this.description,
  });
}

extension BillingStatusExt on BillingStatus {
  String get label {
    switch (this) {
      case BillingStatus.paid:
        return "Paid";
      case BillingStatus.pending:
        return "Pending";
      case BillingStatus.failed:
        return "Failed";
    }
  }

  Color get color {
    switch (this) {
      case BillingStatus.paid:
        return kSuccessColor;
      case BillingStatus.pending:
        return kWarningColor;
      case BillingStatus.failed:
        return kErrorColor;
    }
  }
}

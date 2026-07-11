// data model

import 'package:flutter/material.dart';
import 'package:flutter_ademin/theme/themes.dart';

class InvoiceModel {
  final CompanyInfo companyInfo;
  final String invoiceNo;
  final DateTime dateTime;
  final String paymentStatus;
  final double totalAmount;
  final Address billingAddress;
  final Address shippingAddress;
  final List<ProductItem> items;
  final double estimatedTaxPercent;
  final double discountAmount;
  final double shippingCharge;
  final PaymentDetails paymentDetails;

  InvoiceModel({
    required this.companyInfo,
    required this.invoiceNo,
    required this.dateTime,
    required this.paymentStatus,
    required this.totalAmount,
    required this.billingAddress,
    required this.shippingAddress,
    required this.items,
    required this.estimatedTaxPercent,
    required this.discountAmount,
    required this.shippingCharge,
    required this.paymentDetails,
  });
}

class CompanyInfo {
  final String logoUrl;
  final String companyName;
  final String legalRegistrationNo;
  final String email;
  final String website;
  final String contactNo;
  final String address;
  final String zipCode;

  CompanyInfo({
    required this.logoUrl,
    required this.companyName,
    required this.legalRegistrationNo,
    required this.email,
    required this.website,
    required this.contactNo,
    required this.address,
    required this.zipCode,
  });
}

class Address {
  final String name;
  final String street;
  final String phone;
  final String? tax;

  Address({
    required this.name,
    required this.street,
    required this.phone,
    this.tax,
  });
}

class ProductItem {
  final String title;
  final String description;
  final double rate;
  final int quantity;

  ProductItem({
    required this.title,
    required this.description,
    required this.rate,
    required this.quantity,
  });

  double get amount => rate * quantity;
}

class PaymentDetails {
  final String method;
  final String cardHolder;
  final String cardNumber;

  PaymentDetails({
    required this.method,
    required this.cardHolder,
    required this.cardNumber,
  });
}

// invoice data model

enum PaymentStatus { paid, partiallyPaid, unpaid, refund, cancel }

extension PaymentStatusLabel on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.paid:
        return 'paid';
      case PaymentStatus.partiallyPaid:
        return 'partially paid';
      case PaymentStatus.unpaid:
        return 'unpaid';
      case PaymentStatus.refund:
        return 'refund';
      case PaymentStatus.cancel:
        return 'cancel';
    }
  }

  String get titleLabel {
    final words = label.split(' ');
    return words
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  String get uppercaseLabel => label.toUpperCase();
}

Color getStatusColor(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.paid:
      return kSuccessColor;
    case PaymentStatus.partiallyPaid:
      return kInfoColor;
    case PaymentStatus.unpaid:
      return kWarningColor;
    case PaymentStatus.refund:
      return kInfoColor;
    case PaymentStatus.cancel:
      return kErrorColor;
  }
}

class InvoiceData {
  final String id;
  final String customerName;
  final String avatarUrl;
  final String email;
  final String country;
  final DateTime date;
  final double amount;
  final PaymentStatus status;

  InvoiceData({
    required this.id,
    required this.customerName,
    required this.avatarUrl,
    required this.email,
    required this.country,
    required this.date,
    required this.amount,
    required this.status,
  });
}

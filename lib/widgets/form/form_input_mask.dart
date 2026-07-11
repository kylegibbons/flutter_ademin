import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputMask {
  // Date Formatter
  static TextInputFormatter date({String dateFormat = '##/##/####'}) {
    return _PatternFormatter(pattern: dateFormat, allowedRegExp: RegExp(r'\d'));
  }

  // Time Formatter
  static TextInputFormatter time({String timeFormat = '##:##:##'}) {
    return _PatternFormatter(pattern: timeFormat, allowedRegExp: RegExp(r'\d'));
  }

  // Credit Card Formatter (e.g., #### #### #### ####)
  static TextInputFormatter creditCard({
    String pattern = '#### #### #### ####',
  }) {
    return _PatternFormatter(pattern: pattern, allowedRegExp: RegExp(r'\d'));
  }

  // Delimiter Formatter (customizable pattern)
  static TextInputFormatter delimiter({String pattern = '###-###-###'}) {
    return _PatternFormatter(pattern: pattern, allowedRegExp: RegExp(r'\d'));
  }

  // Phone Formatter (e.g., (###) ###-#### or ###-###-####)
  static TextInputFormatter phone({String pattern = '(###) ###-####'}) {
    return _PatternFormatter(pattern: pattern, allowedRegExp: RegExp(r'\d'));
  }

  // Currency Formatter

  static TextInputFormatter currency({
    required String currencyCode,
    String? locale,
    bool showCent = true,
  }) {
    locale ??= 'en_US'; // fallback
    final symbol = NumberFormat.simpleCurrency(
      name: currencyCode,
      locale: locale,
    ).currencySymbol;
    return _CurrencyFormatter(
      symbol: symbol,
      locale: locale,
      showCent: showCent,
    );
  }
}

// Pattern formatter class for customizable patterns
class _PatternFormatter extends TextInputFormatter {
  final String pattern;
  final RegExp allowedRegExp;

  _PatternFormatter({required this.pattern, required this.allowedRegExp});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final onlyAllowed = newValue.text.replaceAll(
      RegExp('[^${allowedRegExp.pattern}]'),
      '',
    );

    var formattedText = '';
    var index = 0;

    // Insert characters according to the specified pattern
    for (var i = 0; i < pattern.length; i++) {
      if (index >= onlyAllowed.length) break;

      if (pattern[i] == '#') {
        formattedText += onlyAllowed[index];
        index++;
      } else {
        formattedText += pattern[i];
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

// Currency formatter class
class _CurrencyFormatter extends TextInputFormatter {
  final String symbol;
  final String locale;
  final bool showCent;

  _CurrencyFormatter({
    required this.symbol,
    required this.locale,
    required this.showCent,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) {
      return TextEditingValue.empty;
    }

    if (!showCent) {
      final value = int.parse(digitsOnly);
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: symbol,
        decimalDigits: 0,
      );
      final formatted = formatter.format(value);
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    double value;
    if (digitsOnly.length <= 2) {
      value = int.parse(digitsOnly) / 100.0;
    } else {
      final integerPart = digitsOnly.substring(0, digitsOnly.length - 2);
      final decimalPart = digitsOnly.substring(digitsOnly.length - 2);
      value = double.parse('$integerPart.$decimalPart');
    }

    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
    final formatted = formatter.format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final String locale;
  final int decimalDigits;
  final String symbol;

  CurrencyInputFormatter({
    this.locale = 'id_ID', // Default ke Indonesia
    this.decimalDigits = 0, // Default tanpa desimal
    this.symbol = 'Rp ', // Default simbol Rupiah
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Jika input kosong, kembalikan nilai kosong
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Hanya ambil karater angka (buang titik, koma, simbol)
    String numericOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Konversi angka murni menjadi double, dibagi 10 pangkat jumlah desimal
    // Contoh: jika desimal 2 dan user ngetik '123', maka jadinya 1.23
    double value = double.parse(numericOnly) / pow(10, decimalDigits);

    // Format menggunakan intl berdasarkan locale dan symbol
    final formatter = NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigits,
      symbol: symbol,
    );

    String newText = formatter.format(value);

    // Kembalikan teks yang sudah diformat dengan kursor selalu di akhir
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

import 'package:flutter/material.dart';

// FaqItem model

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

class FaqCategory {
  final String title;
  final IconData icon;
  final List<FaqItem> items;

  FaqCategory({required this.title, required this.icon, required this.items});
}

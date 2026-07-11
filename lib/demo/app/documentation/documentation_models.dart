import 'dart:convert';
import 'package:flutter/services.dart';

class DocCategory {
  final String id;
  final String title;
  final int order;
  final List<DocItem> items;

  const DocCategory({
    required this.id,
    required this.title,
    this.order = 0,
    this.items = const [],
  });

  factory DocCategory.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<DocItem> itemsList = list
        .map((i) => DocItem.fromJson(i, json['id']))
        .toList();
    itemsList.sort((a, b) => a.order.compareTo(b.order));

    return DocCategory(
      id: json['id'],
      title: json['title'],
      order: json['order'] ?? 0,
      items: itemsList,
    );
  }
}

class DocItem {
  final String id;
  final String categoryId;
  final String title;
  final String slug;
  final String assetPath;
  final int order;

  const DocItem({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.slug,
    required this.assetPath,
    this.order = 0,
  });

  factory DocItem.fromJson(Map<String, dynamic> json, String catId) {
    return DocItem(
      id: json['id'],
      categoryId: catId,
      title: json['title'],
      slug: json['slug'],
      assetPath: json['assetPath'],
      order: json['order'] ?? 0,
    );
  }
}

// --- SERVICE ---

class DocService {
  static Future<List<DocCategory>> loadManifest() async {
    final String response = await rootBundle.loadString(
      'assets/mds/documentation/manifest.json',
    );
    final List<dynamic> data = json.decode(response);
    List<DocCategory> categories = data
        .map((json) => DocCategory.fromJson(json))
        .toList();
    categories.sort((a, b) => a.order.compareTo(b.order));
    return categories;
  }
}

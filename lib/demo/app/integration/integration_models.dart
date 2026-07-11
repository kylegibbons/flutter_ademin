// Data model

class Integration {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  bool isEnabled;

  Integration({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    this.isEnabled = false,
  });
}

import 'package:flutkit_ademin/configs/global_config.dart';

late Environment _env;

Environment get env => _env;

/// A class to manage the environment configuration for the application.
/// This class is responsible for storing global settings such as
/// the API base URL and the default application language code.

class Environment {
  final String apiBaseUrl;
  final String defaultAppLanguageCode;

  Environment._init({
    required this.apiBaseUrl,
    required this.defaultAppLanguageCode,
  });

  static void init({
    required String apiBaseUrl,
    String defaultAppLanguageCode =
        AppSettings.defaultLocale, // default language
  }) {
    _env = Environment._init(
      apiBaseUrl: apiBaseUrl,
      defaultAppLanguageCode: defaultAppLanguageCode,
    );
  }
}

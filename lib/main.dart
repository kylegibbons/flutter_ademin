import 'package:flutter/material.dart';
import 'package:flutter_ademin/environment.dart';
import 'package:flutter_ademin/root_app.dart';
import 'package:flutter_ademin/configs/global_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.init(apiBaseUrl: AppSettings.apiBaseUrl);

  runApp(ProviderScope(child: const RootApp()));
}

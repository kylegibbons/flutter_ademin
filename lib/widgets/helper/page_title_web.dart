import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;

void updatePageTitle(String title) {
  if (kIsWeb) {
    web.document.title = title;
  }
}

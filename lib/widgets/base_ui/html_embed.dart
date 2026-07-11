export 'html_embed_stub.dart'
    if (dart.library.html) 'html_embed_web.dart'
    if (dart.library.io) 'html_embed_mobile.dart';

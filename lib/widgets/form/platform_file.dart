import 'dart:typed_data';

class PlatformFile {
  PlatformFile({
    required this.name,
    required this.size,
    this.bytes,
    this.path,
    this.extension,
  });

  final String name;
  final int size;
  final Uint8List? bytes;
  final String? path;
  final String? extension;
}

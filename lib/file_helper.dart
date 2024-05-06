import 'dart:typed_data';

abstract class FileHelper {
  Future<String> read(String path);
  Future<void> write(String path, Uint8List data);
}

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:sticky/file_helper.dart';

class FileHelperImpl implements FileHelper {
  @override
  Future<String> read(String path) {
    throw UnimplementedError();
  }

  @override
  Future<void> write(String path, Uint8List data) async {
    FilePicker.platform.saveFile(fileName: path, bytes: data);
  }
}

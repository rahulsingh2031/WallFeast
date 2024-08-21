import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class DownloaderUtils {
  static Future<File> getFileFromImageUrl(String url) async {
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    final pathDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    final imageFilePath = path.join(pathDirectory.path, "image");
    final imageFilePathWithName = path.join(imageFilePath, "image${uuid.v4()}");

    await Directory(imageFilePath).create(recursive: true);
    File file = File(imageFilePathWithName);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}

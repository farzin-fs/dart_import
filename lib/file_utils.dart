import 'dart:io';

import 'messages.dart';

Future<bool> isExists(String path) async => await File(path).exists();

Future<String> readContents(String path) async {
  if (await isExists(path)) {
    return await File(path).readAsString();
  } else {
    print(Exception(Errors.fileNotFound(path)));
  }
}

Future<File> writeContents(String path, String content) async {
  return await File(path).writeAsString(content);
}

Set<String> addExtension(List<String> filenames) {
  return filenames.map((path) {
    return path.endsWith('.dart') ? path : '$path.dart';
  }).toSet();
}

Set<String> getDirectoryFiles() {
  return Directory('./lib')
      .listSync(recursive: true)
      .where((item) => item is File)
      .map((file) => file.path)
      .where((path) => path.endsWith('.dart'))
      .toSet();
}

import 'dart:io';

Future<bool> isExists(String path) async => await File(path).exists();

Future<String> readContents(String path) async {
  if (await isExists(path)) {
    return await File(path).readAsString();
  } else {
    throw Error();
  }
}

Future<File> writeContents(String path, String content) async {
  return await File(path).writeAsString(content);
}

Set<String> normalizePath(List<String> filenames) {
  return filenames.map((path) {
    return path.endsWith(".dart") ? path : "$path.dart";
  }).toSet();
}

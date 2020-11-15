import 'dart:io';

import 'package:path/path.dart' as p;

Future<bool> isExists(String path) async => await File(path).exists();

Future<List<String>> readLines(String path) async =>
    await File(path).readAsLines();

Future<File> writeContents(String path, String content) async =>
    await File(path).writeAsString(content);

Set<String> addExtension(List<String> filenames) => filenames
    .map((path) => 'lib/${path.endsWith('.dart') ? path : '$path.dart'}')
    .toSet();

Set<String> getDirectoryFiles() => Directory('./lib')
    .listSync(recursive: true)
    .where((item) => item is File)
    .map((file) => file.path)
    .where((path) => path.endsWith('.dart'))
    .toSet();

String getRelativePath(String importPath, String filePath) =>
    p.relative("lib/$importPath",
        from: filePath.substring(0, filePath.lastIndexOf("/")));

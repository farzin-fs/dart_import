import 'dart:io';

import 'package:path/path.dart' as path;

Future<bool> isExists(String path) async => File(path).existsSync();

Future<List<String>> readLines(String path) async =>
    await File(path).readAsLines();

Future<File> writeContents(String path, String content) async =>
    await File(path).writeAsString(content);

Set<String> addExtension(List<String> filenames) => filenames
    .map((String path) => 'lib/${path.endsWith('.dart') ? path : '$path.dart'}')
    .toSet();

Set<String> getDirectoryFiles() => Directory('./lib')
    .listSync(recursive: true)
    .whereType<File>()
    .map((FileSystemEntity file) => file.path)
    .where((String path) => path.endsWith('.dart'))
    .toSet();

String getRelativePath(String importPath, String filePath) =>
    path.relative('lib/$importPath',
        from: filePath.substring(0, filePath.lastIndexOf('/')));

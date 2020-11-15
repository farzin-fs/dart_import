library dart_import;

import 'dart:async';

import 'file_utils.dart' as file;
import 'messages.dart';

Future<void> run(List<String> arguments) async {
  Set<String> files;

  if (arguments.isEmpty) {
    print(Exception(Errors.argumentsRequired));
    return;
  }

  if (arguments[0] == ".") {
    files = file.getDirectoryFiles();
  } else {
    files = file.addExtension(arguments);
  }

  files.forEach((file) => makeChanges(file));
}

Future<void> makeChanges(String path) async {
  if (await file.isExists(path)) {
    String content = await file.readContents(path);
    content = fixImports(content);
    await file.writeContents(path, content);
  } else {
    print(Exception(Errors.fileNotFound(path)));
  }
}

String fixImports(String contents) {
  return contents.replaceAll('"MyWidget"', '"MyWidget Edited"');
}

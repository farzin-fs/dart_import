library dart_import;

import 'dart:async';

import 'file_utils.dart' as file_utils;
import 'import_utils.dart' as import_utils;
import 'messages.dart';

Future<void> run(List<String> arguments) async {
  Set<String> files;

  if (arguments.isEmpty) {
    print(Exception(Errors.argumentsRequired));
    return;
  }

  if (arguments[0] == ".") {
    files = file_utils.getDirectoryFiles();
  } else {
    files = file_utils.addExtension(arguments);
  }

  files.forEach((file) => makeChanges(file));
}

Future<void> makeChanges(String path) async {
  if (await file_utils.isExists(path)) {
    List<String> lines = await file_utils.readLines(path);
    var result = await import_utils.fixImports(lines, path);
    await file_utils.writeContents(path, result.join("\n") + "\n");
  } else {
    print(Exception(Errors.fileNotFound(path)));
  }
}

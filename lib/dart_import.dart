library dart_import;

import 'dart:async';

import 'file_utils.dart' as file_utils;
import 'import_utils.dart' as import_utils;
import 'messages.dart' as messages;

Future<void> run(List<String> arguments) async {
  Set<String> files;

  if (arguments.isEmpty) {
    print(Exception(messages.argumentsRequired));
    return;
  }

  if (arguments[0] == '.') {
    files = file_utils.getDirectoryFiles();
  } else {
    files = file_utils.addExtension(arguments);
  }

  for (int i = 0; i < files.length; i++) {
    await makeChanges(files.elementAt(i));
  }
}

Future<void> makeChanges(String path) async {
  if (await file_utils.isExists(path)) {
    final List<String> lines = await file_utils.readLines(path);
    final List<String> result = await import_utils.fixImports(lines, path);
    await file_utils.writeContents(path, result.join('\n') + '\n');
  } else {
    print(Exception(messages.fileNotFound(path)));
  }
}

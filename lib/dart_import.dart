library dart_import;

import 'file_utils.dart' as file;

Future<void> run(List<String> arguments) async {
  var files = file.normalizePath(arguments);
  print(files);

  files.forEach((file) => makeChanges(file));
}

Future<void> makeChanges(String path) async {
  if (await file.isExists(path)) {
    String content = await file.readContents(path);
    content = fixImports(content);
    await file.writeContents(path, content);
  } else {
    print("'$path' does not exist!");
  }
}

String fixImports(String contents) {
  return contents.replaceAll('"MyWidget"', '"MyWidget Edited"');
}

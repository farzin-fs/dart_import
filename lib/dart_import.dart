library dart_import;

import 'dart:io';

void fixImports(List<String> filenames) {
  print(filenames);
  final File file = File("./jamshid.dart");
  file.writeAsString("test");
}

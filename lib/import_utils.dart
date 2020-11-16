import 'utils.dart' as utils;
import 'file_utils.dart' as file_utils;

Future<List<String>> fixImports(List<String> lines, String path) async {
  List<String> newLines = lines;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().length == 0) {
      continue;
    }
    if (!lines[i].trim().contains("import")) {
      break;
    }
    newLines[i] = await fixImportLine(lines[i], path);
  }
  return newLines;
}

Future<String> fixImportLine(String line, String path) async {
  String packageName = 'package:${await utils.getPackageName()}';
  RegExp regex =
      RegExp('^\\s*import\\s*([\'"])$packageName/([^\'"]*)[\'"]([^;]*);\\s*\$');
  if (regex.hasMatch(line)) {
    RegExpMatch match = regex.firstMatch(line);
    String quote = match[1];
    String relative = file_utils.getRelativePath(match[2], path);
    String ending = match[3];
    return 'import ${quote}${relative}${quote}${ending};';
  } else {
    return line;
  }
}

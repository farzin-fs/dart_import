import 'file_utils.dart' as file_utils;
import 'utils.dart' as utils;

Future<List<String>> fixImports(List<String> lines, String path) async {
  List<String> newLines = lines;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().isEmpty) {
      continue;
    }
    if (!lines[i].trim().contains(RegExp('import|part'))) {
      break;
    }
    newLines[i] = await fixImportPath(lines[i], path);
  }

  newLines = sortImports(newLines);

  return newLines;
}

Future<String> fixImportPath(String line, String path) async {
  final String packageName = 'package:${await utils.getPackageName()}';
  final RegExp regex =
      RegExp('^\\s*import\\s*([\'"])$packageName/([^\'"]*)[\'"]([^;]*);\\s*\$');
  if (regex.hasMatch(line)) {
    final RegExpMatch match = regex.firstMatch(line);
    final String quote = match[1];
    final String relative = file_utils.getRelativePath(match[2], path);
    final String ending = match[3];
    return 'import $quote$relative$quote$ending;';
  } else {
    final RegExp regex = RegExp('^\\s*import\\s*([\'"])\\./(.*)\$');
    if (regex.hasMatch(line)) {
      final RegExpMatch match = regex.firstMatch(line);
      final String quote = match[1];
      final String end = match[2];
      return 'import $quote$end';
    }
    return line;
  }
}

List<String> sortImports(List<String> lines) {
  return lines;
}

List<String> removeUnusedImports(List<String> lines) {
  return lines;
}

import 'file_utils.dart' as file_utils;
import 'utils.dart' as utils;

Future<List<String>> fixImports(List<String> lines, String path) async {
  List<String> newLines = lines;
  int lastImportIndex;
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().isEmpty) {
      continue;
    }
    if (!lines[i].trim().contains(RegExp('import|part'))) {
      lastImportIndex = i;
      break;
    }
    newLines[i] = await fixImportPath(lines[i], path);
  }

  newLines = sortImports(newLines, lastImportIndex);

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

List<String> sortImports(List<String> lines, int index) {
  final List<String> importLines = lines.take(index).toList();
  final List<String> codeLines = lines.skip(index).toList();
  List<String> dartImports = <String>[];
  List<String> packageImports = <String>[];
  List<String> relativeImports = <String>[];
  List<String> partImports = <String>[];

  for (int i = 0; i < importLines.length; i++) {
    final String line = importLines[i].trim();
    if (line.isNotEmpty) {
      if (line.startsWith('import')) {
        if (line.contains('dart:')) {
          dartImports.add(line);
        } else if (line.contains('package:')) {
          packageImports.add(line);
        } else {
          relativeImports.add(line);
        }
      } else if (line.startsWith('part')) {
        partImports.add(line);
      }
    }
  }

  dartImports = removeDuplicateImports(dartImports)..sort();
  packageImports = removeDuplicateImports(packageImports)..sort();
  relativeImports = removeDuplicateImports(relativeImports)..sort();
  partImports = removeDuplicateImports(partImports)..sort();

  return <String>[
    ...dartImports,
    dartImports.isNotEmpty ? '\n' : null,
    ...packageImports,
    packageImports.isNotEmpty ? '\n' : null,
    ...relativeImports,
    relativeImports.isNotEmpty ? '\n' : null,
    ...partImports,
    partImports.isNotEmpty ? '\n' : null,
    ...codeLines
  ].where((String line) => line != null).toList();
}

List<String> removeDuplicateImports(List<String> lines) {
  return lines.toSet().toList();
}

List<String> removeUnusedImports(List<String> lines) {
  return lines;
}

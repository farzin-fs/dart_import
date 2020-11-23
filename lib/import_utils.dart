import 'dart:io';

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
  List<String> libraryStatement = <String>[];
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
      } else if (line.startsWith('library')) {
        libraryStatement.add(line);
      }
    }
  }

  libraryStatement = removeDuplicateImports(libraryStatement)..sort();
  dartImports = removeDuplicateImports(dartImports)..sort();
  packageImports = removeDuplicateImports(packageImports)..sort();
  relativeImports = removeDuplicateImports(relativeImports)..sort();
  partImports = removeDuplicateImports(partImports)..sort();

  return <String>[
    ...libraryStatement,
    libraryStatement.isNotEmpty ? '' : null,
    ...dartImports,
    dartImports.isNotEmpty ? '' : null,
    ...packageImports,
    packageImports.isNotEmpty ? '' : null,
    ...relativeImports,
    relativeImports.isNotEmpty ? '' : null,
    ...partImports,
    partImports.isNotEmpty ? '' : null,
    ...codeLines
  ].where((String line) => line != null).toList();
}

List<String> removeDuplicateImports(List<String> lines) {
  return lines.toSet().toList();
}

Future<List<String>> removeUnusedImports(
  List<String> lines,
  String path,
) async {
  try {
    final ProcessResult result =
        await Process.run('dartanalyzer', <String>[path]);
    final List<String> issues = result.stdout.toString().split('\n');
    final List<String> unusedImports = issues
        .where((String issue) => issue.contains('Unused import:'))
        .toList();

    final RegExp regex = RegExp(r'(?!dart:)(\d+)(?=:)');
    for (int i = unusedImports.length - 1; i >= 0; i--) {
      final String line = unusedImports.elementAt(i);
      if (regex.hasMatch(line)) {
        final RegExpMatch match = regex.firstMatch(line);
        final int lineNumber = int.tryParse(match[0]);
        if (lineNumber != null) {
          lines.removeAt(lineNumber - 1);
        }
      }
    }
  } catch (e) {
    print(e);
  }
  return lines;
}

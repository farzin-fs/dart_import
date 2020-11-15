import 'utils.dart' as utils;

List<String> fixImports(List<String> lines) {
  List<String> newLines = [];
  lines.forEach((line) async {
    if (line.trim().startsWith("import ")) {
      newLines.add(await fixLine(line));
    }
    newLines.add(line);
  });
  return newLines;
}

Future<String> fixLine(String line) async {
  String local = 'package:${utils.getPackageName()}';
  RegExp regex =
      RegExp('^\\s*import\\s*([\'"])$local/([^\'"]*)[\'"]([^;]*);\\s*\$');
  if (regex.hasMatch(line)) {
    RegExpMatch match = regex.firstMatch(line);
    String quote = match[1];
    String relativeImport = match[2]; //TODO: Should find file relative path
    String ending = match[3];
    return 'import ${quote}${relativeImport}${quote}${ending};';
  } else {
    return line;
  }
}

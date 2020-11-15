import 'utils.dart' as utils;
import 'file_utils.dart' as file_utils;

Future<List<String>> fixImports(List<String> lines, String path) async {
  return await Future.wait(lines.map((line) async {
    if (line.trim().startsWith("import ")) {
      return await fixLine(line, path);
    }
    return line;
  }));
}

Future<String> fixLine(String line, String path) async {
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

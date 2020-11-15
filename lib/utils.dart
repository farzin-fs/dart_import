import 'file_utils.dart' as file_utils;

Future<String> getPackageName() async {
  String packageName;
  List<String> lines = await file_utils.readLines('pubspec.yaml');
  lines.where((line) => line.contains('name:')).forEach((name) {
    packageName = name.replaceAll('name:', '').trim();
  });
  return packageName;
}

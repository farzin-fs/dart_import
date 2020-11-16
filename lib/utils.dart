import 'file_utils.dart' as file_utils;

Future<String> getPackageName() async {
  String packageName;
  final List<String> lines = await file_utils.readLines('pubspec.yaml');
  lines.where((String line) => line.startsWith('name:')).forEach(
    (String name) {
      packageName = name.replaceAll('name:', '').trim();
    },
  );
  return packageName;
}

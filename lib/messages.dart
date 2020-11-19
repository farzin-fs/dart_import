String help = '''

-------------------- dart_import --------------------

A simple Dart package to help with import statements.


Usage: dart_import [filename]


Example: 

You can pass multiple files and exclude `.dart` extension.

\$ dart_import main widgets/my_widget utils.dart


Will run on all `.dart` files inside the `lib` directory.

\$ dart_import .

Note: You should run command in root of your workspace,
because it will look inside the `lib` directory for Dart files.
''';
String argumentsRequired = 'Specify at least one file';
String fileNotFound(String path) => '"$path" does not exist!';

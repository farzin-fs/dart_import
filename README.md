# dart_import

A simple Dart package to help with import statements.

It will change all Dart/Flutter imports to relative format, remove duplicated imports and, sort imports alphabetically.

## Getting Started

You can run `dart_import` with the following command, You need to specify at least one file name.

```bash
flutter pub run dart_import [filename]
```

You can pass multiple files and exclude `.dart` extension.

```bash
flutter pub run dart_import main my_widget utils.dart
```

Will run on all `.dart` files inside the `lib` directory.

```bash
flutter pub run dart_import .
```

## TODO
- [x] Run on all files inside the `lib` directory.
- [x] Run on only given files.
- [x] Change package imports to relative paths.
- [x] Sort imports alphabetically.
- [x] Remove duplicate imports
- [ ] Remove unused imports
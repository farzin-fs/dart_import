# dart_import

A simple dart package to change all Dart/Flutter imports to relative format.

## Getting Started

### Install

Add `dart_import` to your `dev_dependencies`:

```yaml
dev_dependencies:
  dart_import: "^version"
```

### Run

You can run `dart_import` with the following command, You need to specify at least one file name.

```bash
flutter pub run dart_import:main [filename]
```

You can pass multiple files and exclude `.dart` extension.

```bash
flutter pub run dart_import:main main my_widget utils.dart
```

Will run on all `.dart` files inside the `lib` directory.

```bash
flutter pub run dart_import:main .
```

## TODO
[x] Run on all files inside the `lib` directory.

[x] Run on only given files.

[x] Change package imports to relative paths.

[] Sort imports alphabetically.

[] Remove unused imports
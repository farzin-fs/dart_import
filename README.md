# dart_import

A simple Dart package to help with import statements.

It will change all Dart/Flutter imports to relative format, remove duplicated imports and, sort imports alphabetically.

## Getting Started

### Installation

You can install `dart_import` globally using [pub global](https://dart.dev/tools/pub/cmd/pub-global) or install it locally by adding it as a dev dependency to your `pubspec.yaml` file.

```bash
pub global activate dart_import 
```

or

```yaml
dependencies:
  dart_import: ^0.0.2
```

### Usage

You can run `dart_import` with the following command, You need to specify at least one file name.

```bash
dart_import [filename]
```

You can pass multiple files and exclude the `.dart` extension.

```bash
dart_import main widgets/my_widget utils.dart
```

Will run on all `.dart` files inside the `lib` directory.

```bash
dart_import .
```

Note: If you have installed `dart_import` as a local dependency, then you need to prefix commands with `pub run` or `flutter pub run`.

## TODO
- [ ] Add missing imports
- [ ] Refactor code
<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Description
This package includes core models, components for fakestore app

## Running Test
- Generate `coverage/lcov.info` file
```sh
flutter test --coverage
```
- Generate HTML report
- Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
```sh
genhtml coverage/lcov.info -o coverage/html
```
- Open the report
```sh
open coverage/html/index.html
```
import 'dart:io';

import 'package:melo_cli/string_extension.dart';

import 'cli_helper.dart';

class CliCommons {
  String examplePath;
  String appPath;
  String pluralName;
  String singularName;
  CliCommons(
      {required this.appPath,
      required this.examplePath,
      required this.pluralName,
      required this.singularName});

  Future<void> create() async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      await _createModels(value.path);
      await _createInjection(value.path);
    });
  }

  Future<void> _createModels(String path) async {
    CliHelper.copyFileFromExample('$path\\models\\response_model.dart',
        '$examplePath\\commons\\models\\response_model.dart',
        pluralName: pluralName, singularName: singularName);
    CliHelper.copyFileFromExample('$path\\models\\response.dart',
        '$examplePath\\commons\\models\\response.dart',
        pluralName: pluralName, singularName: singularName);
  }

  Future<void> _createInjection(String path) async {
    CliHelper.copyFileFromExample('$path\\injection\\injection_adapter.dart',
        '$examplePath\\commons\\injection\\injection_adapter.dart',
        pluralName: pluralName, singularName: singularName);
    CliHelper.copyFileFromExample('$path\\injection\\injection_container.dart',
        '$examplePath\\commons\\injection\\injection_container.dart',
        stopIfExists: true, pluralName: pluralName, singularName: singularName);
  }
}

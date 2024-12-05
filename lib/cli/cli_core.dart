import 'dart:io';

import 'package:melo_cli/enums/datasource_type.dart';

import '../cli_helper.dart';

class CliCore {
  String examplePath;
  String appPath;
  DatasourceType datasourceType;
  CliCore(
      {required this.appPath,
      required this.examplePath,
      required this.datasourceType});

  Future<void> create() async {
    Directory('$appPath\\core').create(recursive: true).then((value) async {
      await _createNetwork(value.path);
    });
  }

  Future<void> _createNetwork(String path) async {
    String parentPath = "network";
    await CliHelper.copyFileFromExample('$path\\$parentPath\\local\\prefs.dart',
        '$examplePath\\core\\$parentPath\\local\\prefs.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    if (datasourceType == DatasourceType.restApi) {
      await CliHelper.copyFileFromExample(
          '$path\\$parentPath\\remote\\api_client.dart',
          '$examplePath\\core\\$parentPath\\remote\\api_client.dart',
          pluralName: '',
          singularName: '',
          stopIfExists: true);
    }
  }
}

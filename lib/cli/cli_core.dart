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

  Future<void> create({bool managers = false}) async {
    Directory('$appPath\\core').create(recursive: true).then((value) async {
      if (managers) {
        await _createManager(value.path);
      }
      await _createNetwork(value.path);
      await _createNavigation(value.path);
    });
  }

  Future<void> _createNavigation(String path) async {
    String parentPath = "navigation";
    await CliHelper.copyFileFromExample(
        '$path\\$parentPath\\domain\\mixins\\navigation_route.dart',
        '$examplePath\\core\\$parentPath\\domain\\mixins\\navigation_route.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
    await CliHelper.copyFileFromExample(
        '$path\\$parentPath\\domain\\models\\route_model.dart',
        '$examplePath\\core\\$parentPath\\domain\\models\\route_model.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
    await CliHelper.copyFileFromExample(
        '$path\\$parentPath\\manager\\navigation_cubit.dart',
        '$examplePath\\core\\$parentPath\\manager\\navigation_cubit.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
    await CliHelper.copyFileFromExample(
        '$path\\$parentPath\\manager\\navigation_state.dart',
        '$examplePath\\core\\$parentPath\\manager\\navigation_state.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
  }

  Future<void> _createManager(String path) async {
    String parentPath = "managers";
    await CliHelper.copyFileFromExample(
        '$path\\$parentPath\\manager_injection_container.dart',
        '$examplePath\\core\\$parentPath\\manager_injection_container.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
    await CliHelper.copyFileFromExample('$path\\$parentPath\\user_manager.dart',
        '$examplePath\\core\\$parentPath\\user_manager.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true,
        isToReplaceNameInScript: false);
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

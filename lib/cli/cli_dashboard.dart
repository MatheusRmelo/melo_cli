import 'dart:io';

import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/enums/dashboard_type.dart';

class CliDashboard {
  String examplePath;
  String appPath;
  String name = 'dashboard';
  DashboardType type;

  CliDashboard({
    required this.appPath,
    required this.examplePath,
    required this.type,
  });

  static void startFlow(
      {required String appPath, required String examplePath}) {
    var datasourceType = DashboardType.ask();
    if (datasourceType == null) {
      print("Your must give a dashboard type");
      return;
    }
    CliDashboard(
            appPath: appPath, examplePath: examplePath, type: datasourceType)
        .create();
  }

  Future<void> create() async {
    Directory('$appPath\\modules\\$name')
        .create(recursive: true)
        .then((value) async {
      //await _createData(value.path);
      await _createDomain(value.path);
      await _createInjectionContainer(value.path);
      await _createPresentation(value.path);
    });
  }

  Future<void> _createData(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\data\\data_sources\\${name}_remote_datasource.dart',
        '$examplePath\\modules\\$name\\data\\data_sources\\${type.getName(name)}_remote_datasource.dart',
        isToReplaceNameInScript: false,
        pluralName: '',
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\data\\repositories\\${name}_repository.dart',
        '$examplePath\\modules\\$name\\data\\repositories\\${name}_repository.dart',
        isToReplaceNameInScript: false,
        pluralName: '',
        singularName: '');
  }

  Future<void> _createDomain(String path) async {
    // await CliHelper.copyFileFromExample(
    //     '$path\\domain\\repositories\\i_${name}_repository.dart',
    //     '$examplePath\\modules\\$name\\domain\\repositories\\i_${name}_repository.dart',
    //     pluralName: '',
    //     singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\domain\\models\\feature_model.dart',
        '$examplePath\\modules\\$name\\domain\\models\\feature_model.dart',
        pluralName: '',
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\get_features_usecase.dart',
        '$examplePath\\modules\\$name\\domain\\use_cases\\get_features_usecase.dart',
        pluralName: '',
        singularName: '');
  }

  Future<void> _createInjectionContainer(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\injection_container\\${name}_injection_container.dart',
        '$examplePath\\modules\\$name\\injection_container\\${name}_injection_container.dart',
        pluralName: '',
        singularName: '');
  }

  Future<void> _createPresentation(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\pages\\dashboard_page.dart',
        '$examplePath\\modules\\$name\\presentation\\pages\\${type.getName(name)}_page.dart',
        pluralName: '',
        singularName: '');

    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\features\\features_cubit.dart',
        '$examplePath\\modules\\$name\\presentation\\manager\\features\\features_cubit.dart',
        pluralName: '',
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\features\\features_state.dart',
        '$examplePath\\modules\\$name\\presentation\\manager\\features\\features_state.dart',
        pluralName: '',
        singularName: '');
  }
}

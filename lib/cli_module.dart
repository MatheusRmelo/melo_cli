import 'dart:io';

import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/enums/datasource_type.dart';

class CliModule {
  String examplePath;
  String appPath;
  String name;
  String singularName;
  DatasourceType datasourceType;

  CliModule(
      {required this.appPath,
      required this.examplePath,
      required this.name,
      required this.singularName,
      required this.datasourceType});

  Future<void> create(
      {bool datasource = true,
      bool repository = true,
      bool domain = true,
      bool injection = true,
      bool presentation = true}) async {
    Directory('$appPath\\modules\\$name')
        .create(recursive: true)
        .then((value) async {
      if (datasource) await _createData(value.path, repository: repository);
      if (domain) await _createDomain(value.path);
      if (injection) await _createInjectionContainer(value.path);
      if (presentation) await _createPresentation(value.path);
    });
  }

  Future<void> _createData(String path, {bool repository = true}) async {
    await CliHelper.copyFileFromExample(
        '$path\\data\\data_sources\\${name}_remote_datasource.dart',
        '$examplePath\\modules\\users\\data\\data_sources\\${datasourceType == DatasourceType.restApi ? 'api_' : ''}users_remote_datasource.dart',
        pluralName: name,
        singularName: singularName);
    if (repository) {
      await CliHelper.copyFileFromExample(
          '$path\\data\\repositories\\${name}_repository.dart',
          '$examplePath\\modules\\users\\data\\repositories\\users_repository.dart',
          pluralName: name,
          singularName: singularName);
    }
  }

  Future<void> _createDomain(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\domain\\models\\${singularName}_model.dart',
        '$examplePath\\modules\\users\\domain\\models\\user_model.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\repositories\\i_${name}_repository.dart',
        '$examplePath\\modules\\users\\domain\\repositories\\i_users_repository.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\create_${singularName}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\create_user_usecase.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\update_${singularName}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\update_user_usecase.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\list_${singularName}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\list_user_usecase.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\detail_${singularName}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\detail_user_usecase.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\delete_${singularName}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\delete_user_usecase.dart',
        pluralName: name,
        singularName: singularName);
  }

  Future<void> _createInjectionContainer(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\injection_container\\${name}_injection_container.dart',
        '$examplePath\\modules\\users\\injection_container\\users_injection_container.dart',
        pluralName: name,
        singularName: singularName);
  }

  Future<void> _createPresentation(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\pages\\${name}_page.dart',
        '$examplePath\\modules\\users\\presentation\\pages\\users_page.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\pages\\${name}_form_page.dart',
        '$examplePath\\modules\\users\\presentation\\pages\\users_form_page.dart',
        pluralName: name,
        singularName: singularName);

    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\$name\\${name}_cubit.dart',
        '$examplePath\\modules\\users\\presentation\\manager\\users\\users_cubit.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\$name\\${name}_state.dart',
        '$examplePath\\modules\\users\\presentation\\manager\\users\\users_state.dart',
        pluralName: name,
        singularName: singularName);

    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\${name}_form\\${name}_form_cubit.dart',
        '$examplePath\\modules\\users\\presentation\\manager\\users_form\\users_form_cubit.dart',
        pluralName: name,
        singularName: singularName);
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\${name}_form\\${name}_form_state.dart',
        '$examplePath\\modules\\users\\presentation\\manager\\users_form\\users_form_state.dart',
        pluralName: name,
        singularName: singularName);

    await CliHelper.copyFileFromExample(
        '$path\\presentation\\widgets\\card_tile.dart',
        '$examplePath\\modules\\users\\presentation\\widgets\\card_tile.dart',
        pluralName: name,
        singularName: singularName);
  }
}

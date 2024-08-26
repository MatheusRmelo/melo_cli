import 'dart:io';

import 'package:melo_cli/cli_helper.dart';

class CliAuth {
  String examplePath;
  String appPath;
  String name = 'authentication';

  CliAuth({
    required this.appPath,
    required this.examplePath,
  });

  Future<void> create() async {
    Directory('$appPath\\modules\\$name')
        .create(recursive: true)
        .then((value) async {
      await _createData(value.path);
      await _createDomain(value.path);
      await _createInjectionContainer(value.path);
      await _createPresentation(value.path);
    });
  }

  Future<void> _createData(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\data\\data_sources\\${name}_remote_datasource.dart',
        '$examplePath\\modules\\users\\data\\data_sources\\users_remote_datasource.dart',
        pluralName: name,
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\data\\repositories\\${name}_repository.dart',
        '$examplePath\\modules\\users\\data\\repositories\\users_repository.dart',
        pluralName: name,
        singularName: '');
  }

  Future<void> _createDomain(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\domain\\repositories\\i_${name}_repository.dart',
        '$examplePath\\modules\\$name\\domain\\repositories\\i_${name}_repository.dart',
        pluralName: name,
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\signin_usecase.dart',
        '$examplePath\\modules\\$name\\domain\\use_cases\\signin_usecase.dart',
        pluralName: name,
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\signup_usecase.dart',
        '$examplePath\\modules\\$name\\domain\\use_cases\\signup_usecase.dart',
        pluralName: name,
        singularName: '');
  }

  Future<void> _createInjectionContainer(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\injection_container\\${name}_injection_container.dart',
        '$examplePath\\modules\\$name\\injection_container\\${name}_injection_container.dart',
        pluralName: name,
        singularName: '');
  }

  Future<void> _createPresentation(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\pages\\signin_page.dart',
        '$examplePath\\modules\\$name\\presentation\\pages\\sigin_page.dart',
        pluralName: name,
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\pages\\signup_page.dart',
        '$examplePath\\modules\\$name\\presentation\\pages\\signup_page.dart',
        pluralName: name,
        singularName: '');

    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\$name\\${name}_cubit.dart',
        '$examplePath\\modules\\$name\\presentation\\manager\\$name\\${name}_cubit.dart',
        pluralName: name,
        singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\presentation\\manager\\$name\\${name}_state.dart',
        '$examplePath\\modules\\$name\\presentation\\manager\\$name\\${name}_state.dart',
        pluralName: name,
        singularName: '');
  }
}

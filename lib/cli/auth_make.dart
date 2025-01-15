import 'dart:io';

import 'package:melo_cli/cli/commons_make.dart';
import 'package:melo_cli/cli/core_make.dart';
import 'package:melo_cli/enums/datasource_type.dart';
import 'package:melo_cli/extensions/list_create_file_extension.dart';
import 'package:melo_cli/models/create_file_model.dart';

class AuthMake {
  String examplePath;
  String appPath;
  String name = 'authentication';
  DatasourceType? datasourceType;

  AuthMake({
    required this.appPath,
    required this.examplePath,
    this.datasourceType,
  });

  Future<void> start() async {
    if (datasourceType == null) {
      datasourceType = DatasourceType.ask();
      if (datasourceType == null) {
        print('Tipo não informado');
        return;
      }
    }
    await CoreMake(
            appPath: appPath,
            examplePath: examplePath,
            datasourceType: datasourceType!,
            plural: 'authentication',
            singular: 'authentication')
        .start();
    await CommonsMake(
            appPath: appPath,
            examplePath: examplePath,
            singularName: 'authentication',
            pluralName: 'authentication')
        .start();
    Directory('$appPath\\modules\\$name')
        .create(recursive: true)
        .then((value) async {
      await _data(value.path);
      await _domain(value.path);
      await _injection(value.path);
      await _presentation(value.path);
      await _routes(value.path);
    });
  }

  Future<void> _data(String path) async {
    String basePath = "$path\\data";
    String baseExample = "$examplePath\\modules\\$name\\data";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\data_sources\\${name}_remote_datasource.dart",
        example:
            "$baseExample\\data_sources\\${datasourceType!.getName(name)}_remote_datasource.dart",
      ),
      CreateFileModel(
        result: "$basePath\\repositories\\${name}_repository.dart",
        example: "$baseExample\\repositories\\${name}_repository.dart",
      ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _domain(String path) async {
    String basePath = "$path\\domain";
    String baseExample = "$examplePath\\modules\\$name\\domain";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\repositories\\i_${name}_repository.dart",
        example: "$baseExample\\repositories\\i_${name}_repository.dart",
      ),
      CreateFileModel(
        result: "$basePath\\models\\user_model.dart",
        example: "$baseExample\\models\\user_model.dart",
      ),
      CreateFileModel(
        result: "$basePath\\use_cases\\signin_usecase.dart",
        example: "$baseExample\\use_cases\\signin_usecase.dart",
      ),
      CreateFileModel(
        result: "$basePath\\use_cases\\signup_usecase.dart",
        example: "$baseExample\\use_cases\\signup_usecase.dart",
      ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _injection(String path) async {
    String basePath = "$path\\injection_container";
    String baseExample = "$examplePath\\modules\\$name\\injection_container";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\${name}_injection_container.dart",
        example: "$baseExample\\${name}_injection_container.dart",
      ),
    ];
    await items.create();
  }

  Future<void> _presentation(String path) async {
    String basePath = "$path\\presentation";
    String baseExample = "$examplePath\\modules\\$name\\presentation";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\pages\\signin_page.dart",
        example: "$baseExample\\pages\\signin_page.dart",
      ),
      CreateFileModel(
        result: "$basePath\\pages\\signup_page.dart",
        example: "$baseExample\\pages\\signup_page.dart",
      ),
      CreateFileModel(
        result: "$basePath\\manager\\$name\\${name}_cubit.dart",
        example: "$baseExample\\manager\\$name\\${name}_cubit.dart",
      ),
      CreateFileModel(
        result: "$basePath\\manager\\$name\\${name}_state.dart",
        example: "$baseExample\\manager\\$name\\${name}_state.dart",
      ),
    ];
    await items.create();
  }

  Future<void> _routes(String path) async {
    String basePath = "$path\\routes";
    String baseExample = "$examplePath\\modules\\$name\\routes";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\${name}_router_container.dart",
        example: "$baseExample\\${name}_router_container.dart",
      ),
    ];
    await items.create();
  }
}

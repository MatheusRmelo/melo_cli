import 'dart:io';

import 'package:melo_cli/cli/commons_make.dart';
import 'package:melo_cli/cli/core_make.dart';
import 'package:melo_cli/enums/datasource_type.dart';
import 'package:melo_cli/extensions/list_create_file_extension.dart';
import 'package:melo_cli/models/create_file_model.dart';

class SplashMake {
  String examplePath;
  String appPath;
  String name = 'splash';
  DatasourceType? datasourceType;

  SplashMake({
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
      if (datasourceType == DatasourceType.restApi) {
        await _data(value.path);
        await _domain(value.path);
        await _injection(value.path);
      }
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
        result: "$basePath\\use_cases\\check_is_logged_usecase.dart",
        example: "$baseExample\\use_cases\\check_is_logged_usecase.dart",
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
      if (datasourceType == DatasourceType.firebase)
        CreateFileModel(
          result: "$basePath\\pages\\splash_page.dart",
          example: "$baseExample\\pages\\firebase_splash_page.dart",
        )
      else
        CreateFileModel(
          result: "$basePath\\pages\\splash_page.dart",
          example: "$baseExample\\pages\\splash_page.dart",
        ),
      if (datasourceType == DatasourceType.restApi)
        CreateFileModel(
          result: "$basePath\\manager\\$name\\${name}_cubit.dart",
          example: "$baseExample\\manager\\$name\\${name}_cubit.dart",
        ),
      if (datasourceType == DatasourceType.restApi)
        CreateFileModel(
          result: "$basePath\\manager\\$name\\${name}_state.dart",
          example: "$baseExample\\manager\\$name\\${name}_state.dart",
        ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _routes(String path) async {
    String basePath = "$path\\routes";
    String baseExample = "$examplePath\\modules\\$name\\routes";
    List<CreateFileModel> items = [
      if (datasourceType == DatasourceType.firebase)
        CreateFileModel(
          result: "$basePath\\${name}_router_container.dart",
          example: "$baseExample\\firebase_${name}_router_container.dart",
        )
      else
        CreateFileModel(
          result: "$basePath\\${name}_router_container.dart",
          example: "$baseExample\\${name}_router_container.dart",
        ),
    ];
    await items.create();
  }
}

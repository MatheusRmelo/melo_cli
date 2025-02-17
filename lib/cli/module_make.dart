import 'dart:io';

import 'package:melo_cli/cli/cli_core.dart';
import 'package:melo_cli/cli/commons_make.dart';
import 'package:melo_cli/cli/core_make.dart';
import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/enums/datasource_type.dart';
import 'package:melo_cli/enums/module_type.dart';
import 'package:melo_cli/extensions/list_create_file_extension.dart';
import 'package:melo_cli/models/create_file_model.dart';
import 'package:melo_cli/utils/formatters.dart';
import 'package:melo_cli/utils/inputs.dart';

class ModuleMake {
  String appPath;
  String examplePath;
  String? module;
  String? singularModule;
  DatasourceType? datasourceType;
  String folderModuleName = "";
  String folderSingularName = "";
  ModuleType? moduleType;

  bool get withForm =>
      moduleType == ModuleType.full || moduleType == ModuleType.form;

  ModuleMake(
      {required this.examplePath,
      required this.appPath,
      this.module,
      this.singularModule,
      this.moduleType,
      this.datasourceType});

  Future<void> start(
      {bool datasource = true,
      bool repository = true,
      bool domain = true,
      bool injection = true,
      bool presentation = true,
      bool routes = true}) async {
    if (module == null) {
      module = Inputs.question('Qual o nome do módulo?');
      if (module == null) {
        print('Módulo não informado');
        return;
      }
      folderModuleName = Formatters.camelCaseToSnakeCase(module!);
    }
    if (singularModule == null) {
      singularModule = Inputs.question('Qual o nome do módulo no singular?');
      if (singularModule == null) {
        print('Módulo não informado');
        return;
      }
      folderSingularName = Formatters.camelCaseToSnakeCase(singularModule!);
    }
    if (datasourceType == null) {
      datasourceType = DatasourceType.ask();
      if (datasourceType == null) {
        print('inválido datasource tipo');
        return;
      }
    }
    if (moduleType == null) {
      moduleType = ModuleType.ask();
      if (moduleType == null) {
        print('Inválido módulo tipo');
        return;
      }
    }

    CoreMake(
            appPath: appPath,
            examplePath: examplePath,
            datasourceType: datasourceType!,
            plural: module,
            singular: singularModule)
        .start();
    CommonsMake(
            appPath: appPath,
            examplePath: examplePath,
            pluralName: module,
            singularName: singularModule)
        .start();
    Directory('$appPath\\modules\\$folderModuleName')
        .create(recursive: true)
        .then((value) async {
      if (datasource) await _createData(value.path, repository: repository);
      if (domain) await _createDomain(value.path);
      if (injection) await _createInjectionContainer(value.path);
      if (presentation) await _createPresentation(value.path);
      if (routes) await _routes(value.path);
    });
  }

  Future<void> _createData(String path, {bool repository = true}) async {
    String basePath = "$path\\data";
    String baseExample = "$examplePath\\modules\\users\\data";
    List<CreateFileModel> items = [
      CreateFileModel(
        result:
            "$basePath\\data_sources\\${folderModuleName}_remote_datasource.dart",
        example:
            "$baseExample\\data_sources\\${datasourceType!.getName('users')}_remote_datasource.dart",
      ),
      if (repository)
        CreateFileModel(
          result:
              "$basePath\\repositories\\${folderModuleName}_repository.dart",
          example: "$baseExample\\repositories\\users_repository.dart",
        ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: module!,
          singularName: singularModule!,
          stopIfExists: true);
    }
  }

  Future<void> _createDomain(String path) async {
    String basePath = "$path\\domain";
    String baseExample = "$examplePath\\modules\\users\\domain";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\models\\${folderSingularName}_model.dart",
        example: "$baseExample\\models\\user_model.dart",
      ),
      CreateFileModel(
        result:
            "$basePath\\repositories\\i_${folderModuleName}_repository.dart",
        example: "$baseExample\\repositories\\i_users_repository.dart",
      ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\use_cases\\create_${folderSingularName}_usecase.dart",
          example: "$baseExample\\use_cases\\create_user_usecase.dart",
        ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\use_cases\\update_${folderSingularName}_usecase.dart",
          example: "$baseExample\\use_cases\\update_user_usecase.dart",
        ),
      CreateFileModel(
        result: "$basePath\\use_cases\\list_${folderSingularName}_usecase.dart",
        example: "$baseExample\\use_cases\\list_user_usecase.dart",
      ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\use_cases\\detail_${folderSingularName}_usecase.dart",
          example: "$baseExample\\use_cases\\detail_user_usecase.dart",
        ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\use_cases\\list_${folderSingularName}_dynamic_fields_usecase.dart",
          example:
              "$baseExample\\use_cases\\list_user_dynamic_fields_usecase.dart",
        ),
      CreateFileModel(
        result:
            "$basePath\\use_cases\\delete_${folderSingularName}_usecase.dart",
        example: "$baseExample\\use_cases\\delete_user_usecase.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: module!,
          singularName: singularModule!,
          stopIfExists: true);
    }
  }

  Future<void> _createInjectionContainer(String path) async {
    String basePath = "$path\\injection_container";
    String baseExample = "$examplePath\\modules\\users\\injection_container";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\${folderModuleName}_injection_container.dart",
        example:
            "$baseExample\\users${moduleType!.getName()}_injection_container.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: module!,
          singularName: singularModule!,
          stopIfExists: true);
    }
  }

  Future<void> _createPresentation(String path) async {
    String basePath = "$path\\presentation";
    String baseExample = "$examplePath\\modules\\users\\presentation";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\pages\\${folderModuleName}_page.dart",
        example: "$baseExample\\pages\\users_page.dart",
      ),
      if (withForm)
        CreateFileModel(
          result: "$basePath\\pages\\${folderModuleName}_form_page.dart",
          example: "$baseExample\\pages\\users_form_page.dart",
        ),
      CreateFileModel(
        result:
            "$basePath\\manager\\$folderModuleName\\${folderModuleName}_cubit.dart",
        example: "$baseExample\\manager\\users\\users_cubit.dart",
      ),
      CreateFileModel(
        result:
            "$basePath\\manager\\$folderModuleName\\${folderModuleName}_state.dart",
        example: "$baseExample\\manager\\users\\users_state.dart",
      ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\manager\\${folderModuleName}_form\\${folderModuleName}_form_cubit.dart",
          example: "$baseExample\\manager\\users_form\\users_form_cubit.dart",
        ),
      if (withForm)
        CreateFileModel(
          result:
              "$basePath\\manager\\${folderModuleName}_form\\${folderModuleName}_form_state.dart",
          example: "$baseExample\\manager\\users_form\\users_form_state.dart",
        ),
      CreateFileModel(
        result: "$basePath\\widgets\\card_tile.dart",
        example: "$baseExample\\widgets\\card_tile.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: module!,
          singularName: singularModule!,
          stopIfExists: true);
    }
  }

  Future<void> _routes(String path) async {
    String basePath = "$path\\routes";
    String baseExample = "$examplePath\\modules\\users\\routes";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\${folderModuleName}_router_container.dart",
        example:
            "$baseExample\\users${moduleType!.getName()}_router_container.dart",
      ),
    ];
    await items.create(plural: module!, singular: singularModule!);
  }
}

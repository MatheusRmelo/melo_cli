import 'dart:io';

import 'package:melo_cli/enums/datasource_type.dart';
import 'package:melo_cli/extensions/list_create_file_extension.dart';
import 'package:melo_cli/utils/formatters.dart';
import 'package:melo_cli/utils/inputs.dart';

import '../models/create_file_model.dart';

class CoreMake {
  String examplePath;
  String appPath;
  DatasourceType? datasourceType;
  String? plural;
  String? singular;
  CoreMake(
      {required this.appPath,
      required this.examplePath,
      this.datasourceType,
      this.plural,
      this.singular});

  Future<void> start({bool managers = false}) async {
    if (datasourceType == null) {
      datasourceType = DatasourceType.ask();
      if (datasourceType == null) {
        print('Tipo não informado');
        return;
      }
    }

    Directory('$appPath\\core').create(recursive: true).then((value) async {
      // if (managers) {
      //   await _managers(value.path);
      // }
      await _network(value.path);
      await _navigation(value.path);
      await _adapters(value.path);
      await _containers(value.path);
    });
  }

  Future<void> _adapters(String path) async {
    String basePath = "$path\\adapters";
    String baseExample = "$examplePath\\core\\adapters";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\injection_adapter.dart",
        example: "$baseExample\\injection_adapter.dart",
      ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _containers(String path) async {
    if (plural == null) {
      var plural = Inputs.question('Qual o nome do módulo?');
      if (plural == null) {
        print('Módulo não informado');
        return;
      }
    }
    if (singular == null) {
      singular = Inputs.question('Qual o nome do módulo no singular?');
      if (singular == null) {
        print('Módulo não informado');
        return;
      }
    }

    String basePath = "$path\\containers";
    String baseExample = "$examplePath\\core\\containers";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\injection_container.dart",
        example: "$baseExample\\injection_container.dart",
      ),
      CreateFileModel(
        result: "$basePath\\router_container.dart",
        example: "$baseExample\\router_container.dart",
      ),
    ];
    await items.create(plural: plural!, singular: singular!);
  }

  Future<void> _navigation(String path) async {
    String basePath = "$path\\navigation";
    String baseExample = "$examplePath\\core\\navigation";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\domain\\mixins\\navigation_route.dart",
        example: "$baseExample\\domain\\mixins\\navigation_route.dart",
      ),
      CreateFileModel(
        result: "$basePath\\domain\\models\\route_model.dart",
        example: "$baseExample\\domain\\models\\route_model.dart",
      ),
      CreateFileModel(
        result: "$basePath\\manager\\navigation_cubit.dart",
        example: "$baseExample\\manager\\navigation_cubit.dart",
      ),
      CreateFileModel(
        result: "$basePath\\manager\\navigation_state.dart",
        example: "$baseExample\\manager\\navigation_state.dart",
      ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _managers(String path) async {
    String basePath = "$path\\managers";
    String baseExample = "$examplePath\\core\\managers";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\manager_injection_container.dart",
        example: "$baseExample\\manager_injection_container.dart",
      ),
      CreateFileModel(
        result: "$basePath\\user_manager.dart",
        example: "$baseExample\\user_manager.dart",
      ),
    ];
    await items.create(isToReplaceNameInScript: false);
  }

  Future<void> _network(String path) async {
    String basePath = "$path\\network";
    String baseExample = "$examplePath\\core\\network";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\local\\prefs.dart",
        example: "$baseExample\\local\\prefs.dart",
      ),
      if (datasourceType == DatasourceType.restApi)
        CreateFileModel(
          result: "$basePath\\remote\\api_client.dart",
          example: "$baseExample\\remote\\api_client.dart",
        ),
    ];
    await items.create();
  }
}

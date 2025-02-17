import 'dart:io';

import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/models/create_file_model.dart';
import 'package:melo_cli/utils/inputs.dart';

class CommonsMake {
  String examplePath;
  String appPath;
  String? pluralName;
  String? singularName;

  CommonsMake(
      {required this.appPath,
      required this.examplePath,
      this.pluralName,
      this.singularName});

  Future<void> start(
      {bool models = true,
      bool injection = true,
      bool widgets = true,
      bool extensions = true,
      bool services = true}) async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      if (models) await _createModels(value.path);

      if (widgets) await _createWidgets(value.path);
      if (extensions) await _createExtensions(value.path);
      if (services) await _createServices(value.path);
    });
  }

  Future<void> _createWidgets(String path) async {
    String basePath = "$path\\widgets";
    String baseExample = "$examplePath\\commons\\widgets";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\custom_text.dart",
        example: "$baseExample\\custom_text.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_button.dart",
        example: "$baseExample\\custom_button.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_card.dart",
        example: "$baseExample\\custom_card.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dialogs\\delete_dialog_widget.dart",
        example: "$baseExample\\dialogs\\delete_dialog_widget.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_text_field.dart",
        example: "$baseExample\\custom_text_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_textarea_field.dart",
        example: "$baseExample\\custom_textarea_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_dropdown_field.dart",
        example: "$baseExample\\custom_dropdown_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_file_field.dart",
        example: "$baseExample\\custom_file_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_snackbar.dart",
        example: "$baseExample\\custom_snackbar.dart",
      ),
      CreateFileModel(
        result: "$basePath\\calendar_widget.dart",
        example: "$baseExample\\calendar_widget.dart",
      ),
      //Dynamic Form
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_calendar_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_calendar_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_field_widget.dart",
        example: "$baseExample\\dynamic_form\\dynamic_field_widget.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_form_widget.dart",
        example: "$baseExample\\dynamic_form\\dynamic_form_widget.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_text_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_text_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_checkbox_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_checkbox_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_dropdown_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_dropdown_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_file_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_file_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_foreign_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_foreign_field.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_form\\dynamic_textarea_field.dart",
        example: "$baseExample\\dynamic_form\\dynamic_textarea_field.dart",
      ),
      //-Dynamic Form
      CreateFileModel(
        result: "$basePath\\table_widget.dart",
        example: "$baseExample\\table_widget.dart",
      ),
      CreateFileModel(
        result: "$basePath\\sidebar\\sidebar_item.dart",
        example: "$baseExample\\sidebar\\sidebar_item.dart",
      ),
      CreateFileModel(
        result: "$basePath\\sidebar\\sidebar.dart",
        example: "$baseExample\\sidebar\\sidebar.dart",
      ),
      CreateFileModel(
        result: "$basePath\\custom_logo.dart",
        example: "$baseExample\\custom_logo.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: '', singularName: '', stopIfExists: true);
    }
  }

  Future<void> _createModels(String path) async {
    String basePath = "$path\\models";
    String baseExample = "$examplePath\\commons\\models";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\response_model.dart",
        example: "$baseExample\\response_model.dart",
      ),
      CreateFileModel(
        result: "$basePath\\response.dart",
        example: "$baseExample\\response.dart",
      ),
      CreateFileModel(
        result: "$basePath\\response_paginate_model.dart",
        example: "$baseExample\\response_paginate_model.dart",
      ),
      CreateFileModel(
        result: "$basePath\\dynamic_field_model.dart",
        example: "$baseExample\\dynamic_field_model.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: '', singularName: '', stopIfExists: true);
    }
  }

  Future<void> _createExtensions(String path) async {
    String basePath = "$path\\extensions";
    String baseExample = "$examplePath\\commons\\extensions";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\error_field_extension.dart",
        example: "$baseExample\\error_field_extension.dart",
      ),
      CreateFileModel(
        result: "$basePath\\context_extension.dart",
        example: "$baseExample\\context_extension.dart",
      ),
      CreateFileModel(
        result: "$basePath\\list_dynamic_field_extension.dart",
        example: "$baseExample\\list_dynamic_field_extension.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: '', singularName: '', stopIfExists: true);
    }
  }

  Future<void> _createServices(String path) async {
    String basePath = "$path\\services";
    String baseExample = "$examplePath\\commons\\services";
    List<CreateFileModel> items = [
      CreateFileModel(
        result: "$basePath\\formatter_service.dart",
        example: "$baseExample\\formatter_service.dart",
      ),
    ];
    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: '', singularName: '', stopIfExists: true);
    }
  }
}

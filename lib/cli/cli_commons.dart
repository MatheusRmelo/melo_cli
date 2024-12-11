import 'dart:io';

import '../cli_helper.dart';

class CliCommons {
  String examplePath;
  String appPath;
  String pluralName;
  String singularName;
  CliCommons(
      {required this.appPath,
      required this.examplePath,
      required this.pluralName,
      required this.singularName});

  Future<void> create(
      {bool models = true,
      bool injection = true,
      bool widgets = true,
      bool extensions = true,
      bool services = true}) async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      if (models) await _createModels(value.path);
      if (injection) await _createInjection(value.path);
      if (widgets) await _createWidgets(value.path);
      if (extensions) await _createExtensions(value.path);
      if (services) await _createServices(value.path);
    });
  }

  Future<void> _createWidgets(String path) async {
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_text.dart',
        '$examplePath\\commons\\widgets\\meloui_text.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_button.dart',
        '$examplePath\\commons\\widgets\\meloui_button.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_card.dart',
        '$examplePath\\commons\\widgets\\meloui_card.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_delete_dialog.dart',
        '$examplePath\\commons\\widgets\\meloui_delete_dialog.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);

    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_text_field.dart',
        '$examplePath\\commons\\widgets\\meloui_text_field.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_snackbar.dart',
        '$examplePath\\commons\\widgets\\meloui_snackbar.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_calendar_widget.dart',
        '$examplePath\\commons\\widgets\\meloui_calendar_widget.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    //Dynamic Form
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_dynamic_form\\meloui_dynamic_calendar_field.dart',
        '$examplePath\\commons\\widgets\\meloui_dynamic_form\\meloui_dynamic_calendar_field.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_dynamic_form\\meloui_dynamic_field_widget.dart',
        '$examplePath\\commons\\widgets\\meloui_dynamic_form\\meloui_dynamic_field_widget.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_dynamic_form\\meloui_dynamic_form_widget.dart',
        '$examplePath\\commons\\widgets\\meloui_dynamic_form\\meloui_dynamic_form_widget.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_dynamic_form\\meloui_dynamic_text_field.dart',
        '$examplePath\\commons\\widgets\\meloui_dynamic_form\\meloui_dynamic_text_field.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    //Table
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_table_widget.dart',
        '$examplePath\\commons\\widgets\\meloui_table_widget.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    //Dialogs
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\dialogs\\meloui_delete_dialog_widget.dart',
        '$examplePath\\commons\\widgets\\dialogs\\meloui_delete_dialog_widget.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    //Sidebar
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\sidebar\\meloui_nav_item.dart',
        '$examplePath\\commons\\widgets\\sidebar\\meloui_nav_item.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\sidebar\\meloui_sidebar.dart',
        '$examplePath\\commons\\widgets\\sidebar\\meloui_sidebar.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    //Logo
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_logo.dart',
        '$examplePath\\commons\\widgets\\meloui_logo.dart',
        pluralName: '', singularName: '', stopIfExists: true);
  }

  Future<void> _createModels(String path) async {
    await CliHelper.copyFileFromExample('$path\\models\\response_model.dart',
        '$examplePath\\commons\\models\\response_model.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample('$path\\models\\response.dart',
        '$examplePath\\commons\\models\\response.dart',
        pluralName: '', singularName: '', stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\models\\response_paginate_model.dart',
        '$examplePath\\commons\\models\\response_paginate_model.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\models\\dynamic_field_model.dart',
        '$examplePath\\commons\\models\\dynamic_field_model.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
  }

  Future<void> _createInjection(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\injection\\injection_adapter.dart',
        '$examplePath\\commons\\injection\\injection_adapter.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\injection\\injection_container.dart',
        '$examplePath\\commons\\injection\\injection_container.dart',
        stopIfExists: true,
        pluralName: pluralName,
        singularName: singularName);
  }

  Future<void> _createExtensions(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\extensions\\error_field_extension.dart',
        '$examplePath\\commons\\extensions\\error_field_extension.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\extensions\\context_extension.dart',
        '$examplePath\\commons\\extensions\\context_extension.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
    await CliHelper.copyFileFromExample(
        '$path\\extensions\\list_dynamic_field_extension.dart',
        '$examplePath\\commons\\extensions\\list_dynamic_field_extension.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
  }

  Future<void> _createServices(String path) async {
    await CliHelper.copyFileFromExample(
        '$path\\services\\formatter_service.dart',
        '$examplePath\\commons\\services\\formatter_service.dart',
        pluralName: '',
        singularName: '',
        stopIfExists: true);
  }
}

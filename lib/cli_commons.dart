import 'dart:io';

import 'cli_helper.dart';

class CliCommons {
  String examplePath;
  String appPath;
  CliCommons({required this.appPath, required this.examplePath});

  Future<void> create() async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      await _createModels(value.path);
      await _createInjection(value.path);
      await _createWidgets(value.path);
    });
  }

  Future<void> _createWidgets(String path) async {
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_text.dart',
        '$examplePath\\commons\\widgets\\meloui_text.dart',
        pluralName: '', singularName: '');
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_button.dart',
        '$examplePath\\commons\\widgets\\meloui_button.dart',
        pluralName: '', singularName: '');
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_card.dart',
        '$examplePath\\commons\\widgets\\meloui_card.dart',
        pluralName: '', singularName: '');
    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_delete_dialog.dart',
        '$examplePath\\commons\\widgets\\meloui_delete_dialog.dart',
        pluralName: '',
        singularName: '');

    await CliHelper.copyFileFromExample(
        '$path\\widgets\\meloui_text_field.dart',
        '$examplePath\\commons\\widgets\\meloui_text_field.dart',
        pluralName: '',
        singularName: '');
    await CliHelper.copyFileFromExample('$path\\widgets\\meloui_snackbar.dart',
        '$examplePath\\commons\\widgets\\meloui_snackbar.dart',
        pluralName: '', singularName: '');
  }

  Future<void> _createModels(String path) async {
    CliHelper.copyFileFromExample('$path\\models\\response_model.dart',
        '$examplePath\\commons\\models\\response_model.dart',
        pluralName: '', singularName: '');
    CliHelper.copyFileFromExample('$path\\models\\response.dart',
        '$examplePath\\commons\\models\\response.dart',
        pluralName: '', singularName: '');
  }

  Future<void> _createInjection(String path) async {
    CliHelper.copyFileFromExample('$path\\injection\\injection_adapter.dart',
        '$examplePath\\commons\\injection\\injection_adapter.dart',
        pluralName: '', singularName: '');
    CliHelper.copyFileFromExample('$path\\injection\\injection_container.dart',
        '$examplePath\\commons\\injection\\injection_container.dart',
        stopIfExists: true, pluralName: '', singularName: '');
  }
}

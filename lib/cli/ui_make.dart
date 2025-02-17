import 'dart:io';

import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/models/create_file_model.dart';
import 'package:melo_cli/utils/inputs.dart';

class UiMake {
  String examplePath;
  String appPath;

  UiMake({
    required this.appPath,
    required this.examplePath,
  });

  Future<void> start() async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      String? option = Inputs.question('O que deseja criar?\n 1-AppBar');
      if (option == '1') {
        await _appbars(value.path);
      }
    });
  }

  Future<void> _appbars(String path) async {
    String? option = Inputs.question(
        'Qual AppBar deseja criar?\n0-Todas\n 1-Avatar com notificação');

    String basePath = "$path\\widgets\\appbar";
    String baseExample = "$examplePath\\commons\\widgets\\appbar";
    List<CreateFileModel> items = [
      if (option == '0' || option == '1')
        CreateFileModel(
          result: "$basePath\\appbar_avatar_notification.dart",
          example: "$baseExample\\appbar_avatar_notification.dart",
        ),
    ];

    for (var element in items) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: '', singularName: '', stopIfExists: true);
    }
  }
}

import 'dart:io';

import 'package:melo_cli/cli_auth.dart';
import 'package:melo_cli/cli_commons.dart';
import 'package:melo_cli/cli_module.dart';
import 'package:melo_cli/current_path_utils.dart';

void main(List<String> arguments) async {
  print('What I can do for you?');
  print('1 - Create a New Module');
  print('2 - Create a Authentication Module');
  print('3 - Create a Splash Module');
  final option = stdin.readLineSync();
  if (int.tryParse(option ?? '') == null) {
    print('Invalid Option!');
    return;
  }

  String? currentPath = await CurrentPathUtils.getCurrentPath();
  if (currentPath == null) {
    print('Not possible find melo_cli package files');
    return;
  }
  int value = int.parse(option!);
  String examplePath = '$currentPath\\lib\\example\\';
  String appPath = "${Directory.current.path}\\lib\\features\\";
  String pluralName = "";
  String singularName;
  switch (value) {
    case 1:
      print('What should we name your module?');
      final input = stdin.readLineSync();
      if (input == null) {
        print('Your must give a name to module!');
        return;
      }
      pluralName = input;
      print('What is singular name from module?');
      final input2 = stdin.readLineSync();
      if (input2 == null) {
        print('Your must give a singular name to module!');
        return;
      }
      singularName = input2;
      CliCommons(
        appPath: appPath,
        examplePath: examplePath,
      ).create();
      CliModule(
              appPath: appPath,
              examplePath: examplePath,
              name: pluralName,
              singularName: singularName)
          .create();
      break;
    case 2:
      CliCommons(
        appPath: appPath,
        examplePath: examplePath,
      ).create();
      CliAuth(
        appPath: appPath,
        examplePath: examplePath,
      ).create();
      break;
    case 3:
      print('use_case');
      break;
    default:
      print('Invalid Option!');
  }
}

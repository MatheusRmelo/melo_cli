import 'dart:io';

import 'package:melo_cli/cli_commons.dart';
import 'package:melo_cli/cli_module.dart';

void main(List<String> arguments) {
  print('What I can do for you?');
  print('1 - Create a New Module');
  print('2 - Create a New Cubit');
  print('3 - Create a New UseCase');
  final option = stdin.readLineSync();
  if (int.tryParse(option ?? '') == null) {
    print('Invalid Option!');
    return;
  }
  int value = int.parse(option!);
  String examplePath = '${Directory.current.path}\\lib\\example\\';
  String appPath = "${Directory.current.path}\\app\\";
  switch (value) {
    case 1:
      CliCommons().create(appPath, examplePath: examplePath);
      CliModule().createModule(appPath);
      break;
    case 2:
      print('cubit');
      break;
    case 3:
      print('use_case');
      break;
    default:
      print('Invalid Option!');
  }
}

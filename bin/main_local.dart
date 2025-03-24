import 'dart:io';

import 'package:melo_cli/cli/auth_make.dart';
import 'package:melo_cli/cli/core_make.dart';
import 'package:melo_cli/cli/module_make.dart';
import 'package:melo_cli/cli/splash_make.dart';
import 'package:melo_cli/cli/ui_make.dart';
import 'package:melo_cli/cli/usecase_make.dart';

void main(List<String> arguments) async {
  print('What I can do for you?');
  print('usecase:make - Create a UseCase');
  print('module:make - Create a Module');
  print('core:make - Create a Core Folder');
  print('auth:make - Create a Authentication Module');
  print('splash:make - Create a Splash Module');
  print('ui:make - Create a UI Component');

  final option = stdin.readLineSync();

  String? currentPath = "C:\\saas\\melo_cli";
  // if (currentPath == null) {
  //   print('Not possible find melo_cli package files');
  //   return;
  // }
  String examplePath = '$currentPath\\lib\\example\\';
  String appPath = "${Directory.current.path}\\lib\\features\\";

  if (option == 'usecase:make') {
    await UsecaseMake(appPath: appPath, examplePath: examplePath).start();
    return;
  }
  if (option == 'module:make') {
    await ModuleMake(examplePath: examplePath, appPath: appPath).start();
    return;
  }
  if (option == 'core:make') {
    await CoreMake(examplePath: examplePath, appPath: appPath).start();
    return;
  }
  if (option == 'ui:make') {
    await UiMake(examplePath: examplePath, appPath: appPath).start();
    return;
  }
  if (option == 'auth:make') {
    await AuthMake(
      examplePath: examplePath,
      appPath: appPath,
    ).start();
    return;
  }
  if (option == 'splash:make') {
    await SplashMake(
      examplePath: examplePath,
      appPath: appPath,
    ).start();
    return;
  }
}

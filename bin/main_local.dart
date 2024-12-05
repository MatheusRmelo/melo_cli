import 'dart:io';

import 'package:melo_cli/cli/cli_core.dart';
import 'package:melo_cli/cli_auth.dart';
import 'package:melo_cli/cli/cli_commons.dart';
import 'package:melo_cli/cli_module.dart';
import 'package:melo_cli/current_path_utils.dart';
import 'package:melo_cli/enums/datasource_type.dart';
import 'package:melo_cli/utils/inputs.dart';

void main(List<String> arguments) async {
  print('What I can do for you?');
  print('1 - Create a New Module');
  print('2 - Create a Authentication Module');
  print('3 - Create a Core Folder');
  print('4 - Create a Commons Folder');
  final option = stdin.readLineSync();
  if (int.tryParse(option ?? '') == null) {
    print('Invalid Option!');
    return;
  }

  String? currentPath = "C:\\mooncake\\melo_cli";
  // if (currentPath == null) {
  //   print('Not possible find melo_cli package files');
  //   return;
  // }
  int value = int.parse(option!);
  String examplePath = '$currentPath\\lib\\example\\';
  String appPath = "${Directory.current.path}\\lib\\features\\";
  String? pluralName;
  String? singularName;
  DatasourceType? datasourceType;
  switch (value) {
    case 1:
      pluralName = Inputs.getModuleName();
      if (pluralName == null) {
        print('Your must give a name to module!');
        return;
      }
      singularName = Inputs.getSingularModuleName();
      if (singularName == null) {
        print('Your must give a singular name to module!');
        return;
      }
      datasourceType = Inputs.getDatasourceType();
      if (datasourceType == null) {
        print("Your must give a datasourceType");
        return;
      }

      CliCore(
              appPath: appPath,
              examplePath: examplePath,
              datasourceType: datasourceType)
          .create();
      CliCommons(
              appPath: appPath,
              examplePath: examplePath,
              pluralName: pluralName,
              singularName: singularName)
          .create();
      CliModule(
              appPath: appPath,
              examplePath: examplePath,
              name: pluralName,
              singularName: singularName)
          .create();
      break;
    case 2:
      datasourceType = Inputs.getDatasourceType();
      if (datasourceType == null) {
        print("Your must give a datasourceType");
        return;
      }
      CliCore(
              appPath: appPath,
              examplePath: examplePath,
              datasourceType: datasourceType)
          .create();
      CliCommons(
              appPath: appPath,
              examplePath: examplePath,
              pluralName: 'authentication',
              singularName: 'authentication')
          .create();
      CliAuth(
              appPath: appPath,
              examplePath: examplePath,
              datasourceType: datasourceType)
          .create();
      break;
    case 3:
      DatasourceType? type = Inputs.getDatasourceType();
      if (type == null) {
        print("Option invalid, try again with correct option!");
        return;
      }
      CliCore(appPath: appPath, examplePath: examplePath, datasourceType: type)
          .create();
      break;
    case 4:
      print('What part of Commons Folder you want?');
      print('1 - Complete');
      print('2 - Models');
      final commonOption = stdin.readLineSync();
      if (int.tryParse(commonOption ?? '') == null) {
        print('Invalid Option!');
        return;
      }
      int value = int.parse(commonOption!);
      switch (value) {
        case 1:
          CliCommons(
                  appPath: appPath,
                  examplePath: examplePath,
                  pluralName: '',
                  singularName: '')
              .create(injection: false);
        case 2:
          CliCommons(
                  appPath: appPath,
                  examplePath: examplePath,
                  pluralName: '',
                  singularName: '')
              .create(
                  injection: false,
                  extensions: false,
                  services: false,
                  widgets: false);
      }

    default:
      print('Invalid Option!');
  }
}

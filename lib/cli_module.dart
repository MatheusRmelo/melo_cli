import 'dart:io';

import 'package:melo_cli/cli_datasource.dart';

class CliModule {
  String name = "";
  Future<void> createModule(String path) async {
    print('What should we name your module?');
    final input = stdin.readLineSync();
    if (input == null) {
      print('Your must give a name to module!');
      return;
    }
    name = input;

    Directory(path + name).create(recursive: true).then((value) async {
      await _createData(value.path);
      await _createDomain(value.path);
      await _createInjectionContainer(value.path);
      await _createPresentation(value.path);
    });
  }

  Future<void> _createData(String path) async {
    await Directory('$path/data/data_sources').create(recursive: true);
    CliDataSource().create('$path/data/data_sources', name,
        modelName: 'User', tableName: 'users');
    await Directory('$path/data/repositories').create(recursive: true);
  }

  Future<void> _createDomain(String path) async {
    await Directory('$path/domain/data_sources').create(recursive: true);
    await Directory('$path/domain/use_cases').create(recursive: true);
  }

  Future<void> _createInjectionContainer(String path) async {
    await Directory('$path/injection_container').create(recursive: true);
  }

  Future<void> _createPresentation(String path) async {
    await Directory('$path/presentation/manager').create(recursive: true);
    await Directory('$path/presentation/pages').create(recursive: true);
  }
}

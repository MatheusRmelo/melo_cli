import 'dart:io';
import 'package:melo_cli/enums/datasource_type.dart';

class Inputs {
  static String? getSingularModuleName() {
    print('What is singular name from module?');
    final input = stdin.readLineSync();
    return input;
  }

  static String? getModuleName() {
    print('What should we name your module?');
    final input = stdin.readLineSync();
    return input;
  }

  static DatasourceType? getDatasourceType() {
    print('What type datasource you want? \n#1-SUPABASE\n#2-RESTAPI');
    final datasourceInput = stdin.readLineSync();
    if (datasourceInput != null) {
      if (datasourceInput == '1' || datasourceInput == '#1') {
        return DatasourceType.supabase;
      } else if (datasourceInput == '2' || datasourceInput == '#2') {
        return DatasourceType.restApi;
      } else {
        print(
            "Option invalid $datasourceInput, try again with correct option!");
        return null;
      }
    }
    return null;
  }
}

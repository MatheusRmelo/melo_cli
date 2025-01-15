// ignore_for_file: avoid_print

import 'dart:io';

enum UsecaseType {
  restAPI,
  normal;

  static UsecaseType? ask() {
    print('What type usecase you want? \n#1-API\n#2-NORMAL');
    final datasourceInput = stdin.readLineSync();
    if (datasourceInput != null) {
      if (datasourceInput == '1' || datasourceInput == '#1') {
        return UsecaseType.restAPI;
      } else if (datasourceInput == '2' || datasourceInput == '#2') {
        return UsecaseType.normal;
      } else {
        print(
            "Option invalid $datasourceInput, try again with correct option!");
        return null;
      }
    }
    return null;
  }
}

extension UsecaseTypeExtension on UsecaseType {
  String getName(String name) {
    switch (this) {
      case UsecaseType.restAPI:
        return "api_$name";
      case UsecaseType.normal:
        return "normal_$name";
      default:
        return name;
    }
  }
}

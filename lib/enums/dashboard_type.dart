// ignore_for_file: avoid_print

import 'dart:io';

enum DashboardType {
  game;

  static DashboardType? ask() {
    print('What type dashboard you want? \n#1-GAME');
    final datasourceInput = stdin.readLineSync();
    if (datasourceInput != null) {
      if (datasourceInput == '1' || datasourceInput == '#1') {
        return DashboardType.game;
      } else {
        print(
            "Option invalid $datasourceInput, try again with correct option!");
        return null;
      }
    }
    return null;
  }
}

extension DashboardTypeExtension on DashboardType {
  String getName(String name) {
    switch (this) {
      case DashboardType.game:
        return "game_$name";
      default:
        return name;
    }
  }
}

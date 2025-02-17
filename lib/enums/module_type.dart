import 'dart:io';

enum ModuleType {
  get,
  full,
  form;

  static ModuleType? ask() {
    print(
        'Tipo do módulo? \n#1-Apenas listagem\n#2-Completo\n#3-Apenas formulário');
    final datasourceInput = stdin.readLineSync();
    if (datasourceInput != null) {
      if (datasourceInput == '1' || datasourceInput == '#1') {
        return ModuleType.get;
      } else if (datasourceInput == '2' || datasourceInput == '#2') {
        return ModuleType.full;
      } else if (datasourceInput == '3' || datasourceInput == '#3') {
        return ModuleType.form;
      } else {
        print(
            "Option invalid $datasourceInput, try again with correct option!");
        return null;
      }
    }
    return null;
  }
}

extension ModuleTypeExtension on ModuleType {
  String getName() {
    switch (this) {
      case ModuleType.get:
        return "_get";
      case ModuleType.full:
        return "";
      case ModuleType.form:
        return "_form";
      default:
        return "";
    }
  }
}

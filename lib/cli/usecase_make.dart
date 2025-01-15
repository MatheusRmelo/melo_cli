import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/enums/usecase_type.dart';
import 'package:melo_cli/utils/inputs.dart';

class UsecaseMake {
  String appPath;
  String examplePath;

  UsecaseMake({required this.examplePath, required this.appPath});

  Future<void> start() async {
    String? module = Inputs.question('Qual o módulo destino?');
    if (module == null) {
      print('Módulo não informado');
      return;
    }
    String? singularModule =
        Inputs.question('Qual o módulo destino no singular?');
    if (singularModule == null) {
      print('Módulo não informado');
      return;
    }
    String path = '$appPath\\modules\\$module';

    String? name = Inputs.question('Qual o nome do UseCase?');
    if (name == null) {
      print('Nome não informado');
      return;
    }
    UsecaseType? type = UsecaseType.ask();
    if (type == null) {
      print('Tipo não informado');
      return;
    }

    await CliHelper.copyFileFromExample(
        '$path\\domain\\use_cases\\${name}_usecase.dart',
        '$examplePath\\modules\\users\\domain\\use_cases\\${type.getName("")}usecase.dart',
        pluralName: module,
        singularName: singularModule);
  }
}

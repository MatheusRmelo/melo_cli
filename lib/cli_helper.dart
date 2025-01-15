import 'dart:io';

import 'package:melo_cli/string_extension.dart';
import 'package:melo_cli/utils/formatters.dart';

class CliHelper {
  static Future<void> copyFileFromExample(String result, String example,
      {bool stopIfExists = false,
      bool isToReplaceNameInScript = true,
      required String pluralName,
      required String singularName}) async {
    File exampleFile = File(example);
    if (stopIfExists) {
      if (await File(result).exists()) {
        return;
      }
    }
    File file = await File(result).create(recursive: true);
    String contents = await exampleFile.readAsString();
    if (isToReplaceNameInScript) {
      var replace = {
        'users'.capitalize(): pluralName,
        'user'.capitalize(): singularName,
        'users': Formatters.camelCaseToSnakeCase(pluralName),
        'user': Formatters.camelCaseToSnakeCase(singularName),
      };
      for (var element in replace.entries) {
        contents = contents.replaceAll(element.key, element.value);
      }
    }

    file.writeAsString(contents);
  }
}

import 'dart:io';

import 'package:melo_cli/string_extension.dart';

class CliHelper {
  static Future<void> copyFileFromExample(String result, String example,
      {bool stopIfExists = false,
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
    var replace = {
      'users'.capitalize(): pluralName.capitalize(),
      'user'.capitalize(): singularName.capitalize(),
      'users': pluralName,
      'user': singularName,
    };
    for (var element in replace.entries) {
      contents = contents.replaceAll(element.key, element.value);
    }

    file.writeAsString(contents);
  }
}

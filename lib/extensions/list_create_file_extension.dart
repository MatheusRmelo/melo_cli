import 'package:melo_cli/cli_helper.dart';
import 'package:melo_cli/models/create_file_model.dart';

extension ListCreateFileExtension on List<CreateFileModel> {
  Future<void> create(
      {String plural = '',
      String singular = '',
      bool stopIfExists = true,
      bool isToReplaceNameInScript = true}) async {
    for (var element in this) {
      await CliHelper.copyFileFromExample(element.result, element.example,
          pluralName: plural,
          singularName: singular,
          stopIfExists: stopIfExists,
          isToReplaceNameInScript: isToReplaceNameInScript);
    }
  }
}

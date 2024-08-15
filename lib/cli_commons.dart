import 'dart:io';

class CliCommons {
  Future<void> create(String appPath, {required String examplePath}) async {
    Directory('$appPath\\commons').create(recursive: true).then((value) async {
      File exampleFile = File('$examplePath\\models\\response_model.dart');
      File file = await File('${value.path}\\models\\response_model.dart')
          .create(recursive: true);

      String contents = await exampleFile.readAsString();
      file.writeAsString(contents).then((value) {
        print('Success when create commons');
      }).catchError((error) {
        print('Error when try to create commons $error');
      });
    });
  }
}

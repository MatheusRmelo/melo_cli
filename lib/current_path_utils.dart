import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class CurrentPathUtils {
  static Future<String?> getCurrentPath() async {
    var scriptPath = Platform.script.path;
    String baseDir = path.dirname(path.dirname(scriptPath));
    String packageConfigPath =
        path.join(baseDir, '.dart_tool', 'package_config.json');

    if (packageConfigPath.startsWith('/')) {
      packageConfigPath = packageConfigPath.substring(1);
    }
    File packageConfigFile = File(packageConfigPath);
    if (packageConfigFile.existsSync()) {
      File jsonFile = packageConfigFile;
      String contents = await jsonFile.readAsString();
      Map<String, dynamic> json = jsonDecode(contents);

      if (json['packages'] is List) {
        for (var element in (json['packages'] as List)) {
          if (element['name'] == 'melo_cli') {
            const String prefix = 'file:///';
            String rootUri = element['rootUri'];
            if (rootUri.startsWith(prefix)) {
              rootUri = rootUri.substring(prefix.length);
            }
            return rootUri;
          }
        }
      }
    }

    return null;
  }
}

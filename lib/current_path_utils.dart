import 'dart:io';

class CurrentPathUtils {
  static String? getCurrentPath() {
    var scriptPath = Platform.script.path;
    var targetDir = 'melo_cli';

    if (scriptPath.contains(targetDir)) {
      var endIndex = scriptPath.indexOf(targetDir) + targetDir.length;
      var resultPath = scriptPath.substring(0, endIndex);
      if (resultPath.startsWith('/')) {
        resultPath = resultPath.substring(1);
      }

      resultPath = resultPath.replaceAll('/', '\\');
      return resultPath;
    }

    return null;
  }
}

import 'dart:io';

enum DatasourceType {
  supabase,
  restApi,
  firebase;

  static DatasourceType? ask() {
    print(
        'What type datasource you want? \n#1-SUPABASE\n#2-RESTAPI\n#3-FIREBASE');
    final datasourceInput = stdin.readLineSync();
    if (datasourceInput != null) {
      if (datasourceInput == '1' || datasourceInput == '#1') {
        return DatasourceType.supabase;
      } else if (datasourceInput == '2' || datasourceInput == '#2') {
        return DatasourceType.restApi;
      } else if (datasourceInput == '3' || datasourceInput == '#3') {
        return DatasourceType.firebase;
      } else {
        print(
            "Option invalid $datasourceInput, try again with correct option!");
        return null;
      }
    }
    return null;
  }
}

extension DatasourceTypeExtension on DatasourceType {
  String getName(String name) {
    switch (this) {
      case DatasourceType.firebase:
        return "firebase_$name";
      case DatasourceType.restApi:
        return "api_$name";
      case DatasourceType.supabase:
        return name;
      default:
        return name;
    }
  }
}

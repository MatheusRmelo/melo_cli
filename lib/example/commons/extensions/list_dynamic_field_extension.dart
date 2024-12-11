import '../models/dynamic_field_model.dart';

extension ListDynamicFieldExtension on List<DynamicFieldModel> {
  List<DynamicFieldModel> fromJson(Map<String, dynamic> json) {
    List<DynamicFieldModel> result = this;
    for (int index = 0; index < result.length; index++) {
      result[index].value = json[result[index].code] ?? "";
    }

    return result;
  }

  Map<String, String> toJson() {
    Map<String, String> result = {};

    forEach((element) {
      result[element.code] = element.value ?? "";
    });

    return result;
  }

  List<DynamicFieldModel> clearFields() {
    List<DynamicFieldModel> result = this;
    for (int index = 0; index < result.length; index++) {
      result[index].value = "";
    }

    return result;
  }
}

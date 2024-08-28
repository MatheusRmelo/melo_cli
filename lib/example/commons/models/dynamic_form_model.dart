import 'package:flutter/material.dart';

class DynamicFormModel {
  String? name;
  List<DynamicFieldModel> fields;

  DynamicFormModel({this.name, required this.fields});
}

class DynamicFieldModel {
  String label;
  String? placeholder;
  FieldType type;
  String? value;
  ValueChanged<DynamicFieldModel>? onChange;

  DynamicFieldModel(
      {required this.label,
      this.placeholder,
      this.type = FieldType.text,
      this.value,
      this.onChange});
}

enum FieldType { select, text, real, day }

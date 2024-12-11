import 'package:flutter/material.dart';

class DynamicFieldModel {
  String code;

  String label;
  String? placeholder;
  FieldType type;
  String? value;
  ValueChanged<DynamicFieldModel>? onChange;

  DynamicFieldModel(
      {required this.label,
      required this.code,
      this.placeholder,
      this.type = FieldType.text,
      this.value,
      this.onChange});
}

enum FieldType { select, text, real, day }

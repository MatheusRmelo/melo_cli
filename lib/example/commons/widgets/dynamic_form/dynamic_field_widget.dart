import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/dynamic_field_model.dart';
import '../../services/formatter_service.dart';
import 'dynamic_calendar_field.dart';
import 'dynamic_text_field.dart';

class DynamicFieldWidget extends StatefulWidget {
  const DynamicFieldWidget({
    super.key,
    required this.field,
    required this.onChange,
  });

  final DynamicFieldModel field;
  final ValueChanged<DynamicFieldModel?> onChange;

  @override
  State<DynamicFieldWidget> createState() => _DynamicFieldWidgetState();
}

class _DynamicFieldWidgetState extends State<DynamicFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.field.type == FieldType.text) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.real) {
      return DynamicTextField(
        value: widget.field.value,
        placeholder: widget.field.placeholder,
        label: widget.field.label,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          FormatterService.getRealInputFormatter(),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          var field = widget.field;
          field.value = value;
          widget.onChange(field);
        },
      );
    }
    if (widget.field.type == FieldType.day) {
      return DynamicCalendarField(
          label: widget.field.label,
          activeDate: widget.field.value == null
              ? DateTime.now()
              : DateTime.parse(widget.field.value!),
          onChanged: (value) {
            if (value != null) {
              var field = widget.field;
              field.value = DateFormat('yyyy-MM-dd').format(value);
              widget.onChange(field);
            }
          });
    }

    throw Exception("Dynamic Field Type choose is not available yet");
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

import '../../models/dynamic_form_model.dart';
import 'meloui_dynamic_field_widget.dart';

class MeloUiDynamicFormWidget extends StatefulWidget {
  const MeloUiDynamicFormWidget({super.key, required this.form});
  final DynamicFormModel form;
  @override
  State<MeloUiDynamicFormWidget> createState() =>
      _MeloUiDynamicFormWidgetState();
}

class _MeloUiDynamicFormWidgetState extends State<MeloUiDynamicFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.form.name != null)
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Text(widget.form.name!)),
      Wrap(
        children: widget.form.fields
            .mapIndexed((index, element) => Container(
                  width: context.isMobile ? null : 500,
                  margin: const EdgeInsets.only(right: 16),
                  child: MeloUiDynamicFieldWidget(
                    field: widget.form.fields[index],
                    onChange: (value) {
                      if (value != null &&
                          widget.form.fields[index].onChange != null) {
                        widget.form.fields[index].onChange!(value);
                      }
                    },
                  ),
                ))
            .toList(),
      ),
    ]);
  }
}

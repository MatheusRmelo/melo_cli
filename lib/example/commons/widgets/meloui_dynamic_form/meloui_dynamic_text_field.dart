import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../meloui_text_field.dart';

class MeloUiDynamicTextField extends StatefulWidget {
  const MeloUiDynamicTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.value,
    this.formatters,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  });

  final String label;
  final String? placeholder;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;

  @override
  State<MeloUiDynamicTextField> createState() => _MeloUiDynamicTextFieldState();
}

class _MeloUiDynamicTextFieldState extends State<MeloUiDynamicTextField> {
  final TextEditingController _textInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textInputController.text = widget.value ?? "";
    _textInputController.addListener(() {
      widget.onChanged(_textInputController.text);
    });
  }

  @override
  void dispose() {
    _textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeloUiTextField(
      controller: _textInputController,
      placeholder: widget.placeholder,
      label: widget.label,
      formatters: widget.formatters,
      keyboardType: widget.keyboardType,
    );
  }
}

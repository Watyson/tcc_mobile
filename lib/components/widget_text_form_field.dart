import 'package:flutter/material.dart';

class WidgetTextFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final bool autofocus;
  final TextInputType keyboardType;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String initialValue;
  final AutovalidateMode autoValidateMode;
  final TextEditingController? controller;

  const WidgetTextFormField({
    super.key,
    this.title = "",
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.initialValue = "",
    this.onChanged,
    this.onSaved,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      autofocus: autofocus,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        labelText: title,
        errorStyle: const TextStyle(fontSize: 15.0),
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autoValidateMode,
      controller: controller,
    );
  }
}

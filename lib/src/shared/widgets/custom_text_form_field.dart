import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.validator,
    this.border,
    this.hint,
    this.formatter,
    this.autovalidateMode,
    this.initialValue,
    this.obscureText = false,
  });

  final String? labelText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final InputBorder? border;
  final String? hint;
  final TextInputFormatter? formatter;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: autovalidateMode,
      keyboardAppearance: Brightness.dark,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 18),
      inputFormatters: formatter != null ? [formatter!] : [],
      decoration: InputDecoration(
        border: border,
        labelText: labelText,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}

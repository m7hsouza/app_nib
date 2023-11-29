import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.labelText, this.onChanged, this.keyboardType, this.controller, this.validator});

  final String? labelText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        keyboardAppearance: Brightness.dark,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}

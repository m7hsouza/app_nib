import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, this.labelText, this.onChanged});

  final String? labelText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}

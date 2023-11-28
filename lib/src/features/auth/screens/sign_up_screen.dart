import 'package:app_nib/src/shared/widgets/custom_text_form_field.dart';
import 'package:app_nib/src/features/auth/screens/widgets/layout_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutWidget(
        title: Text(
          "Criar um nova conta",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Form(
            child: Column(
              children: [
                const CustomTextFormField(labelText: "Nome Completo"),
                const SizedBox(height: 16),
                const CustomTextFormField(labelText: "Email"),
                const SizedBox(height: 16),
                const CustomTextFormField(labelText: "Celular"),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: "Sexo",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                    value: "Masculino",
                    itemHeight: 50,
                    onChanged: (value) {},
                    items: [
                      "Masculino",
                      "Feminino"
                    ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                const CustomTextFormField(labelText: "Nascimento"),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text("Já sou batizado")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Expanded(
                      child: Text("Já assinei a ficha de compromisso de membro"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 48),
                  child: ElevatedButton(onPressed: () {}, child: const Text("Criar")),
                ),
                const Text("Já tem conta?"),
                TextButton(
                  child: const Text("Faça seu login"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/screens/sign-in');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

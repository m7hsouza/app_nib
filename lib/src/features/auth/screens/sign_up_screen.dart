import 'package:app_nib/src/commons/widgets/custom_text_form_field.dart';
import 'package:app_nib/src/features/auth/screens/widgets/layout_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: LayoutWidget(
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Criar um nova conta",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Text(
                "Por favor preencha o formulário para continuar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 24),
              const CustomTextFormField(labelText: "Nome Completo"),
              const SizedBox(height: 16),
              const CustomTextFormField(labelText: "Email"),
              const SizedBox(height: 16),
              const CustomTextFormField(labelText: "Celular"),
              const SizedBox(height: 16),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  padding: const EdgeInsets.all(0),
                  isDense: true,
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
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: ElevatedButton(onPressed: () {}, child: const Text("Criar")),
              ),
              const Text("Já tem conta?"),
              TextButton(
                child: const Text("Faça seu login"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sign-in');
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

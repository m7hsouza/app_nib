import 'package:app_nib/src/commons/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: ColoredBox(color: Theme.of(context).primaryColor),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.9,
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
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
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomTextFormField(labelText: "Nome Completo"),
                          const SizedBox(height: 16),
                          CustomTextFormField(labelText: "Email"),
                          const SizedBox(height: 16),
                          CustomTextFormField(labelText: "Celular"),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 50,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                padding: const EdgeInsets.all(0),
                                isDense: true,
                                onChanged: (value) {},
                                hint: SizedBox(
                                  child: Text("Selecione"),
                                ),
                                items: [
                                  "Masculino",
                                  "Feminino"
                                ].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(labelText: "Nascimento"),
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text("Já sou batizado")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text("Já assinei a ficha de compromisso de membro")
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32, bottom: 8),
                            child: ElevatedButton(onPressed: () {}, child: const Text("Criar")),
                          ),
                          const Spacer(),
                          const Text("Já tem conta?"),
                          TextButton(
                            child: const Text("Faça seu login"),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/sign-in');
                            },
                          ),
                          const SizedBox(height: 32)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

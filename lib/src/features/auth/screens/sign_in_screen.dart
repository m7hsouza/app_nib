import 'package:app_nib/src/commons/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Form(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Image.asset("assets/images/nib_logo.png", width: 160),
                ),
                const CustomTextFormField(labelText: "Matricula"),
                const SizedBox(height: 16),
                const CustomTextFormField(labelText: "Senha"),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text("Entrar"),
                  ),
                ),
                TextButton(
                  child: const Text("Esqueceu sua senha?"),
                  onPressed: () {},
                ),
                const Spacer(),
                const Text("Não tem conta?"),
                TextButton(
                  child: const Text("Criar conta"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sign-up');
                  },
                ),
                const SizedBox(height: 16)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

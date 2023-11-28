import 'package:app_nib/src/shared/widgets/custom_text_form_field.dart';
import 'package:app_nib/src/features/auth/screens/widgets/layout_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutWidget(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      Navigator.pushReplacementNamed(context, "/screens/");
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
                    Navigator.pushReplacementNamed(context, '/screens/sign-up');
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

import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                height: MediaQuery.sizeOf(context).height / 1.125,
                child: ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Image.asset("assets/images/nib_logo.png", width: 160),
                        ),
                        const TextField(decoration: InputDecoration(labelText: "Matricula")),
                        const SizedBox(height: 16),
                        const TextField(decoration: InputDecoration(labelText: "Senha")),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 8),
                          child: ElevatedButton(onPressed: () {}, child: const Text("Entrar")),
                        ),
                        TextButton(onPressed: () {}, child: const Text("Esqueceu sua senha?")),
                        const Spacer(),
                        const Text("Não tem conta?"),
                        TextButton(
                          child: const Text("Criar conta"),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/sign-up');
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
        ],
      ),
    );
  }
}

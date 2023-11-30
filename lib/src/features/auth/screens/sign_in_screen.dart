import 'package:app_nib/src/app_widget.dart';
import 'package:app_nib/src/features/auth/stores/sign_in_store.dart';
import 'package:app_nib/src/shared/widgets/custom_text_form_field.dart';
import 'package:app_nib/src/features/auth/screens/widgets/layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInStore _store;

  @override
  void initState() {
    super.initState();

    _store = context.read();
    _store.addListener(() {
      final state = _store.state;

      if (state == SignIgnState.success) {
        Navigator.of(context).pushReplacementNamed('/screens/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutWidget(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _store.form,
            child: Column(
              children: [
                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Image.asset("assets/images/nib_logo.png", width: 160),
                ),
                CustomTextFormField(
                  labelText: "Matricula",
                  keyboardType: TextInputType.number,
                  controller: _store.enrollmentNumber,
                  validator: _store.validateEnrollmentNumber,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(labelText: "Senha", controller: _store.password, validator: _store.validatePassword),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _store.errorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 8),
                  child: ElevatedButton(
                    onPressed: _store.login,
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

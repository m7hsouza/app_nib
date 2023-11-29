import 'package:app_nib/src/commons/auth/auth_service.dart';
import 'package:app_nib/src/commons/auth/credentials.dart';
import 'package:flutter/cupertino.dart';

class SignInStore extends ChangeNotifier {
  final AuthService _authService;

  final form = GlobalKey<FormState>();
  final enrollmentNumber = TextEditingController();
  final password = TextEditingController();

  SignInStore(this._authService);

  String? validateEnrollmentNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'A matricula é obrigatoria';
    }

    debugPrint(value);
    if (!RegExp(r'\d{6}').hasMatch(value)) {
      return 'Matricula inválida';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'A senha é obrigatoria';
    }

    return null;
  }

  Future<void> login() async {
    if (form.currentState!.validate()) {
      await _authService.login(credentials: Credentials(enrollmentNumber: enrollmentNumber.text, password: password.text));
    }
  }
}
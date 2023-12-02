import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/shared/auth/credentials.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum SignIgnState { idle, loading, success, error }

class SignInStore extends ChangeNotifier {
  final AuthService _authService;

  final form = GlobalKey<FormState>();
  final enrollmentNumber = TextEditingController();
  final password = TextEditingController();

  SignIgnState _state = SignIgnState.idle;
  SignIgnState get state => _state;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;


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
    _state = SignIgnState.loading;
    if (form.currentState!.validate()) {
      try {
        await _authService.login(credentials: Credentials(enrollmentNumber: enrollmentNumber.text, password: password.text));
        _state = SignIgnState.success;
        enrollmentNumber.clear();
        password.clear();
      } on DioException catch (error) {
        
        if (error.type == DioExceptionType.connectionError) {
          _errorMessage = 'Servidor indiposinvel';
          
        } else if (error.type == DioExceptionType.badResponse) {
          if (error.response?.statusCode == 401) {
            _errorMessage = 'Usuario ou senha invalido';
          } else {
            _errorMessage = error.response?.data.toString() ?? '';
          }
        }
        _state = SignIgnState.error;
      } finally {
        notifyListeners();
        _errorMessage = '';
      }
    }
  }
}

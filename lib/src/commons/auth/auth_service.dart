import 'dart:async';

import 'package:app_nib/src/commons/auth/credentials.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {

  final HttpService _httpService;

  AuthService(this._httpService);

  Future<void> login({ required Credentials credentials}) async {
    final client = _httpService.client;

    final response = await client.post('/login', data: {
      'enrollment_number': credentials.enrollmentNumber,
      'password': credentials.password,
    });

    debugPrint(response.data['access_token']);
  }
}

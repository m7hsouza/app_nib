import 'dart:async';

import 'package:app_nib/src/shared/auth/credentials.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  final HttpService _httpService;
  User? loggedUser;

  AuthService(this._httpService);

  Future<void> login({required Credentials credentials}) async {
    final client = _httpService.client;
    final response = await client.post('/login', data: {
      'enrollment_number': credentials.enrollmentNumber,
      'password': credentials.password,
    });
    loggedUser = User.fromMap(response.data['user']);
    _httpService.addTokenInHeaderRequest(response.data['access_token']);
  }

  bool can(String name) {
    if (loggedUser == null) return false;

    final permissions = loggedUser!.roles.fold(
      loggedUser!.permissions,
      (permisisons, role) => permisisons..addAll(role.permissions),
    );
    return permissions.any((permission) => permission.name == name);
  }

  bool hasRole(String pattern) {
    if (loggedUser == null) return false;

    final regex = RegExp(pattern);
    return loggedUser!.roles.any((role) => regex.hasMatch(role.name));
  }
}

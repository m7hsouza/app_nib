import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:flutter/material.dart';

class ProfileStore extends ChangeNotifier {

  late User _user;
  User get user => _user;
  final AuthService _authService;
  ProfileStore(this._authService);

  void loadUser() {
    _user = _authService.loggedUser!.copyWith();
  }

  void onChangeAlredyBaptized(bool? value) {
    _user = _user.copyWith(isAlreadyBaptized: value);
    notifyListeners();
  }

  void onChangeAlredyAcceptedTerm(bool? value) {
    _user = _user.copyWith(alreadyAcceptedTerm: value);
    notifyListeners();
  }

  void updateUser(Map<String, dynamic> map) {
    _user = _user.copyWith(avatar: 'http://10.0.2.2:3333/${map['avatar_url']}');
    notifyListeners();
  }


}
import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileStore extends ChangeNotifier {
  final picker = ImagePicker();
  final HttpService _httpService;

  late User _user;
  User get user => _user;
  final AuthService _authService;
  ProfileStore(this._authService, this._httpService);

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

  void updateAvatar() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final data = FormData.fromMap({'avatar': await MultipartFile.fromFile(image.path, filename: image.name)});
    final response = await _httpService.client.post('/user/me/update-avatar', data: data);
    _user = _user.copyWith(avatar: 'http://10.0.2.2:3333/${response.data['avatar_url']}');
    notifyListeners();
  }
}
import 'package:app_nib/src/shared/auth/auth_service.dart';
import 'package:app_nib/src/shared/models/user.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum ProfileState {
  idle,
  loading,
  success,
  error
}

class ProfileStore extends ChangeNotifier {
  final picker = ImagePicker();
  final HttpService _httpService;

  late User _user;
  User get user => _user;
  String get formattedDate => DateFormat('dd/MM/yyyy').format(_user.birth);
  final AuthService _authService;
  ProfileStore(this._authService, this._httpService);

  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String _error = '';
  Map<String, dynamic> _errors = {};

  ProfileState _state = ProfileState.idle;
  ProfileState get state => _state;
  bool get isLoading => state == ProfileState.loading;
  bool get isError => state == ProfileState.error;
  bool get isSuccess => state == ProfileState.success;

  void resetState() => _state = ProfileState.idle;

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

  void onChangeBirth(DateTime birth) {
    _user = _user.copyWith(birth: birth);
    notifyListeners();
  }

  void onChangeName(String value) {
    _user = user.copyWith(name: value);
  }

  void onChangeEmail(String value) {
    _user = user.copyWith(email: value);
  }

  void onChangePhone(String value) {
    _user = user.copyWith(phone: value);
  }

  void onChangeGender(UserGender? value) {
    _user = user.copyWith(gender: value);
  }

  void _setState(ProfileState state) {
    _state = state;
    notifyListeners();
  }

  bool hasError(String field) => _errors[field] != null;
  String? getError([String? field]) {
    if (field == null) return _error;
    return _errors[field]?.join(',');
  }

  Future<void> onSubmit() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) return;
    _setState(ProfileState.loading);
    await Future.delayed(const Duration(seconds: 1));
    try {
      final data = user.toMap();
      if (passwordController.text.isNotEmpty) {
        data.addAll({
          'password': passwordController.text
        });
      }
      debugPrint(data.toString());

      await _httpService.client.put('/user/me', data: data);
      _authService.loggedUser = user;
      _setState(ProfileState.success);
      passwordController.clear();
    } on DioException catch (dioException) {
      _clearErrors();
      final response = dioException.response;
      if (response == null) {
        _error = 'Aconteceu um error inesperado ao tentar salvar o usuario';
      } else if (response.statusCode == 422) {
        debugPrint(response.data.toString());
        _errors = response.data;
      }
      _setState(ProfileState.error);
    }
  }

  Future<void> updateAvatar() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final data = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(image.path, filename: image.name)
    });
    final response = await _httpService.client.post('/user/me/update-avatar', data: data);
    _user = _user.copyWith(avatar: response.data['avatar_url']);
    notifyListeners();
  }

  void _clearErrors() {
    _error = '';
    _errors = {};
  }
}

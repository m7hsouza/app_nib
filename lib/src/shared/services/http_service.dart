import 'dart:io' show Platform;

import 'package:dio/dio.dart';

class HttpService {

  final Dio _client;

  HttpService() : _client =  Dio(
    BaseOptions(
      baseUrl: Platform.environment['API_URL'] ?? 'http://10.0.2.2:3333/api'
    )
  );

  void addTokenInHeaderRequest(String token) {
    _client.options.headers.addAll({'Authorization': 'Bearer $token'});
  }

  void removeTokenFromHeaderRequest() {
    _client.options.headers.remove('Authorization');
  }

  Dio get client => _client;
}

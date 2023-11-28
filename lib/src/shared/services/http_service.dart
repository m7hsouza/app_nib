import 'dart:io' show Platform;

import 'package:dio/dio.dart';

class HttpService {

  final Dio _client;

  HttpService() : _client =  Dio(
    BaseOptions(
      baseUrl: Platform.environment['API_URL'] ?? 'http://localhost:3333'
    )
  );

  void addTokenInHeaderRequest(String token) {
    _client.options.headers.addAll({'authorization': token});
  }

  void removeTokenFromHeaderRequest() {
    _client.options.headers.remove('authorization');
  }

  Dio get client => _client;
}

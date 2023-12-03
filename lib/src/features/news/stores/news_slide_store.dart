import 'dart:collection';

import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';


enum  NewsSlideState {
  idle, loading, error, succes;

  bool get isLoading => this == NewsSlideState.loading;
}

class NewsSlideStore extends ChangeNotifier {
  final HttpService _httpService;
  late NewsSlideState _state;
  NewsSlideState get state => _state;

  final List<Article> _cards = [];
  List<Article> get cards => UnmodifiableListView(_cards);

  NewsSlideStore(this._httpService) {
    init();
  }

  Future<void> init() async {
    _state = NewsSlideState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _cards.clear();
    final response = await _httpService.client.get('/article/highlights');
    _cards.addAll((response.data as List).map((data) => Article.fromMap(data)));
    _state = NewsSlideState.succes;
    notifyListeners();
  }
}
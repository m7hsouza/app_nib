import 'dart:collection';

import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';

enum NewsState { idle, loading, error, succes }

class NewsStore extends ChangeNotifier {

  final HttpService _httpService;
  late NewsState _state;
  NewsState get state => _state;

  final List<Article> _articles = [];
  List<Article> get articles => UnmodifiableListView(_articles);

  final List<Article> _highlights = [];
  List<Article> get highlights => UnmodifiableListView(_highlights);

   NewsStore(this._httpService) {
    loadArticles();
   }

  Future<void> loadArticles() async {
    _state = NewsState.loading;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _articles.clear();
    final response = await _httpService.client.get('/articles');
    _articles.addAll((response.data['data'] as List).map((data) => Article.fromMap(data)));
    _state = NewsState.succes;
    notifyListeners();
  }

  Future<Article> getArticleById(int id) async {
    final response = await _httpService.client.get('/article/$id');
    return Article.fromMap(response.data);
  }
}
import 'dart:collection';

import 'package:app_nib/src/features/news/models/article.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';

enum RecentArticleState {
  idle, loading, success, error
}

class RecentArticlesStore extends ChangeNotifier {
  RecentArticlesStore(this._http);

  final HttpService _http;
  
  List<Article> _articles = [];
  List<Article> get articles => UnmodifiableListView(_articles);

  RecentArticleState _state = RecentArticleState.idle;
  RecentArticleState get state => _state;

  void _setState(RecentArticleState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getRecentArticles() async {
    _articles = [];
    _setState(RecentArticleState.loading);
    final response = await _http.client.get('/recent-articles');
    final recentArticles = (response.data as List).map((data) => Article.fromMap(data));
    _articles = recentArticles.toList();
    _setState(RecentArticleState.success);
  }

}
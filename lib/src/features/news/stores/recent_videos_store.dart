import 'dart:collection';

import 'package:app_nib/src/features/news/models/video.dart';
import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';

enum RecentVideosState {
  idle, loading, success, error
}

class RecentVideosStore extends ChangeNotifier {
  RecentVideosStore(this._http);

  final HttpService _http;
  
  List<Video> _videos = [];
  List<Video> get videos => UnmodifiableListView(_videos);

  RecentVideosState _state = RecentVideosState.idle;
  RecentVideosState get state => _state;

  void _setState(RecentVideosState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getRecentVideos() async {
    _videos = [];
    _setState(RecentVideosState.loading);
    final response = await _http.client.get('/recent-videos');
    final recentVideos = (response.data as List).map((data) => Video.fromMap(data));
    _videos = recentVideos.toList();
    _setState(RecentVideosState.success);
  }

}
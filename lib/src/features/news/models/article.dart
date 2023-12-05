import 'dart:convert';

import 'package:app_nib/src/features/news/models/author.dart';

class Article {
  final int id;
  final String title;
  final String content;
  final int likes;
  final String image;
  final DateTime createdAt;
  final Author author;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.likes,
    required this.image,
    required this.createdAt,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'likes': likes,
      'image_url': image,
      'created_at': createdAt.millisecondsSinceEpoch,
      'author': author.toMap(),
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      likes: map['likes'] ?? 0,
      image: map['image_url'] as String,
      createdAt: DateTime.parse(map['created_at']),
      author: Author.fromMap(map['author'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) => Article.fromMap(json.decode(source) as Map<String, dynamic>);
}

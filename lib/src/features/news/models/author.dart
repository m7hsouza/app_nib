import 'dart:convert';

class Author {
  final int id;
  final String name;
  final String? avatar;
  Author({
    required this.id,
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar_url': avatar,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map['id'] as int,
      name: map['name'] as String,
      avatar: map['avatar_url'] != null ? map['avatar_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) => Author.fromMap(json.decode(source) as Map<String, dynamic>);
}

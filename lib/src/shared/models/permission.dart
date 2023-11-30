// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Permission {
  final int id;
  final String name;

  Permission({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Permission.fromJson(String source) => Permission.fromMap(json.decode(source) as Map<String, dynamic>);
}

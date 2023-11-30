// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_nib/src/shared/models/permission.dart';

class Role {
  final int id;
  final String name;
  final List<Permission> permissions;

  Role({
    required this.id,
    required this.name,
    required this.permissions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'permissions': permissions.map((x) => x.toMap()).toList(),
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'] as int,
      name: map['name'] as String,
      permissions: List<Permission>.from((map['permissions'] as List).map<Permission>((x) => Permission.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source) as Map<String, dynamic>);
}

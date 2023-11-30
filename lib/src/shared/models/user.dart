// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_nib/src/shared/models/permission.dart';
import 'package:app_nib/src/shared/models/role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String enrollmentNumber;
  final String? avatar;
  final bool passwordChangeRequired;
  final List<Role> roles;
  final List<Permission> permissions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.enrollmentNumber,
    required this.passwordChangeRequired,
    required this.roles,
    required this.permissions,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'enrollment_number': enrollmentNumber,
      'avatar_url': avatar,
      'password_change_required': passwordChangeRequired,
      'roles': roles.map((x) => x.toMap()).toList(),
      'permissions': permissions.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      enrollmentNumber: map['enrollment_number'] as String,
      avatar: map['avatar_url'] as String?,
      passwordChangeRequired: map['password_change_required'] as bool,
      roles: List<Role>.from((map['roles'] as List).map<Role>((x) => Role.fromMap(x as Map<String,dynamic>),),),
      permissions: List<Permission>.from((map['permissions'] as List).map<Permission>((x) => Permission.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

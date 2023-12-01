import 'dart:convert';

import 'package:app_nib/src/shared/models/permission.dart';
import 'package:app_nib/src/shared/models/role.dart';

enum UserState {
  active,
  deactivate;

  @override
  String toString() {
    return switch(this) {
      UserState.active => 'active',
      UserState.deactivate => 'deactivate',
    };
  }

  static UserState fromString(String value) {
    if (value == 'active') return UserState.active;
    if (value == 'deactivate') return UserState.deactivate;
    throw Exception('value invalid');
  }
}
enum UserGender {
  male, female;

    @override
  String toString() {
    return switch(this) {
      UserGender.male => 'male',
      UserGender.female => 'female',
    };
  }

  static UserGender fromString(String value) {
    if (value == 'male') return UserGender.male;
    if (value == 'female') return UserGender.female;
    throw Exception('value invalid');
  }
 }

class User {
  final int id;
  final String name;
  final String email;
  final String enrollmentNumber;
  final String? avatar;
  final bool passwordChangeRequired;
  final String phone;
  final UserGender gender;
  final UserState state;
  final bool isAlreadyBaptized;
  final bool alreadyAcceptedTerm;
  final DateTime birth;
  final DateTime updatedAt;
  final List<Role> roles;
  final List<Permission> permissions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.enrollmentNumber,
    this.avatar,
    required this.passwordChangeRequired,
    required this.phone,
    required this.gender,
    required this.state,
    required this.isAlreadyBaptized,
    required this.alreadyAcceptedTerm,
    required this.birth,
    required this.updatedAt,
    required this.roles,
    required this.permissions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'enrollment_number': enrollmentNumber,
      'avatar_url': avatar,
      'password_change_required': passwordChangeRequired,
      'phone': phone,
      'gender': gender.toString(),
      'state': state.toString(),
      'is_already_baptized': isAlreadyBaptized,
      'already_accepted_term': alreadyAcceptedTerm,
      'birth': birth.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'roles': roles.map((x) => x.toMap()).toList(),
      'updated_at': permissions.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      enrollmentNumber: map['enrollment_number'] as String,
      avatar: map['avatar_url'] != null ? 'http://10.0.2.2:3333/${map['avatar_url']}' : null,
      passwordChangeRequired: map['password_change_required'] as bool,
      phone: map['phone'] as String,
      gender: UserGender.fromString(map['gender'] as String),
      state: UserState.fromString(map['state'] as String),
      isAlreadyBaptized: map['is_already_baptized'] as bool,
      alreadyAcceptedTerm: map['already_accepted_term'] as bool,
      birth: DateTime.parse(map['birth']),
      updatedAt: DateTime.parse(map['updated_at']),
      roles: List<Role>.from((map['roles'] as List).map<Role>((x) => Role.fromMap(x as Map<String,dynamic>),),),
      permissions: List<Permission>.from((map['permissions'] as List).map<Permission>((x) => Permission.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}

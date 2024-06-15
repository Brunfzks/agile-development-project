// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/user.dart';

class UserModel implements User {
  @override
  final String email;

  @override
  final int idUser;

  @override
  final String password;

  @override
  final String user;

  UserModel({
    required this.email,
    required this.idUser,
    required this.password,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'idUser': idUser,
      'password': password,
      'user': user,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      idUser: map['idUser'] as int,
      password: map['password'] as String,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

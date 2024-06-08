// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/credentials.dart';

class CredentialsModel implements Credentials {
  @override
  final String email;

  @override
  final String password;
  CredentialsModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory CredentialsModel.fromMap(Map<String, dynamic> map) {
    return CredentialsModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CredentialsModel.fromJson(String source) =>
      CredentialsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

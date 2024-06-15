// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/project_user.dart';
import 'package:agile_development_project/app/infra/model/type_user_model.dart';

class ProjectUserModel implements ProjectUser {
  @override
  final String email;

  @override
  final int idProject;

  @override
  final int idUser;

  @override
  final TypeUserModel typeUser;

  @override
  final String user;

  @override
  final int idProjectUser;

  ProjectUserModel({
    required this.email,
    required this.idProject,
    required this.idUser,
    required this.typeUser,
    required this.user,
    required this.idProjectUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'idProject': idProject,
      'idUser': idUser,
      'typeUser': typeUser.toMap(),
      'user': user,
      'idProjectUser': idProjectUser,
    };
  }

  factory ProjectUserModel.fromMap(Map<String, dynamic> map) {
    return ProjectUserModel(
      email: map['email'] as String,
      idProject: map['idProject'] ?? 0,
      idUser: map['idUser'] as int,
      typeUser: TypeUserModel.fromMap(map['typeUser'] as Map<String, dynamic>),
      user: map['user'] as String,
      idProjectUser: map['idProjectUsers'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectUserModel.fromJson(String source) =>
      ProjectUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

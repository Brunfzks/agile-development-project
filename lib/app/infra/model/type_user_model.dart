// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/type_user.dart';

class TypeUserModel implements TypeUser {
  @override
  final int idTypeUser;

  @override
  final String typeUser;

  TypeUserModel({
    required this.idTypeUser,
    required this.typeUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTypeUser': idTypeUser,
      'typeUser': typeUser,
    };
  }

  factory TypeUserModel.fromMap(Map<String, dynamic> map) {
    return TypeUserModel(
      idTypeUser: map['idTypeUser'] ?? 0,
      typeUser: map['typeUser'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUserModel.fromJson(String source) =>
      TypeUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

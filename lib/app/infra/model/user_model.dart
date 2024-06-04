// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}

import 'package:agile_development_project/app/infra/model/type_user_model.dart';

class ProjectUser {
  final int idProjectUser;
  final int idProject;
  final int idUser;
  final String user;
  final String email;
  final TypeUserModel typeUser;
  ProjectUser({
    required this.idProjectUser,
    required this.idProject,
    required this.idUser,
    required this.user,
    required this.email,
    required this.typeUser,
  });
}

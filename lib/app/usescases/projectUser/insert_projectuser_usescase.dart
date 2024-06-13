// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_user_repository.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';

abstract class IInsertProjectUsers {
  Future<Either<ProjectUsersExeption, bool>> call(
      ParamsInsertProjectUser params);
}

class InsertProjectUsers implements IInsertProjectUsers {
  ProjectUserRepository repository;
  InsertProjectUsers({
    required this.repository,
  });

  @override
  Future<Either<ProjectUsersExeption, bool>> call(
      ParamsInsertProjectUser params) async {
    if (params.projectUserModel.email.isEmpty ||
        params.projectUserModel.idProject.isNaN ||
        params.projectUserModel.idUser.isNaN ||
        params.projectUserModel.user.isEmpty ||
        params.projectUserModel.typeUser.idTypeUser.isNaN) {
      throw ProjectUsersExeption(message: 'USUARIO INVALIDO');
    }
    return await repository.insertProjectUser(params);
  }
}

class ParamsInsertProjectUser {
  final ProjectUserModel projectUserModel;
  ParamsInsertProjectUser({
    required this.projectUserModel,
  });
}

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_user_repository.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IDeleteProjectUsers {
  Future<Either<ProjectUsersExeption, bool>> call(
      ParamsDeleteProjectUser params);
}

class DeleteProjectUsers implements IDeleteProjectUsers {
  ProjectUserRepository repository;
  DeleteProjectUsers({
    required this.repository,
  });

  @override
  Future<Either<ProjectUsersExeption, bool>> call(
      ParamsDeleteProjectUser params) async {
    if (params.projectUserModel.idProjectUser.isNaN) {
      throw ProjectUsersExeption(message: 'USUARIO INVALIDO');
    }
    return await repository.deleteProjectUser(params);
  }
}

class ParamsDeleteProjectUser {
  final ProjectUserModel projectUserModel;
  ParamsDeleteProjectUser({
    required this.projectUserModel,
  });
}

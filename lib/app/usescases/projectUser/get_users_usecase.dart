import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_user_repository.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IGetProjectUsers {
  Future<Either<ProjectUsersExeption, List<ProjectUserModel>>> call(
      ParamsGetProjectUser params);
}

class GetProjectUsers implements IGetProjectUsers {
  ProjectUserRepository repository;
  GetProjectUsers({
    required this.repository,
  });

  @override
  Future<Either<ProjectUsersExeption, List<ProjectUserModel>>> call(
      ParamsGetProjectUser params) async {
    return await repository.getUsers(params);
  }
}

class ParamsGetProjectUser {}

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/usescases/projectUser/delete_projectuser_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/get_users_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/insert_projectuser_usescase.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectUserRepository {
  Future<Either<ProjectUsersExeption, List<ProjectUserModel>>> getUsers(
      ParamsGetProjectUser params);
  Future<Either<ProjectUsersExeption, ProjectUserModel>> insertProjectUser(
      ParamsInsertProjectUser params);
  Future<Either<ProjectUsersExeption, bool>> deleteProjectUser(
      ParamsDeleteProjectUser params);
}

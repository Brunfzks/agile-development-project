import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_user_repository.dart';
import 'package:agile_development_project/app/infra/datasource/projectuser_datasource.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/usescases/projectUser/delete_projectuser_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/get_users_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/insert_projectuser_usescase.dart';
import 'package:dartz/dartz.dart';

class ProjectUserRepositoryImpl implements ProjectUserRepository {
  final ProjectuserDataSource datasource;
  ProjectUserRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<ProjectUsersExeption, List<ProjectUserModel>>> getUsers(
      ParamsGetProjectUser params) async {
    try {
      final projectusers = await datasource.getProjectUser(params);
      return Right(projectusers);
    } on ProjectUsersExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectUsersExeption(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<ProjectUsersExeption, ProjectUserModel>> insertProjectUser(
      ParamsInsertProjectUser params) async {
    try {
      final bool = await datasource.insertProjectUser(params);
      return Right(bool);
    } on ProjectUsersExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectUsersExeption(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<ProjectUsersExeption, bool>> deleteProjectUser(
      ParamsDeleteProjectUser params) async {
    try {
      final bool = await datasource.deleteProjectUser(params);
      return Right(bool);
    } on ProjectUsersExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectUsersExeption(message: 'Exception Error'));
    }
  }
}

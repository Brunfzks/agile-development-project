import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_repository.dart';
import 'package:agile_development_project/app/infra/datasource/project_datasource.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/usescases/project/create_project_usecase.dart';
import 'package:agile_development_project/app/usescases/project/delete_project_usescase.dart';
import 'package:agile_development_project/app/usescases/project/get_projects_usecase.dart';
import 'package:agile_development_project/app/usescases/project/update_project_usecase.dart';
import 'package:dartz/dartz.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDatasource datasource;
  ProjectRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<ProjectsExeption, List<ProjectModel>>> getProjects(
      ParamsGetProjects params) async {
    try {
      final projects = await datasource.getProjects(params);
      return Right(projects);
    } on ProjectsExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectsExeption(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<ProjectsExeption, ProjectModel>> insertProjects(
      ParamsCreateProjects params) async {
    try {
      final projects = await datasource.insertProjects(params);
      return Right(projects);
    } on ProjectsExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectsExeption(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<ProjectsExeption, bool>> deleteProjects(
      ParamsDeleteProjects params) async {
    try {
      final projects = await datasource.deleteProjects(params);
      return Right(projects);
    } on ProjectsExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectsExeption(message: 'Exception Error'));
    }
  }

  @override
  Future<Either<ProjectsExeption, bool>> updateProjects(
      ParamsUpdateProjects params) async {
    try {
      final projects = await datasource.updateProjects(params);
      return Right(projects);
    } on ProjectsExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(ProjectsExeption(message: 'Exception Error'));
    }
  }
}

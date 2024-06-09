import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/usescases/project/create_project_usecase.dart';
import 'package:agile_development_project/app/usescases/project/delete_project_usescase.dart';
import 'package:agile_development_project/app/usescases/project/get_projects_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class ProjectRepository {
  Future<Either<ProjectsExeption, List<ProjectModel>>> getProjects(
      ParamsGetProjects params);
  Future<Either<ProjectsExeption, ProjectModel>> insertProjects(
      ParamsCreateProjects params);
  Future<Either<ProjectsExeption, bool>> deleteProjects(
      ParamsDeleteProjects params);
}

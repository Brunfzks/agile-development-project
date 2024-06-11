import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_repository.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:dartz/dartz.dart';

abstract class IUpdateProject {
  Future<Either<ProjectsExeption, bool>> call(ParamsUpdateProjects params);
}

class UpdateProjectUsesCases implements IUpdateProject {
  ProjectRepository repository;
  UpdateProjectUsesCases({
    required this.repository,
  });

  @override
  Future<Either<ProjectsExeption, bool>> call(
      ParamsUpdateProjects params) async {
    return await repository.updateProjects(params);
  }
}

class ParamsUpdateProjects {
  final ProjectModel project;
  ParamsUpdateProjects({
    required this.project,
  });
}
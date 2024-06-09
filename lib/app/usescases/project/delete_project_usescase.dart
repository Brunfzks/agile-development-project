import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_repository.dart';
import 'package:dartz/dartz.dart';

abstract class IDeleteProject {
  Future<Either<ProjectsExeption, bool>> call(ParamsDeleteProjects params);
}

class DeleteProjectProjectUsesCases implements IDeleteProject {
  ProjectRepository repository;
  DeleteProjectProjectUsesCases({
    required this.repository,
  });

  @override
  Future<Either<ProjectsExeption, bool>> call(
      ParamsDeleteProjects params) async {
    return await repository.deleteProjects(params);
  }
}

class ParamsDeleteProjects {
  final int idProject;
  ParamsDeleteProjects({
    required this.idProject,
  });
}

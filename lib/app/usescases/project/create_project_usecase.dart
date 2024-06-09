// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_repository.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';

abstract class ICreatetProject {
  Future<Either<ProjectsExeption, ProjectModel>> call(
      ParamsCreateProjects params);
}

class CreateProjectUsesCases implements ICreatetProject {
  ProjectRepository repository;
  CreateProjectUsesCases({
    required this.repository,
  });

  @override
  Future<Either<ProjectsExeption, ProjectModel>> call(
      ParamsCreateProjects params) async {
    return await repository.insertProjects(params);
  }
}

class ParamsCreateProjects {
  final ProjectModel project;
  ParamsCreateProjects({
    required this.project,
  });
}

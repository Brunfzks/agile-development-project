// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/project_repository.dart';
import 'package:agile_development_project/app/infra/model/project_model.dart';

abstract class IGetProject {
  Future<Either<ProjectsExeption, List<ProjectModel>>> call(
      ParamsGetProjects params);
}

class GetProjectUsesCases implements IGetProject {
  ProjectRepository repository;
  GetProjectUsesCases({
    required this.repository,
  });

  @override
  Future<Either<ProjectsExeption, List<ProjectModel>>> call(
      ParamsGetProjects params) async {
    if (params.idUser.isNaN) {
      return left(ProjectsExeption(message: 'NO USER'));
    }
    return await repository.getProjects(params);
  }
}

class ParamsGetProjects {
  final int idUser;
  ParamsGetProjects({
    required this.idUser,
  });
}

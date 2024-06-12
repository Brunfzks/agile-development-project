import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/status_repository.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:dartz/dartz.dart';

abstract class ICreatetStatus {
  Future<Either<StatusExeption, StatusProjectTaskModel>> call(
      ParamsCreateStatus params);
}

class CreateStatusUsesCases implements ICreatetStatus {
  StatusRepository repository;
  CreateStatusUsesCases({
    required this.repository,
  });

  @override
  Future<Either<StatusExeption, StatusProjectTaskModel>> call(
      ParamsCreateStatus params) async {
    return await repository.createStatus(params);
  }
}

class ParamsCreateStatus {
  final StatusProjectTaskModel status;
  ParamsCreateStatus({
    required this.status,
  });
}

import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/status_repository.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:dartz/dartz.dart';

abstract class IDeleteStatus {
  Future<Either<StatusExeption, bool>> call(ParamsDeleteStatus params);
}

class DeleteStatus implements IDeleteStatus {
  StatusRepository repository;
  DeleteStatus({
    required this.repository,
  });

  @override
  Future<Either<StatusExeption, bool>> call(ParamsDeleteStatus params) async {
    return await repository.deleteStatus(params);
  }
}

class ParamsDeleteStatus {
  final StatusProjectTaskModel status;
  ParamsDeleteStatus({
    required this.status,
  });
}

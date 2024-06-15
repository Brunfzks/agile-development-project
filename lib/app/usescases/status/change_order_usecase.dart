import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/status_repository.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:dartz/dartz.dart';

abstract class IChangeStatusOrder {
  Future<Either<StatusExeption, bool>> call(ParamsChangeStatusOrder params);
}

class ChangeStatusOrder implements IChangeStatusOrder {
  StatusRepository repository;
  ChangeStatusOrder({
    required this.repository,
  });

  @override
  Future<Either<StatusExeption, bool>> call(
      ParamsChangeStatusOrder params) async {
    return await repository.changeStatusOrder(params);
  }
}

class ParamsChangeStatusOrder {
  final List<StatusProjectTaskModel> status;
  ParamsChangeStatusOrder({
    required this.status,
  });
}

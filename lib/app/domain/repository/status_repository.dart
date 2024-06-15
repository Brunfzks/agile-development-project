import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/usescases/status/change_order_usecase.dart';
import 'package:agile_development_project/app/usescases/status/delete_status_usecase.dart';
import 'package:agile_development_project/app/usescases/status/insert_status_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class StatusRepository {
  Future<Either<StatusExeption, StatusProjectTaskModel>> createStatus(
      ParamsCreateStatus params);
  Future<Either<StatusExeption, bool>> deleteStatus(ParamsDeleteStatus params);
  Future<Either<StatusExeption, bool>> changeStatusOrder(
      ParamsChangeStatusOrder params);
}

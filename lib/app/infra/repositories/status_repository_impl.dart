import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/status_repository.dart';
import 'package:agile_development_project/app/infra/datasource/status_datasource.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/usescases/status/insert_status_usecase.dart';
import 'package:dartz/dartz.dart';

class StatusRepositoryImpl implements StatusRepository {
  final StatusDataSource datasource;
  StatusRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<StatusExeption, StatusProjectTaskModel>> createStatus(
      ParamsCreateStatus params) async {
    try {
      final status = await datasource.createStatus(params);
      return Right(status);
    } on StatusExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(StatusExeption(message: 'Exception Error'));
    }
  }
}

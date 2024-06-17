import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/task_repository.dart';
import 'package:agile_development_project/app/infra/datasource/task_datasource.dart';
import 'package:agile_development_project/app/usescases/task/update_task_usecase.dart';
import 'package:dartz/dartz.dart';

class TaskRepositoyImpl implements TaskRepository {
  final TaskDataSource datasource;
  TaskRepositoyImpl({
    required this.datasource,
  });

  @override
  Future<Either<TaskExeption, bool>> updateTask(ParamsUpdateTask params) async {
    try {
      final status = await datasource.updateTask(params);
      return Right(status);
    } on TaskExeption catch (e) {
      return Left(e);
    } on Exception {
      return left(TaskExeption(message: 'Exception Error'));
    }
  }
}

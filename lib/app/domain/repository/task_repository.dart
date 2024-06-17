import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/usescases/task/update_task_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class TaskRepository {
  Future<Either<TaskExeption, bool>> updateTask(ParamsUpdateTask params);
}

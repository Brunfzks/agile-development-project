import 'package:agile_development_project/app/domain/errors/errors.dart';
import 'package:agile_development_project/app/domain/repository/task_repository.dart';
import 'package:agile_development_project/app/infra/model/task_model.dart';
import 'package:dartz/dartz.dart';

abstract class IUpdateTask {
  Future<Either<TaskExeption, bool>> call(ParamsUpdateTask params);
}

class UpdateTask implements IUpdateTask {
  TaskRepository repository;
  UpdateTask({
    required this.repository,
  });

  @override
  Future<Either<TaskExeption, bool>> call(ParamsUpdateTask params) async {
    return await repository.updateTask(params);
  }
}

class ParamsUpdateTask {
  final TaskModel task;
  ParamsUpdateTask({
    required this.task,
  });
}

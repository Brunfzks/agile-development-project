import 'package:agile_development_project/app/usescases/task/update_task_usecase.dart';

abstract class TaskDataSource {
  Future<bool> updateTask(ParamsUpdateTask params);
}

import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';
import 'package:agile_development_project/app/usescases/status/insert_status_usecase.dart';

abstract class StatusDataSource {
  Future<StatusProjectTaskModel> createStatus(ParamsCreateStatus params);
}

import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/usescases/projectUser/get_users_usecase.dart';
import 'package:agile_development_project/app/usescases/projectUser/insert_projectuser_usescase.dart';

abstract class ProjectuserDataSource {
  Future<List<ProjectUserModel>> getProjectUser(ParamsGetProjectUser params);
  Future<bool> insertProjectUser(ParamsInsertProjectUser params);
}

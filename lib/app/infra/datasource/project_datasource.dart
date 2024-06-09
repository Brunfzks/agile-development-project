import 'package:agile_development_project/app/infra/model/project_model.dart';
import 'package:agile_development_project/app/usescases/project/create_project_usecase.dart';
import 'package:agile_development_project/app/usescases/project/delete_project_usescase.dart';
import 'package:agile_development_project/app/usescases/project/get_projects_usecase.dart';

abstract class ProjectDatasource {
  Future<List<ProjectModel>> getProjects(ParamsGetProjects params);
  Future<ProjectModel> insertProjects(ParamsCreateProjects params);
  Future<bool> deleteProjects(ParamsDeleteProjects params);
}

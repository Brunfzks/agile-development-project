// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';

class Project {
  final int idProject;
  final String description;
  final String feedback;
  final List<ProjectUserModel> projectUsers;
  final List<StatusProjectTaskModel> statusProjectTask;
  Project({
    required this.idProject,
    required this.description,
    required this.feedback,
    required this.projectUsers,
    required this.statusProjectTask,
  });
}

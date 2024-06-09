import 'package:agile_development_project/app/infra/model/project_user_model.dart';

class Project {
  final int idProject;
  final String description;
  final String feedback;
  final List<ProjectUserModel> projectUsers;
  Project({
    required this.projectUsers,
    required this.idProject,
    required this.description,
    required this.feedback,
  });
}

import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/project.dart';
import 'package:agile_development_project/app/infra/model/project_user_model.dart';
import 'package:agile_development_project/app/infra/model/status_project_task_model.dart';

class ProjectModel implements Project {
  @override
  final String description;

  @override
  final String feedback;

  @override
  final int idProject;

  @override
  final List<ProjectUserModel> projectUsers;

  @override
  final List<StatusProjectTaskModel> statusProjectTask;

  ProjectModel({
    required this.description,
    required this.feedback,
    required this.idProject,
    required this.projectUsers,
    required this.statusProjectTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'feedback': feedback,
      'idProject': idProject,
      'projectUsers': projectUsers.map((x) => x.toMap()).toList(),
      'statusProjectTask': statusProjectTask.map((x) => x.toMap()).toList(),
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      description: map['description'] as String,
      feedback: map['feedback'] ?? '',
      idProject: map['idProject'] as int,
      projectUsers: List<ProjectUserModel>.from(
        (map['projectUsers'] as List<dynamic>).map<ProjectUserModel>(
          (x) => ProjectUserModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      statusProjectTask: List<StatusProjectTaskModel>.from(
        (map['status'] ?? []).map<StatusProjectTaskModel>(
          (x) => StatusProjectTaskModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/task.dart';

class TaskModel implements Tasks {
  @override
  final DateTime deadLine;

  @override
  final String description;

  @override
  final int idProject;

  @override
  final int idStatus;

  @override
  final int idTask;

  @override
  final int idUser;

  @override
  final int ordem;

  @override
  final int priority;

  TaskModel({
    required this.deadLine,
    required this.description,
    required this.idProject,
    required this.idStatus,
    required this.idTask,
    required this.idUser,
    required this.ordem,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deadLine': deadLine.toString(),
      'description': description,
      'idProject': idProject,
      'idStatus': idStatus,
      'idTask': idTask,
      'idUser': idUser,
      'ordem': ordem,
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      deadLine: DateTime.parse(map['deadline'] as String),
      description: map['description'] as String,
      idProject: map['fk_Projects_idProjects'] as int,
      idStatus: map['fk_StatusProjectTask_idStatusProjectTask'] as int,
      idTask: map['idTask'] as int,
      idUser: map['fk_Users_idUsuario'] as int,
      ordem: map['ordem'] as int,
      priority: map['priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

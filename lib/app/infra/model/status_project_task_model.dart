// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:agile_development_project/app/domain/entities/status_project_task.dart';

class StatusProjectTaskModel implements StatusProjectTask {
  @override
  final int idProject;

  @override
  final int idStatusProjectTask;

  @override
  final String status;

  StatusProjectTaskModel({
    required this.idProject,
    required this.idStatusProjectTask,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProject': idProject,
      'idStatusProjectTask': idStatusProjectTask,
      'status': status,
    };
  }

  factory StatusProjectTaskModel.fromMap(Map<String, dynamic> map) {
    return StatusProjectTaskModel(
      idProject: map['idProject'] as int,
      idStatusProjectTask: map['idStatusProjectTask'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusProjectTaskModel.fromJson(String source) =>
      StatusProjectTaskModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
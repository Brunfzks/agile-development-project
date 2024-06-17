class Tasks {
  final int idTask;
  final int idProject;
  final int priority;
  final String description;
  final DateTime deadLine;
  final int idUser;
  final int idStatus;
  final int ordem;
  Tasks({
    required this.idTask,
    required this.idProject,
    required this.priority,
    required this.description,
    required this.deadLine,
    required this.idUser,
    required this.idStatus,
    required this.ordem,
  });
}

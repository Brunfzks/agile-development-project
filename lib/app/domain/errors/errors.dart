class UserException implements Exception {
  final String message;
  UserException({
    required this.message,
  });

  @override
  String toString() => 'UserException(message: $message)';
}

class ProjectsExeption implements Exception {
  final String message;
  ProjectsExeption({
    required this.message,
  });

  @override
  String toString() => 'ProjectsExeption(message: $message)';
}

class StatusExeption implements Exception {
  final String message;
  StatusExeption({
    required this.message,
  });

  @override
  String toString() => 'StatusExeption(message: $message)';
}

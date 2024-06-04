class UserException implements Exception {
  final String message;
  UserException({
    required this.message,
  });

  @override
  String toString() => 'UserException(message: $message)';
}

class GetListExeption implements Exception {
  final String message;
  GetListExeption({
    required this.message,
  });

  @override
  String toString() => 'GetListExeption(message: $message)';
}

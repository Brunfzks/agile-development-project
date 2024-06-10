enum StatusMessage { erro, success, warning }

class AlertMessage {
  final String message;
  final StatusMessage status;
  AlertMessage({
    required this.message,
    required this.status,
  });
}

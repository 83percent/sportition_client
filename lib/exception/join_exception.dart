class JoinException implements Exception {
  final String message;

  JoinException(this.message);

  @override
  String toString() => 'JoinException: $message';

  String getMessage() => message;
}

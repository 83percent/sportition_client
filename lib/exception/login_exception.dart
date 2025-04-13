class LoginException implements Exception {
  final String message;

  LoginException(this.message);

  @override
  String toString() => 'LoginException: $message';

  String getMessage() => message;
}

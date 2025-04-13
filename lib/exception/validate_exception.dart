class ValidateException implements Exception {
  final String message;

  ValidateException(this.message);

  @override
  String toString() => 'ValidateException: $message';

  String getMessage() => message;
}

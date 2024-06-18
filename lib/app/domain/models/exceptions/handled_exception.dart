class HandledException implements Exception {
  final String? message;
  final String? error;
  final int? statusCode;
  final StackTrace? stackTrace;
  final dynamic exception;

  HandledException({
    this.message,
    this.error,
    this.statusCode,
    this.stackTrace,
    this.exception,
  });
}

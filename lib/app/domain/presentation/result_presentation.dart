import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/exceptions.dart';

class ResultPresentation {
  final String? message;
  final bool success;
  final String? error;
  final dynamic payload;

  ResultPresentation({
    this.success = true,
    this.message,
    this.error = '',
    this.payload,
  });

  factory ResultPresentation.exception(
    HandledException exception, {
    dynamic payload,
  }) {
    return ResultPresentation(
      success: false,
      message: exception.message ?? '',
      error: exception.error ?? '',
      payload: payload,
    );
  }
}

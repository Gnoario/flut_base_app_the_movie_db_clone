import 'package:dio/dio.dart';

class ErrorHandleInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    bool isStatusSuccess =
        response.statusCode! >= 200 && response.statusCode! <= 299;

    if (isStatusSuccess) return handler.next(response);

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.unknown,
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final error = DioException(
      error: err.message,
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
    );

    handler.next(error);
  }
}

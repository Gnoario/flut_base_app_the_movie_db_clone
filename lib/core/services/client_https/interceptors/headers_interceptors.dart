import 'package:dio/dio.dart';

class HeadersInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["accept"] = "application/json";
    options.headers["Authorization"] = "Bearer $_token";
    return handler.next(options);
  }

  String get _token => 'ApiTokenHere';
}

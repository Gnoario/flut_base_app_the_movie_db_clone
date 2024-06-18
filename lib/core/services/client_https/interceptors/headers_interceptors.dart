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

  String get _token =>
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZWYzZjExNzFlNWE1YjUzNWVmNGVmZDIzOWE3YjRkMCIsInN1YiI6IjY2NmM1ODAyZTk4MTA1ZTQyNzM4NjQ3NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LRtHQUNGbR0iD5S0cWXNDmuwUtoVdduVYqEYCSIufzc';
}

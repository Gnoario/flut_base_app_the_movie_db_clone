import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_exception.dart';
import 'package:dio/dio.dart' hide LogInterceptor;

import 'client_base.dart';

class ClientHttpsBaseImpl implements ClientBase {
  final Dio _dio;

  ClientHttpsBaseImpl(
    BaseOptions baseOptions, {
    List<Interceptor>? interceptors,
    HttpClientAdapter? httpClientAdapter,
  }) : _dio = Dio(
          baseOptions,
        ) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
    if (httpClientAdapter != null) {
      _dio.httpClientAdapter = httpClientAdapter;
    }
  }

  get httpsClientAdapter => _dio.httpClientAdapter;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) async {
    try {
      return await _dio.fetch(requestOptions);
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _getExceptionInstance(e);
    }
  }

  BaseOptions get options => _dio.options;

  HandledException _getExceptionInstance(DioException e) {
    dynamic error;
    if (e.response?.data['errors'] != null) {
      final errors = e.response!.data['errors'] as List;
      error = errors.first;
    } else {
      error = null;
    }
    final titleError = error?['title'];
    final messageError = error?['detail'];
    return HandledException(
      error: titleError ?? e.error,
      message: messageError ?? e.response?.statusMessage ?? '',
      statusCode: e.response?.statusCode ?? 500,
      exception: e,
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggersInterceptors extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log(
      tag: 'ERROR',
      message: err.error.toString(),
    );
    _log(
      tag: 'ERROR',
      message: err.message.toString(),
    );
    _log(
      tag: 'ERROR',
      message: err.response?.data?.toString() ??
          err.response?.statusMessage ??
          'ERRO NÃO IDENTIFICADO',
    );

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log(
      tag: 'RESPONSE',
      message: (response.statusCode ?? 500).toString(),
    );
    if (response.data != null) {
      _log(
        tag: 'RESPONSE',
        message: response.data.toString(),
      );
    }

    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log(
      tag: 'REQUEST',
      message: options.method,
    );
    _log(
      tag: 'REQUEST',
      message: "${options.baseUrl}${options.path}",
    );
    if (options.data != null) {
      _log(
        tag: 'REQUEST',
        message: jsonEncode(options.data),
      );
    }
    if (options.queryParameters.isNotEmpty) {
      _log(
        tag: 'RESPONSE',
        message: options.queryParameters.toString(),
      );
    }
    if (options.headers.isNotEmpty) {
      _log(
        tag: 'RESPONSE',
        message: options.headers.toString(),
      );
    }
    super.onRequest(options, handler);
  }

  _log({String? tag, String? message}) => kIsWeb
      // ignore: avoid_print
      ? print('[$tag] $message at ${DateTime.now()}')
      : log(
          message ?? '',
          name: tag?.toUpperCase() ?? ' ',
          time: DateTime.now(),
        );
}

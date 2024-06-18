import 'package:flut_base_app_the_movie_db_clone/core/services/client_https/base/base_string_helper.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/client_https/base/client_base_impl.dart';
import 'package:dio/dio.dart';

class ClientHttps extends ClientHttpsBaseImpl {
  ClientHttps({
    super.interceptors,
    super.httpClientAdapter,
  }) : super(
          BaseOptions(
            baseUrl: BaseStringHelper.get().baseUrl,
            connectTimeout: BaseStringHelper.get().timeout,
            receiveTimeout: BaseStringHelper.get().timeout,
          ),
        );
}

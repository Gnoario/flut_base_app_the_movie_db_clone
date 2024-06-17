import 'package:dio/dio.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/client_https/base/client_base_impl.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/client_https_adapter_mock.dart';

void main() {
  late ClientHttpsAdapterMock clientHttpsAdapterMock;
  late ClientHttpsBaseImpl https;
  late Dio dio;

  setUp(() async {
    dio = Dio();

    clientHttpsAdapterMock = ClientHttpsAdapterMock(
      dio: dio,
    );

    https = ClientHttps(
      httpClientAdapter: clientHttpsAdapterMock,
    );
  });

  group('ClientHttps Response', () {
    test('GET METHOD should return a instance of Response', () async {
      clientHttpsAdapterMock.mockGetSuccess();
      final response = await https.get(clientHttpsAdapterMock.path);
      expect(response, isA<Response>());
    });

    test('GET METHOD should throws a instance of HandledException', () async {
      clientHttpsAdapterMock.mockGetException();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });

    test('POST METHOD should return a instance of Response', () async {
      clientHttpsAdapterMock.mockPostSuccess();
      final response = await https.post(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response, isA<Response>());
    });

    test('POST METHOD should throws a instance of HandledException', () async {
      clientHttpsAdapterMock.mockPostException();
      expect(
        () => https.post(
          clientHttpsAdapterMock.path,
          data: clientHttpsAdapterMock.data,
        ),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });

    test('PUT METHOD should return a instance of Response', () async {
      clientHttpsAdapterMock.mockPutSuccess();
      final response = await https.put(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response, isA<Response>());
    });

    test('PUT METHOD should throws a instance of HandledException', () async {
      clientHttpsAdapterMock.mockPutException();
      expect(
        () => https.put(
          clientHttpsAdapterMock.path,
          data: clientHttpsAdapterMock.data,
        ),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });

    test('DELETE METHOD should return a instance of Response', () async {
      clientHttpsAdapterMock.mockDeleteSuccess();
      final response = await https.delete(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response, isA<Response>());
    });

    test('DELETE METHOD should throws a instance of HandledException',
        () async {
      clientHttpsAdapterMock.mockDeleteException();
      expect(
        () => https.delete(
          clientHttpsAdapterMock.path,
          data: clientHttpsAdapterMock.data,
        ),
        throwsA(
          isA<HandledException>(),
        ),
      );
    });
  });

  group('ClientHttps Success Status Code', () {
    test('GET METHOD should return a 200 code if success', () async {
      clientHttpsAdapterMock.mockGetSuccess();
      final response = await https.get(clientHttpsAdapterMock.path);
      expect(response.statusCode, 200);
    });

    test('PUT METHOD should return a 204 code if success', () async {
      clientHttpsAdapterMock.mockPutSuccess();
      final response = await https.put(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response.statusCode, 204);
    });

    test('DELETE METHOD should return a 200 code if success', () async {
      clientHttpsAdapterMock.mockDeleteSuccess();
      final response = await https.delete(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response.statusCode, 200);
    });

    test('POST METHOD should return a 200 code if success', () async {
      clientHttpsAdapterMock.mockPostSuccess();
      final response = await https.post(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response.statusCode, 200);
    });

    test('PATCH METHOD should return a 200 code if success', () async {
      clientHttpsAdapterMock.mockPatchSuccess();
      final response = await https.patch(
        clientHttpsAdapterMock.path,
        data: clientHttpsAdapterMock.data,
      );
      expect(response.statusCode, 200);
    });
  });

  group('ClientHttps return HandledException on Error', () {
    test(
        'GET METHOD should throws a instance of HandledException when receive a 500 status code',
        () async {
      clientHttpsAdapterMock.mockDatabaseError();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });

    test(
        'GET METHOD should throws a instance of HandledException when receive a 503 status code',
        () async {
      clientHttpsAdapterMock.mockNetworkError();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });

    test(
        'GET METHOD should throws a instance of HandledException when receive a 504 status code',
        () async {
      clientHttpsAdapterMock.mockTimeoutError();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });

    test(
        'GET METHOD should throws a instance of HandledException when receive a 520 status code',
        () async {
      clientHttpsAdapterMock.mockUnknownError();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });

    test(
        'GET METHOD should throws a instance of HandledException when receive a 400 status code',
        () async {
      clientHttpsAdapterMock.mockError();
      expect(() => https.get(clientHttpsAdapterMock.path),
          throwsA(isA<HandledException>()));
    });
  });
}

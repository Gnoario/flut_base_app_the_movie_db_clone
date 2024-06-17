import 'package:http_mock_adapter/http_mock_adapter.dart';

class ClientHttpsAdapterMock extends DioAdapter {
  ClientHttpsAdapterMock({required super.dio});

  String get path => '/mock';

  Map<String, dynamic> get data => {'data': 'data'};

  mockGetSuccess() => onGet(
        path,
        (server) => server.reply(200, {'message': 'Success!'}),
      );

  mockGetException() => onGet(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
      );

  mockPostSuccess() => onPost(
        path,
        (server) => server.reply(200, {'message': 'Success!'}),
        data: data,
      );

  mockPostException() => onPost(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
        data: data,
      );

  mockPutSuccess() => onPut(
        path,
        (server) => server.reply(204, {'message': 'Success!'}),
        data: data,
      );

  mockPutException() => onPut(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
        data: data,
      );

  mockDeleteSuccess() => onDelete(
        path,
        (server) => server.reply(200, {'message': 'Success!'}),
        data: data,
      );

  mockDeleteException() => onDelete(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
        data: data,
      );

  mockPatchSuccess() => onPatch(
        path,
        (server) => server.reply(200, {'message': 'Success!'}),
        data: data,
      );

  mockPatchException() => onPatch(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
        data: data,
      );

  mockDatabaseError() => onGet(
        path,
        (server) => server.reply(500, {'message': 'Database Error'}),
      );

  mockNetworkError() => onGet(
        path,
        (server) => server.reply(503, {'message': 'Network Error'}),
      );

  mockTimeoutError() => onGet(
        path,
        (server) => server.reply(504, {'message': 'Timeout Error'}),
      );

  mockUnknownError() => onGet(
        path,
        (server) => server.reply(520, {'message': 'Unknown Error'}),
      );

  mockError() => onGet(
        path,
        (server) => server.reply(400, {'message': 'Error'}),
      );
}

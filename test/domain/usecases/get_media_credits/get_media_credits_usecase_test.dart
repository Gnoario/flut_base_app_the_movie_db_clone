import 'package:flut_base_app_the_movie_db_clone/app/data/repositories/repositories.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_the_movie_db_clone/app/external/datasources/datasources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/person_mock.dart';
import 'get_media_credits_usecase_test.mocks.dart';

@GenerateMocks([GetMediaCreditsDatasource])
void main() {
  late final GetMediaCreditsDatasource datasource;
  late final GetMediaCreditsRepository repository;
  late final GetMediaCreditsUsecase usecase;
  late final PersonMock personMock;

  setUpAll(() {
    datasource = MockGetMediaCreditsDatasource();
    repository = GetMediaCreditsImpRepository(datasource);
    usecase = GetMediaCreditsImpUsecase(repository);
    personMock = PersonMock();
  });

  setUp(() {
    reset(datasource);
  });

  group('Success Cases', () {
    test('Should return a list of persons normally', () async {
      final moviesMock = personMock.createPersonsMock();
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase(
        mediaType: mediaType,
        mediaId: mediaId,
      );

      expect(result, moviesMock);
    });

    test('Should return a PaginatedMoviesDto normally from json', () async {
      final moviesMock = personMock.createPersonsMockFromJson();
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase(
        mediaType: mediaType,
        mediaId: mediaId,
      );

      expect(result, moviesMock);
    });

    test('Should send the correct time window to the datasource', () async {
      final language = personMock.createRandomLanguage();
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query:
              '/${mediaType.dynamicUrl}/$mediaId/credits?language=${language.convertedType}',
        ),
      ).thenAnswer(
        (_) async => personMock.createPersonsMock(),
      );

      await usecase(
        mediaType: mediaType,
        mediaId: mediaId,
        language: language,
      );

      var expectedQuery =
          '/${mediaType.dynamicUrl}/$mediaId/credits?language=${language.convertedType}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test('Should send the correct default value to the datasource', () async {
      const language = Language.ptBR;
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenAnswer(
        (_) async => personMock.createPersonsMock(),
      );

      await usecase(
        mediaType: mediaType,
        mediaId: mediaId,
      );

      var expectedQuery =
          '/${mediaType.dynamicUrl}/$mediaId/credits?language=${language.convertedType}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });
  });

  group('Throws Cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenAnswer(
        (_) async => personMock.createPersonsMockFromJsonWithError(),
      );

      expect(
        () async => await usecase(
          mediaType: mediaType,
          mediaId: mediaId,
        ),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException', () async {
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenThrow(Exception());

      expect(
        () async => await usecase(
          mediaType: mediaType,
          mediaId: mediaId,
        ),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      final mediaType = personMock.createRandomMediaType();
      final mediaId = personMock.createRandomBigInt();
      when(
        datasource(
          query: '/${mediaType.dynamicUrl}/$mediaId/credits?language=pt-BR',
        ),
      ).thenThrow(HandledException());

      expect(
        () async => await usecase(
          mediaType: mediaType,
          mediaId: mediaId,
        ),
        throwsA(isA<HandledException>()),
      );
    });
  });
}

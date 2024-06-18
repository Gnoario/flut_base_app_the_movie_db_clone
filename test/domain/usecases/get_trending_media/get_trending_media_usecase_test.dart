import 'package:flut_base_app_the_movie_db_clone/app/data/repositories/repositories.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_the_movie_db_clone/app/external/datasources/datasources.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/paginated_movies_mock.dart';
import 'get_trending_media_usecase_test.mocks.dart';

@GenerateMocks([GetTrendingMediaDatasource])
void main() {
  late final GetTrendingMediaDatasource datasource;
  late final GetTrendingMediaRepository repository;
  late final GetTrendingMediaUsecase usecase;
  late final PaginatedMoviesMock paginatedMoviesMock;
  late final String query;

  setUpAll(() {
    datasource = MockGetTrendingMediaDatasource();
    repository = GetTrendingMediaImpRepository(datasource);
    usecase = GetTrendingMediaImpUsecase(repository);
    paginatedMoviesMock = PaginatedMoviesMock();
    query = paginatedMoviesMock.createDefaultTrendingMediaQuery();
  });

  setUp(() {
    reset(datasource);
  });

  group('Success Cases', () {
    test('Should return a PaginatedMoviesDto normally', () async {
      final moviesMock = paginatedMoviesMock.create();
      when(
        datasource(
          query: query,
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase();

      expect(result, moviesMock);
    });

    test('Should return a PaginatedMoviesDto normally from json', () async {
      final moviesMock = paginatedMoviesMock.fromJson(
        paginatedMoviesMock.createPaginatedMoviesJson(),
      );
      when(
        datasource(
          query: query,
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase();

      expect(result, moviesMock);
    });

    test('Should send the correct time window to the datasource', () async {
      final language = paginatedMoviesMock.createRandomLanguage();
      final timeWindow = paginatedMoviesMock.createRandomTrendingTimeWindow();
      when(
        datasource(
          query:
              '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}',
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        language: language,
        timeWindow: timeWindow,
      );

      var expectedQuery =
          '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test('Should send the correct default value to the datasource', () async {
      const language = Language.ptBR;
      const timeWindow = TrendingTimeWindow.day;
      when(
        datasource(
          query:
              '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}',
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase();

      var expectedQuery =
          '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });
  });

  group('Throws Cases', () {
    test('Should throw a HandledException when json conversion failed',
        () async {
      when(
        datasource(
          query: query,
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.fromJson(
          paginatedMoviesMock.createPaginatedMoviesJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException', () async {
      when(
        datasource(
          query: query,
        ),
      ).thenThrow(Exception());

      expect(
        () async => await usecase(),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      when(
        datasource(
          query: query,
        ),
      ).thenThrow(HandledException());

      expect(
        () async => await usecase(),
        throwsA(isA<HandledException>()),
      );
    });
  });
}

import 'package:flut_base_app_the_movie_db_clone/app/data/datasources/get_movies/get_movies_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/app/data/repositories/repositories.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/paginated_movies_mock.dart';
import 'get_movies_usecase_test.mocks.dart';

@GenerateMocks([GetMoviesDatasource])
void main() {
  late final GetMoviesDatasource datasource;
  late final GetMoviesRepository repository;
  late final GetMoviesUsecase usecase;
  late final PaginatedMoviesMock paginatedMoviesMock;

  setUpAll(() {
    datasource = MockGetMoviesDatasource();
    repository = GetMoviesImpRepository(datasource);
    usecase = GetMoviesImpUsecase(repository);
    paginatedMoviesMock = PaginatedMoviesMock();
  });

  group('Success Cases', () {
    test('Should return a PaginatedMoviesDto normally', () async {
      final moviesMock = paginatedMoviesMock.create();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer((_) async => moviesMock);

      final result = await usecase(
        pagination: paginatedMoviesMock.createPaginationMock(),
        language: paginatedMoviesMock.createRandomLanguage(),
        movieFilter: paginatedMoviesMock.createRandomMovieFilter(),
      );

      expect(result, moviesMock);
    });

    test('Should return a PaginatedMoviesDto normally from json', () async {
      final moviesMock = paginatedMoviesMock.fromJson(
        paginatedMoviesMock.createPaginatedMoviesJson(),
      );
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => moviesMock,
      );

      final result = await usecase(
        pagination: paginatedMoviesMock.createPaginationMock(),
        language: paginatedMoviesMock.createRandomLanguage(),
        movieFilter: paginatedMoviesMock.createRandomMovieFilter(),
      );

      expect(result, moviesMock);
    });

    test('Should send the correct movie filter to the datasource', () async {
      final language = paginatedMoviesMock.createRandomLanguage();
      final movieFilter = paginatedMoviesMock.createRandomMovieFilter();
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        language: language,
        movieFilter: movieFilter,
      );

      var expectedQuery =
          '/movie/${movieFilter.nameSnakeCase}?language=${language.convertedType}&page=${pagination.page}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test('Should send the correct query with default data to the datasource',
        () async {
      const language = Language.ptBR;
      const movieFilter = MovieFilter.popular;
      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
      );

      var expectedQuery =
          '/movie/${movieFilter.nameSnakeCase}?language=${language.convertedType}&page=${pagination.page}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test('Should send the correct pagination and searchValue to the datasource',
        () async {
      final searchValue = paginatedMoviesMock.createRandomSearchValue();
      final pagination = paginatedMoviesMock.createPaginationMock();
      final language = paginatedMoviesMock.createRandomLanguage();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        searchValue: searchValue,
        language: language,
      );

      var expectedQuery =
          '/search/movie?query=$searchValue&language=${language.convertedType}&page=${pagination.page}';
      verify(
        datasource(query: expectedQuery),
      ).called(1);
    });

    test(
        'Should send the correct query on send all attributes to the datasource',
        () async {
      final movieFilter = paginatedMoviesMock.createRandomMovieFilter();
      final language = paginatedMoviesMock.createRandomLanguage();
      final searchValue = paginatedMoviesMock.createRandomSearchValue();

      final pagination = paginatedMoviesMock.createPaginationMock();
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.create(),
      );

      await usecase(
        pagination: pagination,
        language: language,
        movieFilter: movieFilter,
        searchValue: searchValue,
      );

      var expectedQuery =
          '/search/movie?query=$searchValue&language=${language.convertedType}&page=${pagination.page}';
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
          query: anyNamed('query'),
        ),
      ).thenAnswer(
        (_) async => paginatedMoviesMock.fromJson(
          paginatedMoviesMock.createPaginatedMoviesJsonWithError(),
        ),
      );

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          language: paginatedMoviesMock.createRandomLanguage(),
          movieFilter: paginatedMoviesMock.createRandomMovieFilter(),
        ),
        throwsA(isA<HandledException>()),
      );
    });

    test('Should throw a HandledGenericException', () async {
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenThrow(Exception());

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          language: paginatedMoviesMock.createRandomLanguage(),
          movieFilter: paginatedMoviesMock.createRandomMovieFilter(),
        ),
        throwsA(isA<HandledGenericException>()),
      );
    });

    test('Should throw a HandledException', () async {
      when(
        datasource(
          query: anyNamed('query'),
        ),
      ).thenThrow(HandledException());

      expect(
        () async => await usecase(
          pagination: paginatedMoviesMock.createPaginationMock(),
          language: paginatedMoviesMock.createRandomLanguage(),
          movieFilter: paginatedMoviesMock.createRandomMovieFilter(),
        ),
        throwsA(isA<HandledException>()),
      );
    });
  });
}

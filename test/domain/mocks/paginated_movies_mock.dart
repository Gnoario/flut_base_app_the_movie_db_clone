import 'package:faker/faker.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

import 'movie_mock.dart';

class PaginatedMoviesMock {
  final MovieMock _moviesMock = MovieMock();
  PaginatedMediaDto create() {
    return PaginatedMediaDto(
      pagination: createPaginationMock(),
      media: List<MediaItemDto>.generate(
        faker.randomGenerator.integer(10, min: 5),
        (index) => _moviesMock.createMovieMock(),
      ),
    );
  }

  String createDefaultTrendingMediaQuery() {
    const language = Language.ptBR;
    const timeWindow = TrendingTimeWindow.day;
    return '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}';
  }

  MovieFilter createRandomMovieFilter() {
    return faker.randomGenerator.element(MovieFilter.values);
  }

  TrendingTimeWindow createRandomTrendingTimeWindow() {
    return faker.randomGenerator.element(TrendingTimeWindow.values);
  }

  Language createRandomLanguage() {
    return faker.randomGenerator.element(Language.values);
  }

  String createRandomSearchValue() {
    return faker.lorem.word();
  }

  PaginationDto createPaginationMock() {
    return PaginationDto(
      page: faker.randomGenerator.integer(10),
      totalResults: faker.randomGenerator.integer(10),
      totalPages: faker.randomGenerator.integer(10),
    );
  }

  PaginatedMediaDto fromJson(Map<String, dynamic> json) {
    return PaginatedMediaDto.fromJson(json);
  }

  Map<String, dynamic> createPaginationJson() {
    return {
      'totalPages': faker.randomGenerator.integer(10),
      'totalResults': faker.randomGenerator.integer(10),
      'page': faker.randomGenerator.integer(10),
    };
  }

  Map<String, dynamic> createPaginatedMoviesJson() {
    final pagination = createPaginationJson();
    return {
      'results': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10, min: 5),
        (index) => _moviesMock.createMovieJson(),
      ).toList(),
      ...pagination,
    };
  }

  Map<String, dynamic> createPaginatedMoviesJsonWithError() {
    return {
      'content': List<Map<String, dynamic>>.generate(
        faker.randomGenerator.integer(10, min: 5),
        (index) => _moviesMock.createMovieJson(),
      ).toList(),
    };
  }

  List<Map<String, dynamic>> createMoviesJson() {
    return List<Map<String, dynamic>>.generate(
      faker.randomGenerator.integer(10, min: 1),
      (index) => _moviesMock.createMovieJson(),
    );
  }
}

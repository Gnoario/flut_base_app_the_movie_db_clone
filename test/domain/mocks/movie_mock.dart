import 'package:faker/faker.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/media_item_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

class MovieMock {
  MediaItemDto createMovieMock() {
    return MediaItemDto(
      id: BigInt.from(faker.randomGenerator.integer(100)),
      originalName: faker.lorem.word(),
      name: faker.lorem.word(),
      mediaType: createRandomMediaType(),
      popularity: faker.randomGenerator.decimal(),
      adult: createRandomBool(),
      backdropPath: faker.image.image(),
      posterPath: faker.image.image(),
      overview: faker.lorem.sentence(),
      genreIds: List<int>.generate(
        faker.randomGenerator.integer(10, min: 5),
        (index) => faker.randomGenerator.integer(10),
      ),
      originalLanguage: faker.lorem.word(),
      releaseDate: DateTime.now(),
      video: createRandomBool(),
      voteAverage: faker.randomGenerator.decimal(),
      voteCount: BigInt.from(faker.randomGenerator.integer(1000)),
    );
  }

  DateTime createRandomReleaseDate() {
    return faker.date.dateTime();
  }

  List<MediaItemDto> createMoviesMockList() {
    return List<MediaItemDto>.generate(
      faker.randomGenerator.integer(
        10,
        min: 5,
      ),
      (index) => createMovieMock(),
    );
  }

  MediaType createRandomMediaType() {
    return faker.randomGenerator.element(MediaType.values);
  }

  bool createRandomBool() {
    return faker.randomGenerator.boolean();
  }

  Map<String, dynamic> createMovieJson() {
    final mediaType = faker.randomGenerator.element(['movie', 'tv']);

    return {
      'id': faker.randomGenerator.integer(100),
      'media_type': mediaType,
      if (mediaType == 'movie')
        'original_title': faker.lorem.word()
      else
        'original_name': faker.lorem.word(),
      if (mediaType == 'movie')
        'title': faker.lorem.word()
      else
        'name': faker.lorem.word(),
      'release_date': createRandomReleaseDate().toIso8601String(),
      'adult': createRandomBool(),
      'popularity': faker.randomGenerator.decimal(),
      'backdrop_path': faker.image.image(),
      'poster_path': faker.image.image(),
      'overview': faker.lorem.sentence(),
      'genre_ids': List<int>.generate(
        faker.randomGenerator.integer(10, min: 5),
        (index) => faker.randomGenerator.integer(10),
      ),
      'original_language': faker.lorem.word(),
      'video': createRandomBool(),
      'vote_average': faker.randomGenerator.decimal(),
      'vote_count': faker.randomGenerator.integer(1000),
    };
  }

  MediaItemDto fromJson(Map<String, dynamic> json) {
    return MediaItemDto.fromJson(json);
  }

  Map<String, dynamic> createMovieJsonWithError() {
    return {
      'title': faker.lorem.word(),
      'release_date': createRandomReleaseDate().toIso8601String(),
      'poster_path': faker.image.image(),
      'overview': faker.lorem.sentence(),
      'genre_ids': List<int>.generate(
        faker.randomGenerator.integer(10),
        (index) => faker.randomGenerator.integer(10),
      ),
      'original_language': faker.lorem.word(),
      'video': createRandomBool(),
      'vote_average': faker.randomGenerator.decimal(),
    };
  }
}

import 'package:faker/faker.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

import 'movie_mock.dart';

class PersonMock {
  final movieMock = MovieMock();
  PersonDto createPersonMock() {
    return PersonDto(
      id: BigInt.from(faker.randomGenerator.integer(100)),
      originalName: faker.lorem.word(),
      name: faker.lorem.word(),
      mediaType: createRandomMediaType(),
      popularity: faker.randomGenerator.decimal(),
      adult: createRandomBool(),
      gender: faker.randomGenerator.element(Gender.values),
      knownForDepartment: faker.lorem.word(),
      profilePath: faker.image.image(),
      knownFor: List.generate(
        faker.randomGenerator.integer(10),
        (index) => movieMock.createMovieMock(),
      ),
    );
  }

  List<PersonDto> createPersonsMock() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => createPersonMock(),
    );
  }

  Language createRandomLanguage() {
    return faker.randomGenerator.element(Language.values);
  }

  MediaType createRandomMediaType() {
    return faker.randomGenerator.element(MediaType.values);
  }

  BigInt createRandomBigInt() {
    return BigInt.from(faker.randomGenerator.integer(100));
  }

  bool createRandomBool() {
    return faker.randomGenerator.boolean();
  }

  Map<String, dynamic> createPersonsJson() {
    return {
      'cast': List.generate(
        faker.randomGenerator.integer(10),
        (index) => createPersonJson(),
      ),
    };
  }

  Map<String, dynamic> createPersonJson() {
    final mediaType = faker.randomGenerator.element(['movie', 'tv']);

    return {
      'id': faker.randomGenerator.integer(100),
      'original_name': faker.lorem.word(),
      'media_type': mediaType,
      'adult': createRandomBool(),
      'name': faker.lorem.word(),
      'popularity': faker.randomGenerator.decimal(),
      'gender': faker.randomGenerator.element(Gender.values).index,
      'known_for_department': faker.lorem.word(),
      'profile_path': faker.image.image(),
      'known_for': List.generate(
        faker.randomGenerator.integer(10),
        (index) => movieMock.createMovieJson(),
      )
    };
  }

  List<PersonDto> createPersonsMockFromJsonWithError() {
    return List.generate(
      faker.randomGenerator.integer(10),
      (index) => PersonDto.fromJson(createPersonJsonWithError()),
    );
  }

  PersonDto fromJson(Map<String, dynamic> json) {
    return PersonDto.fromJson(json);
  }

  List<PersonDto> createPersonsMockFromJson() {
    return (createPersonsJson()['cast'] as List)
        .map<PersonDto>((e) => PersonDto.fromJson(e))
        .toList();
  }

  Map<String, dynamic> createPersonJsonWithError() {
    return {
      'title': faker.lorem.word(),
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

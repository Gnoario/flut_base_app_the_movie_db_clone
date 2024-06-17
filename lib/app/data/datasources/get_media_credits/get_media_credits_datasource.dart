import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';

abstract class GetMediaCreditsDatasource {
  Future<List<PersonDto>> call({
    required String query,
  });
}

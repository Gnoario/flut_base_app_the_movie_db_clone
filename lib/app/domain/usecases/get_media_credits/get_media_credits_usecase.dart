import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';

import '../../models/enums/enums.dart';

abstract class GetMediaCreditsUsecase {
  Future<List<PersonDto>> call({
    required MediaType mediaType,
    required BigInt mediaId,
    Language language = Language.ptBR,
  });
}

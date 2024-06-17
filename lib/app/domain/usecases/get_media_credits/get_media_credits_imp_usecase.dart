import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

import 'get_media_credits_usecase.dart';
import '../../repositories/get_media_credits/get_media_credits_repository.dart';

class GetMediaCreditsImpUsecase implements GetMediaCreditsUsecase {
  final GetMediaCreditsRepository _getMediaCreditsRepository;

  GetMediaCreditsImpUsecase(this._getMediaCreditsRepository);

  @override
  Future<List<PersonDto>> call({
    required MediaType mediaType,
    required BigInt mediaId,
    Language language = Language.ptBR,
  }) async {
    return await _getMediaCreditsRepository(
      query:
          '/${mediaType.dynamicUrl}/$mediaId/credits?language=${language.convertedType}',
    );
  }
}

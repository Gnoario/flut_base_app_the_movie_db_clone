import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

import 'get_trending_media_usecase.dart';
import '../../repositories/get_trending_media/get_trending_media_repository.dart';

class GetTrendingMediaImpUsecase implements GetTrendingMediaUsecase {
  final GetTrendingMediaRepository _getTrendingMediaRepository;

  GetTrendingMediaImpUsecase(this._getTrendingMediaRepository);

  @override
  Future<PaginatedMediaDto> call({
    Language language = Language.ptBR,
    TrendingTimeWindow timeWindow = TrendingTimeWindow.day,
  }) async {
    return await _getTrendingMediaRepository(
      query: _query(language: language, timeWindow: timeWindow),
    );
  }

  String _query({
    required Language language,
    required TrendingTimeWindow timeWindow,
  }) {
    return '/all/${timeWindow.nameSnakeCase}?language=${language.convertedType}';
  }
}

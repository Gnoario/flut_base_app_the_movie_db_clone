import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';

abstract class GetTrendingMediaUsecase {
  Future<PaginatedMediaDto> call({
    Language language = Language.ptBR,
    TrendingTimeWindow timeWindow = TrendingTimeWindow.day,
  });
}

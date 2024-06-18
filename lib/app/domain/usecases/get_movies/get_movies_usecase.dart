import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';

import '../../models/dtos/pagination/pagination_dto.dart';
import '../../models/enums/enums.dart';

abstract class GetMoviesUsecase {
  Future<PaginatedMediaDto> call({
    required PaginationDto pagination,
    Language language = Language.ptBR,
    MovieFilter movieFilter = MovieFilter.popular,
    String? searchValue,
  });
}

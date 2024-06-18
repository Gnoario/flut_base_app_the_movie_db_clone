import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';

import '../../models/dtos/pagination/pagination_dto.dart';
import '../../models/enums/enums.dart';
import 'get_movies_usecase.dart';
import '../../repositories/get_movies/get_movies_repository.dart';

class GetMoviesImpUsecase implements GetMoviesUsecase {
  final GetMoviesRepository _getMoviesRepository;

  GetMoviesImpUsecase(this._getMoviesRepository);

  @override
  Future<PaginatedMediaDto> call({
    required PaginationDto pagination,
    Language language = Language.ptBR,
    MovieFilter movieFilter = MovieFilter.popular,
    String? searchValue,
  }) async {
    return await _getMoviesRepository(
      query: _buildQuery(pagination, language, movieFilter, searchValue),
    );
  }

  _buildQuery(
    PaginationDto pagination,
    Language language,
    MovieFilter movieFilter,
    String? searchValue,
  ) {
    StringBuffer? query;
    if (searchValue != null) {
      query = StringBuffer(
        '/search/movie?query=$searchValue&language=${language.convertedType}&page=${pagination.page}',
      );
    } else {
      query = StringBuffer(
        '/movie/${movieFilter.nameSnakeCase}?language=${language.convertedType}&page=${pagination.page}',
      );
    }

    return query.toString();
  }
}

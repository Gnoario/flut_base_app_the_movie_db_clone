import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';

import '../../../data/datasources/get_movies/get_movies_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/services.dart';

class GetMoviesImpDatasource implements GetMoviesDatasource {
  final ClientHttps _clientHttps;

  GetMoviesImpDatasource(this._clientHttps);

  @override
  Future<PaginatedMediaDto> call({
    String? query,
  }) async {
    final result = await _clientHttps.get('$query');

    return PaginatedMediaDto.fromJson(result.data);
  }
}

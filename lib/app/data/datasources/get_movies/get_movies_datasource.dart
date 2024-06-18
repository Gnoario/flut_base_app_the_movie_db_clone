import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';

abstract class GetMoviesDatasource {
  Future<PaginatedMediaDto> call({
    String? query,
  });
}

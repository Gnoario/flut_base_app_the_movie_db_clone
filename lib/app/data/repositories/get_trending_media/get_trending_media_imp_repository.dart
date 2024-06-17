import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';
import '../../../domain/repositories/get_trending_media/get_trending_media_repository.dart';
import '../../datasources/get_trending_media/get_trending_media_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_generic_exception.dart';

class GetTrendingMediaImpRepository implements GetTrendingMediaRepository {
  final GetTrendingMediaDatasource _getTrendingMediaDatasource;

  GetTrendingMediaImpRepository(this._getTrendingMediaDatasource);

  @override
  Future<PaginatedMediaDto> call({
    required String query,
  }) async {
    try {
      return await _getTrendingMediaDatasource(
        query: query,
      );
    } on HandledException catch (_) {
      rethrow;
    } catch (_) {
      throw HandledGenericException();
    }
  }
}

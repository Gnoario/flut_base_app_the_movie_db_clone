import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/media_item/paginated_media_dto.dart';
import '../../../data/datasources/get_trending_media/get_trending_media_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/services.dart';

class GetTrendingMediaImpDatasource implements GetTrendingMediaDatasource {
  final ClientHttps _clientHttps;

  GetTrendingMediaImpDatasource(this._clientHttps);

  final _endpoint = '/trending';

  @override
  Future<PaginatedMediaDto> call({
    required String query,
  }) async {
    final result = await _clientHttps.get('$_endpoint$query');

    return PaginatedMediaDto.fromJson(result.data);
  }
}

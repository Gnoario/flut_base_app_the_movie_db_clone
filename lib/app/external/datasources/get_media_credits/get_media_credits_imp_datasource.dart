import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';
import '../../../data/datasources/get_media_credits/get_media_credits_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/core/services/services.dart';

class GetMediaCreditsImpDatasource implements GetMediaCreditsDatasource {
  final ClientHttps _clientHttps;

  GetMediaCreditsImpDatasource(this._clientHttps);

  @override
  Future<List<PersonDto>> call({
    required String query,
  }) async {
    final result = await _clientHttps.get(query);
    return (result.data as List).map((e) => PersonDto.fromJson(e)).toList();
  }
}

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/person/person_dto.dart';
import '../../../domain/repositories/get_media_credits/get_media_credits_repository.dart';
import '../../datasources/get_media_credits/get_media_credits_datasource.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_exception.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/handled_generic_exception.dart';

class GetMediaCreditsImpRepository implements GetMediaCreditsRepository {
  final GetMediaCreditsDatasource _getMediaCreditsDatasource;

  GetMediaCreditsImpRepository(this._getMediaCreditsDatasource);

  @override
  Future<List<PersonDto>> call({
    required String query,
  }) async {
    try {
      return await _getMediaCreditsDatasource(
        query: query,
      );
    } on HandledException catch (_) {
      rethrow;
    } catch (_) {
      throw HandledGenericException();
    }
  }
}

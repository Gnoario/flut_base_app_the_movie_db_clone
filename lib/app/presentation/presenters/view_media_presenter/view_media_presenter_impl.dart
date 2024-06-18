import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';

import '../../../domain/models/enums/enums.dart';
import '../../../domain/models/exceptions/exceptions.dart';
import '../../../ui/pages/view_media/view_media_presenter.dart';

class ViewMediaPresenterImpl implements ViewMediaPresenter {
  final GetMediaCreditsUsecase _getMediaCreditsUsecase;

  ViewMediaPresenterImpl(this._getMediaCreditsUsecase);

  late StreamController<ResultPresentation> _mediaCreditsController;

  late StreamController<bool> _isGetMediaCreditsLoadingController;

  @override
  Stream<bool> get isGetMediaCreditsLoading =>
      _isGetMediaCreditsLoadingController.stream;

  @override
  Stream<ResultPresentation> get mediaCredits => _mediaCreditsController.stream;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _mediaCreditsController.close();
    _isGetMediaCreditsLoadingController.close();
  }

  @override
  startStreams() {
    _isGetMediaCreditsLoadingController = StreamController<bool>.broadcast();
    _mediaCreditsController = StreamController<ResultPresentation>.broadcast();
  }

  @override
  Future<ResultPresentation> getMediaCredits({
    required BigInt mediaId,
    required MediaType mediaType,
  }) async {
    try {
      _isGetMediaCreditsLoadingController.add(true);

      final result = await _getMediaCreditsUsecase(
        mediaId: mediaId,
        mediaType: mediaType,
      );

      final resultPresentation = ResultPresentation(
        payload: result,
      );
      _mediaCreditsController.add(resultPresentation);
      return resultPresentation;
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _mediaCreditsController.add(resultPresentation);
      return resultPresentation;
    } finally {
      _isGetMediaCreditsLoadingController.add(false);
    }
  }

  @override
  void removeListener(VoidCallback listener) {}
}

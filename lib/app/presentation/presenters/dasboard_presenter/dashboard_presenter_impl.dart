import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/dtos/pagination/pagination_dto.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/models/exceptions/exceptions.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/usecases/usecases.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_presenter.dart';

class DashboardPresenterImpl implements DashboardPresenter {
  final GetMoviesUsecase _getMoviesUsecase;
  final GetTrendingMediaUsecase _getTrendingMediaUsecase;

  DashboardPresenterImpl(
    this._getMoviesUsecase,
    this._getTrendingMediaUsecase,
  );

  @override
  Stream<bool> get isGetMoviesLoading => _getMoviesLoadingController.stream;

  @override
  Stream<ResultPresentation> get movies => _moviesController.stream;

  @override
  Stream<bool> get isGetTrendingMediaLoading =>
      _getTrendingMediaLoadingController.stream;

  @override
  Stream<ResultPresentation> get trendingMedia =>
      _trendingMediaController.stream;

  @override
  Stream<String> get randomMediaBackgroundPath =>
      _randomMediaBackgroundPathController.stream;

  String _lastBackgroundPath = '';

  late StreamController<bool> _getMoviesLoadingController;

  late StreamController<String> _randomMediaBackgroundPathController;

  late StreamController<ResultPresentation> _moviesController;

  late StreamController<bool> _getTrendingMediaLoadingController;

  late StreamController<ResultPresentation> _trendingMediaController;

  @override
  startStreams() {
    _getMoviesLoadingController = StreamController<bool>.broadcast();
    _moviesController = StreamController<ResultPresentation>.broadcast();
    _getTrendingMediaLoadingController = StreamController<bool>.broadcast();
    _trendingMediaController = StreamController<ResultPresentation>.broadcast();
    _randomMediaBackgroundPathController = StreamController<String>.broadcast();
  }

  @override
  void dispose() {
    _getMoviesLoadingController.close();
    _moviesController.close();
    _getTrendingMediaLoadingController.close();
    _trendingMediaController.close();
    _randomMediaBackgroundPathController.close();
  }

  @override
  Future<ResultPresentation> getMovies({
    MovieFilter movieFilter = MovieFilter.popular,
    Language language = Language.ptBR,
  }) async {
    try {
      _getMoviesLoadingController.add(true);
      final result = await _getMoviesUsecase(
        pagination: PaginationDto(page: 1),
        movieFilter: movieFilter,
        language: language,
      );
      final resultPresentation = ResultPresentation(
        payload: result.media,
      );
      _randomImageByMedia(result.media);
      _moviesController.add(resultPresentation);
      return resultPresentation;
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _moviesController.add(resultPresentation);
      return resultPresentation;
    } finally {
      _getMoviesLoadingController.add(false);
    }
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<ResultPresentation> getTrendingMedia({
    Language language = Language.ptBR,
    TrendingTimeWindow trendingTimeWindow = TrendingTimeWindow.day,
  }) async {
    try {
      _getTrendingMediaLoadingController.add(true);
      final result = await _getTrendingMediaUsecase(
        language: language,
        timeWindow: trendingTimeWindow,
      );
      final resultPresentation = ResultPresentation(
        payload: result.media,
      );
      _trendingMediaController.add(resultPresentation);
      return resultPresentation;
    } on HandledException catch (e) {
      final resultPresentation = ResultPresentation.exception(e);
      _trendingMediaController.add(resultPresentation);
      return resultPresentation;
    } finally {
      _getTrendingMediaLoadingController.add(false);
    }
  }

  _randomImageByMedia(List<dynamic> media) async {
    final randomIndex = Random().nextInt(media.length);
    final randomMedia = media[randomIndex];

    if (_lastBackgroundPath.isEmpty) {
      _lastBackgroundPath = randomMedia.backdropPath;
      _randomMediaBackgroundPathController.add(randomMedia.backdropPath);
    }
  }
}

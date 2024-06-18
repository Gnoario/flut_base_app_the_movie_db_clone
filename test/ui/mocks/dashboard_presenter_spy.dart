import 'dart:async';
import 'dart:ui';

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flut_base_app_the_movie_db_clone/app/ui/pages/dashboard/dashboard_presenter.dart';
import 'package:mockito/mockito.dart';

class DashboardPresenterSpy extends Mock implements DashboardPresenter {
  bool getMoviesCalled = false;

  bool getTrendingMediaCalled = false;

  @override
  Stream<bool> get isGetMoviesLoading =>
      getMoviesLoadingController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get trendingMedia =>
      trendingMediaController.stream.asBroadcastStream();

  @override
  Stream<ResultPresentation> get movies =>
      moviesController.stream.asBroadcastStream();

  @override
  Stream<bool> get isGetTrendingMediaLoading =>
      getTrendingMediaLoadingController.stream.asBroadcastStream();

  @override
  Stream<String> get randomMediaBackgroundPath =>
      randomMediaBackgroundPathController.stream.asBroadcastStream();

  final StreamController<bool> getMoviesLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<bool> getTrendingMediaLoadingController =
      StreamController<bool>.broadcast();

  final StreamController<ResultPresentation> moviesController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<ResultPresentation> trendingMediaController =
      StreamController<ResultPresentation>.broadcast();

  final StreamController<String> randomMediaBackgroundPathController =
      StreamController<String>.broadcast();

  @override
  Future<ResultPresentation> getMovies({
    Language language = Language.ptBR,
    MovieFilter movieFilter = MovieFilter.popular,
  }) {
    getMoviesCalled = true;

    return super.noSuchMethod(
      Invocation.method(#getMovies, []),
      returnValue: Future(() => ResultPresentation()),
      returnValueForMissingStub: Future(() => ResultPresentation()),
    );
  }

  @override
  Future<ResultPresentation> getTrendingMedia({
    Language language = Language.ptBR,
    TrendingTimeWindow trendingTimeWindow = TrendingTimeWindow.day,
  }) {
    getTrendingMediaCalled = true;

    return super.noSuchMethod(
      Invocation.method(#getTrendingMedia, []),
      returnValue: Future(() => ResultPresentation()),
      returnValueForMissingStub: Future(() => ResultPresentation()),
    );
  }

  emitMoviesLoading(bool isLoading) =>
      getMoviesLoadingController.add(isLoading);

  emitRandomMediaBackgroundPath(String path) =>
      randomMediaBackgroundPathController.add(path);

  emitTrendingMediaLoading(bool isLoading) =>
      getTrendingMediaLoadingController.add(isLoading);

  emitTrendingMedia(ResultPresentation result) =>
      trendingMediaController.add(result);

  emitMovies(ResultPresentation result) => moviesController.add(result);

  emitLoadings({loading = true}) {
    emitMoviesLoading(loading);
    emitTrendingMediaLoading(loading);
  }

  @override
  void dispose() {
    // getMoviesLoadingController.close();
    // moviesController.close();
    // getTrendingMediaLoadingController.close();
    // trendingMediaController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}

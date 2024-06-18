import 'dart:async';

import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class DashboardPresenter implements Disposable, Listenable {
  Stream<bool> get isGetMoviesLoading;
  Stream<bool> get isGetTrendingMediaLoading;
  Stream<ResultPresentation> get movies;
  Stream<ResultPresentation> get trendingMedia;
  Stream<String> get randomMediaBackgroundPath;

  startStreams();
  Future<ResultPresentation> getMovies({
    MovieFilter movieFilter = MovieFilter.popular,
    Language language = Language.ptBR,
  });
  Future<ResultPresentation> getTrendingMedia({
    Language language = Language.ptBR,
    TrendingTimeWindow trendingTimeWindow = TrendingTimeWindow.day,
  });
}

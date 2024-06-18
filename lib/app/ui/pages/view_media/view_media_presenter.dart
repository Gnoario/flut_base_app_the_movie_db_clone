import 'package:flut_base_app_the_movie_db_clone/app/domain/models/enums/enums.dart';
import 'package:flut_base_app_the_movie_db_clone/app/domain/presentation/result_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ViewMediaPresenter implements Disposable, Listenable {
  Stream<bool> get isGetMediaCreditsLoading;
  Stream<ResultPresentation> get mediaCredits;

  startStreams();
  Future<ResultPresentation> getMediaCredits({
    required MediaType mediaType,
    required BigInt mediaId,
  });
}
